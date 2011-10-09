////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import flash.events.Event;
	import flash.events.TransformGestureEvent;

	//--------------------------------------
	//  Namespaces
	//--------------------------------------
	
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
		$internal static function $get(event:TransformGestureEvent):$TransformGestureEvent {
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
		//  Includes
		//
		//--------------------------------------------------------------------------
		
		include 'event_base.as';
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		public override function clone():Event {
			return new $TransformGestureEvent( super.type, super.bubbles, super.cancelable, super.phase, super.localX, super.localY, super.scaleX, super.scaleY, super.rotation, super.offsetX, super.offsetY, super.ctrlKey, super.altKey, super.shiftKey );
		}
		
	}
	
}