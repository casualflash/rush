////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {

	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	//--------------------------------------
	//  Namespaces
	//--------------------------------------
	
	use namespace $internal;

	[ExcludeClass]
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					03.10.2011 4:04:17
	 */
	public class NativeTransform2D {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function NativeTransform2D(target:DisplayObject2D) {
			if ( !target ) Error.throwError( TypeError, 2007, 'target' );
			super();
			this.$target = target;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		$internal var $target:DisplayObject2D;

		/*
		
		TODO:
		
		colorTransform
		concatenatedColorTransform?
		concatenatedMatrix?
		matrix3D?
		perspectiveProjection?
		
		*/

		//----------------------------------
		//  matrix
		//----------------------------------
		
		public function get matrix():Matrix {
			if ( this.$target.$changed & 3 ) this.$target.$updateMatrix();
			return this.$target.$matrix.clone();
		}

		/**
		 * @private
		 */
		public function set matrix(value:Matrix):void {
			if ( !value ) return;
			this.$target.$matrix.copyFrom( value );
			this.$target.$updateMatrixDerivatives();
		}

		//----------------------------------
		//  height
		//----------------------------------
		
		public function get pixelBounds():Rectangle {
			var m:Matrix = this.$target.$getConcatedMatrix();
			var bounds:Rectangle = this.$target.$orign;
			// TODO: optimize
			var topLeft:Point =		m.transformPoint( bounds.topLeft );
			var topRight:Point =	m.transformPoint( new Point( bounds.right, bounds.top ) );
			var bottomRight:Point =	m.transformPoint( bounds.bottomRight );
			var bottomLeft:Point =	m.transformPoint( new Point( bounds.left, bounds.bottom ) );
			bounds = new Rectangle();
			bounds.top =		Math.floor( Math.min( topLeft.y, topRight.y, bottomRight.y, bottomLeft.y ) );
			bounds.right =		Math.ceil( Math.max( topLeft.x, topRight.x, bottomRight.x, bottomLeft.x ) );
			bounds.bottom =		Math.ceil( Math.max( topLeft.y, topRight.y, bottomRight.y, bottomLeft.y ) );
			bounds.left =		Math.floor( Math.min( topLeft.x, topRight.x, bottomRight.x, bottomLeft.x ) );
			return bounds;
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		
		TODO
		
		getRelativeMatrix3D
		
		*/
		
	}
	
}