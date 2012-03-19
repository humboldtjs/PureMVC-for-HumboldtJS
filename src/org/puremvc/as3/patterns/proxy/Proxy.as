package org.puremvc.as3.patterns.proxy
{
    import org.puremvc.as3.interfaces.INotifier;
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.observer.Notifier;

    public class Proxy extends Notifier implements IProxy, INotifier
    {
        protected var proxyName:String;

        protected var data:Object;

        public static var NAME:String = 'Proxy';

        public function Proxy( aProxyName:String, aData:Object )
        {
			super();

            proxyName = ( aProxyName != null )? aProxyName:NAME;

            if ( aData != null ) {
                setData(aData);
            }
        }

        public function getProxyName():String
        {
            return proxyName;
        }

        public function setData( aData:Object ):void
        {
            data = aData;
        }

        public function getData():Object
        {
            return data;
        }

        public function onRegister( ):void {}

        public function onRemove( ):void {}

    }
}
