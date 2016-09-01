/**
 * Expression handler for "User has performed action recently "
 *
 * @feature websiteUsers
 */
component {

	property name="rulesEngineOperatorService" inject="rulesEngineOperatorService";
	property name="websiteUserActionService"   inject="websiteUserActionService";

	/**
	 * @expression         true
	 * @expressionContexts webrequest,user
	 * @action.fieldType   websiteUserAction
	 * @action.multiple    false
	 * @days.fieldLabel    rules.expressions.UserPerformedActionRecently.webrequest:field.days.config.label
	 */
	private boolean function webRequest(
		  required string  action
		, required numeric days
		,          boolean _has = true
	) {
		if ( ListLen( action, "." ) != 2 ) {
			return false;
		}

		var result = websiteUserActionService.hasPerformedAction(
			  type   = ListFirst( action, "." )
			, action = ListLast( action, "." )
			, userId = payload.user.id ?: ""
			, since  = DateAdd( "d", -days, Now() )
		);

		return _has ? result : !result;
	}

}