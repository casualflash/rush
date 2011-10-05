////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.rush.display {
	
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
			return new $Event( super.type, super.bubbles, super.cancelable );
		}
		
	}
	
}