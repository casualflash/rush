////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {
	
	import avmplus.getQualifiedClassName;
	
	import by.blooddy.secret.geom.Transform2D;
	
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.events.IEventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	use namespace $internal;

	//--------------------------------------
	//  Events
	//--------------------------------------

	[Event( name="added", type="flash.events.Event" )]

	[Event( name="removed", type="flash.events.Event" )]

	[Event( name="addedToStage", type="flash.events.Event" )]

	[Event( name="removedFromStage", type="flash.events.Event" )]

	[Event( name="enterFrame", type="flash.events.Event" )]

	[Event( name="exitFrame", type="flash.events.Event" )]

	[Event( name="frameConstructed", type="flash.events.Event" )]
	
	[Event( name="render", type="flash.events.Event" )]

	/*
	
	TODO
	
	render
	
	*/
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 17:45:12
	 */
	public class DisplayObject2D implements IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static const _BROADCASTER:Shape = new Shape();

		/**
		 * @private
		 */
		private static const _BROADCAST_EVENTS:Object = new Object();
		_BROADCAST_EVENTS[ Event.ENTER_FRAME ] = true;
		_BROADCAST_EVENTS[ Event.EXIT_FRAME ] = true;
		_BROADCAST_EVENTS[ Event.FRAME_CONSTRUCTED ] = true;

		/**
		 * @private
		 */
		private static const _STOPPED_NAME:QName = new QName( $internal, '$stopped' );

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 * Constructor
		 */
		public function DisplayObject2D() {
			if ( ( this as Object ).constructor === DisplayObject2D ) {
				Error.throwError( IllegalOperationError, 2012, getQualifiedClassName( this ) );
			}
			super();
			this.$bubble = new EventDispatcher( this );
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _parents:Vector.<DisplayObject2D>;
		
		//--------------------------------------------------------------------------
		//
		//  Internal variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		$internal var $bubble:EventDispatcher;
		
		/**
		 * @private
		 */
		$internal var $capture:EventDispatcher;

		/**
		 * @private
		 * 1 - matrix
		 * 2 - bounds
		 */
		$internal var $changed:uint = 0;
		
		/**
		 * @private
		 */
		$internal const $orign:Rectangle = new Rectangle();
		
		/**
		 * @private
		 */
		$internal const $matrix:Matrix = new Matrix();

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/*
		TODO:

		blendMode?
		blendShader?
		filters?
		
		loaderInfo?
		opaqueBackground?
		
		alpha
		visible
		
		z?
		scaleZ?
		width
		height
		rotationX?
		rotationY?
		rotationZ?
		
		scrollRect?
		scale9Grid?
		
		mouseX
		mouseY
		
		mask?

		*/

		//----------------------------------
		//  parent
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var $parent:NativeDisplayObjectContainer2D;

		public function get parent():DisplayObjectContainer2D {
			return this.$parent as DisplayObjectContainer2D;
		}

		//----------------------------------
		//  stage
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var $stage:Stage2D;

		public function get stage():Stage2D {
			return this.$stage;
		}

		//----------------------------------
		//  root
		//----------------------------------
		
		public function get root():DisplayObjectContainer2D {
			return this.$stage;
		}
		
		//----------------------------------
		//  name
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var $name:String;
		
		public function get name():String {
			return this.$name;
		}
		
		/**
		 * @private
		 */
		public function set name(value:String):void {
			if ( this.$name == value ) return;
			this.$name = value;
		}
		
		//----------------------------------
		//  transform
		//----------------------------------

		/**
		 * @private
		 */
		$internal var $transform:Transform2D;

		public function get transform():Transform2D {
			if ( !this.$transform ) this.$transform = new Transform2D( this );
			return this.$transform;
		}
		
		/**
		 * @private
		 */
		public function set transform(value:Transform2D):void{
			if ( !value ) Error.throwError( TypeError, 2007 );
			if ( this.$transform == value || this == value.$target ) return;
			var target:DisplayObject2D = value.$target;
			this.$setMatrix( target.$matrix );
		}

		//----------------------------------
		//  x
		//----------------------------------

		$internal var $x:Number = 0;

		public function get x():Number {
			return this.$x;
		}

		/**
		 * @private
		 */
		public function set x(value:Number):void {
			if ( this.$x == value ) return;
			this.$x = value;
			this.$changed |= 1;
		}

		//----------------------------------
		//  y
		//----------------------------------

		$internal var $y:Number = 0;

		public function get y():Number {
			return this.$y;
		}
		
		/**
		 * @private
		 */
		public function set y(value:Number):void {
			if ( this.$y == value ) return;
			this.$y = value;
			this.$changed |= 1;
		}
		
		//----------------------------------
		//  scaleX
		//----------------------------------

		/**
		 * @private
		 */
		$internal var $scaleX:Number = 1;

		public function get scaleX():Number {
			return this.$scaleX;
		}

		/**
		 * @private
		 */
		public function set scaleX(value:Number):void {
			if ( this.$scaleX == value ) return;
			this.$scaleX = value;
			this.$changed |= 1;
		}
		
		//----------------------------------
		//  scaleY
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var $scaleY:Number = 1;
		
		public function get scaleY():Number {
			return this.$scaleY;
		}
		
		/**
		 * @private
		 */
		public function set scaleY(value:Number):void {
			if ( this.$scaleY == value ) return;
			this.$scaleY = value;
			this.$changed |= 1;
		}
		
		//----------------------------------
		//  rotation
		//----------------------------------

		/**
		 * @private
		 */
		$internal var $rotation:Number = 0;
		
		public function get rotation():Number {
			return this.$rotation;
		}
		
		/**
		 * @private
		 */
		public function set rotation(value:Number):void {
			if ( this.$rotation == value ) return;
			this.$rotation = value;
			this.$changed |= 1;
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			if ( useCapture ) {
				if ( !this.$capture ) this.$capture = new EventDispatcher( this );
				this.$capture.addEventListener( type, listener, true, priority, useWeakReference );
			} else {
				if ( type in _BROADCAST_EVENTS && !this.$bubble.hasEventListener( type ) ) {
					_BROADCASTER.addEventListener( type, this.$bubble.dispatchEvent, false, 0, true );
				}
				this.$bubble.addEventListener( type, listener, false, priority, useWeakReference );
			}
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			if ( useCapture ) {
				if ( this.$capture ) {
					this.$capture.removeEventListener( type, listener, true );
				}
			} else {
				this.$bubble.removeEventListener( type, listener, false );
				if ( type in _BROADCAST_EVENTS && this.$bubble.hasEventListener( type ) ) {
					_BROADCASTER.removeEventListener( type, this.$bubble.dispatchEvent );
				}
			}
		}

		public function hasEventListener(type:String):Boolean {
			return this.$bubble.hasEventListener( type );
		}

		public function willTrigger(type:String):Boolean {
			if ( this.$bubble.hasEventListener( type ) || ( this.$capture && this.$capture.hasEventListener( type ) ) ) {
				return true;
			}
			var target:DisplayObject2D = this.$parent;
			while ( target ) {
				if ( target.hasEventListener( type ) || ( target.$capture && target.$capture.hasEventListener( type ) ) ) {
					return true;
				}
				target = target.$parent;
			}
			return false;
		}

		public function dispatchEvent(event:Event):Boolean {
			if ( event.bubbles ) {
				if ( !( event is INativeEvent ) ) {
					event = EventFactory.getEvent( event );
					if ( !event ) throw new TypeError();
				}
				return this.$dispatchEventFunction( event );
			} else {
				return this.$bubble.dispatchEvent( event );
			}
		}

		/*
		
		TODO
		
		getBounds
		getRect
		globalToLocal
		localToGlobal
		globalToLocal3D?
		local3DToGlobal?
		
		hitTestPoint
		hitTestObject
		
		*/

		//--------------------------------------------------------------------------
		//
		//  Internal methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal function $dispatchEventFunction(event:Event):Boolean {
			var canceled:Boolean = false;
			var target:DisplayObject2D;
			if ( !this._parents ) {
				this._parents = new Vector.<DisplayObject2D>();
				target = this.$parent;
				while ( target ) {
					this._parents.push( target );
					target = target.$parent;
				}
			}
			// надо отдиспатчить капчу
			var type:String = event.type;
			var e:Object;
			var i:int;
			var l:uint = this._parents.length;
			for ( i=l-1; i>=0; --i ) {
				target = this._parents[ i ];
				if ( target.$capture && target.$capture.hasEventListener( type ) ) {
					e = event.clone();
					e.$eventPhase = EventPhase.CAPTURING_PHASE;
					e.$target = this;
					e.$canceled = canceled;
					CONTAINER.$event = e as Event;
					target.$capture.dispatchEvent( CONTAINER );
					canceled &&= e.$canceled;
					if ( e.$stopped ) {
						return canceled;
					}
				}
			}
			if ( this.$bubble.hasEventListener( event.type ) ) {
				canceled = !this.$bubble.dispatchEvent( event );
				if ( event[ _STOPPED_NAME ] ) {
					return canceled;
				}
			}
			for each ( target in this._parents ) {
				if ( target.hasEventListener( type ) ) {
					e = event.clone();
					e.$eventPhase = EventPhase.BUBBLING_PHASE;
					e.$target = this;
					e.$canceled = canceled;
					CONTAINER.$event = e as Event;
					target.$bubble.dispatchEvent( CONTAINER );
					canceled &&= e.$canceled;
					if ( e.$stopped ) {
						return canceled;
					}
				}
			}
			return canceled;
		}

		/**
		 * @private
		 */
		$internal function $setParent(parent:NativeDisplayObjectContainer2D):void {
			if ( this.$parent ) {
				this.$dispatchEventFunction( new $Event( Event.REMOVED, true ) );
				if ( this.$stage  && this.$bubble.hasEventListener( Event.REMOVED_FROM_STAGE ) ) {
					this.$bubble.dispatchEvent( new Event( Event.REMOVED_FROM_STAGE ) );
				}
			}
			if ( parent ) {
				if ( this.$parent !== parent ) {
					this.$stage = parent.$stage;
					this.$parent = parent;
					this.$dispatchEventFunction( new $Event( Event.ADDED, true ) );
					if ( this.$stage && this.$bubble.hasEventListener( Event.ADDED_TO_STAGE ) ) {
						this.$bubble.dispatchEvent( new Event( Event.ADDED_TO_STAGE ) );
					}
				}
			} else {
				this.$parent = null;
				this.$stage = null;
			}
		}

		/**
		 * @private
		 */
		$internal function $setStage(stage:Stage2D):void {
			if ( this.$stage && this.$bubble.hasEventListener( Event.REMOVED_FROM_STAGE ) ) {
				this.$bubble.dispatchEvent( new Event( Event.REMOVED_FROM_STAGE ) );
			}
			if ( stage ) {
				if ( this.$stage !== stage ) {
					this.$stage = stage;
					if ( this.$bubble.hasEventListener( Event.ADDED_TO_STAGE ) ) {
						this.$bubble.dispatchEvent( new Event( Event.ADDED_TO_STAGE ) );
					}
				}
			} else {
				this.$stage = null;
			}
		}

		$internal function $getMatrix():Matrix {
			if ( this.$changed & 1 ) {
				this.$changed &= ~1;
//				this.$matrix.createBox(
//					this.$scaleX,
//					this.$scaleY,
//					this.$rotation / 180 * Math.PI,
//					this.$x,
//					this.$y
//				);
				this.$matrix.identity();
				this.$matrix.scale( this.$scaleX, this.$scaleY );
				this.$matrix.rotate( this.$rotation / 180 * Math.PI );
				this.$matrix.translate( this.$x, this.$y );
			}
			return this.$matrix;
		}

		$internal function $setMatrix(value:Matrix):void {
			this.$matrix.copyFrom( value );
			this.$x = value.tx;
			this.$y = value.ty;
			var a:Number = value.a;
			var b:Number = value.b;
			var c:Number = value.c;
			var d:Number = value.d;
			this.$scaleX = ( a < 0 != b < 0 ? -1 : 1 ) * Math.sqrt( a*a + b*b );
			this.$scaleY = ( c < 0 != d < 0 ? -1 : 1 ) * Math.sqrt( c*c + d*d );
			this.$rotation = Math.atan2( b, a ) / Math.PI * 180;
			// TODO: call something
		}

	}

}

//==============================================================================
//
//  Inner definitions
//
//==============================================================================

import flash.events.Event;

////////////////////////////////////////////////////////////////////////////////
//
//  Helper class: EventContainer
//
////////////////////////////////////////////////////////////////////////////////

/**
 * @private
 * Вспомогательный класс.
 * 
 * Является контэйнером, для евента.
 * Хук, для того, что бы передать нормальный таргет средствами стандартного EventDispatcher'а.
 */
internal final class EventContainer extends Event {
	
	//--------------------------------------------------------------------------
	//
	//  Private class constants
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private static const TARGET:Object = new Object();
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * Constructor.
	 */
	public function EventContainer() {
		super( '', true );
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	internal var $event:Event;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties: Event
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * Возвращает левый таргет, для того что бы обмануть EventDispatcher.
	 */
	public override function get target():Object {
		return TARGET;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods: Event
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * Возвращаем наш евент.
	 */
	public override function clone():Event {
		return this.$event;
	}
	
}

/**
 * @private
 */
internal const CONTAINER:EventContainer = new EventContainer();