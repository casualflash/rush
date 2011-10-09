////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {

	import com.casualflash.rush.geom.Transform2D;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTriangleFace;
	import flash.errors.IllegalOperationError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Matrix;

	//--------------------------------------
	//  Namespaces
	//--------------------------------------
	
	use namespace $internal;

	//--------------------------------------
	//  Events
	//--------------------------------------

	/*
	
	TODO

	mouseLeave
	resize?
	
	*/

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:07:36
	 */
	public class Stage2D extends DisplayObjectContainer2D {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function Stage2D(stage3D:Stage3D) {
			super();
			this.$parents = new Vector.<NativeDisplayObjectContainer2D>();
			this.$stage = this;
			this._stage3D = stage3D;
			this._stage3D.addEventListener( Event.CONTEXT3D_CREATE,	this.handler_context3DCreate );
			this._stage3D.addEventListener( ErrorEvent.ERROR,		this.handler_error );
			this._stage3D.requestContext3D();
			this.$stageMatrix.tx = this._stage3D.x;
			this.$stageMatrix.ty = this._stage3D.y;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _stage3D:Stage3D;

		//--------------------------------------------------------------------------
		//
		//  Internal variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal var $context:Context3D;

		/**
		 * @private
		 */
		$internal const $stageMatrix:Matrix = new Matrix();

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/*
		
		TODO:
		
		align?
		color? wtf?
		focus?
		frameRate?
		scaleMode?

		*/
		
		/*
		
		OVERRIDE SETTERS:
		
		alpha
		blendMode
		contextMenu
		filters
		focusRect
		loaderInfo
		mask
		mouseEnabled
		name
		opaqueBackground
		scale9Grid
		scrollRect
		tabEnabled
		tabIndex
		
		*/

		//----------------------------------
		//  name
		//----------------------------------
		
		public override function set name(value:String):void{
			Error.throwError( IllegalOperationError, 2071 );
		}

		//----------------------------------
		//  transform
		//----------------------------------
		
		public override function set transform(value:Transform2D):void{
			Error.throwError( IllegalOperationError, 2071 );
		}
		
		//----------------------------------
		//  x
		//----------------------------------
		
		public override function get x():Number {
			return this.$stageMatrix.tx;
		}
		
		public override function set x(value:Number):void {
			this.$stageMatrix.tx = value;
			this._stage3D.x = value;
		}

		//----------------------------------
		//  y
		//----------------------------------

		public override function get y():Number {
			return this.$stageMatrix.ty;
		}

		public override function set y(value:Number):void {
			this.$stageMatrix.ty = value;
			this._stage3D.y = value;
		}

		//----------------------------------
		//  visible
		//----------------------------------
		
		public override function set visible(value:Boolean):void {
			super.visible = value;
			this._stage3D.visible = value;
		}

		//----------------------------------
		//  stageWidth
		//----------------------------------

		/**
		 * @private
		 */
		private var _stageWidth:Number = 50;

		public function get stageWidth():Number {
			return this._stageWidth;
		}

		/**
		 * @private
		 */
		public function set stageWidth(value:Number):void {
			// TODO: errors
			if ( this._stageWidth == value ) return;
			this._stageWidth = value;
			throw new IllegalOperationError( 'TODO: configureBackBuffer' );
		}

		//----------------------------------
		//  stageHeight
		//----------------------------------
		
		/**
		 * @private
		 */
		private var _stageHeight:Number = 50;
		
		public function get stageHeight():Number {
			return this._stageHeight;
		}
		
		/**
		 * @private
		 */
		public function set stageHeight(value:Number):void {
			// TODO: errors
			if ( this._stageHeight == value ) return;
			this._stageHeight = value;
			throw new IllegalOperationError( 'TODO: configureBackBuffer' );
		}

		//----------------------------------
		//  scaleX
		//----------------------------------
		
		public override function set scaleX(value:Number):void{
			Error.throwError( IllegalOperationError, 2071 );
		}

		//----------------------------------
		//  scaleY
		//----------------------------------
		
		public override function set scaleY(value:Number):void{
			Error.throwError( IllegalOperationError, 2071 );
		}

		//----------------------------------
		//  transform
		//----------------------------------
		
		public override function set rotation(value:Number):void{
			Error.throwError( IllegalOperationError, 2071 );
		}

		//----------------------------------
		//  width
		//----------------------------------
		
		public override function set width(value:Number):void{
			Error.throwError( IllegalOperationError, 2071 );
		}
		
		//----------------------------------
		//  height
		//----------------------------------
		
		public override function set height(value:Number):void{
			Error.throwError( IllegalOperationError, 2071 );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		/*
		
		TODO:
		
		invalidate
		
		*/

		//--------------------------------------------------------------------------
		//
		//  Internal methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal override function $setParent(parent:NativeDisplayObjectContainer2D):void {
			throw new IllegalOperationError();
		}

		/**
		 * @private
		 */
		$internal override function $setStage(stage:Stage2D):void {
			throw new IllegalOperationError();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function handler_context3DCreate(event:Event):void {
			this._stage3D.removeEventListener( Event.CONTEXT3D_CREATE, this.handler_context3DCreate );
			this._stage3D.removeEventListener( ErrorEvent.ERROR, this.handler_error );
			this.$context = this._stage3D.context3D;
			this.$context.configureBackBuffer( this._stageWidth, this._stageHeight, 2, false ); // TODO: configure antiAlias & enableDepthAndStencil
			this.$context.setCulling( Context3DTriangleFace.BACK );
		}

		/**
		 * @private
		 */
		private function handler_error(event:Event):void {
			this._stage3D.removeEventListener( Event.CONTEXT3D_CREATE, this.handler_context3DCreate );
			this._stage3D.removeEventListener( ErrorEvent.ERROR, this.handler_error );
			super.dispatchEvent( event ); // TODO
		}

		/**
		 * @private
		 */
		private function handler_enterFrame(event:Event):void {
			this.$context.clear();
			super.$draw();
			this.$context.present();
		}

	}
	
}