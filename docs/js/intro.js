import Typed from "typed.js";

var options = {
  strings: ["<i>First</i> sentence.", "&amp; a second sentence."],
  typeSpeed: 40
};

var typed = new Typed(".element", options);

var typed = new Typed("#typed", {
  stringsElement: "#typed-strings",
  typeSpeed: 0,
  backSpeed: 0,
  backDelay: 500,
  startDelay: 1000,
  loop: false,
  onBegin: function(self) {
    prettyLog("onBegin " + self);
  },
  onComplete: function(self) {
    prettyLog("onCmplete " + self);
  },
  preStringTyped: function(pos, self) {
    prettyLog("preStringTyped " + pos + " " + self);
  },
  onStringTyped: function(pos, self) {
    prettyLog("onStringTyped " + pos + " " + self);
  },
  onLastStringBackspaced: function(self) {
    prettyLog("onLastStringBackspaced " + self);
  },
  onTypingPaused: function(pos, self) {
    prettyLog("onTypingPaused " + pos + " " + self);
  },
  onTypingResumed: function(pos, self) {
    prettyLog("onTypingResumed " + pos + " " + self);
  },
  onReset: function(self) {
    prettyLog("onReset " + self);
  },
  onStop: function(pos, self) {
    prettyLog("onStop " + pos + " " + self);
  },
  onStart: function(pos, self) {
    prettyLog("onStart " + pos + " " + self);
  },
  onDestroy: function(self) {
    prettyLog("onDestroy " + self);
  }
});
