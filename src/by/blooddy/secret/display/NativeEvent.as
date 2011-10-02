////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {
	
	import avmplus.getQualifiedClassName;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;

	//--------------------------------------
	//  Excluded APIs
	//--------------------------------------
	
	[Exclude( kind="property", name="$stopped" )]
	[Exclude( kind="property", name="$canceled" )]
	[Exclude( kind="property", name="$target" )]
	[Exclude( kind="property", name="$eventPhase" )]
	
	[ExcludeClass]
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 19:44:49
	 */
	public class NativeEvent extends Event implements INativeEvent {
		
		//--------------------------------------------------------------------------
		//
		//  Namespaces
		//
		//--------------------------------------------------------------------------
		
		use namespace $internal;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 * Constructor.
		 * 
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function NativeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super( type, bubbles, cancelable );
			if ( !( this is NativeEvent ) ) {
				Error.throwError( IllegalOperationError, 2012, getQualifiedClassName( this ) );
			}
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
		public override function formatToString(className:String, ...args):String {
			if ( !className ) className = getQualifiedClassName( this );
			args.unshift( className );
			return super.formatToString.apply( this, args );
		}
		
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
			var c:Class = ( this as Object ).constructor as Class;
			return new c( super.type, super.bubbles, super.cancelable );
		}
		
		/**
		 * @private
		 */
		public override function toString():String {
			return this.formatToString( null, 'type', 'bubbles', 'cancelable' );
		}
		
	}
		
}