package org.puremvc.as3.patterns.command
{
    import org.puremvc.as3.interfaces.IAsyncCommand;

    public class AsyncCommand extends SimpleCommand	implements IAsyncCommand
    {

        protected   var valueObject :Object;
        private     var onComplete	:Function;
        private     var onCancel	:Function;

        public function setValueObject ( vo:Object ) :void
        {
            valueObject = vo;
        }

        public function setOnComplete ( value:Function ) : void
        {
            onComplete = value;
        }

        public function setOnCancel ( value:Function ) :void
        {
            onCancel = value;
        }

        protected function commandComplete () : void
        {
            if ( Boolean( onComplete ) ) onComplete();
        }

        protected function commandCancel () : void
        {
            if ( Boolean( onCancel ) ) {
                onCancel();
            }
        }
    }
}
