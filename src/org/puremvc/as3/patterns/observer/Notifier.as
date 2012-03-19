package org.puremvc.as3.patterns.observer
{
    import org.puremvc.as3.interfaces.IFacade;
    import org.puremvc.as3.interfaces.INotifier;
    import org.puremvc.as3.patterns.facade.Facade;

    public class Notifier implements INotifier
    {
        protected var facade:IFacade;
		
		public function Notifier()
		{
			facade = Facade.getInstance();
		}

        public function sendNotification( aNotificationName:String = null, aBody:Object = null, aType:String = null ):void
        {
            facade.sendNotification( aNotificationName, aBody, aType );
        }
    }
}
