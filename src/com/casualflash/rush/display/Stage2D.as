////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {

	import com.casualflash.rush.geom.Transform2D;
	
	import flash.errors.IllegalOperationError;

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
		public function Stage2D() {
			super();
			this.$parents = new Vector.<NativeDisplayObjectContainer2D>();
			this.$stage = this;
		}
		
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

		stageHeight
		stageWidth
		
		
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
		rotation
		scale9Grid
		scaleX
		scaleY
		scrollRect
		tabEnabled
		tabIndex
		transform
		visible
		x
		y 
		
		*/
		
		public override function set name(value:String):void{
			Error.throwError( IllegalOperationError, 2071 );
		}

//		public override function set mask(value:DisplayObject):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set visible(value:Boolean):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set x(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set y(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set z(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set scaleX(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set scaleY(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set scaleZ(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set rotation(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set rotationX(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set rotationY(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set rotationZ(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set alpha(value:Number):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set cacheAsBitmap(value:Boolean):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set opaqueBackground(value:Object):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set scrollRect(value:Rectangle):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set filters(value:Array):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set blendMode(value:String):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}

		public override function set transform(value:Transform2D):void{
			Error.throwError( IllegalOperationError, 2071 );
		}

//		public override function set tabEnabled(value:Boolean):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set tabIndex(value:int):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set focusRect(value:Object):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}
//
//		public override function set mouseEnabled(value:Boolean):void{
//			Error.throwError( IllegalOperationError, 2071 );
//		}

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

		$internal override function $setParent(parent:NativeDisplayObjectContainer2D):void {
			throw new IllegalOperationError();
		}

		$internal override function $setStage(stage:Stage2D):void {
			throw new IllegalOperationError();
		}

	}
	
}