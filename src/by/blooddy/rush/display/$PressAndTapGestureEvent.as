////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.rush.display {
	
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
			return new $PressAndTapGestureEvent( super.type, super.bubbles, super.cancelable, super.phase, super.localX, super.localY, super.tapLocalX, super.tapLocalY, super.ctrlKey, super.altKey, super.shiftKey );
		}

	}

}