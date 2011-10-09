////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {

	import avmplus.getQualifiedClassName;
	
	import flash.errors.IllegalOperationError;

	//--------------------------------------
	//  Namespaces
	//--------------------------------------
	
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
			return this.$list.length;
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
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			if ( child === this ) Error.throwError( ArgumentError, 2024 );
			if ( child.$parent === this ) {
				this.$setChildIndex( child, this.$list.length );
				return child;
			} else {
				if ( child is NativeDisplayObjectContainer2D && ( child as NativeDisplayObjectContainer2D ).$contains( this ) ) {
					Error.throwError( ArgumentError, 2150 );
				}
				return this.$addChildAt( child, this.$list.length );
			}
		}

		public function addChildAt(child:DisplayObject2D, index:int):DisplayObject2D {
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			if ( index < 0 || index > this.$list.length ) Error.throwError( RangeError, 2006 );
			if ( child === this ) Error.throwError( ArgumentError, 2024 );
			if ( child.$parent === this ) {
				this.$setChildIndex( child, index );
				return child;
			} else {
				if ( child is NativeDisplayObjectContainer2D && ( child as NativeDisplayObjectContainer2D ).$contains( this ) ) {
					Error.throwError( ArgumentError, 2150 );
				}
				return this.$addChildAt( child, index );
			}
		}

		public function removeChild(child:DisplayObject2D):DisplayObject2D {
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			if ( child.$parent !== this ) Error.throwError( ArgumentError, 2025 );
			return this.$removeChildAt( this.$list.indexOf( child ) );
		}

		public function removeChildAt(index:int):DisplayObject2D {
			if ( index < 0 || index >= this.$list.length ) Error.throwError( RangeError, 2006 );
			return this.$removeChildAt( index );
		}

		public function removeChildren(beginIndex:int=0, endIndex:int=int.MAX_VALUE):void {
			if ( arguments.length < 2 ) endIndex = this.$list.length - 1;
			if ( beginIndex > endIndex || beginIndex < 0 || endIndex >= this.$list.length ) Error.throwError( RangeError, 2006 );
			for each( var child:DisplayObject2D in this.$list.splice( beginIndex, endIndex - beginIndex + 1 ) ) {
				child.$setParent( null );
			}
		}

		public function contains(child:DisplayObject2D):Boolean {
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			return this.$contains( child );
		}

		public function getChildAt(index:int):DisplayObject2D {
			if ( index < 0 || index >= this.$list.length ) Error.throwError( RangeError, 2006 );
			return this.$list[ index ];
		}

		public function getChildByName(name:String):DisplayObject2D {
			for each ( var child:DisplayObject2D in this.$list ) {
				if ( child.$name === name ) return child;
			}
			return null;
		}

		public function getChildIndex(child:DisplayObject2D):int {
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			if ( child.$parent !== this ) Error.throwError( ArgumentError, 2025 );
			return this.$list.indexOf( child );
		}

		public function setChildIndex(child:DisplayObject2D, index:int):void {
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			if ( index < 0 || index >= this.$list.length ) Error.throwError( RangeError, 2006 );
			this.$setChildIndex( child, index );
		}

		public function swapChildren(child1:DisplayObject2D, child2:DisplayObject2D):void {
			if ( !child1 ) Error.throwError( TypeError, 2007, 'child1' );
			if ( !child2 ) Error.throwError( TypeError, 2007, 'child2' );
			if ( child1.$parent !== this || child2.$parent !== this ) Error.throwError( ArgumentError, 2025 );
			this.$swapChildrenAt(
				child1,
				child2,
				this.$list.indexOf( child1 ),
				this.$list.indexOf( child2 )
			);
		}
		
		public function swapChildrenAt(index1:int, index2:int):void {
			if ( index1 < 0 || index1 >= this.$list.length || index2 < 0 || index2 >= this.$list.length ) Error.throwError( RangeError, 2006 );
			this.$swapChildrenAt(
				this.$list[ index1 ],
				this.$list[ index2 ],
				index1,
				index2
			);
		}

	}

}