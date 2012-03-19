package org.puremvc.as3.patterns.command
{
    import dom.eventFunction;
    
    import org.puremvc.as3.interfaces.IAsyncCommand;
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.interfaces.INotifier;
    import org.puremvc.as3.patterns.observer.Notifier;

    public class AsyncMacroCommand extends Notifier	implements IAsyncCommand, INotifier
    {
        protected var valueObject           :Object;
        protected var subCommands		    :Array;
        protected var cancelCommands	    :Array;
        protected var nextCancelCommandRef  :Class;
        protected var note			        :INotification;
        protected var onComplete		    :Function;
        protected var onCancel		        :Function;

        public function AsyncMacroCommand()
        {
			super();
            subCommands     = new Array();
            cancelCommands  = new Array();
            initializeAsyncMacroCommand();
        }

        protected function initializeAsyncMacroCommand():void {}

        protected function addSubCommand( commandClassRef:Class, cancelCommandClassRef:Class = null): void
        {
            subCommands.push( commandClassRef );
            cancelCommands.push(cancelCommandClassRef);
        }

        public function setOnComplete ( value:Function ) : void { onComplete = value; }

        public function setOnCancel ( value:Function ) : void { onCancel = value; }

        public function setValueObject ( value:Object ) :void { valueObject = value }

        public final function execute( notification:INotification ) : void
        {
            note = notification;
            nextCommand();
        }

        private function nextCommand ():void
        {
            if ( subCommands == null ) {
                return;
            }
            if ( subCommands.length > 0 )
            {
                var commandClassRef:Class	= subCommands.shift();
                nextCancelCommandRef        = cancelCommands.shift();
                var commandInstance:Object	= new commandClassRef();
                var isAsync:Boolean			= commandInstance is IAsyncCommand;
                if ( isAsync )
                {
                    (( commandInstance ) as IAsyncCommand ).setOnComplete( eventFunction( this, nextCommand ));
                    if ( nextCancelCommandRef != null ) {
                        (( commandInstance ) as IAsyncCommand ).setOnCancel( eventFunction( this, nextCancelCommand ));
                    }
                    if ( valueObject != null )  (( commandInstance ) as IAsyncCommand ).setValueObject( valueObject );
                }
                commandInstance.execute( note );
                //(( commandInstance ) as ICommand ).execute( note );
                if ( !isAsync ) {
                    nextCommand();
                }
            }
            else
            {
                if( onComplete != null ) {
                    onComplete();
                }
                note 		= null;
                onComplete	= null;
                onCancel    = null;
            }
        }

        private function nextCancelCommand():void
        {
            if ( nextCancelCommandRef != null ) {
                var nccr:ICommand = new nextCancelCommandRef();
                if ( valueObject != null && nccr is IAsyncCommand ) ( nccr as IAsyncCommand ).setValueObject( valueObject );
                nccr.execute( note );
            }
            if ( onCancel != null ) {
                onCancel();
            }
            note 		= null;
            onComplete	= null;
            onCancel    = null;
        }
    }
}
