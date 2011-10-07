////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import avmplus.getQualifiedClassName;
	
	import com.casualflash.rush.events.Event2D;
	
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
	 * @private
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
			if ( !( this is Event2D ) ) {
				Error.throwError( IllegalOperationError, 2012, getQualifiedClassName( this ) );
			}
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
		public override function formatToString(className:String, ...args):String {
			if ( !className ) className = getQualifiedClassName( this );
			args.unshift( className );
			return super.formatToString.apply( this, args );
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