////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.events {
	
	import by.blooddy.secret.display.NativeEvent;
	
	import flash.events.Event;
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 20:21:48
	 */
	public class Event extends NativeEvent {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const ADDED:String =				flash.events.Event.ADDED;
		
		public static const REMOVED:String =			flash.events.Event.REMOVED;
		
		public static const ADDED_TO_STAGE:String =		flash.events.Event.ADDED_TO_STAGE;
		
		public static const REMOVED_FROM_STAGE:String =	flash.events.Event.REMOVED_FROM_STAGE;
		
		public static const ENTER_FRAME:String =		flash.events.Event.ENTER_FRAME;
		
		public static const EXIT_FRAME:String =			flash.events.Event.EXIT_FRAME;
		
		public static const FRAME_CONSTRUCTED:String =	flash.events.Event.FRAME_CONSTRUCTED;
		
		public static const RENDER:String =				flash.events.Event.RENDER;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function Event(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super( type, bubbles, cancelable );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		public override function clone():flash.events.Event {
			return new by.blooddy.secret.events.Event( super.type, super.bubbles, super.cancelable );
		}

	}

}