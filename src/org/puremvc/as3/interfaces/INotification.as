package org.puremvc.as3.interfaces
{
	public interface INotification
	{
		
		/**
		 * Get the name of the <code>INotification</code> instance. 
		 * No setter, should be set by constructor only
		 */
		function getName():String;

		/**
		 * Set the body of the <code>INotification</code> instance
		 */
		function setBody( body:Object ):void;
		
		/**
		 * Get the body of the <code>INotification</code> instance
		 */
		function getBody():Object;
		
		/**
		 * Set the type of the <code>INotification</code> instance
		 */
		function setType( type:String ):void;
		
		/**
		 * Get the type of the <code>INotification</code> instance
		 */
		function getType():String;

		/**
		 * Get the string representation of the <code>INotification</code> instance
		 */
		function toString():String;
	}
}
