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



},{}],"logger":[function(require,module,exports){
exports.keen = function() {
  return new Keen({
    projectId: '54ed8c642fd4b14d3bc9a823',
    writeKey: 'c4aaeb6bf7c70d14951ecc8148d42ed8a5fe3ed1cef64c039ade9c57d56da2fb87b4b63e0c7ebac6d15168085f7b7d4a13b14a7cc974b2edfa825b2c1ea081af76e8cc7f342dcdef3485a6aca4518d51164f9cb83c36b4627fd225b80f8f8a2fc1446b7421638242457aec071ff12ce0'
  });
};

exports.log = function(keen, name, state, action) {
  var keenEvent, keenEventSimple;
  keenEvent = {
    click: name,
    state: state,
    action: action,
    keen: {
      "addons": [
        {
          "name": "keen:ip_to_geo",
          "input": {
            "ip": "ip_address"
          },
          "output": "ip_geo_info"
        }, {
          "name": "keen:ua_parser",
          "input": {
            "ua_string": "user_agent"
          },
          "output": "parsed_user_agent"
        }
      ]
    },
    "ip_address": "${keen.ip}",
    "user_agent": "${keen.user_agent}"
  };
  keen.addEvent("clicks", keenEvent);
  keenEventSimple = {
    click: name,
    state: state,
    action: action
  };
  return keen.addEvent("clicks-simple", keenEventSimple);
};



},{}]},{},[])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvenJoMC9Ecm9wYm94L19fX19fX19fX19fX0QtRU5HL2Rlc2lnbi1lbmdpbmVlci9nYWxsZXJ5LmZyYW1lci9tb2R1bGVzL2hhbW1lci5jb2ZmZWUiLCIvVXNlcnMvenJoMC9Ecm9wYm94L19fX19fX19fX19fX0QtRU5HL2Rlc2lnbi1lbmdpbmVlci9nYWxsZXJ5LmZyYW1lci9tb2R1bGVzL2xvZ2dlci5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQSxJQUFBOztxSkFBQTs7QUFBQSxPQUFPLENBQUMsSUFBUixHQUFlLFNBQUEsR0FBQTtBQUdkLE1BQUEseUJBQUE7QUFBQSxFQUFBLFlBQUEsR0FDQztBQUFBLElBQUEsSUFBQSxFQUFNLE1BQU47R0FERCxDQUFBO0FBQUEsRUFHQSxNQUFNLENBQUMsTUFBUCxHQUFnQixDQUFDLENBQUMsTUFBRixDQUFTLE1BQVQsRUFBaUIsWUFBakIsQ0FIaEIsQ0FBQTtBQUFBLEVBS007QUFDTCxtQ0FBQSxDQUFBOzs7O0tBQUE7O0FBQUEsMEJBQUEsRUFBQSxHQUFJLFNBQUMsU0FBRCxFQUFZLENBQVosR0FBQTtBQUNILFVBQUEsTUFBQTtBQUFBLE1BQUEsSUFBRyxhQUFhLENBQUMsQ0FBQyxNQUFGLENBQVMsWUFBVCxDQUFiLEVBQUEsU0FBQSxNQUFIO0FBQ0MsUUFBQSxJQUFDLENBQUEsWUFBRCxHQUFnQixLQUFoQixDQUFBO2VBQ0EsTUFBQSxHQUFTLE1BQUEsQ0FBTyxJQUFDLENBQUEsUUFBUixDQUFpQixDQUFDLEVBQWxCLENBQXFCLFNBQXJCLEVBQWdDLENBQWhDLEVBRlY7T0FBQSxNQUFBO2VBSUMsb0NBQU0sU0FBTixFQUFpQixDQUFqQixFQUpEO09BREc7SUFBQSxDQUFKLENBQUE7O3VCQUFBOztLQUR5QixNQUFNLENBQUMsTUFMakMsQ0FBQTtTQWFBLE1BQU0sQ0FBQyxLQUFQLEdBQWUsWUFoQkQ7QUFBQSxDQUFmLENBQUE7Ozs7O0FDQUEsT0FBTyxDQUFDLElBQVIsR0FBZSxTQUFBLEdBQUE7U0FDVixJQUFBLElBQUEsQ0FDSDtBQUFBLElBQUEsU0FBQSxFQUFXLDBCQUFYO0FBQUEsSUFDQSxRQUFBLEVBQVUsa09BRFY7R0FERyxFQURVO0FBQUEsQ0FBZixDQUFBOztBQUFBLE9BS08sQ0FBQyxHQUFSLEdBQWMsU0FBQyxJQUFELEVBQU8sSUFBUCxFQUFhLEtBQWIsRUFBb0IsTUFBcEIsR0FBQTtBQUNiLE1BQUEsMEJBQUE7QUFBQSxFQUFBLFNBQUEsR0FBWTtBQUFBLElBQ1gsS0FBQSxFQUFPLElBREk7QUFBQSxJQUVYLEtBQUEsRUFBTyxLQUZJO0FBQUEsSUFHWCxNQUFBLEVBQVEsTUFIRztBQUFBLElBSVgsSUFBQSxFQUFNO0FBQUEsTUFBRSxRQUFBLEVBQVc7UUFDakI7QUFBQSxVQUNDLE1BQUEsRUFBUyxnQkFEVjtBQUFBLFVBRUMsT0FBQSxFQUFVO0FBQUEsWUFDVCxJQUFBLEVBQU8sWUFERTtXQUZYO0FBQUEsVUFLQyxRQUFBLEVBQVcsYUFMWjtTQURpQixFQU9kO0FBQUEsVUFDRixNQUFBLEVBQVMsZ0JBRFA7QUFBQSxVQUVGLE9BQUEsRUFBVTtBQUFBLFlBQ1QsV0FBQSxFQUFjLFlBREw7V0FGUjtBQUFBLFVBS0YsUUFBQSxFQUFXLG1CQUxUO1NBUGM7T0FBYjtLQUpLO0FBQUEsSUFvQlgsWUFBQSxFQUFlLFlBcEJKO0FBQUEsSUFxQlgsWUFBQSxFQUFlLG9CQXJCSjtHQUFaLENBQUE7QUFBQSxFQXVCQSxJQUFJLENBQUMsUUFBTCxDQUFjLFFBQWQsRUFBd0IsU0FBeEIsQ0F2QkEsQ0FBQTtBQUFBLEVBd0JBLGVBQUEsR0FBa0I7QUFBQSxJQUNqQixLQUFBLEVBQU8sSUFEVTtBQUFBLElBRWpCLEtBQUEsRUFBTyxLQUZVO0FBQUEsSUFHakIsTUFBQSxFQUFRLE1BSFM7R0F4QmxCLENBQUE7U0E2QkEsSUFBSSxDQUFDLFFBQUwsQ0FBYyxlQUFkLEVBQStCLGVBQS9CLEVBOUJhO0FBQUEsQ0FMZCxDQUFBIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsImV4cG9ydHMuaW5pdCA9IC0+XG5cdCMgSGFtbWVyLmpzIGludGVncmF0aW9uIGJ5IEtvZW4gQm9rXG5cblx0SGFtbWVyRXZlbnRzID1cblx0XHRIb2xkOiBcImhvbGRcIlxuXG5cdHdpbmRvdy5FdmVudHMgPSBfLmV4dGVuZCBFdmVudHMsIEhhbW1lckV2ZW50c1xuXG5cdGNsYXNzIEhhbW1lckxheWVyIGV4dGVuZHMgRnJhbWVyLkxheWVyXG5cdFx0b246IChldmVudE5hbWUsIGYpIC0+XG5cdFx0XHRpZiBldmVudE5hbWUgaW4gXy52YWx1ZXMoSGFtbWVyRXZlbnRzKVxuXHRcdFx0XHRAaWdub3JlRXZlbnRzID0gZmFsc2VcdFx0XHRcblx0XHRcdFx0aGFtbWVyID0gSGFtbWVyKEBfZWxlbWVudCkub24gZXZlbnROYW1lLCBmXG5cdFx0XHRlbHNlXG5cdFx0XHRcdHN1cGVyIGV2ZW50TmFtZSwgZlxuXG5cdHdpbmRvdy5MYXllciA9IEhhbW1lckxheWVyXG4iLCJleHBvcnRzLmtlZW4gPSAtPlxuXHRuZXcgS2Vlbihcblx0XHRwcm9qZWN0SWQ6ICc1NGVkOGM2NDJmZDRiMTRkM2JjOWE4MjMnXG5cdFx0d3JpdGVLZXk6ICdjNGFhZWI2YmY3YzcwZDE0OTUxZWNjODE0OGQ0MmVkOGE1ZmUzZWQxY2VmNjRjMDM5YWRlOWM1N2Q1NmRhMmZiODdiNGI2M2UwYzdlYmFjNmQxNTE2ODA4NWY3YjdkNGExM2IxNGE3Y2M5NzRiMmVkZmE4MjViMmMxZWEwODFhZjc2ZThjYzdmMzQyZGNkZWYzNDg1YTZhY2E0NTE4ZDUxMTY0ZjljYjgzYzM2YjQ2MjdmZDIyNWI4MGY4ZjhhMmZjMTQ0NmI3NDIxNjM4MjQyNDU3YWVjMDcxZmYxMmNlMCcpXG5cbmV4cG9ydHMubG9nID0gKGtlZW4sIG5hbWUsIHN0YXRlLCBhY3Rpb24pIC0+XG5cdGtlZW5FdmVudCA9IHtcblx0XHRjbGljazogbmFtZVxuXHRcdHN0YXRlOiBzdGF0ZVxuXHRcdGFjdGlvbjogYWN0aW9uXG5cdFx0a2VlbjogeyBcImFkZG9uc1wiIDogW1xuXHRcdFx0XHR7XG5cdFx0XHRcdFx0XCJuYW1lXCIgOiBcImtlZW46aXBfdG9fZ2VvXCJcblx0XHRcdFx0XHRcImlucHV0XCIgOiB7XG5cdFx0XHRcdFx0XHRcImlwXCIgOiBcImlwX2FkZHJlc3NcIlxuXHRcdFx0XHRcdH1cblx0XHRcdFx0XHRcIm91dHB1dFwiIDogXCJpcF9nZW9faW5mb1wiXG5cdFx0XHRcdH0sIHtcblx0XHRcdFx0XHRcIm5hbWVcIiA6IFwia2Vlbjp1YV9wYXJzZXJcIlxuXHRcdFx0XHRcdFwiaW5wdXRcIiA6IHtcblx0XHRcdFx0XHRcdFwidWFfc3RyaW5nXCIgOiBcInVzZXJfYWdlbnRcIlxuXHRcdFx0XHRcdH1cblx0XHRcdFx0XHRcIm91dHB1dFwiIDogXCJwYXJzZWRfdXNlcl9hZ2VudFwiXG5cdFx0XHRcdH1cblx0XHRcdF1cblx0XHR9LFxuXHRcdFwiaXBfYWRkcmVzc1wiIDogXCIke2tlZW4uaXB9XCJcblx0XHRcInVzZXJfYWdlbnRcIiA6IFwiJHtrZWVuLnVzZXJfYWdlbnR9XCJcblx0fVxuXHRrZWVuLmFkZEV2ZW50KFwiY2xpY2tzXCIsIGtlZW5FdmVudClcblx0a2VlbkV2ZW50U2ltcGxlID0ge1xuXHRcdGNsaWNrOiBuYW1lXG5cdFx0c3RhdGU6IHN0YXRlXG5cdFx0YWN0aW9uOiBhY3Rpb25cblx0fVxuXHRrZWVuLmFkZEV2ZW50KFwiY2xpY2tzLXNpbXBsZVwiLCBrZWVuRXZlbnRTaW1wbGUpIl19
