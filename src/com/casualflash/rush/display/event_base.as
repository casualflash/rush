////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2011 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

//--------------------------------------------------------------------------
//
//  Variables
//
//--------------------------------------------------------------------------

/**
 * @private
 */
$internal var $stopped:Boolean = false;

/**
 * @private
 */
$internal var $canceled:Boolean = false;

//--------------------------------------------------------------------------
//
//  Properties
//
//--------------------------------------------------------------------------

//----------------------------------
//  target
//----------------------------------

/**
 * @private
 */
$internal var $target:Object;

/**
 * @private
 * Сцылка на таргет.
 */
public override function get target():Object {
	return this.$target || super.target;
}

//----------------------------------
//  eventPhase
//----------------------------------

/**
 * @private
 */
$internal var $eventPhase:uint;

/**
 * @private
 * Фаза.
 */
public override function get eventPhase():uint {
	return this.$eventPhase || super.eventPhase;
}

//--------------------------------------------------------------------------
//
//  Overriden methods: Event
//
//--------------------------------------------------------------------------

/**
 * @private
 */
public override function stopImmediatePropagation():void {
	super.stopImmediatePropagation();
	this.$stopped = true;
}

/**
 * @private
 */
public override function stopPropagation():void {
	this.$stopped = true;
}

/**
 * @private
 */
public override function preventDefault():void {
	if ( super.cancelable ) this.$canceled = true;
}

/**
 * @private
 */
public override function isDefaultPrevented():Boolean {
	return this.$canceled;
}