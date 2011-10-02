////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {

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
	public class Stage extends DisplayObjectContainer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function Stage() {
			super();
			this._stage = this;
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

		$internal override function $setParent(parent:NativeDisplayObjectContainer):void {
			throw new IllegalOperationError();
		}

		$internal override function $setStage(stage:Stage):void {
			throw new IllegalOperationError();
		}

	}
	
}