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
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

part of universal_html.internal;

Window get window => HtmlDriver.current.window;

class Window extends EventTarget
    with WindowBase
    implements WindowEventHandlers {
  /// Static factory designed to expose `contentloaded` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> contentLoadedEvent =
      EventStreamProvider<Event>('DOMContentLoaded');

  /// Static factory designed to expose `devicemotion` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<DeviceMotionEvent> deviceMotionEvent =
      EventStreamProvider<DeviceMotionEvent>('devicemotion');

  /// Static factory designed to expose `deviceorientation` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<DeviceOrientationEvent>
      deviceOrientationEvent =
      EventStreamProvider<DeviceOrientationEvent>('deviceorientation');

  /// Static factory designed to expose `hashchange` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> hashChangeEvent =
      EventStreamProvider<Event>('hashchange');

  static const EventStreamProvider<Event> loadStartEvent =
      EventStreamProvider<Event>('loadstart');

  /// Static factory designed to expose `message` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  /// Static factory designed to expose `offline` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> offlineEvent =
      EventStreamProvider<Event>('offline');

  /// Static factory designed to expose `online` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> onlineEvent =
      EventStreamProvider<Event>('online');

  /// Static factory designed to expose `pagehide` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> pageHideEvent =
      EventStreamProvider<Event>('pagehide');

  /// Static factory designed to expose `pageshow` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> pageShowEvent =
      EventStreamProvider<Event>('pageshow');

  /// Static factory designed to expose `popstate` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<PopStateEvent> popStateEvent =
      EventStreamProvider<PopStateEvent>('popstate');

  static const EventStreamProvider<Event> progressEvent =
      EventStreamProvider<Event>('progress');

  /// Static factory designed to expose `storage` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<StorageEvent> storageEvent =
      EventStreamProvider<StorageEvent>('storage');

  /// Static factory designed to expose `unload` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> unloadEvent =
      EventStreamProvider<Event>('unload');

  /// Static factory designed to expose `animationend` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<AnimationEvent> animationEndEvent =
      EventStreamProvider<AnimationEvent>('webkitAnimationEnd');

  /// Static factory designed to expose `animationiteration` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<AnimationEvent> animationIterationEvent =
      EventStreamProvider<AnimationEvent>('webkitAnimationIteration');

  /// Static factory designed to expose `animationstart` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<AnimationEvent> animationStartEvent =
      EventStreamProvider<AnimationEvent>('webkitAnimationStart');

  /// Indicates that file system data cannot be cleared unless given user
  /// permission.
  ///
  /// ## Other resources
  ///
  /// * [Exploring the FileSystem
  ///   APIs](http://www.html5rocks.com/en/tutorials/file/filesystem/)
  ///   from HTML5Rocks.
  /// * [File API](http://www.w3.org/TR/file-system-api/#idl-def-LocalFileSystem)
  ///   from W3C.
  static const int PERSISTENT = 1;

  /// Indicates that file system data can be cleared at any time.
  ///
  /// ## Other resources
  ///
  /// * [Exploring the FileSystem
  ///   APIs](http://www.html5rocks.com/en/tutorials/file/filesystem/) from HTML5Rocks.
  /// * [File API](http://www.w3.org/TR/file-system-api/#idl-def-LocalFileSystem)
  ///   from W3C.
  static const int TEMPORARY = 0;

  // API level getter and setter for Location.
  // TODO: The cross domain safe wrapper can be inserted here.
  /// Static factory designed to expose `beforeunload` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<BeforeUnloadEvent> beforeUnloadEvent =
      EventStreamProvider('beforeunload');

  /// convertPointFromNodeToPage and convertPointFromPageToNode are removed.
  /// see http://dev.w3.org/csswg/cssom-view/#geometry
  static bool get supportsPointConversions => false;

  final HtmlDriver _htmlDriver;

  Navigator _navigator;

  Storage _localStorage;

  Storage _sessionStorage;

  Console _console;

  Location _location;

  History _history;

  bool _closed = false;

  Performance _performance;

  // TODO: consider forcing users to do: window.location.assign('string').
  ApplicationCache _applicationCache;

  /// The name of this window.
  ///
  /// ## Other resources
  ///
  /// * [Window.name](https://developer.mozilla.org/en-US/docs/Web/API/Window/name)
  ///   from MDN.
  String name;

  /// The height of this window including all user interface elements.
  ///
  /// ## Other resources
  ///
  /// * [Window.outerHeight](https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight)
  ///   from MDN.
  final int outerHeight;

  /// The width of the window including all user interface elements.
  ///
  /// ## Other resources
  ///
  /// * [Window.outerWidth](https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth)
  ///   from MDN.
  final int outerWidth;

  /// *Deprecated*.
  String status;

  Window._(this._htmlDriver, {this.outerWidth = 0, this.outerHeight = 0})
      : super._created();

  /// Returns a Future that completes just before the window is about to
  /// repaint so the user can draw an animation frame.
  ///
  /// If you need to later cancel this animation, use [requestAnimationFrame]
  /// instead.
  ///
  /// The [Future] completes to a timestamp that represents a floating
  /// point value of the number of milliseconds that have elapsed since the page
  /// started to load (which is also the timestamp at this call to
  /// animationFrame).
  ///
  /// Note: The code that runs when the future completes should call
  /// [animationFrame] again for the animation to continue.
  Future<num> get animationFrame {
    final completer = Completer<num>.sync();
    requestAnimationFrame((num value) {
      completer.complete(value);
    });
    return completer.future;
  }

  _Worklet get animationWorklet => throw UnimplementedError();

  /// The application cache for this window.
  ///
  /// ## Other resources
  ///
  /// * [A beginner's guide to using the application
  ///   cache](http://www.html5rocks.com/en/tutorials/appcache/beginner)
  ///   from HTML5Rocks.
  /// * [Application cache
  ///   API](https://html.spec.whatwg.org/multipage/browsers.html#application-cache-api)
  ///   from WHATWG.
  ApplicationCache get applicationCache =>
      _applicationCache ??
      (_applicationCache =
          _htmlDriver.browserImplementation.newApplicationCache());

  _Worklet get audioWorklet => throw UnimplementedError();

  CacheStorage get caches => CacheStorage._();

  bool get closed => _closed;

  /// The debugging console for this window.
  Console get console =>
      _console ?? (_console = _htmlDriver.browserImplementation.newConsole());

  CookieStore get cookieStore => CookieStore._();

  /// Entrypoint for the browser's cryptographic functions.
  ///
  /// ## Other resources
  ///
  /// * [Web cryptography API](http://www.w3.org/TR/WebCryptoAPI/) from W3C.
  Crypto get crypto => Crypto._();

  CustomElementRegistry get customElements => null;

  /// *Deprecated*.
  String get defaultstatus => throw UnimplementedError();

  /// *Deprecated*.
  String get defaultStatus => throw UnimplementedError();

  /// The ratio between physical pixels and logical CSS pixels.
  ///
  /// ## Other resources
  ///
  /// * [devicePixelRatio](http://www.quirksmode.org/blog/archives/2012/06/devicepixelrati.html)
  ///   from quirksmode.
  /// * [More about devicePixelRatio](http://www.quirksmode.org/blog/archives/2012/07/more_about_devi.html)
  ///   from quirksmode.
  num get devicePixelRatio => 1;

  /// The newest document in this window.
  ///
  /// ## Other resources
  ///
  /// * [Loading web
  ///   pages](https://html.spec.whatwg.org/multipage/browsers.html)
  ///   from WHATWG.
  Document get document => null;

  External get external => External._();

  History get history =>
      _history ?? (_history = _htmlDriver.browserImplementation.newHistory());

  /// Gets an instance of the Indexed DB factory to being using Indexed DB.
  ///
  /// Use [indexed_db.IdbFactory.supported] to check if Indexed DB is supported on the
  /// current platform.
  IdbFactory get indexedDB => null;

  /// The height of the viewport including scrollbars.
  ///
  /// ## Other resources
  ///
  /// * [Window.innerHeight](https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight)
  ///   from MDN.
  int get innerHeight => outerHeight;

  /// The width of the viewport including scrollbars.
  ///
  /// ## Other resources
  ///
  /// * [Window.innerWidth](https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth)
  ///   from MDN.
  int get innerWidth => outerWidth;

  bool get isSecureContext => throw UnimplementedError();

  /// Storage for this window that persists across sessions.
  ///
  /// ## Other resources
  ///
  /// * [DOM storage guide](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Storage)
  ///   from MDN.
  /// * [The past, present & future of local storage for web
  ///   applications](http://diveintohtml5.info/storage.html) from Dive Into HTML5.
  /// * [Local storage specification](http://www.w3.org/TR/webstorage/#the-localstorage-attribute)
  ///   from W3C.
  Storage get localStorage =>
      _localStorage ??
      (_localStorage = _htmlDriver.browserImplementation.newStorage());

  /// The current location of this window.
  ///
  ///     Location currentLocation = window.location;
  ///     print(currentLocation.href); // 'http://www.example.com:80/'
  Location get location =>
      _location ??
      (_location = _htmlDriver.browserImplementation.newLocation());

  /// Sets the window's location, which causes the browser to navigate to the new
  /// location. [value] may be a Location object or a String.
  set location(value) {
    _location = value;
  }

  /// This window's location bar, which displays the URL.
  ///
  /// ## Other resources
  ///
  /// * [Browser interface
  ///   elements](https://html.spec.whatwg.org/multipage/browsers.html#browser-interface-elements)
  ///   from WHATWG.
  _BarProp get locationbar => throw UnimplementedError();

  /// This window's menu bar, which displays menu commands.
  ///
  /// ## Other resources
  ///
  /// * [Browser interface
  ///   elements](https://html.spec.whatwg.org/multipage/browsers.html#browser-interface-elements)
  ///   from WHATWG.
  _BarProp get menubar => throw UnimplementedError();

  /// The user agent accessing this window.
  ///
  /// ## Other resources
  ///
  /// * [The navigator
  ///   object](https://html.spec.whatwg.org/multipage/webappapis.html#the-navigator-object)
  ///   from WHATWG.
  Navigator get navigator =>
      _navigator ??
      (_navigator = _htmlDriver.browserImplementation.newNavigator());

  /// Whether objects are drawn offscreen before being displayed.
  ///
  /// ## Other resources
  ///
  /// * [offscreenBuffering](https://webplatform.github.io/docs/dom/HTMLElement/offscreenBuffering/)
  ///   from WebPlatform.org.
  bool get offscreenBuffering => false;

  /// Stream of `abort` events handled by this [Window].
  Stream<Event> get onAbort => Element.abortEvent.forTarget(this);

  /// Stream of `animationend` events handled by this [Window].
  Stream<AnimationEvent> get onAnimationEnd =>
      animationEndEvent.forTarget(this);

  /// Stream of `animationiteration` events handled by this [Window].
  Stream<AnimationEvent> get onAnimationIteration =>
      animationIterationEvent.forTarget(this);

  /// Stream of `animationstart` events handled by this [Window].
  Stream<AnimationEvent> get onAnimationStart =>
      animationStartEvent.forTarget(this);

  /// Stream of `beforeunload` events handled by this [Window].
  Stream<Event> get onBeforeUnload => beforeUnloadEvent.forTarget(this);

  /// Stream of `blur` events handled by this [Window].
  Stream<Event> get onBlur => Element.blurEvent.forTarget(this);

  Stream<Event> get onCanPlay => Element.canPlayEvent.forTarget(this);

  Stream<Event> get onCanPlayThrough =>
      Element.canPlayThroughEvent.forTarget(this);

  /// Stream of `change` events handled by this [Window].
  Stream<Event> get onChange => Element.changeEvent.forTarget(this);

  /// Stream of `click` events handled by this [Window].
  Stream<MouseEvent> get onClick => Element.clickEvent.forTarget(this);

  /// Stream of `contentloaded` events handled by this [Window].
  Stream<Event> get onContentLoaded => contentLoadedEvent.forTarget(this);

  /// Stream of `contextmenu` events handled by this [Window].
  Stream<MouseEvent> get onContextMenu =>
      Element.contextMenuEvent.forTarget(this);

  /// Stream of `devicemotion` events handled by this [Window].
  Stream<DeviceMotionEvent> get onDeviceMotion =>
      deviceMotionEvent.forTarget(this);

  /// Stream of `deviceorientation` events handled by this [Window].
  Stream<DeviceOrientationEvent> get onDeviceOrientation =>
      deviceOrientationEvent.forTarget(this);

  /// Stream of `doubleclick` events handled by this [Window].
  @DomName('Window.ondblclick')
  Stream<Event> get onDoubleClick => Element.doubleClickEvent.forTarget(this);

  /// Stream of `drag` events handled by this [Window].
  Stream<MouseEvent> get onDrag => Element.dragEvent.forTarget(this);

  /// Stream of `dragend` events handled by this [Window].
  Stream<MouseEvent> get onDragEnd => Element.dragEndEvent.forTarget(this);

  /// Stream of `dragenter` events handled by this [Window].
  Stream<MouseEvent> get onDragEnter => Element.dragEnterEvent.forTarget(this);

  /// Stream of `dragleave` events handled by this [Window].
  Stream<MouseEvent> get onDragLeave => Element.dragLeaveEvent.forTarget(this);

  /// Stream of `dragover` events handled by this [Window].
  Stream<MouseEvent> get onDragOver => Element.dragOverEvent.forTarget(this);

  /// Stream of `dragstart` events handled by this [Window].
  Stream<MouseEvent> get onDragStart => Element.dragStartEvent.forTarget(this);

  /// Stream of `drop` events handled by this [Window].
  Stream<MouseEvent> get onDrop => Element.dropEvent.forTarget(this);

  Stream<Event> get onDurationChange =>
      Element.durationChangeEvent.forTarget(this);

  Stream<Event> get onEmptied => Element.emptiedEvent.forTarget(this);

  Stream<Event> get onEnded => Element.endedEvent.forTarget(this);

  /// Stream of `error` events handled by this [Window].
  Stream<Event> get onError => Element.errorEvent.forTarget(this);

  /// Stream of `focus` events handled by this [Window].
  Stream<Event> get onFocus => Element.focusEvent.forTarget(this);

  /// Stream of `hashchange` events handled by this [Window].
  Stream<Event> get onHashChange => hashChangeEvent.forTarget(this);

  /// Stream of `input` events handled by this [Window].
  Stream<Event> get onInput => Element.inputEvent.forTarget(this);

  /// Stream of `invalid` events handled by this [Window].
  Stream<Event> get onInvalid => Element.invalidEvent.forTarget(this);

  /// Stream of `keydown` events handled by this [Window].
  Stream<KeyboardEvent> get onKeyDown => Element.keyDownEvent.forTarget(this);

  /// Stream of `keypress` events handled by this [Window].
  Stream<KeyboardEvent> get onKeyPress => Element.keyPressEvent.forTarget(this);

  /// Stream of `keyup` events handled by this [Window].
  Stream<KeyboardEvent> get onKeyUp => Element.keyUpEvent.forTarget(this);

  /// Stream of `load` events handled by this [Window].
  Stream<Event> get onLoad => Element.loadEvent.forTarget(this);

  Stream<Event> get onLoadedData => Element.loadedDataEvent.forTarget(this);

  Stream<Event> get onLoadedMetadata =>
      Element.loadedMetadataEvent.forTarget(this);

  Stream<Event> get onLoadStart => loadStartEvent.forTarget(this);

  /// Stream of `message` events handled by this [Window].
  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  /// Stream of `mousedown` events handled by this [Window].
  Stream<MouseEvent> get onMouseDown => Element.mouseDownEvent.forTarget(this);

  /// Stream of `mouseenter` events handled by this [Window].
  Stream<MouseEvent> get onMouseEnter =>
      Element.mouseEnterEvent.forTarget(this);

  /// Stream of `mouseleave` events handled by this [Window].
  Stream<MouseEvent> get onMouseLeave =>
      Element.mouseLeaveEvent.forTarget(this);

  /// Stream of `mousemove` events handled by this [Window].
  Stream<MouseEvent> get onMouseMove => Element.mouseMoveEvent.forTarget(this);

  /// Stream of `mouseout` events handled by this [Window].
  Stream<MouseEvent> get onMouseOut => Element.mouseOutEvent.forTarget(this);

  /// Stream of `mouseover` events handled by this [Window].
  Stream<MouseEvent> get onMouseOver => Element.mouseOverEvent.forTarget(this);

  // From WindowBase64

  /// Stream of `mouseup` events handled by this [Window].
  Stream<MouseEvent> get onMouseUp => Element.mouseUpEvent.forTarget(this);

  /// Stream of `mousewheel` events handled by this [Window].
  Stream<WheelEvent> get onMouseWheel =>
      Element.mouseWheelEvent.forTarget(this);

  /// Stream of `offline` events handled by this [Window].
  Stream<Event> get onOffline => offlineEvent.forTarget(this);

  /// Stream of `online` events handled by this [Window].
  Stream<Event> get onOnline => onlineEvent.forTarget(this);

  /// Stream of `pagehide` events handled by this [Window].
  Stream<Event> get onPageHide => pageHideEvent.forTarget(this);

  /// Stream of `pageshow` events handled by this [Window].
  Stream<Event> get onPageShow => pageShowEvent.forTarget(this);

  Stream<Event> get onPause => Element.pauseEvent.forTarget(this);

  Stream<Event> get onPlay => Element.playEvent.forTarget(this);

  Stream<Event> get onPlaying => Element.playingEvent.forTarget(this);

  /// Stream of `popstate` events handled by this [Window].
  Stream<PopStateEvent> get onPopState => popStateEvent.forTarget(this);

  Stream<Event> get onProgress => progressEvent.forTarget(this);

  Stream<Event> get onRateChange => Element.rateChangeEvent.forTarget(this);

  /// Stream of `reset` events handled by this [Window].
  Stream<Event> get onReset => Element.resetEvent.forTarget(this);

  /// Stream of `resize` events handled by this [Window].
  Stream<Event> get onResize => Element.resizeEvent.forTarget(this);

  /// Stream of `scroll` events handled by this [Window].
  Stream<Event> get onScroll => Element.scrollEvent.forTarget(this);

  /// Stream of `search` events handled by this [Window].
  Stream<Event> get onSearch => Element.searchEvent.forTarget(this);

  Stream<Event> get onSeeked => Element.seekedEvent.forTarget(this);

  Stream<Event> get onSeeking => Element.seekingEvent.forTarget(this);

  /// Stream of `select` events handled by this [Window].
  Stream<Event> get onSelect => Element.selectEvent.forTarget(this);

  Stream<Event> get onStalled => Element.stalledEvent.forTarget(this);

  /// Stream of `storage` events handled by this [Window].
  Stream<StorageEvent> get onStorage => storageEvent.forTarget(this);

  /// Stream of `submit` events handled by this [Window].
  Stream<Event> get onSubmit => Element.submitEvent.forTarget(this);

  Stream<Event> get onSuspend => Element.suspendEvent.forTarget(this);

  Stream<Event> get onTimeUpdate => Element.timeUpdateEvent.forTarget(this);

  /// Stream of `touchcancel` events handled by this [Window].
  Stream<TouchEvent> get onTouchCancel =>
      Element.touchCancelEvent.forTarget(this);

  /// Stream of `touchend` events handled by this [Window].
  Stream<TouchEvent> get onTouchEnd => Element.touchEndEvent.forTarget(this);

  /// Stream of `touchmove` events handled by this [Window].
  Stream<TouchEvent> get onTouchMove => Element.touchMoveEvent.forTarget(this);

  /// Stream of `touchstart` events handled by this [Window].
  Stream<TouchEvent> get onTouchStart =>
      Element.touchStartEvent.forTarget(this);

  /// Stream of `transitionend` events handled by this [Window].
  Stream<TransitionEvent> get onTransitionEnd =>
      Element.transitionEndEvent.forTarget(this);

  /// Stream of `unload` events handled by this [Window].
  Stream<Event> get onUnload => unloadEvent.forTarget(this);

  Stream<Event> get onVolumeChange => Element.volumeChangeEvent.forTarget(this);

  Stream<Event> get onWaiting => Element.waitingEvent.forTarget(this);

  /// Stream of `wheel` events handled by this [Window].
  Stream<WheelEvent> get onWheel => Element.wheelEvent.forTarget(this);

  WindowBase get opener => null;

  set opener(Window value) {
    throw UnimplementedError();
  }

  int get orientation => 0;

  String get origin => _htmlDriver.uri.origin;

  int get pageXOffset => 0;

  int get pageYOffset => 0;

  WindowBase get parent => null;

  /// Timing and navigation data for this window.
  ///
  /// ## Other resources
  ///
  /// * [Measuring page load speed with navigation
  ///   timeing](http://www.html5rocks.com/en/tutorials/webperformance/basics/)
  ///   from HTML5Rocks.
  /// * [Navigation timing
  ///   specification](http://www.w3.org/TR/navigation-timing/) from W3C.
  Performance get performance =>
      this._performance ?? (this._performance = Performance._());

  /// Information about the screen displaying this window.
  ///
  /// ## Other resources
  ///
  /// * [The Screen interface specification](http://www.w3.org/TR/cssom-view/#screen)
  ///   from W3C.
  Screen get screen => Screen._();

  /// The distance from the left side of the screen to the left side of this
  /// window.
  ///
  /// ## Other resources
  ///
  /// * [The Screen interface specification](http://www.w3.org/TR/cssom-view/#screen)
  ///   from W3C.
  int get screenLeft => 0;

  /// The distance from the top of the screen to the top of this window.
  ///
  /// ## Other resources
  ///
  /// * [The Screen interface specification](http://www.w3.org/TR/cssom-view/#screen)
  ///   from W3C.
  int get screenTop => 0;

  /// The distance from the left side of the screen to the mouse pointer.
  ///
  /// ## Other resources
  ///
  /// * [The Screen interface specification](http://www.w3.org/TR/cssom-view/#screen)
  ///   from W3C.
  int get screenX => screenLeft;

  /// The distance from the top of the screen to the mouse pointer.
  ///
  /// ## Other resources
  ///
  /// * [The Screen interface specification](http://www.w3.org/TR/cssom-view/#screen)
  ///   from W3C.
  int get screenY => screenTop;

  /// This window's scroll bars.
  ///
  /// ## Other resources
  ///
  /// * [Browser interface
  ///   elements](https://html.spec.whatwg.org/multipage/browsers.html#browser-interface-elements)
  ///   from WHATWG.
  _BarProp get scrollbars => throw UnimplementedError();

  /// The distance this window has been scrolled horizontally.
  ///
  /// ## Other resources
  ///
  /// * [The Screen interface
  ///   specification](http://www.w3.org/TR/cssom-view/#screen) from W3C.
  /// * [scrollX](https://developer.mozilla.org/en-US/docs/Web/API/Window.scrollX)
  ///   from MDN.
  int get scrollX => document.documentElement.scrollLeft;

  /// The distance this window has been scrolled vertically.
  ///
  /// ## Other resources
  ///
  /// * [The Screen interface
  ///   specification](http://www.w3.org/TR/cssom-view/#screen) from W3C.
  /// * [scrollY](https://developer.mozilla.org/en-US/docs/Web/API/Window.scrollY)
  ///   from MDN.
  int get scrollY => document.documentElement.scrollTop;

  /// The current window.
  ///
  /// ## Other resources
  ///
  /// * [Window.self](https://developer.mozilla.org/en-US/docs/Web/API/Window.self)
  ///   from MDN.
  WindowBase get self => this;

  /// Storage for this window that is cleared when this session ends.
  ///
  /// ## Other resources
  ///
  /// * [DOM storage
  ///   guide](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Storage)
  ///   from MDN.
  /// * [The past, present & future of local storage for web
  ///   applications](http://diveintohtml5.info/storage.html) from Dive Into HTML5.
  /// * [Local storage
  ///   specification](http://www.w3.org/TR/webstorage/#dom-sessionstorage) from W3C.
  Storage get sessionStorage =>
      _sessionStorage ??
      (_sessionStorage =
          _htmlDriver.browserImplementation.newStorage(sessionStorage: true));

  /// Access to speech synthesis in the browser.
  ///
  /// ## Other resources
  ///
  /// * [Web speech
  ///   specification](https://dvcs.w3.org/hg/speech-api/raw-file/tip/speechapi.html#tts-section)
  ///   from W3C.
  SpeechSynthesis get speechSynthesis => throw UnimplementedError();

  /// This window's status bar.
  ///
  /// ## Other resources
  ///
  /// * [Browser interface
  ///   elements](https://html.spec.whatwg.org/multipage/browsers.html#browser-interface-elements)
  ///   from WHATWG.
  _BarProp get statusbar => throw UnimplementedError();

  /// Access to CSS media queries.
  ///
  /// ## Other resources
  ///
  /// * [StyleMedia class
  ///   reference](https://developer.apple.com/library/safari/documentation/SafariDOMAdditions/Reference/StyleMedia/)
  ///   from Safari Developer Library.
  StyleMedia get styleMedia => throw UnimplementedError();

  /// This window's tool bar.
  ///
  /// ## Other resources
  ///
  /// * [Browser interface
  ///   elements](https://html.spec.whatwg.org/multipage/browsers.html#browser-interface-elements)
  ///   from WHATWG.
  _BarProp get toolbar => throw UnimplementedError();

  WindowBase get top => null;

  VisualViewport get visualViewport => throw UnimplementedError();

  /// The current window.
  ///
  /// ## Other resources
  ///
  /// * [Window.window](https://developer.mozilla.org/en-US/docs/Web/API/Window.window)
  ///   from MDN.
  WindowBase get window => this;

  /// Displays a modal alert to the user.
  ///
  /// ## Other resources
  ///
  /// * [User prompts](https://html.spec.whatwg.org/multipage/webappapis.html#user-prompts)
  ///   from WHATWG.
  void alert([String message]) {}

  String atob(String atob) {
    throw UnimplementedError();
  }

  String btoa(String btoa) {
    throw UnimplementedError();
  }

  void cancelIdleCallback(int handle) {}

  void close() {
    _closed = true;
  }

  /// Displays a modal OK/Cancel prompt to the user.
  ///
  /// ## Other resources
  ///
  /// * [User prompts](https://html.spec.whatwg.org/multipage/webappapis.html#user-prompts)
  ///   from WHATWG.
  bool confirm([String message]) {
    throw UnimplementedError();
  }

  Future fetch(/*RequestInfo*/ input, [Map init]) {
    throw UnimplementedError();
  }

  /// Finds text in this window.
  ///
  /// ## Other resources
  ///
  /// * [Window.find](https://developer.mozilla.org/en-US/docs/Web/API/Window.find)
  ///   from MDN.
  bool find(String string, bool caseSensitive, bool backwards, bool wrap,
      bool wholeWord, bool searchInFrames, bool showDialog) {
    return false;
  }

  StylePropertyMapReadonly getComputedStyleMap(
      Element element, String pseudoElement) {
    throw UnimplementedError();
  }

  List<CssRule> getMatchedCssRules(Element element, String pseudoElement) {
    throw UnimplementedError();
  }

  /// Returns the currently selected text.
  ///
  /// ## Other resources
  ///
  /// * [Window.getSelection](https://developer.mozilla.org/en-US/docs/Web/API/Window.getSelection)
  ///   from MDN.
  Selection getSelection() {
    return _htmlDriver.selection;
  }

  /// Returns a list of media queries for the given query string.
  ///
  /// ## Other resources
  ///
  /// * [Testing media
  ///   queries](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Testing_media_queries)
  ///   from MDN.
  /// * [The MediaQueryList
  ///   specification](http://www.w3.org/TR/cssom-view/#the-mediaquerylist-interface) from W3C.
  MediaQueryList matchMedia(String query) {
    throw UnimplementedError();
  }

  /// Moves this window.
  ///
  /// x and y can be negative.
  ///
  /// ## Other resources
  ///
  /// * [Window.moveBy](https://developer.mozilla.org/en-US/docs/Web/API/Window.moveBy)
  ///   from MDN.
  /// * [Window.moveBy](http://dev.w3.org/csswg/cssom-view/#dom-window-moveby) from W3C.
  void moveBy(int x, int y) {}

  /// Moves this window to a specific position.
  ///
  /// x and y can be negative.
  ///
  /// ## Other resources
  ///
  /// * [Window.moveTo](https://developer.mozilla.org/en-US/docs/Web/API/Window.moveTo)
  ///   from MDN.
  /// * [Window.moveTo](http://dev.w3.org/csswg/cssom-view/#dom-window-moveto)
  ///   from W3C.
  void moveTo(Point p) {}

  /// Opens a new window.
  ///
  /// ## Other resources
  ///
  /// * [Window.open](https://developer.mozilla.org/en-US/docs/Web/API/Window.open)
  ///   from MDN.
  WindowBase open(String url, String name, [String options]) {
    return null;
  }

  void postMessage(dynamic message, String targetOrigin,
      [List<Object> transfer]) {
    _htmlDriver.addOutgoingMessage(
      message,
      targetOrigin: targetOrigin,
      transfer: transfer,
    );
  }

  /// Opens the print dialog for this window.
  ///
  /// ## Other resources
  ///
  /// * [Window.print](https://developer.mozilla.org/en-US/docs/Web/API/Window.print)
  ///   from MDN.
  void print() {}

  /// Called to draw an animation frame and then request the window to repaint
  /// after [callback] has finished (creating the animation).
  ///
  /// Use this method only if you need to later call [cancelAnimationFrame]. If
  /// not, the preferred Dart idiom is to set animation frames by calling
  /// [animationFrame], which returns a Future.
  ///
  /// Returns a non-zero valued integer to represent the request id for this
  /// request. This value only needs to be saved if you intend to call
  /// [cancelAnimationFrame] so you can specify the particular animation to
  /// cancel.
  ///
  /// Note: The supplied [callback] needs to call [requestAnimationFrame] again
  /// for the animation to continue.
  int requestAnimationFrame(FrameRequestCallback callback) {
    throw UnimplementedError();
  }

  /// Access a sandboxed file system of `size` bytes.
  ///
  /// If `persistent` is true, the application will request permission from the
  /// user to create lasting storage. This storage cannot be freed without the
  /// user's permission. Returns a [Future] whose value stores a reference to
  /// the sandboxed file system for use. Because the file system is sandboxed,
  /// applications cannot access file systems created in other web pages.
  Future<FileSystem> requestFileSystem(int size, {bool persistent = false}) {
    return _htmlDriver.browserImplementation.windowRequestFileSystem(
      size,
      persistent: false,
    );
  }

  int requestIdleCallback(IdleRequestCallback callback, [Map options]) {
    Timer(const Duration(microseconds: 1), () {
      final idleDeadline =
          IdleDeadline._(DateTime.now().add(const Duration(microseconds: 10)));
      callback(idleDeadline);
    });
    return 0;
  }

  /// Resizes this window by an offset.
  ///
  /// ## Other resources
  ///
  /// * [Window.resizeBy](https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeBy)
  ///   from MDN.
  void resizeBy(int x, int y) {}

  /// Resizes this window to a specific width and height.
  ///
  /// ## Other resources
  ///
  /// * [Window.resizeTo](https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeTo)
  ///   from MDN.
  void resizeTo(int x, int y) {}

  /// Asynchronously retrieves a local filesystem entry.
  ///
  /// ## Other resources
  ///
  /// * [Obtaining access to file system entry
  ///   points](http://www.w3.org/TR/file-system-api/#obtaining-access-to-file-system-entry-points)
  /// from W3C.
  Future<Entry> resolveLocalFileSystemUrl(String url) {
    throw UnimplementedError();
  }

  /// Scrolls the page horizontally and vertically to a specific point.
  ///
  /// This method is identical to [scrollTo].
  ///
  /// ## Other resources
  ///
  /// * [Window.scroll](https://developer.mozilla.org/en-US/docs/Web/API/Window/scroll)
  ///   from MDN.
  void scroll([options_OR_x, y, Map scrollOptions]) {}

  /// Scrolls the page horizontally and vertically by an offset.
  ///
  /// ## Other resources
  ///
  /// * [Window.scrollBy](https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollBy)
  ///   from MDN.
  void scrollBy([options_OR_x, y, Map scrollOptions]) {}

  /// Scrolls the page horizontally and vertically to a specific point.
  ///
  /// This method is identical to [scroll].
  ///
  /// ## Other resources
  ///
  /// * [Window.scrollTo](https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollTo)
  ///   from MDN.
  void scrollTo([options_OR_x, y, Map scrollOptions]) {}

  /// Stops the window from loading.
  ///
  /// ## Other resources
  ///
  /// * [The Window
  ///   object](http://www.w3.org/html/wg/drafts/html/master/browsers.html#the-window-object)
  ///   from W3C.
  void stop() {}
}

abstract class WindowBase {
  bool get closed;

  /// The current session history for this window's newest document.
  ///
  /// ## Other resources
  ///
  /// * [Loading web pages](https://html.spec.whatwg.org/multipage/browsers.html)
  ///   from WHATWG.
  History get history;

  Location get location;

  WindowBase get opener => null;

  WindowBase get parent => null;

  WindowBase get top => null;

  void close();

  void postMessage(dynamic message, String targetOrigin,
      [List<Object> transfer]);
}

abstract class WindowEventHandlers extends EventTarget {
  static const EventStreamProvider<Event> hashChangeEvent =
      EventStreamProvider<Event>('hashchange');

  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  static const EventStreamProvider<Event> offlineEvent =
      EventStreamProvider<Event>('offline');

  static const EventStreamProvider<Event> onlineEvent =
      EventStreamProvider<Event>('online');

  static const EventStreamProvider<PopStateEvent> popStateEvent =
      EventStreamProvider<PopStateEvent>('popstate');

  static const EventStreamProvider<StorageEvent> storageEvent =
      EventStreamProvider<StorageEvent>('storage');

  static const EventStreamProvider<Event> unloadEvent =
      EventStreamProvider<Event>('unload');

  factory WindowEventHandlers._() {
    throw UnsupportedError("Not supported");
  }

  Stream<Event> get onHashChange => hashChangeEvent.forTarget(this);

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Stream<Event> get onOffline => offlineEvent.forTarget(this);

  Stream<Event> get onOnline => onlineEvent.forTarget(this);

  Stream<PopStateEvent> get onPopState => popStateEvent.forTarget(this);

  Stream<StorageEvent> get onStorage => storageEvent.forTarget(this);

  Stream<Event> get onUnload => unloadEvent.forTarget(this);
}
