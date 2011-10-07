////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import flash.events.Event;
	import flash.events.GestureEvent;

	use namespace $internal;

	[ExcludeClass]
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					02.10.2011 23:59:55
	 */
	internal final class $GestureEvent extends GestureEvent implements INativeEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Internal class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		$internal static function get(event:GestureEvent):$GestureEvent {
			return new $GestureEvent( event.type, event.bubbles, event.cancelable, event.phase, event.localX, event.localY, event.ctrlKey, event.altKey, event.shiftKey );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function $GestureEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, phase:String=null, localX:Number=0, localY:Number=0, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false) {
			super( type, bubbles, cancelable, phase, localX, localY, ctrlKey, altKey, shiftKey );
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
			return new $GestureEvent( super.type, super.bubbles, super.cancelable, super.phase, super.localX, super.localY, super.ctrlKey, super.altKey, super.shiftKey );
		}
		
	}
	
}