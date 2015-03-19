require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"constants":[function(require,module,exports){
var define;

define = function(name, value) {
  Object.defineProperty(exports, name, {
    value: value,
    enumerable: true
  });
};

define("DEVICE_WIDTH", Framer.Device.screen.width);

define("DEVICE_HEIGHT", Framer.Device.screen.height);



},{}],"hammer":[function(require,module,exports){
var HammerEvents, HammerLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

HammerEvents = {
  Hold: "hold"
};

window.Events = _.extend(Events, HammerEvents);

HammerLayer = (function(superClass) {
  extend(HammerLayer, superClass);

  function HammerLayer() {
    return HammerLayer.__super__.constructor.apply(this, arguments);
  }

  HammerLayer.prototype.on = function(eventName, f) {
    var hammer;
    if (indexOf.call(_.values(HammerEvents), eventName) >= 0) {
      this.ignoreEvents = false;
      return hammer = Hammer(this._element).on(eventName, f);
    } else {
      return HammerLayer.__super__.on.call(this, eventName, f);
    }
  };

  return HammerLayer;

})(Framer.Layer);

window.Layer = HammerLayer;



},{}],"layout":[function(require,module,exports){




},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];



},{}]},{},[])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvenJoMC9Ecm9wYm94L19XT1JLL19BUFBMSUNBVElPTlMvX19fX19fX19fX19fRC1FTkcvZGVzaWduLWVuZ2luZWVyL2dhbGxlcnkuZnJhbWVyL21vZHVsZXMvY29uc3RhbnRzLmNvZmZlZSIsIi9Vc2Vycy96cmgwL0Ryb3Bib3gvX1dPUksvX0FQUExJQ0FUSU9OUy9fX19fX19fX19fX19ELUVORy9kZXNpZ24tZW5naW5lZXIvZ2FsbGVyeS5mcmFtZXIvbW9kdWxlcy9oYW1tZXIuY29mZmVlIiwiLi4vLi4vLi4vLi4vLi4vVXNlcnMvenJoMC9Ecm9wYm94L19XT1JLL19BUFBMSUNBVElPTlMvX19fX19fX19fX19fRC1FTkcvZGVzaWduLWVuZ2luZWVyL2dhbGxlcnkuZnJhbWVyL21vZHVsZXMvbGF5b3V0LmNvZmZlZSIsIi9Vc2Vycy96cmgwL0Ryb3Bib3gvX1dPUksvX0FQUExJQ0FUSU9OUy9fX19fX19fX19fX19ELUVORy9kZXNpZ24tZW5naW5lZXIvZ2FsbGVyeS5mcmFtZXIvbW9kdWxlcy9teU1vZHVsZS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQSxJQUFBLE1BQUE7O0FBQUEsTUFBQSxHQUFTLFNBQUMsSUFBRCxFQUFPLEtBQVAsR0FBQTtBQUNQLEVBQUEsTUFBTSxDQUFDLGNBQVAsQ0FBc0IsT0FBdEIsRUFBK0IsSUFBL0IsRUFDRTtBQUFBLElBQUEsS0FBQSxFQUFPLEtBQVA7QUFBQSxJQUNBLFVBQUEsRUFBWSxJQURaO0dBREYsQ0FBQSxDQURPO0FBQUEsQ0FBVCxDQUFBOztBQUFBLE1BTUEsQ0FBTyxjQUFQLEVBQXVCLE1BQU0sQ0FBQyxNQUFNLENBQUMsTUFBTSxDQUFDLEtBQTVDLENBTkEsQ0FBQTs7QUFBQSxNQU9BLENBQU8sZUFBUCxFQUF3QixNQUFNLENBQUMsTUFBTSxDQUFDLE1BQU0sQ0FBQyxNQUE3QyxDQVBBLENBQUE7Ozs7O0FDR0EsSUFBQSx5QkFBQTtFQUFBOztxSkFBQTs7QUFBQSxZQUFBLEdBQ0M7QUFBQSxFQUFBLElBQUEsRUFBTSxNQUFOO0NBREQsQ0FBQTs7QUFBQSxNQUdNLENBQUMsTUFBUCxHQUFnQixDQUFDLENBQUMsTUFBRixDQUFTLE1BQVQsRUFBaUIsWUFBakIsQ0FIaEIsQ0FBQTs7QUFBQTtBQU1DLGlDQUFBLENBQUE7Ozs7R0FBQTs7QUFBQSx3QkFBQSxFQUFBLEdBQUksU0FBQyxTQUFELEVBQVksQ0FBWixHQUFBO0FBQ0gsUUFBQSxNQUFBO0FBQUEsSUFBQSxJQUFHLGFBQWEsQ0FBQyxDQUFDLE1BQUYsQ0FBUyxZQUFULENBQWIsRUFBQSxTQUFBLE1BQUg7QUFDQyxNQUFBLElBQUMsQ0FBQSxZQUFELEdBQWdCLEtBQWhCLENBQUE7YUFDQSxNQUFBLEdBQVMsTUFBQSxDQUFPLElBQUMsQ0FBQSxRQUFSLENBQWlCLENBQUMsRUFBbEIsQ0FBcUIsU0FBckIsRUFBZ0MsQ0FBaEMsRUFGVjtLQUFBLE1BQUE7YUFJQyxvQ0FBTSxTQUFOLEVBQWlCLENBQWpCLEVBSkQ7S0FERztFQUFBLENBQUosQ0FBQTs7cUJBQUE7O0dBRHlCLE1BQU0sQ0FBQyxNQUxqQyxDQUFBOztBQUFBLE1BYU0sQ0FBQyxLQUFQLEdBQWUsV0FiZixDQUFBOzs7OztBQ0hBO0FBQ0E7QUFDQTtBQUNBOztBQ0NBLE9BQU8sQ0FBQyxLQUFSLEdBQWdCLFlBQWhCLENBQUE7O0FBQUEsT0FFTyxDQUFDLFVBQVIsR0FBcUIsU0FBQSxHQUFBO1NBQ3BCLEtBQUEsQ0FBTSx1QkFBTixFQURvQjtBQUFBLENBRnJCLENBQUE7O0FBQUEsT0FLTyxDQUFDLE9BQVIsR0FBa0IsQ0FBQyxDQUFELEVBQUksQ0FBSixFQUFPLENBQVAsQ0FMbEIsQ0FBQSIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJkZWZpbmUgPSAobmFtZSwgdmFsdWUpIC0+XG4gIE9iamVjdC5kZWZpbmVQcm9wZXJ0eSBleHBvcnRzLCBuYW1lLFxuICAgIHZhbHVlOiB2YWx1ZVxuICAgIGVudW1lcmFibGU6IHRydWVcbiAgcmV0dXJuXG5cbmRlZmluZShcIkRFVklDRV9XSURUSFwiLCBGcmFtZXIuRGV2aWNlLnNjcmVlbi53aWR0aCk7XG5kZWZpbmUoXCJERVZJQ0VfSEVJR0hUXCIsIEZyYW1lci5EZXZpY2Uuc2NyZWVuLmhlaWdodCk7XG4iLCIjIFRoaXMgbmVlZHMgdG8gYmUgbG9hZGVkIGF0IHRoZSBiZWdpbm5pbmcuLi5cbiMgSGFtbWVyLmpzIGludGVncmF0aW9uIGJ5IEtvZW4gQm9rXG5cbkhhbW1lckV2ZW50cyA9XG5cdEhvbGQ6IFwiaG9sZFwiXG5cbndpbmRvdy5FdmVudHMgPSBfLmV4dGVuZCBFdmVudHMsIEhhbW1lckV2ZW50c1xuXG5jbGFzcyBIYW1tZXJMYXllciBleHRlbmRzIEZyYW1lci5MYXllclxuXHRvbjogKGV2ZW50TmFtZSwgZikgLT5cblx0XHRpZiBldmVudE5hbWUgaW4gXy52YWx1ZXMoSGFtbWVyRXZlbnRzKVxuXHRcdFx0QGlnbm9yZUV2ZW50cyA9IGZhbHNlXHRcdFx0XG5cdFx0XHRoYW1tZXIgPSBIYW1tZXIoQF9lbGVtZW50KS5vbiBldmVudE5hbWUsIGZcblx0XHRlbHNlXG5cdFx0XHRzdXBlciBldmVudE5hbWUsIGZcblxud2luZG93LkxheWVyID0gSGFtbWVyTGF5ZXJcbiIsIlxuXG4vLyMgc291cmNlTWFwcGluZ1VSTD1kYXRhOmFwcGxpY2F0aW9uL2pzb247YmFzZTY0LGV5SjJaWEp6YVc5dUlqb3pMQ0ptYVd4bElqb2lMMVZ6WlhKekwzcHlhREF2UkhKdmNHSnZlQzlmVjA5U1N5OWZRVkJRVEVsRFFWUkpUMDVUTDE5ZlgxOWZYMTlmWDE5ZlgwUXRSVTVITDJSbGMybG5iaTFsYm1kcGJtVmxjaTluWVd4c1pYSjVMbVp5WVcxbGNpOXRiMlIxYkdWekwyeGhlVzkxZEM1amIyWm1aV1VpTENKemIzVnlZMlZTYjI5MElqb2lJaXdpYzI5MWNtTmxjeUk2V3lJdlZYTmxjbk12ZW5Kb01DOUVjbTl3WW05NEwxOVhUMUpMTDE5QlVGQk1TVU5CVkVsUFRsTXZYMTlmWDE5ZlgxOWZYMTlmUkMxRlRrY3ZaR1Z6YVdkdUxXVnVaMmx1WldWeUwyZGhiR3hsY25rdVpuSmhiV1Z5TDIxdlpIVnNaWE12YkdGNWIzVjBMbU52Wm1abFpTSmRMQ0p1WVcxbGN5STZXMTBzSW0xaGNIQnBibWR6SWpvaVFVRkJRU0lzSW5OdmRYSmpaWE5EYjI1MFpXNTBJanBiSWlKZGZRPT1cbiIsIiMgQWRkIHRoZSBmb2xvd2luZyBsaW5lIHRvIHlvdXIgcHJvamVjdCBpbiBGcmFtZXIgU3R1ZGlvLiBcbiMgbW9kdWxlID0gcmVxdWlyZSBcIm1vZHVsZVwiXG4jIFJlZmVyZW5jZSB0aGUgY29udGVudHMgYnkgbmFtZSwgbGlrZSBtb2R1bGUubXlGdW5jKCkgb3IgbW9kdWxlLm15VmFyXG5cbmV4cG9ydHMubXlWYXIgPSBcIm15VmFyaWFibGVcIlxuXG5leHBvcnRzLm15RnVuY3Rpb24gPSAtPlxuXHRwcmludCBcIm15RnVuY3Rpb24gaXMgcnVubmluZ1wiXG5cbmV4cG9ydHMubXlBcnJheSA9IFsxLCAyLCAzXSJdfQ==
