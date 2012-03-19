package org.puremvc.as3.interfaces
{
    public interface IController
    {
        function registerCommand( aNotificationName : String, aCommandClassRef : Class ) : void;

        function executeCommand( aNotification : INotification ) : void;

        function removeCommand( aNotificationName : String ):void;

        function hasCommand( aNotificationName:String ) : Boolean;
    }
}
