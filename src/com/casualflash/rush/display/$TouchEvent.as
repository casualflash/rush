////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.TouchEvent;

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
	 * @created					02.10.2011 23:41:55
	 */
	internal class $TouchEvent extends TouchEvent implements INativeEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Internal class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		$internal static function $get(event:TouchEvent):$TouchEvent {
			return new $TouchEvent( event.type, event.bubbles, event.cancelable, event.touchPointID, event.isPrimaryTouchPoint, event.localX, event.localY, event.sizeX, event.sizeY, event.pressure, event.relatedObject, event.ctrlKey, event.altKey, event.shiftKey );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function $TouchEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, touchPointID:int=0, isPrimaryTouchPoint:Boolean=false, localX:Number=NaN, localY:Number=NaN, sizeX:Number=NaN, sizeY:Number=NaN, pressure:Number=NaN, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false) {
			super( type, bubbles, cancelable, touchPointID, isPrimaryTouchPoint, localX, localY, sizeX, sizeY, pressure, relatedObject, ctrlKey, altKey, shiftKey );
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
			return new $TouchEvent( super.type, super.bubbles, super.cancelable, super.touchPointID, super.isPrimaryTouchPoint, super.localX, super.localY, super.sizeX, super.sizeY, super.pressure, super.relatedObject, super.ctrlKey, super.altKey, super.shiftKey );
		}
		
	}
	
}