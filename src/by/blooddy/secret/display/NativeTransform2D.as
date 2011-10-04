////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {

	import flash.geom.Matrix;
	import flash.geom.Rectangle;

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
			if ( this.$target.$changed & 1 ) this.$target.$updateMatrix();
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
			if ( this.$target.$changed & 2 ) this.$target.$updateBounds();
			return this.$target.$bounds.clone();
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