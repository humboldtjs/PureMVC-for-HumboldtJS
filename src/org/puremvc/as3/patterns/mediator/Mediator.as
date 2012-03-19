package org.puremvc.as3.patterns.mediator
{
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.interfaces.INotifier;
    import org.puremvc.as3.patterns.observer.Notifier;

    public class Mediator extends Notifier implements IMediator, INotifier
	{
		public static const NAME:String = 'Mediator';
		
		protected var mediatorName:String;
		
		protected var viewComponent:Object;
		
		public function Mediator(aMediatorName:String, aViewComponent:Object)
		{
			super();

			mediatorName = (aMediatorName != null) ? aMediatorName : NAME;
			viewComponent = aViewComponent;
		}
		
		public function getMediatorName():String
		{
			return mediatorName;
		}
		
		public function getViewComponent():Object
		{
			return viewComponent;
		}
		
		public function handleNotification(aNotification:INotification):void
		{
		}
		
		public function listNotificationInterests():Array
		{
			return [];
		}
		
		public function onRegister():void
		{
		}
		
		public function onRemove():void
		{
		}
		
		public function setViewComponent(aViewComponent:Object):void
		{
			viewComponent = aViewComponent;
		}
	}
}
