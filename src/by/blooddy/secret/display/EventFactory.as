////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {

	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.events.PressAndTapGestureEvent;

	use namespace $internal;

	[ExcludeClass]
	/**
	 * используется, для конвертации флэшовых событий в кастомные.
	 * стандартное событие необходимо сконвертить, что была возможность его баблить. 
	 * 
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					02.10.2011 19:21:06
	 */
	internal final class EventFactory {
		
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static const _HASH:Dictionary = new Dictionary( true );
		_HASH[ Event ] =					$Event.get;
		_HASH[ MouseEvent ] =				$MouseEvent.get;
		_HASH[ TouchEvent ] =				$TouchEvent.get;
		_HASH[ GestureEvent ] =				$GestureEvent.get;
		_HASH[ TransformGestureEvent ] =	$TransformGestureEvent.get;
		_HASH[ PressAndTapGestureEvent ] =	$PressAndTapGestureEvent.get;

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function getEvent(event:Event):Event {
			var c:Class = ( event as Object ).constructor;
			if ( c in _HASH ) {
				return _HASH[ c ]( event );
			}
			return null;
		}

	}
	
}