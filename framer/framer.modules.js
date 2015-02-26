require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"hammer":[function(require,module,exports){
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

exports.init = function() {
  var HammerEvents, HammerLayer;
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
  return window.Layer = HammerLayer;
};



},{}]},{},[])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvenJoMC9Ecm9wYm94L19fX19fX19fX19fX0QtRU5HL2Rlc2lnbi1lbmdpbmVlci9nYWxsZXJ5LmZyYW1lci9tb2R1bGVzL2hhbW1lci5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQSxJQUFBOztxSkFBQTs7QUFBQSxPQUFPLENBQUMsSUFBUixHQUFlLFNBQUEsR0FBQTtBQUdkLE1BQUEseUJBQUE7QUFBQSxFQUFBLFlBQUEsR0FDQztBQUFBLElBQUEsSUFBQSxFQUFNLE1BQU47R0FERCxDQUFBO0FBQUEsRUFHQSxNQUFNLENBQUMsTUFBUCxHQUFnQixDQUFDLENBQUMsTUFBRixDQUFTLE1BQVQsRUFBaUIsWUFBakIsQ0FIaEIsQ0FBQTtBQUFBLEVBS007QUFDTCxtQ0FBQSxDQUFBOzs7O0tBQUE7O0FBQUEsMEJBQUEsRUFBQSxHQUFJLFNBQUMsU0FBRCxFQUFZLENBQVosR0FBQTtBQUNILFVBQUEsTUFBQTtBQUFBLE1BQUEsSUFBRyxhQUFhLENBQUMsQ0FBQyxNQUFGLENBQVMsWUFBVCxDQUFiLEVBQUEsU0FBQSxNQUFIO0FBQ0MsUUFBQSxJQUFDLENBQUEsWUFBRCxHQUFnQixLQUFoQixDQUFBO2VBQ0EsTUFBQSxHQUFTLE1BQUEsQ0FBTyxJQUFDLENBQUEsUUFBUixDQUFpQixDQUFDLEVBQWxCLENBQXFCLFNBQXJCLEVBQWdDLENBQWhDLEVBRlY7T0FBQSxNQUFBO2VBSUMsb0NBQU0sU0FBTixFQUFpQixDQUFqQixFQUpEO09BREc7SUFBQSxDQUFKLENBQUE7O3VCQUFBOztLQUR5QixNQUFNLENBQUMsTUFMakMsQ0FBQTtTQWFBLE1BQU0sQ0FBQyxLQUFQLEdBQWUsWUFoQkQ7QUFBQSxDQUFmLENBQUEiLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXNDb250ZW50IjpbIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIiwiZXhwb3J0cy5pbml0ID0gLT5cblx0IyBIYW1tZXIuanMgaW50ZWdyYXRpb24gYnkgS29lbiBCb2tcblxuXHRIYW1tZXJFdmVudHMgPVxuXHRcdEhvbGQ6IFwiaG9sZFwiXG5cblx0d2luZG93LkV2ZW50cyA9IF8uZXh0ZW5kIEV2ZW50cywgSGFtbWVyRXZlbnRzXG5cblx0Y2xhc3MgSGFtbWVyTGF5ZXIgZXh0ZW5kcyBGcmFtZXIuTGF5ZXJcblx0XHRvbjogKGV2ZW50TmFtZSwgZikgLT5cblx0XHRcdGlmIGV2ZW50TmFtZSBpbiBfLnZhbHVlcyhIYW1tZXJFdmVudHMpXG5cdFx0XHRcdEBpZ25vcmVFdmVudHMgPSBmYWxzZVx0XHRcdFxuXHRcdFx0XHRoYW1tZXIgPSBIYW1tZXIoQF9lbGVtZW50KS5vbiBldmVudE5hbWUsIGZcblx0XHRcdGVsc2Vcblx0XHRcdFx0c3VwZXIgZXZlbnROYW1lLCBmXG5cblx0d2luZG93LkxheWVyID0gSGFtbWVyTGF5ZXJcbiJdfQ==
