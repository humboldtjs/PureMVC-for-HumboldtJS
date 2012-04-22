/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.puremvc.as3.patterns.proxy
{
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	/**
	 * A base <code>IProxy</code> implementation. 
	 * 
	 * <P>
	 * In PureMVC, <code>Proxy</code> classes are used to manage parts of the 
	 * application's data model. </P>
	 * 
	 * <P>
	 * A <code>Proxy</code> might simply manage a reference to a local data object, 
	 * in which case interacting with it might involve setting and 
	 * getting of its data in synchronous fashion.</P>
	 * 
	 * <P>
	 * <code>Proxy</code> classes are also used to encapsulate the application's 
	 * interaction with remote services to save or retrieve data, in which case, 
	 * we adopt an asyncronous idiom; setting data (or calling a method) on the 
	 * <code>Proxy</code> and listening for a <code>Notification</code> to be sent 
	 * when the <code>Proxy</code> has retrieved the data from the service. </P>
	 * 
	 * @see org.puremvc.as3.core.model.Model Model
	 */
	public class Proxy extends Notifier implements IProxy, INotifier
	{

		public static var NAME:String = 'Proxy';
		
		/**
		 * Constructor
		 */
		public function Proxy( aProxyName:String=null, aData:Object=null ) 
		{
			super();
			this.proxyName = (aProxyName != null)?aProxyName:NAME; 
			if (aData != null) setData(aData);
		}

		/**
		 * Get the proxy name
		 */
		public function getProxyName():String 
		{
			return proxyName;
		}		
		
		/**
		 * Set the data object
		 */
		public function setData( aData:Object ):void 
		{
			this.data = aData;
		}
		
		/**
		 * Get the data object
		 */
		public function getData():Object 
		{
			return data;
		}		

		/**
		 * Called by the Model when the Proxy is registered
		 */ 
		public function onRegister( ):void {}

		/**
		 * Called by the Model when the Proxy is removed
		 */ 
		public function onRemove( ):void {}
		
		
		// the proxy name
		protected var proxyName:String;
		
		// the data object
		protected var data:Object;
	}
}