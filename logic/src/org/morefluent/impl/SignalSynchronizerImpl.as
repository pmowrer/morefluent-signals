package org.morefluent.impl
{
    import org.morefluent.api.Assertion;
    import org.morefluent.api.SignalSynchronizer;
    
    public class SignalSynchronizerImpl extends EventSynchronizer implements SignalSynchronizer
    {
        public function SignalSynchronizerImpl(subject:EventSubjectImpl)
        {
            super(subject);
        }
        
        public function assertOnArguments():Assertion
        {
            return super.assertOnEvent("args");
        }
    }
}