////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import flash.events.Event;
	import flash.events.TransformGestureEvent;

	use namespace $internal;

	[ExcludeClass]
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					02.10.2011 23:52:19
	 */
	internal final class $TransformGestureEvent extends TransformGestureEvent implements INativeEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Internal class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		$internal static function get(event:TransformGestureEvent):$TransformGestureEvent {
			return new $TransformGestureEvent( event.type, event.bubbles, event.cancelable, event.phase, event.localX, event.localY, event.scaleX, event.scaleY, event.rotation, event.offsetX, event.offsetY, event.ctrlKey, event.altKey, event.shiftKey );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function $TransformGestureEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, phase:String=null, localX:Number=0, localY:Number=0, scaleX:Number=1.0, scaleY:Number=1.0, rotation:Number=0, offsetX:Number=0, offsetY:Number=0, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false) {
			super( type, bubbles, cancelable, phase, localX, localY, scaleX, scaleY, rotation, offsetX, offsetY, ctrlKey, altKey, shiftKey );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		$internal var $stopped:Boolean = false;
		
		/**
		 * @private
		 */
		$internal var $canceled:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Overriden properties: Event
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  target
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var $target:Object;
		
		/**
		 * @private
		 * Сцылка на таргет.
		 */
		public override function get target():Object {
			return this.$target || super.target;
		}
		
		//----------------------------------
		//  eventPhase
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var $eventPhase:uint;
		
		/**
		 * @private
		 * Фаза.
		 */
		public override function get eventPhase():uint {
			return this.$eventPhase || super.eventPhase;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overriden methods: Event
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		public override function stopImmediatePropagation():void {
			super.stopImmediatePropagation();
			this.$stopped = true;
		}
		
		/**
		 * @private
		 */
		public override function stopPropagation():void {
			this.$stopped = true;
		}
		
		/**
		 * @private
		 */
		public override function preventDefault():void {
			if ( super.cancelable ) this.$canceled = true;
		}
		
		/**
		 * @private
		 */
		public override function isDefaultPrevented():Boolean {
			return this.$canceled;
		}
		
		/**
		 * @private
		 */
		public override function clone():Event {
			return new $TransformGestureEvent( super.type, super.bubbles, super.cancelable, super.phase, super.localX, super.localY, super.scaleX, super.scaleY, super.rotation, super.offsetX, super.offsetY, super.ctrlKey, super.altKey, super.shiftKey );
		}
		
	}
	
}