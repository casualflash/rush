////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.secret.display {

	import by.blooddy.secret.events.Event;

	use namespace $internal;

	[ExcludeClass]
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					01.10.2011 18:04:48
	 */
	internal class NativeDisplayObjectContainer extends InteractiveObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function NativeDisplayObjectContainer() {
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
		$internal const _list:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		//--------------------------------------------------------------------------
		//
		//  Internal methods
		//
		//--------------------------------------------------------------------------

		$internal override function $setParent(parent:NativeDisplayObjectContainer):void {
			var child:DisplayObject;
			if ( this._parent ) { // мы потеряли СТАРОГО папу
				this._bubbleParent = this._parent;
				this.$dispatchEventFunction( new by.blooddy.secret.events.Event( by.blooddy.secret.events.Event.REMOVED, true ) );
				if ( this._stage ) {
					this._bubble.dispatchEvent( new by.blooddy.secret.events.Event( by.blooddy.secret.events.Event.REMOVED_FROM_STAGE ) );
					for each ( child in this._list ) {
						child.$setStage( null );
					}
				}
			}
			if ( parent ) {
				if ( this._parent !== parent ) {
					this._stage = ( parent as DisplayObject )._stage;
					this._parent = parent;
					this._bubbleParent = parent;
					this.$dispatchEventFunction( new by.blooddy.secret.events.Event( by.blooddy.secret.events.Event.ADDED, true ) );
					if ( this._stage ) {
						this._bubble.dispatchEvent( new by.blooddy.secret.events.Event( by.blooddy.secret.events.Event.ADDED_TO_STAGE ) );
						for each ( child in this._list ) {
							child.$setStage( this._stage );
						}
					}
				}
			} else {
				this._stage = null;
				this._parent = null;
			}
		}
		
		$internal override function $setStage(stage:Stage):void {
			var child:DisplayObject;
			if ( this._stage ) {
				this._bubble.dispatchEvent( new by.blooddy.secret.events.Event( by.blooddy.secret.events.Event.REMOVED_FROM_STAGE ) );
				for each ( child in this._list ) {
					child.$setStage( null );
				}
			}
			if ( stage ) {
				if ( this._stage !== stage ) {
					this._stage = stage;
					this._bubble.dispatchEvent( new by.blooddy.secret.events.Event( by.blooddy.secret.events.Event.ADDED_TO_STAGE ) );
					for each ( child in this._list ) {
						child.$setStage( this._stage );
					}
				}
			} else {
				this._stage = null;
			}
		}

		/**
		 * @private
		 */
		$internal function $addChildAt(child:DisplayObject, index:int):DisplayObject {
			// проверим наличие передоваемого объекта
			if ( !child ) Error.throwError( TypeError, 2007, 'child' );
			// проверим рэндж
			if ( index < 0 || index > this._list.length ) Error.throwError( RangeError, 2006 );
			// проверим не мыли это?
			if ( child === this ) Error.throwError( ArgumentError, 2024 );
			// если есть родитель, то надо его отуда удалить
			if ( child._parent === this ) {
				this.$setChildIndex( child, index, false );
			} else {
				var parent:NativeDisplayObjectContainer = child._parent;
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
				if ( child is NativeDisplayObjectContainer && ( child as NativeDisplayObjectContainer ).$contains( this ) ) {
					Error.throwError( ArgumentError, 2150 );
				}
				// добавляем
				this._list.splice( index, 0, child );
				// обновляем
				child.$setParent( this );
			}
			// возвращаем
			return child;
		}

		/**
		 * @private
		 */
		$internal function $removeChildAt(index:int, strict:Boolean=true):DisplayObject {
			if ( strict ) {
				// проверим рэндж
				if ( index < 0 || index > this._list.length ) Error.throwError( RangeError, 2006 );
			}
			// удалим
			var child:DisplayObject = this._list.splice( index, 1 )[ 0 ];
			// обновим
			child.$setParent( null );
			// вернём
			return child;
		}
		
		/**
		 * @private
		 */
		$internal function $contains(child:DisplayObject):Boolean {
			// проверим нашу пренадлежность, вдруг зацикливание
			do {
				if ( child === this ) return true;
			} while ( child = child._parent );
			return false;
		}

		/**
		 * @private
		 */
		$internal function $getChildAt(index:int):DisplayObject {
			// проверим рэндж
			if ( index<0 || index>this._list.length ) Error.throwError( RangeError, 2006 );
			return this._list[ index ];
		}
		
		/**
		 * @private
		 */
		$internal function $getChildIndex(child:DisplayObject, strict:Boolean=true):int {
			if ( strict ) {
				// проверяем мы ли родитель
				if ( !child || child._parent !== this ) Error.throwError( ArgumentError, 2025 );
			}
			// ищем
			return this._list.indexOf( child );
		}
		
		/**
		 * @private
		 */
		$internal function $setChildIndex(child:DisplayObject, index:int, strict:Boolean=true):void {
			if ( strict ) {
				if ( !child )  Error.throwError( TypeError, 2007, 'child' );
				// проверим рэндж
				if ( index < 0 || index > this._list.length ) Error.throwError( RangeError, 2006 );
			}
			this._list.splice( this.$getChildIndex( child, strict ), 1 );
			this._list.splice( index, 0, child );
		}
		
		/**
		 * @private
		 */
		$internal function $swapChildrenAt(child1:DisplayObject, child2:DisplayObject, index1:int, index2:int):void {
			// надо сперва поставить того кто выше
			if ( index1 > index2 ) {
				this.$setChildIndex( child1, index2, false );
				this.$setChildIndex( child2, index1, false );
			} else {
				this.$setChildIndex( child2, index1, false );
				this.$setChildIndex( child1, index2, false );
			}
		}
		
	}
	
}