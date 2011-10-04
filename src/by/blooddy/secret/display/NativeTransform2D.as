////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {
	import flash.geom.Matrix;

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
			super();
			if ( !target ) Error.throwError( TypeError, 2007, 'target' );
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
		pixelBounds
		
		*/

		public function get matrix():Matrix {
			return this.$target.$matrix.clone();
		}

		public function set matrix(value:Matrix):void {
			if ( !value ) return;
			this.$target.$matrix = value.clone();
			// TODO: call something?
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