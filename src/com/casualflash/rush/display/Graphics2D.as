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
	 * @created					03.10.2011 2:33:06
	 */
	public class Graphics2D {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function Graphics2D() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _waiting:Boolean = false;

		/**
		 * @private
		 */
		private var _plane:Fill;
		
		//--------------------------------------------------------------------------
		//
		//  Internal variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal var $target:DisplayObject2D;

		/**
		 * @private
		 */
		$internal const $planes:Vector.<Fill> = new Vector.<Fill>();

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		/*
		
		TODO:
		
		beginShaderFill
		
		*/

		public function clear():void {
			this._plane = null;
			while ( this.$planes.length ) {
				this.$planes.pop().dispose();
			}
		}

		public function beginFill(color:uint, alpha:Number=1.0):void {
			var plane:SolidFill;
			if ( this._plane ) {
				plane = this._plane as SolidFill;
				if ( !plane || plane.color != color || plane.alpha != alpha ) {
					plane = new SolidFill();
					plane.color = color;
					plane.alpha = alpha;
					if ( this._plane.points.length <= 0 ) {
						this.$planes.pop();
					}
					this._plane = plane;
					this.$planes.push( plane );
				}
			} else if ( this.$planes.length > 0 ) {
				plane = this.$planes[ this.$planes.length - 1 ] as SolidFill;
				if ( !plane || plane.color != color || plane.alpha != alpha ) {
					plane = new SolidFill();
					plane.color = color;
					plane.alpha = alpha;
					if ( this._plane.points.length <= 0 ) {
						this.$planes.pop();
					}
					this._plane = plane;
				}
			}
		}

		public function endFill():void {
			if ( this._plane.points.length <= 0 ) {
				this._plane.dispose();
			}
			this._plane = null;
		}

		public function drawRect(x:Number, y:Number, width:Number, height:Number):void {
			if ( this._plane ) {
				if ( this._plane.points.length <= 0 ) {
					this.$planes.push( this._plane );
				}
				var x1:Number = x + width;
				var y1:Number = y + height;
				this._plane.points.push(
					x, y,	x1, y,	x, y1,
					x1, y,	x, y1,	x1, y1
				);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

	}

}