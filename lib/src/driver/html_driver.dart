// Copyright 2019 terrier989@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart';
import 'package:universal_io/io.dart' as io;
import 'package:zone_local/zone_local.dart';

/// Simulates a browser window.
class HtmlDriver {
  /// Enables forking zones with a different zone-local instance.
  static final ZoneLocal<HtmlDriver> zoneLocal =
      ZoneLocal<HtmlDriver>(defaultValue: HtmlDriver());

  /// Default value of [uri] when it hasn't been specified.
  ///
  /// Currently "memory:/", but it may be changed in future.
  static final Uri defaultUri = Uri(scheme: "memory", path: "/");

  /// Default value of:
  ///   * HTTP request header "User-Agent"
  ///   * [Navigator.userAgent]
  static const UserAgent defaultUserAgent = UserAgent("Browser");

  /// Instance of the current zone.
  static HtmlDriver get current => zoneLocal.value;

  /// Style sheets that have been loaded.
  final Map<String, Future<StyleSheet>> loadedStyleSheets =
      <String, Future<StyleSheet>>{};

  BrowserImplementation _browserImplementation;

  Uri _uri = defaultUri;

  Window _window;

  HtmlDocument _document;

  /// CSP attached to the content.
  Csp contentSecurityPolicy;

  /// Used by 'dart:html' _window.navigator.languages_.
  final List<String> languages;

  Selection selection;

  /// Used for parsing HTML/XHTML/SVG/XML.
  final DomParserDriver domParserDriver = DomParserDriver();

  /// User agent string.
  final UserAgent userAgent;

  /// Constructs a new browser instance.
  ///
  /// Parameter [:languages] is used by _window.navigator.languages_.
  ///
  /// Parameter [:userAgent] is default string for:
  ///   * HTTP request header "User-Agent"
  ///   * _window.navigator.userAgent_
  HtmlDriver({
    BrowserImplementation browserImplementation,
    @deprecated BrowserImplementation browserClassFactory,
    this.languages = const <String>["en-US"],
    this.userAgent = defaultUserAgent,
  }) {
    this._browserImplementation = browserImplementation ?? browserClassFactory;
  }

  @Deprecated("Please use 'browserImplementation' instead")
  BrowserImplementation get browserClassFactory => browserImplementation;

  BrowserImplementation get browserImplementation {
    return _browserImplementation ??
        (_browserImplementation = BrowserImplementation(this));
  }

  /// Used by 'dart:html' _document_.
  HtmlDocument get document {
    var document = this._document;
    if (document == null) {
      this._document = document = BrowserImplementationUtils.newHtmlDocument(
        htmlDriver: this,
        contentType: "text/html",
        filled: true,
      );
    }
    return document;
  }

  /// URI of the current document.
  Uri get uri => _uri;

  /// Sets URI of the current document.
  set uri(Uri value) {
    this._uri = value;
  }

  /// URI string.
  String get uriString => _uri?.toString();

  /// Used by 'dart:html' _window_.
  Window get window {
    var window = this._window;
    if (window == null) {
      this._window = window = browserImplementation.newWindow();
    }
    return window;
  }

  /// Called when an outgoing message is added.
  void addOutgoingMessage(dynamic message,
      {String targetOrigin, List<Object> transfer}) {
    throw UnimplementedError();
  }

  void clear({Uri uri}) {
    setDocument(
      BrowserImplementationUtils.newHtmlDocument(
        htmlDriver: HtmlDriver.current,
        contentType: "text/html",
        filled: true,
      ),
      uri: uri,
    );
  }

  void reload() {
    setDocumentFromUri(uri);
  }

  /// Replaces current document.
  ///
  /// If document is null, empty default document will be used.
  ///
  /// This method affects all state, including:
  ///   * [uri]
  ///   * [document]
  ///   * [window]
  ///   * [contentSecurityPolicy] (using null)
  void setDocument(Document document, {Uri uri}) {
    // Set URL
    this._uri = uri ?? defaultUri;

    // Set document
    final htmlDocument = _convertToHtmlDocument(document);
    this._document = htmlDocument;

    // Set window.
    // It will be lazily initialized.
    this._window = null;

    // Set content security policy.
    this.contentSecurityPolicy = null;
    if (htmlDocument == null) {
      this.contentSecurityPolicy = null;
    } else {
      this.contentSecurityPolicy = Csp.fromHtmlDocument(
        htmlDocument,
      );
    }
  }

  Future<void> setDocumentFromHttpClientRequest(
      io.HttpClientRequest request) async {
    final response = await request.close();
    return setDocumentFromHttpClientResponse(response, request: request);
  }

  Future<void> setDocumentFromHttpClientResponse(
    io.HttpClientResponse response, {
    @required io.HttpClientRequest request,
  }) async {
    final data = await collectBytes(response);
    setDocumentFromContent(utf8.decode(data), uri: request.uri);
  }

  /// Loads document from the string and calls [setDocument].
  void setDocumentFromContent(
    String input, {
    Uri uri,
    String mime,
    ContentTypeSniffer contentTypeSniffer = const ContentTypeSniffer(),
  }) async {
    mime ??= contentTypeSniffer.sniffMime(input) ?? "text/html";
    final document = domParserDriver.parseHtmlFromAnything(input, mime: mime);
    setDocument(document, uri: uri);
  }

  /// Loads document from the URI and calls [setDocumentFromContent].
  Future<void> setDocumentFromUri(
    Uri uri, {
    FutureOr<void> onHttpResponse(io.HttpClientResponse response),
    String mime,
    ContentTypeSniffer contentTypeSniffer = const ContentTypeSniffer(),
  }) async {
    final httpClient = browserImplementation.newHttpClient();
    final httpRequest = await httpClient.getUrl(uri);
    final httpResponse = await httpRequest.close();
    if (onHttpResponse != null) {
      await onHttpResponse(httpResponse);
    }
    final content = await utf8.decodeStream(httpResponse);
    mime ??= httpResponse.headers.contentType.mimeType;
    setDocumentFromContent(
      content,
      uri: uri,
      mime: mime,
      contentTypeSniffer: contentTypeSniffer,
    );
    final cspHeader = httpResponse.headers.value("Content-Security-Policy");
    if (cspHeader != null) {
      this.contentSecurityPolicy = Csp.parse(cspHeader);
    }
  }

  /// Converts any document (such as [XmlDocument]) to [HtmlDocument].
  HtmlDocument _convertToHtmlDocument(Document document) {
    if (document == null) {
      return null;
    }
    if (document is HtmlDocument) {
      return document;
    }
    final result = BrowserImplementationUtils.newHtmlDocument(
      htmlDriver: this,
      contentType: document.contentType,
      filled: true,
    );
    for (var child in document.childNodes) {
      result.append(child);
    }
    return result;
  }
}
