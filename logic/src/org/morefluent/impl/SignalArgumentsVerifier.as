/**
 * The MIT License
 *
 * Copyright (c) 2011 Morefluent contributors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **/

package org.morefluent.impl
{
    import flash.events.IEventDispatcher;
    
    import org.hamcrest.object.equalTo;
    import org.morefluent.api.AssertableContext;
    import org.morefluent.api.ObservationVerifier;
    import org.morefluent.api.VerifiableObservation;
    import org.morefluent.api.VerifyingOnNonRegisteredObserver;
    import org.osflash.signals.utils.SignalSyncEvent;
    
    public class SignalArgumentsVerifier implements ObservationVerifier
    {
        private var args:Array;
    
        public function SignalArgumentsVerifier(args:Array)
        {
            this.args = args;
        }
    
        public function verify(context:AssertableContext, target:IEventDispatcher, event:String, useCapture:Boolean = false):void
        {
            var observersOf:Array = context.observersOf(target, event, useCapture);
            if (observersOf.length == 0)
                throw new VerifyingOnNonRegisteredObserver("Not listening to " + event + " on " + target + " in " + (useCapture ? "capture" : "") + ". " +
                                                           "Did you forget to to add observe('" + event + ", " + useCapture + "').on(" + target + "); ?");
            for each (var observation:VerifiableObservation in observersOf)
            {
                var events:Array = observation.eventsFor(target, event, useCapture);
    
                for each(var signalEvent:SignalSyncEvent in events)
                {
                    if(!argumentsMatch(signalEvent))
                        context.fail(null, "Expected signal arguments: " + args + ", but was " + signalEvent.args + ".");
                }
            }
        }
        
        private function argumentsMatch(event:SignalSyncEvent):Boolean
        {
            return equalTo(args).matches(event.args);
        }
    }
}