package org.puremvc.as3.interfaces
{
    public interface INotifier
    {
        function sendNotification( aNotificationName:String = null, aBody:Object = null, aType:String = null ):void;

    }
}
