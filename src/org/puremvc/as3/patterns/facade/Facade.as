package org.puremvc.as3.patterns.facade
{
    import org.puremvc.as3.core.Controller;
    import org.puremvc.as3.core.Model;
    import org.puremvc.as3.core.View;
    import org.puremvc.as3.interfaces.IController;
    import org.puremvc.as3.interfaces.IFacade;
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.IModel;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.interfaces.IView;
    import org.puremvc.as3.patterns.observer.Notification;

    public class Facade implements IFacade
    {
        // Private references to Model, View and Controller
        public var controller :IController;
        public var model	  :IModel;
        public var view		  :IView;

        // The Singleton Facade instance.
        protected static var instance : IFacade;

        // Message Constants
        protected const SINGLETON_MSG	: String = "Facade Singleton already constructed!";

        public function Facade( )
        {
            if (instance != null) {
                throw Error(SINGLETON_MSG);
            }
            instance = this;
            initializeFacade();
        }

        protected function initializeFacade():void
        {
            initializeModel();
            initializeController();
            initializeView();
        }

        public static function getInstance():IFacade {
            if (instance == null) instance = new Facade( );
            return instance;
        }

        public static function setInstance( aInstance:IFacade ):void
        {
            instance = aInstance;
        }

        protected function initializeController( ):void
        {
            if ( controller != null ) {
                return;
            }
            controller = Controller.getInstance();
        }

        protected function initializeModel( ):void
        {
            if ( model != null ) {
                return;
            }
            model = Model.getInstance();
        }

        protected function initializeView( ):void
        {
            if ( view != null ) {
                return;
            }
            view = View.getInstance();
        }

        public function registerCommand( aNotificationName:String, aCommandClassRef:Class ):void
        {
            controller.registerCommand( aNotificationName, aCommandClassRef );
        }

        public function removeCommand( aNotificationName:String ):void
        {
            controller.removeCommand( aNotificationName );
        }

        public function hasCommand( aNotificationName:String ):Boolean
        {
            return controller.hasCommand( aNotificationName );
        }

        public function registerProxy ( aProxy:IProxy ):void
        {
            model.registerProxy ( aProxy );
        }


        public function retrieveProxy ( aProxyName:String ):IProxy
        {
            return model.retrieveProxy ( aProxyName );
        }

        public function removeProxy ( aProxyName:String ):IProxy
        {
            var proxy:IProxy;
            if ( model != null ) {
                proxy = model.removeProxy ( aProxyName );
            }
            return proxy;
        }

        public function hasProxy( aProxyName:String ) : Boolean
        {
            return model.hasProxy( aProxyName );
        }

        public function registerMediator( aMediator:IMediator ):void
        {
            if ( view != null ) {
                view.registerMediator( aMediator );
            }
        }

        public function retrieveMediator( aMediatorName:String ):IMediator
        {
            return view.retrieveMediator( aMediatorName ) as IMediator;
        }

        public function removeMediator( aMediatorName:String ) : IMediator
        {
            var mediator:IMediator;
            if ( view != null ) {
                mediator = view.removeMediator( aMediatorName );
            }
            return mediator;
        }

        public function hasMediator( aMediatorName:String ) : Boolean
        {
            return view.hasMediator( aMediatorName );
        }

        public function sendNotification( aNotificationName:String = null, aBody:Object = null, aType:String = null ):void
        {
            notifyObservers( new Notification( aNotificationName, aBody || null, aType || null ));
        }

        public function notifyObservers ( aNotification:INotification ):void
        {
            if ( view != null ) {
                view.notifyObservers( aNotification );
            }
        }
    }
}
