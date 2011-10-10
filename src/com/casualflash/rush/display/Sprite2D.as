////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {

	//--------------------------------------
	//  Namespaces
	//--------------------------------------
	
	use namespace $internal;

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:01:02
	 */
	public class Sprite2D extends DisplayObjectContainer2D {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function Sprite2D() {
			super();
			this._graphics.$target = this;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/*
		
		TODO:

		buttonMode
		useHandCursor
		dropTarget
		hitArea
		
		*/

		/**
		 * @private
		 */
		private const _graphics:Graphics2D = new Graphics2D();

		public function get graphics():Graphics2D {
			return this._graphics;
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		/*
		
		TODO:
		
		startDrag?
		stopDrag?
		startTouchDrag?
		stopTouchDrag?
		
		*/

		//--------------------------------------------------------------------------
		//
		//  Internal methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal override function $draw():void {
			for each ( var plane:Fill in this._graphics.$planes ) {
				
			}
			super.$draw();
		}

	}

}