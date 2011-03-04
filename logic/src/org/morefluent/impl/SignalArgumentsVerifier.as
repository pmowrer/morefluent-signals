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
    import org.hamcrest.Matcher;
    import org.hamcrest.number.greaterThanOrEqualTo;
    import org.hamcrest.object.equalTo;
    import org.morefluent.api.AssertableContext;
    import org.morefluent.api.SignalObservationVerifier;
    import org.morefluent.api.VerifiableObservation;
    import org.osflash.signals.utils.SignalSync;
    import org.osflash.signals.utils.SignalSyncEvent;
    
    public class SignalArgumentsVerifier extends SignalTimes implements SignalObservationVerifier
    {
        private var args:Array;
    
        public function SignalArgumentsVerifier(args:Array)
        {
            super(greaterThanOrEqualTo(1));
                
            this.args = args;
        }
    
        override public function verify(context:AssertableContext, target:SignalSync):void
        {
            super.verify(context, target);
            
            var observersOf:Array = context.observersOf(target, SignalSyncEvent.CALLED, false);

            for each (var observation:VerifiableObservation in observersOf)
            {
                var events:Array = observation.eventsFor(target, SignalSyncEvent.CALLED, false);
                
                for each(var signalEvent:SignalSyncEvent in events)
                {
                    if(args.length != signalEvent.args.length)
                        context.fail(null, "Expected " + args.length + " signal arguments, but received " + signalEvent.args.length + " arguments.");
                    
                    if(argumentsMatch(signalEvent))
                        return;
                }
                
                context.fail(null, "Expected signal arguments: " + args + ", but was " + signalEvent.args + ".");
            }
        }
        
        private function argumentsMatch(event:SignalSyncEvent):Boolean
        {
            for(var index:uint = 0; index < args.length; index++)
            {
                var argumentMatcher:Matcher;
                                
                if(args[index] is Matcher)
                    argumentMatcher = args[index];
                else
                    argumentMatcher = equalTo(args[index]);
                
                if(!argumentMatcher.matches(event.args[index]))
                    return false;
            }
            
            return true;
        }
    }
}