package org.puremvc.as3.patterns.observer
{
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.interfaces.IObserver;

    public class Observer implements IObserver
    {
        private var _notify  :Function;
        private var _context :Object;

        public function Observer( aNotifyMethod:Function, aNotifyContext:Object )
        {
            setNotifyMethod( aNotifyMethod );
            setNotifyContext( aNotifyContext );
        }

        public function setNotifyMethod( aNotifyMethod:Function ):void
        {
            _notify = aNotifyMethod;
        }

        public function setNotifyContext( aNotifyContext:Object ):void
        {
            _context = aNotifyContext;
        }

        private function getNotifyMethod():Function
        {
            return _notify;
        }

        private function getNotifyContext():Object
        {
            return _context;
        }

        public function notifyObserver( aNotification:INotification ):void
        {
            getNotifyMethod().apply( getNotifyContext(), [ aNotification ]);
        }

         public function compareNotifyContext( aObject:Object ):Boolean
         {
            return aObject === _context;
         }
    }
}
