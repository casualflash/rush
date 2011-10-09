////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package com.casualflash.rush.display {

	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Matrix;

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
			var parent:NativeDisplayObjectContainer2D = child.$parent;
			if ( parent ) {
				parent.$removeChildAt( parent.$list.indexOf( child ) );
			}
			this.$list.splice( index, 0, child );
			child.$setParent( this );
			return child;
		}

		/**
		 * @private
		 */
		$internal function $removeChildAt(index:int):DisplayObject2D {
			var child:DisplayObject2D = this.$list.splice( index, 1 )[ 0 ];
			child.$setParent( null );
			return child;
		}

		/**
		 * @private
		 */
		$internal function $contains(child:DisplayObject2D):Boolean {
			if ( child === this ) return true;
			if ( child.$parents ) {
				return child.$parents.indexOf( this ) >= 0;
			} else {
				while ( child = child.$parent ) {
					if ( child === this ) return true;
				};
				return false;
			}
		}

		/**
		 * @private
		 */
		$internal function $setChildIndex(child:DisplayObject2D, index:int):void {
			var i:int = this.$list.indexOf( child );
			if ( i != index ) {
				this.$list.splice( i, 1 );
				this.$list.splice( index, 0, child );
			}
		}

		/**
		 * @private
		 */
		$internal function $swapChildrenAt(child1:DisplayObject2D, child2:DisplayObject2D, index1:int, index2:int):void {
			this.$list.splice( index1, 1, child2 );
			this.$list.splice( index2, 1, child1 );
		}

		/**
		 * @private
		 */
		$internal override function $hitTestPoint(point:Point, shapeFlag:Boolean=false):Boolean {
			var p:Point;
			var im:Matrix;
			for each ( var child:DisplayObject2D in this.$list ) {
				if ( child.$changed & 2 ) child.$updateMatrix();
				im = child.$matrix.clone();
				im.invert();
				p = im.transformPoint( point );
				if ( child.$orign.containsPoint( p ) ) {
					if ( child.$hitTestPoint( p, shapeFlag ) ) {
						return true;
					}
				}
			}
			return false;
		}

		/**
		 * @private
		 */
		$internal override function $draw():void {
			for each ( var child:DisplayObject2D in this.$list ) {
				if ( child.visible ) {
					child.$draw();
				}
			}
		}

	}

}