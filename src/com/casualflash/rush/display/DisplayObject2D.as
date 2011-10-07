////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {
	
	import avmplus.getQualifiedClassName;
	
	import com.casualflash.rush.geom.Transform2D;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.events.IEventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
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
		//  Internal variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		$internal var $parents:Vector.<NativeDisplayObjectContainer2D>;
		
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
		 * 1 - orign
		 * 2 - matrix
		 * 4 - size
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

		/**
		 * @private
		 */
		$internal const $size:Point = new Point();

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
		
		z?
		scaleZ?
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
			this.$matrix.copyFrom( target.$matrix );
			this.$updateMatrixDerivatives();
		}

		//----------------------------------
		//  x
		//----------------------------------

		/**
		 * @private
		 */
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
			this.$matrix.tx = value;
			this.$changed |= 4;
		}

		//----------------------------------
		//  y
		//----------------------------------

		/**
		 * @private
		 */
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
			this.$matrix.ty = value;
			this.$changed |= 4;
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
			this.$changed |= 6;
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
			this.$changed |= 6;
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
			this.$rotation = value % 360;
			this.$changed |= 6;
		}

		//----------------------------------
		//  width
		//----------------------------------
		
		public function get width():Number {
			if ( this.$changed & 7 ) this.$updateSize();
			return this.$size.x;
		}
		
		/**
		 * @private
		 */
		public function set width(value:Number):void { // TODO: optimize
			if ( this.$changed & 7 ) this.$updateSize();
			if ( this.$size.x == value ) return;
			this.$matrix.scale( value / this.$size.x, 1 ); // тут видимо накопится погрешность
			this.$size.x = value;
		}
		
		//----------------------------------
		//  height
		//----------------------------------
		
		public function get height():Number {
			if ( this.$changed & 7 ) this.$updateSize();
			return this.$size.y;
		}
		
		/**
		 * @private
		 */
		public function set height(value:Number):void { // TODO: optimize
			if ( this.$changed & 7 ) this.$updateSize();
			if ( this.$size.y == value ) return;
			this.$matrix.scale( 1, value / this.$size.y ); // тут видимо накопится погрешность
			this.$size.y = value;
		}
		
		//----------------------------------
		//  visible
		//----------------------------------

		/**
		 * @private
		 */
		$internal var $visible:Boolean = true;

		public function get visible():Boolean {
			return this.$visible;
		}
		
		/**
		 * @private
		 */
		public function set visible(value:Boolean):void {
			if ( this.$visible == value ) return;
			this.$visible = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		/*
		
		TODO
		
		globalToLocal3D?
		local3DToGlobal?
		
		*/
		
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
				if ( type in _BROADCAST_EVENTS && !this.$bubble.hasEventListener( type ) ) {
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

		public function getBounds(targetCoordinateSpace:Object):Rectangle {
			if ( targetCoordinateSpace && targetCoordinateSpace !== this ) {

				var m:Matrix = this.$getConcatedMatrix(); // TODO: предположим, что матрицы закэшированы
				var im:Matrix;

				if ( targetCoordinateSpace is DisplayObject2D ) {

					im = ( targetCoordinateSpace as DisplayObject2D ).$getConcatedMatrix();

				} else if ( targetCoordinateSpace is DisplayObject ) {

					im = target.transform.matrix;
					var target:DisplayObject = targetCoordinateSpace as DisplayObject;
					var parent:DisplayObjectContainer = target.parent;
					if ( parent ) {
						do {
							im.concat( parent.transform.matrix );
						} while ( parent = parent.parent );
					}

				} else {

					throw new TypeError();

				}

				im.invert();
				m.concat( im );

				// TODO: optimize
				var topLeft:Point =		m.transformPoint( this.$orign.topLeft );
				var topRight:Point =	m.transformPoint( new Point( this.$orign.right, this.$orign.top ) );
				var bottomRight:Point =	m.transformPoint( this.$orign.bottomRight );
				var bottomLeft:Point =	m.transformPoint( new Point( this.$orign.left, this.$orign.bottom ) );
				var bounds:Rectangle = new Rectangle();
				bounds.top =		Math.min( topLeft.y, topRight.y, bottomRight.y, bottomLeft.y );
				bounds.right =		Math.max( topLeft.x, topRight.x, bottomRight.x, bottomLeft.x );
				bounds.bottom =		Math.max( topLeft.y, topRight.y, bottomRight.y, bottomLeft.y );
				bounds.left =		Math.min( topLeft.x, topRight.x, bottomRight.x, bottomLeft.x );
				return bounds;

			} else {

				if ( this.$changed & 1 ) this.$updateOrign();
				return this.$orign.clone();

			}
		}

		public function localToGlobal(point:Point):Point {
			return this.$getConcatedMatrix().transformPoint( point );
		}

		public function globalToLocal(point:Point):Point {
			var im:Matrix = this.$getConcatedMatrix();
			im.invert();
			return im.transformPoint( point );
		}

		public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean=false):Boolean {
			var im:Matrix = new Matrix();
			im.invert();
			var p:Point = im.transformPoint( new Point( x, y ) );
			if ( this.$orign.containsPoint( p ) ) {
				return this.$hitTestPoint( p, shapeFlag );
			}
			return false;
		}

		public function hitTestObject(obj:Object):Boolean {
			if ( obj is DisplayObject2D ) {
				var target2D:DisplayObject2D;
				throw new IllegalOperationError( 'TODO' );
			} else if ( obj is DisplayObject ) {
				var target:DisplayObject;
				throw new IllegalOperationError( 'TODO' );
			} else {
				throw new TypeError();
			}
			return false;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Internal methods
		//
		//--------------------------------------------------------------------------

		$internal function $getParents():Vector.<NativeDisplayObjectContainer2D> {
			var result:Vector.<NativeDisplayObjectContainer2D> = new Vector.<NativeDisplayObjectContainer2D>();
			var parent:NativeDisplayObjectContainer2D = this.$parent;
			while ( parent ) {
				result.push( parent );
				parent = parent.$parent;
			}
			return result;
		}

		/**
		 * @private
		 */
		$internal function $dispatchEventFunction(event:Event):Boolean {
			var canceled:Boolean = false;
			var parents:Vector.<NativeDisplayObjectContainer2D> = ( this.$parents ? this.$parents : this.$getParents() );
			// capture
			var type:String = event.type;
			var target:NativeDisplayObjectContainer2D;
			var e:Object;
			var l:uint = parents.length;
			for ( var i:int = l-1; i>=0; --i ) {
				target = parents[ i ];
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
			// at target
			if ( this.$bubble.hasEventListener( event.type ) ) {
				canceled = !this.$bubble.dispatchEvent( event );
				if ( ( event as Object ).$stopped ) {
					return canceled;
				}
			}
			// bubble
			for each ( target in parents ) {
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
					this.$parent = parent;
					this.$stage = parent.$stage;
					if ( this.$stage ) {
						this.$parents = parent.$parents.slice();
						this.$parents.unshift( parent );
					}
					this.$dispatchEventFunction( new $Event( Event.ADDED, true ) );
					if ( this.$stage && this.$bubble.hasEventListener( Event.ADDED_TO_STAGE ) ) {
						this.$bubble.dispatchEvent( new Event( Event.ADDED_TO_STAGE ) );
					}
				}
			} else {
				this.$parents = null;
				this.$stage = null;
				this.$parent = null;
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
					this.$parents = parent.$parents.slice();
					this.$parents.unshift( parent );
					if ( this.$bubble.hasEventListener( Event.ADDED_TO_STAGE ) ) {
						this.$bubble.dispatchEvent( new Event( Event.ADDED_TO_STAGE ) );
					}
				}
			} else {
				this.$stage = null;
				this.$parents = null;
			}
		}

		$internal function $updateOrign():void {
			// must be overriden
			this.$changed &= ~1;
		}

		$internal function $updateMatrix():void {
			if ( this.$changed & 1 ) this.$updateOrign();
			this.$changed &= ~2;
//			this.$matrix.createBox(
//				this.$scaleX,
//				this.$scaleY,
//				this.$rotation / 180 * Math.PI,
//				this.$x,
//				this.$y
//			);
			this.$matrix.identity();
			this.$matrix.scale( this.$scaleX, this.$scaleY );
			this.$matrix.rotate( this.$rotation / 180 * Math.PI );
			this.$matrix.translate( this.$x, this.$y );
		}

		$internal function $updateMatrixDerivatives():void {
			this.$x = this.$matrix.tx;
			this.$y = this.$matrix.ty;
			var a:Number = this.$matrix.a;
			var b:Number = this.$matrix.b;
			var c:Number = this.$matrix.c;
			var d:Number = this.$matrix.d;
			this.$scaleX = Math.sqrt( a*a + b*b );
			this.$scaleY = Math.sqrt( c*c + d*d );
			this.$rotation = Math.atan2( b, a ) / Math.PI * 180;
		}

		$internal function $getConcatedMatrix():Matrix { // матрицы можно кэшировать у парентов
			if ( this.$changed & 3 ) this.$updateMatrix();
			var result:Matrix = this.$matrix.clone();
			var parent:NativeDisplayObjectContainer2D;
			if ( this.$parents ) {
				for each ( parent in this.$parents ) {
					if ( parent.$changed & 3 ) parent.$updateMatrix();
					result.concat( parent.$matrix );
				}
			} else {
				parent = this.$parent;
				while ( parent ) {
					if ( parent.$changed & 3 ) parent.$updateMatrix();
					result.concat( parent.$matrix );
					parent = parent.$parent;
				}
			}
			return result;
		}

		$internal function $updateSize():void {
			if ( this.$changed & 3 ) this.$updateMatrix();
			this.$changed &= ~4;
			// TODO: optimize
			var topLeft:Point =		this.$matrix.transformPoint( this.$orign.topLeft );
			var topRight:Point =	this.$matrix.transformPoint( new Point( this.$orign.right, this.$orign.top ) );
			var bottomRight:Point =	this.$matrix.transformPoint( this.$orign.bottomRight );
			var bottomLeft:Point =	this.$matrix.transformPoint( new Point( this.$orign.left, this.$orign.bottom ) );
			var bounds:Rectangle = new Rectangle();
			bounds.top =		Math.min( topLeft.y, topRight.y, bottomRight.y, bottomLeft.y );
			bounds.right =		Math.max( topLeft.x, topRight.x, bottomRight.x, bottomLeft.x );
			bounds.bottom =		Math.max( topLeft.y, topRight.y, bottomRight.y, bottomLeft.y );
			bounds.left =		Math.min( topLeft.x, topRight.x, bottomRight.x, bottomLeft.x );
			this.$size.x = bounds.width;
			this.$size.y = bounds.height;
		}

		$internal function $hitTestPoint(point:Point, shapeFlag:Boolean=false):Boolean {
			// must be overriden
			return true;
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