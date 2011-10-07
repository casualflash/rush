////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {

	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Matrix;

	use namespace $internal;

	[ExcludeClass]
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:04:48
	 */
	internal class NativeDisplayObjectContainer2D extends InteractiveObject2D {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function NativeDisplayObjectContainer2D() {
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
		$internal const $list:Vector.<DisplayObject2D> = new Vector.<DisplayObject2D>();
		
		//--------------------------------------------------------------------------
		//
		//  Internal methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		$internal override function $setParent(parent:NativeDisplayObjectContainer2D):void {
			this.$changed |= 8;
			var child:DisplayObject2D;
			if ( this.$parent ) { // мы потеряли СТАРОГО папу
				this.$dispatchEventFunction( new $Event( Event.REMOVED, true ) );
				if ( this.$stage ) {
					if ( this.$bubble.hasEventListener( Event.REMOVED_FROM_STAGE ) ) {
						this.$bubble.dispatchEvent( new Event( Event.REMOVED_FROM_STAGE ) );
					}
					for each ( child in this.$list ) {
						child.$setStage( null );
					}
				}
			}
			if ( parent ) {
				if ( this.$parent !== parent ) {
					this.$parent = parent;
					this.$stage = parent.$stage;
					if ( this.$stage ) {
						this.$parents = parent.$parents.slice();
						this.$parents.unshift( parent );
					}
					this.$dispatchEventFunction( new $Event( Event.ADDED, true ) );
					if ( this.$stage ) {
						if ( this.$bubble.hasEventListener( Event.ADDED_TO_STAGE ) ) {
							this.$bubble.dispatchEvent( new Event( Event.ADDED_TO_STAGE ) );
						}
						for each ( child in this.$list ) {
							child.$setStage( this.$stage );
						}
					}
				}
			} else {
				this.$parents = null;
				this.$stage = null;
				this.$parent = null;
			}
		}
		
		/**
		 * @private
		 */
		$internal override function $setStage(stage:Stage2D):void {
			var child:DisplayObject2D;
			if ( this.$stage ) {
				if ( this.$bubble.hasEventListener( Event.REMOVED_FROM_STAGE ) ) {
					this.$bubble.dispatchEvent( new Event( Event.REMOVED_FROM_STAGE ) );
				}
				for each ( child in this.$list ) {
					child.$setStage( null );
				}
			}
			if ( stage ) {
				if ( this.$stage !== stage ) {
					this.$stage = stage;
					this.$parents = parent.$parents.slice();
					this.$parents.unshift( parent );
					if ( this.$bubble.hasEventListener( Event.ADDED_TO_STAGE ) ) {
						this.$bubble.dispatchEvent( new Event( Event.ADDED_TO_STAGE ) );
					}
					for each ( child in this.$list ) {
						child.$setStage( this.$stage );
					}
				}
			} else {
				this.$stage = null;
				this.$parents = null;
			}
		}

		/**
		 * @private
		 */
		$internal function $addChildAt(child:DisplayObject2D, index:int):DisplayObject2D {
			// проверим наличие передоваемого объекта
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			// проверим рэндж
			if ( index < 0 || index > this.$list.length ) Error.throwError( RangeError, 2006 );
			// проверим не мыли это?
			if ( child === this ) Error.throwError( ArgumentError, 2024 );
			// если есть родитель, то надо его отуда удалить
			if ( child.$parent === this ) {
				this.$setChildIndex( child, index, false );
			} else {
				var parent:NativeDisplayObjectContainer2D = child.$parent;
				if ( parent ) {
					parent.$removeChildAt(
						parent.$getChildIndex(
							child,
							false
						),
						false
					);
				}
				// проверим нашу пренадлежность, вдруг зацикливание
				if ( child is NativeDisplayObjectContainer2D && ( child as NativeDisplayObjectContainer2D ).$contains( this ) ) {
					Error.throwError( ArgumentError, 2150 );
				}
				// добавляем
				this.$list.splice( index, 0, child );
				// обновляем
				child.$setParent( this );
			}
			// возвращаем
			return child;
		}

		/**
		 * @private
		 */
		$internal function $removeChildAt(index:int, strict:Boolean=true):DisplayObject2D {
			if ( strict ) {
				// проверим рэндж
				if ( index < 0 || index > this.$list.length ) Error.throwError( RangeError, 2006 );
			}
			// удалим
			var child:DisplayObject2D = this.$list.splice( index, 1 )[ 0 ];
			// обновим
			child.$setParent( null );
			// вернём
			return child;
		}
		
		/**
		 * @private
		 */
		$internal function $contains(child:DisplayObject2D):Boolean {
			// проверим нашу пренадлежность, вдруг зацикливание
			if ( child.$parents ) {
				return child.$parents.indexOf( this ) >= 0;
			} else {
				do {
					if ( child === this ) return true;
				} while ( child = child.$parent );
				return false;
			}
		}

		/**
		 * @private
		 */
		$internal function $getChildAt(index:int):DisplayObject2D {
			// проверим рэндж
			if ( index<0 || index>this.$list.length ) Error.throwError( RangeError, 2006 );
			return this.$list[ index ];
		}
		
		/**
		 * @private
		 */
		$internal function $getChildIndex(child:DisplayObject2D, strict:Boolean=true):int {
			if ( strict ) {
				// проверяем мы ли родитель
				if ( !child || child.$parent !== this ) Error.throwError( ArgumentError, 2025 );
			}
			// ищем
			return this.$list.indexOf( child );
		}
		
		/**
		 * @private
		 */
		$internal function $setChildIndex(child:DisplayObject2D, index:int, strict:Boolean=true):void {
			if ( strict ) {
				if ( !child )  Error.throwError( TypeError, 2007, 'child' );
				// проверим рэндж
				if ( index < 0 || index > this.$list.length ) Error.throwError( RangeError, 2006 );
			}
			this.$list.splice( this.$getChildIndex( child, strict ), 1 );
			this.$list.splice( index, 0, child );
		}
		
		/**
		 * @private
		 */
		$internal function $swapChildrenAt(child1:DisplayObject2D, child2:DisplayObject2D, index1:int, index2:int):void {
			// надо сперва поставить того кто выше
			if ( index1 > index2 ) {
				this.$setChildIndex( child1, index2, false );
				this.$setChildIndex( child2, index1, false );
			} else {
				this.$setChildIndex( child2, index1, false );
				this.$setChildIndex( child1, index2, false );
			}
		}

		/**
		 * @private
		 */
		$internal override function $hitTestPoint(point:Point, shapeFlag:Boolean=false):Boolean {
			var p:Point;
			var mi:Matrix;
			for each ( var child:DisplayObject2D in this.$list ) {
				if ( child.$changed & 2 ) child.$updateMatrix();
				mi = child.$matrix.clone();
				mi.invert();
				p = mi.transformPoint( point );
				if ( child.$orign.containsPoint( p ) ) {
					if ( child.$hitTestPoint( p, shapeFlag ) ) {
						return true;
					}
				}
			}
			return false;
		}
		
	}
	
}