/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.puremvc.as3.patterns.observer
{
	import dom.domobjects.EventFunction;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IObserver;
	
	/**
	 * A base <code>IObserver</code> implementation.
	 * 
	 * <P> 
	 * An <code>Observer</code> is an object that encapsulates information
	 * about an interested object with a method that should 
	 * be called when a particular <code>INotification</code> is broadcast. </P>
	 * 
	 * <P>
	 * In PureMVC, the <code>Observer</code> class assumes these responsibilities:
	 * <UL>
	 * <LI>Encapsulate the notification (callback) method of the interested object.</LI>
	 * <LI>Encapsulate the notification context (this) of the interested object.</LI>
	 * <LI>Provide methods for setting the notification method and context.</LI>
	 * <LI>Provide a method for notifying the interested object.</LI>
	 * </UL>
	 * 
	 * @see org.puremvc.as3.core.view.View View
	 * @see org.puremvc.as3.patterns.observer.Notification Notification
	 */
	public class Observer implements IObserver
	{
		private var notify:EventFunction;
		private var context:Object;
	
		/**
		 * Constructor. 
		 * 
		 * <P>
		 * The notification method on the interested object should take 
		 * one parameter of type <code>INotification</code></P>
		 * 
		 * @param notifyMethod the notification method of the interested object
		 * @param notifyContext the notification context of the interested object
		 */
		public function Observer( aNotifyMethod:EventFunction, aNotifyContext:Object ) 
		{
			setNotifyMethod( aNotifyMethod );
			setNotifyContext( aNotifyContext );
		}
		
		/**
		 * Set the notification method.
		 * 
		 * <P>
		 * The notification method should take one parameter of type <code>INotification</code>.</P>
		 * 
		 * @param notifyMethod the notification (callback) method of the interested object.
		 */
		public function setNotifyMethod( aNotifyMethod:EventFunction ):void
		{
			notify = aNotifyMethod;
		}
		
		/**
		 * Set the notification context.
		 * 
		 * @param notifyContext the notification context (this) of the interested object.
		 */
		public function setNotifyContext( aNotifyContext:Object ):void
		{
			context = aNotifyContext;
		}
		
		/**
		 * Get the notification method.
		 * 
		 * @return the notification (callback) method of the interested object.
		 */
		private function getNotifyMethod():Function
		{
			return notify;
		}
		
		/**
		 * Get the notification context.
		 * 
		 * @return the notification context (<code>this</code>) of the interested object.
		 */
		private function getNotifyContext():Object
		{
			return context;
		}
		
		/**
		 * Notify the interested object.
		 * 
		 * @param notification the <code>INotification</code> to pass to the interested object's notification method.
		 */
		public function notifyObserver( aNotification:INotification ):void
		{
			this.getNotifyMethod().apply(this.getNotifyContext(),[aNotification]);
		}
	
		/**
		 * Compare an object to the notification context. 
		 * 
		 * @param object the object to compare
		 * @return boolean indicating if the object and the notification context are the same
		 */
		 public function compareNotifyContext( aObject:Object ):Boolean
		 {
		 	return aObject === this.context;
		 }		
	}
}