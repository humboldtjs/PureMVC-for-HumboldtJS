package org.puremvc.as3.core
{
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.interfaces.IObserver;
    import org.puremvc.as3.interfaces.IView;
    import org.puremvc.as3.patterns.observer.Observer;

    public class View implements IView
    {
         // Mapping of Mediator names to Mediator instances
        protected var mediatorMap : Array;

        // Mapping of Notification names to Observer lists
        protected var observerMap	: Array;

        // Singleton instance
        protected static var instance	: IView;

        // Message Constants
        protected const SINGLETON_MSG	: String = "View Singleton already constructed!";

        public function View( )
        {
            if ( instance != null ) {
                throw Error( SINGLETON_MSG );
            }
            instance = this;
            mediatorMap = [];
            observerMap = [];
            initializeView();
        }

        protected function initializeView(  ) : void
        {
        }

        public static function getInstance() : IView
        {
            if ( instance == null ) instance = new View( );
            return instance;
        }

        public function registerObserver ( notificationName:String, observer:IObserver ) : void
        {
            var observers:Array = observerMap[ notificationName ];
            if( observers ) {
                observers.push( observer );
            } else {
                observerMap[ notificationName ] = [ observer ];
            }
        }

        public function notifyObservers( notification:INotification ):void
        {
            var tmp:Object = observerMap[ notification.getName() ];
            if( tmp != null )
            {
                var observers_ref:Array = (tmp) as Array;
                var theLength:int = observers_ref.length;

                var observer:IObserver;
                for ( var i:int = 0; i < theLength; ++i ) {
                    observer = (observers_ref[ i ]) as IObserver;
                    observer.notifyObserver( notification );
                }
            }
            //delete tmp;
        }

        public function removeObserver( notificationName:String, notifyContext:Object ):void
        {
            var observers:Array = (observerMap[ notificationName ]) as Array;

            for ( var i: int = 0; i < observers.length; ++i )
            {
                var observer:Observer = observers[i];
                if ( observer.compareNotifyContext( notifyContext )) {
                    observers.splice(i,1);
                    break;
                }
            }
            if ( observers.length == 0 ) {
                delete observerMap[ notificationName ];
            }
        }

        public function registerMediator( mediator:IMediator ) : void
        {
            if ( mediatorMap[ mediator.getMediatorName() ] != null ) {
                return;
            }
            mediatorMap[ mediator.getMediatorName() ] = mediator;

            var interests:Array = mediator.listNotificationInterests();

            if ( interests.length > 0 ) {
                var observer:Observer = new Observer( mediator.handleNotification, mediator );

                for ( var i:int = 0;  i < interests.length; ++i ) {
                    registerObserver( interests[i],  observer );
                }
            }
            mediator.onRegister();
        }

        public function retrieveMediator( mediatorName:String ) : IMediator
        {
            return mediatorMap[ mediatorName ];
        }

        public function removeMediator( mediatorName:String ) : IMediator
        {
            var mediator:IMediator = ( mediatorMap[ mediatorName ]) as IMediator;

            if ( mediator )
            {
                var interests:Array = mediator.listNotificationInterests();
                for ( var i:Number = 0; i < interests.length; ++i )
                {
                    removeObserver( interests[i], mediator );
                }
                delete mediatorMap[ mediatorName ];

                mediator.onRemove();
            }
            return mediator;
        }

        public function hasMediator( mediatorName:String ) : Boolean
        {
            return mediatorMap[ mediatorName ] != null;
        }
    }
}
