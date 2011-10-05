////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.rush.display {

	import avmplus.getQualifiedClassName;
	
	import flash.errors.IllegalOperationError;

	use namespace $internal;

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:00:39
	 */
	public class DisplayObjectContainer2D extends NativeDisplayObjectContainer2D {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function DisplayObjectContainer2D() {
			if ( ( this as Object ).constructor === DisplayObjectContainer2D ) {
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
		
		TODO:
		
		mouseChildren
		tabChildren?
		
		*/
		
		//----------------------------------
		//  numChildren
		//----------------------------------
		
		/**
		 * Возвращает количество детей.
		 * 
		 * @keyword					datacontainer.numchildren, numchildren
		 */
		public function get numChildren():int {
			return this._list.length;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		
		TODO:
		
		getObjectsUnderPoint
		
		*/
		
		public function addChild(child:DisplayObject2D):DisplayObject2D {
			return this.$addChildAt( child, this._list.length );
		}
		
		public function addChildAt(child:DisplayObject2D, index:int):DisplayObject2D {
			return this.$addChildAt( child, index  );
		}
		
		public function removeChild(child:DisplayObject2D):DisplayObject2D {
			return this.$removeChildAt( this.$getChildIndex( child ) );
		}
		
		public function removeChildAt(index:int):DisplayObject2D {
			return this.$removeChildAt( index );
		}
		
		public function contains(child:DisplayObject2D):Boolean {
			// проверим наличие передоваемого объекта
			if ( !child )  Error.throwError( TypeError, 2007, 'child' );
			return this.$contains( child );
		}
		
		public function getChildAt(index:int):DisplayObject2D {
			return this.$getChildAt( index );
		}
		
		public function getChildByName(name:String):DisplayObject2D {
			// проверяем мы ли родитель
			for each ( var child:DisplayObject2D in this._list ) {
				if ( child.$name === name ) return child;
			}
			return null;
		}
		
		public function getChildIndex(child:DisplayObject2D):int {
			return this.$getChildIndex( child );
		}
		
		public function setChildIndex(child:DisplayObject2D, index:int):void {
			this.$setChildIndex( child, index );
		}
		
		public function swapChildren(child1:DisplayObject2D, child2:DisplayObject2D):void {
			this.$swapChildrenAt( child1, child2, this.$getChildIndex( child1 ), this.$getChildIndex( child2 ) );
		}
		
		public function swapChildrenAt(index1:int, index2:int):void {
			this.$swapChildrenAt( this.$getChildAt( index1 ), this.$getChildAt( index2 ), index1, index2 );
		}
		
	}
	
}