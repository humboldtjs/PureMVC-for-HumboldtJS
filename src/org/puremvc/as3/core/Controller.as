package org.puremvc.as3.core
{
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.IController;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.interfaces.IView;
    import org.puremvc.as3.patterns.observer.Observer;

    public class Controller implements IController
    {
        protected var view              :IView;
        protected var commandMap        :Array;
        protected static var instance   :IController;

        protected const SINGLETON_MSG   :String = "Controller Singleton already constructed!";

        public function Controller()
        {
            if (instance != null) {
                throw Error(SINGLETON_MSG);
            }
            instance = this;
            commandMap = new Array();
            initializeController();
        }

        protected function initializeController():void
        {
            view = View.getInstance();
        }

        public static function getInstance():IController
        {
            if ( instance == null ) {
                instance = new Controller( );
            }
            return instance;
        }

        public function executeCommand( aNote:INotification ) : void
        {
            var commandClassRef : Class = commandMap[ aNote.getName() ];
            if ( commandClassRef == null ) {
                return;
            }
            var commandInstance : ICommand = new commandClassRef();
            commandInstance.execute( aNote );
        }

        public function registerCommand( aNotificationName : String, aCommandClassRef : Class ) : void
        {
            if ( commandMap[ aNotificationName ] == null ) {
                view.registerObserver( aNotificationName, new Observer( executeCommand, this ) );
            }
            commandMap[ aNotificationName ] = aCommandClassRef;
        }

        public function hasCommand( aNotificationName:String ) : Boolean
        {
            return commandMap[ aNotificationName ] != null;
        }

        public function removeCommand( aNotificationName : String ) : void
        {
            // if the Command is registered...
            if ( hasCommand( aNotificationName ) )
            {
                // remove the observer
                view.removeObserver( aNotificationName, this );

                // remove the command
                commandMap[ aNotificationName ] = null;
            }
        }
    }
}
