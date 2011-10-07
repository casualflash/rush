////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import flash.events.Event;
	import flash.events.PressAndTapGestureEvent;

	use namespace $internal;

	[ExcludeClass]
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					02.10.2011 23:54:14
	 */
	internal final class $PressAndTapGestureEvent extends PressAndTapGestureEvent implements INativeEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Internal class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		$internal static function get(event:PressAndTapGestureEvent):$PressAndTapGestureEvent {
			return new $PressAndTapGestureEvent( event.type, event.bubbles, event.cancelable, event.phase, event.localX, event.localY, event.tapLocalX, event.tapLocalY, event.ctrlKey, event.altKey, event.shiftKey );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function $PressAndTapGestureEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, phase:String=null, localX:Number=0, localY:Number=0, tapLocalX:Number=0, tapLocalY:Number=0, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false) {
			super( type, bubbles, cancelable, phase, localX, localY, tapLocalX, tapLocalY, ctrlKey, altKey, shiftKey );
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
			return new $PressAndTapGestureEvent( super.type, super.bubbles, super.cancelable, super.phase, super.localX, super.localY, super.tapLocalX, super.tapLocalY, super.ctrlKey, super.altKey, super.shiftKey );
		}

	}

}