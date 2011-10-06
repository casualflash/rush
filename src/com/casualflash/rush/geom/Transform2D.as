////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.geom {

	import com.casualflash.rush.display.DisplayObject2D;
	import com.casualflash.rush.display.NativeTransform2D;

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:45:21
	 */
	public class Transform2D extends NativeTransform2D {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function Transform2D(target:DisplayObject2D) {
			super( target );
		}

	}
	
}