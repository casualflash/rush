////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.rush.display {

	import avmplus.getQualifiedClassName;
	
	import flash.errors.IllegalOperationError;
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/*
	
	TODO

	click
	doubleClick
	mouseDown
	mouseUp
	mouseMove
	mouseOver
	mouseOut
	mouseWheel
	rollOver
	rollOut

	touch events?
	
	focusIn?
	focusOut?

	*/

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:00:25
	 */
	public class InteractiveObject2D extends DisplayObject2D {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function InteractiveObject2D() {
			if ( ( this as Object ).constructor === InteractiveObject2D ) {
				Error.throwError( IllegalOperationError, 2012, getQualifiedClassName( this ) );
			}
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/*
		
		contextMenu?
		focusRect?

		doubleClickEnabled
		mouseEnabled
		tabEnabled?
		tabIndex

		*/

	}
	
}