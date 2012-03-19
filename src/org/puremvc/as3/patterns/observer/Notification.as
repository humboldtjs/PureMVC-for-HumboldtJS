package org.puremvc.as3.patterns.observer
{
    import org.puremvc.as3.interfaces.INotification;

    public class Notification implements INotification
    {
        protected var _name  :String;
        protected var _type  :String;
        protected var _body  :Object;

        public function Notification( aName:String, aBody:Object, aType:String )
        {
            _name = aName;
            _body = aBody || null;
            _type = aType || null;
        }

        public function getName():String
        {
            return _name;
        }

        public function setBody( body:Object ):void
        {
            this._body = body;
        }

        public function getBody():Object
        {
            return _body;
        }

        public function setType( aType:String ):void
        {
            _type = aType;
        }

        public function getType():String
        {
            return _type;
        }

        public function toString():String
        {
            var msg:String = "Notification Name: "+getName();
            msg += "\nBody:"+(( _body == null )?"null":_body.toString());
            msg += "\nType:"+(( _type == null )?"null":_type);
            return msg;
        }
    }
}
