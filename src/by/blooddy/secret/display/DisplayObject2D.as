////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {
	
	import avmplus.getQualifiedSuperclassName;
	
	import by.blooddy.secret.events.Event2D;
	import by.blooddy.secret.geom.Transform;
	
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.events.IEventDispatcher;

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
			super();
			// TODO: сделать проверку на конкретный класс
			if ( ( this as Object ).constructor === DisplayObject2D ) {
				Error.throwError( IllegalOperationError, 2012, getQualifiedSuperclassName( this ) );
			}
			this._bubble = new EventDispatcher( this );
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal var _bubble:EventDispatcher;
		
		/**
		 * @private
		 */
		$internal var _capture:EventDispatcher;

		/**
		 * @private
		 */
		private var _parents:Vector.<DisplayObject2D>;

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
		
		name
		alpha
		visible
		
		transform
		
		x
		y
		z?
		width
		height
		scaleX
		scaleY
		scaleZ?
		rotation
		rotationX?
		rotationY?
		rotationZ?
		
		scrollRect
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
		$internal var _parent:NativeDisplayObjectContainer2D;

		/**
		 * @private
		 */
		$internal var _bubbleParent:NativeDisplayObjectContainer2D;

		public function get parent():DisplayObjectContainer2D {
			return this._parent as DisplayObjectContainer2D;
		}

		//----------------------------------
		//  stage
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var _stage:Stage2D;

		public function get stage():Stage2D {
			return this._stage;
		}

		//----------------------------------
		//  root
		//----------------------------------
		
		public function get root():DisplayObjectContainer2D {
			return this._stage;
		}
		
		//----------------------------------
		//  name
		//----------------------------------
		
		/**
		 * @private
		 */
		$internal var _name:String;
		
		public function get name():String {
			return this._name;
		}
		
		/**
		 * @private
		 */
		public function set name(value:String):void {
			if ( this._name == value ) return;
			this._name = value;
		}
		
		//----------------------------------
		//  name
		//----------------------------------
		
		public function set transform(value:Transform):void{
			Error.throwError( IllegalOperationError, 2071 );
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			if ( useCapture ) {
				if ( !this._capture ) this._capture = new EventDispatcher( this );
				this._capture.addEventListener( type, listener, true, priority, useWeakReference );
			} else {
				if ( type in _BROADCAST_EVENTS && !this._bubble.hasEventListener( type ) ) {
					_BROADCASTER.addEventListener( type, this._bubble.dispatchEvent, false, 0, true );
				}
				this._bubble.addEventListener( type, listener, false, priority, useWeakReference );
			}
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			if ( useCapture ) {
				if ( this._capture ) {
					this._capture.removeEventListener( type, listener, true );
				}
			} else {
				this._bubble.removeEventListener( type, listener, false );
				if ( type in _BROADCAST_EVENTS && this._bubble.hasEventListener( type ) ) {
					_BROADCASTER.removeEventListener( type, this._bubble.dispatchEvent );
				}
			}
		}

		public function hasEventListener(type:String):Boolean {
			return this._bubble.hasEventListener( type );
		}

		public function willTrigger(type:String):Boolean {
			if ( this._bubble.hasEventListener( type ) || ( this._capture && this._capture.hasEventListener( type ) ) ) {
				return true;
			}
			var target:DisplayObject2D = this._bubbleParent;
			while ( target ) {
				if ( target.hasEventListener( type ) || ( target._capture && target._capture.hasEventListener( type ) ) ) {
					return true;
				}
				target = target._bubbleParent;
			}
			return false;
		}

		public function dispatchEvent(event:Event):Boolean {
			if ( event.bubbles ) {
				if ( !( event is NativeEvent ) ) throw new ArgumentError();
				return this.$dispatchEventFunction( event as NativeEvent );
			} else {
				return this._bubble.dispatchEvent( event );
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
		$internal function $setParent(parent:NativeDisplayObjectContainer2D):void {
			if ( this._parent ) {
				this._bubbleParent = this._parent;
				this.$dispatchEventFunction( new Event2D( Event.REMOVED, true ) );
				if ( this._stage ) {
					this._bubble.dispatchEvent( new Event2D( Event.REMOVED_FROM_STAGE ) );
				}
			}
			if ( parent ) {
				if ( this._parent !== parent ) {
					this._stage = ( parent as DisplayObject2D )._stage;
					this._parent = parent;
					this._bubbleParent = parent;
					this.$dispatchEventFunction( new Event2D( Event.ADDED, true ) );
					if ( this._stage ) {
						this._bubble.dispatchEvent( new Event2D( Event.ADDED_TO_STAGE ) );
					}
				}
			} else {
				this._parent = null;
				this._stage = null;
			}
		}

		/**
		 * @private
		 */
		$internal function $setStage(stage:Stage2D):void {
			if ( this._stage ) {
				this._bubble.dispatchEvent( new Event2D( Event.REMOVED_FROM_STAGE ) );
			}
			if ( stage ) {
				if ( this._stage !== stage ) {
					this._stage = stage;
					this._bubble.dispatchEvent( new Event2D( Event.ADDED_TO_STAGE ) );
				}
			} else {
				this._stage = null;
			}
		}
		
		/**
		 * @private
		 */
		$internal function $dispatchEventFunction(event:NativeEvent):Boolean {
			var canceled:Boolean = false;
			var target:DisplayObject2D;
			if ( !this._parents ) {
				this._parents = new Vector.<DisplayObject2D>();
				target = this._bubbleParent;
				while ( target ) {
					this._parents.push( target );
					target = target._parent;
				}
			}
			// надо отдиспатчить капчу
			var type:String = event.type;
			var e:NativeEvent;
			var i:int;
			var l:uint = this._parents.length;
			for ( i=l-1; i>=0; --i ) {
				target = this._parents[ i ];
				if ( target._capture && target._capture.hasEventListener( type ) ) {
					e = event.clone() as NativeEvent;
					e.$eventPhase = EventPhase.CAPTURING_PHASE;
					e.$target = this;
					e.$canceled = canceled;
					CONTAINER.$event = e;
					target._capture.dispatchEvent( CONTAINER );
					canceled &&= e.$canceled;
					if ( e.$stopped ) {
						return canceled;
					}
				}
			}
			if ( this._bubble.hasEventListener( event.type ) ) {
				canceled = !this._bubble.dispatchEvent( event );
				if ( event.$stopped ) {
					return canceled;
				}
			}
			for each ( target in this._parents ) {
				if ( target.hasEventListener( type ) ) {
					e = event.clone() as NativeEvent;
					e.$eventPhase = EventPhase.BUBBLING_PHASE;
					e.$target = this;
					e.$canceled = canceled;
					CONTAINER.$event = e;
					target._bubble.dispatchEvent( CONTAINER );
					canceled &&= e.$canceled;
					if ( e.$stopped ) {
						return canceled;
					}
				}
			}
			return canceled;
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
