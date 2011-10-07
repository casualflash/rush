////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import flash.events.Event;

	use namespace $internal;

	[ExcludeClass]
	/**
	 * обёртка вокруг стандартного события флэша
	 * 
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					02.10.2011 20:16:50
	 * 
	 * @see						flash.events.Event
	 */
	internal final class $Event extends Event implements INativeEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Internal class methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal static function get(event:Event):$Event {
			return new $Event( event.type, event.bubbles, event.cancelable );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function $Event(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super( type, bubbles, cancelable );
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
			return new $Event( super.type, super.bubbles, super.cancelable );
		}
		
	}
	
}