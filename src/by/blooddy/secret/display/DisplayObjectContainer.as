////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {

	use namespace $internal;

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:00:39
	 */
	public class DisplayObjectContainer extends NativeDisplayObjectContainer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function DisplayObjectContainer() {
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
		
		public function addChild(child:DisplayObject):DisplayObject {
			return this.$addChildAt( child, this._list.length );
		}
		
		public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			return this.$addChildAt( child, index  );
		}
		
		public function removeChild(child:DisplayObject):DisplayObject {
			return this.$removeChildAt( this.$getChildIndex( child ) );
		}
		
		public function removeChildAt(index:int):DisplayObject {
			return this.$removeChildAt( index );
		}
		
		public function contains(child:DisplayObject):Boolean {
			// проверим наличие передоваемого объекта
			if ( !child )  Error.throwError( TypeError, 2007, 'child' );
			return this.$contains( child );
		}
		
		public function getChildAt(index:int):DisplayObject {
			return this.$getChildAt( index );
		}
		
		public function getChildByName(name:String):DisplayObject {
			// проверяем мы ли родитель
			for each ( var child:DisplayObject in this._list ) {
				if ( child.name === name ) return child;
			}
			return null;
		}
		
		public function getChildIndex(child:DisplayObject):int {
			return this.$getChildIndex( child );
		}
		
		public function setChildIndex(child:DisplayObject, index:int):void {
			this.$setChildIndex( child, index );
		}
		
		public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			this.$swapChildrenAt( child1, child2, this.$getChildIndex( child1 ), this.$getChildIndex( child2 ) );
		}
		
		public function swapChildrenAt(index1:int, index2:int):void {
			this.$swapChildrenAt( this.$getChildAt( index1 ), this.$getChildAt( index2 ), index1, index2 );
		}
		
	}
	
}