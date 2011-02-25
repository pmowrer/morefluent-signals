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
    
    import org.hamcrest.Description;
    import org.hamcrest.Matcher;
    import org.hamcrest.StringDescription;
    import org.morefluent.api.AssertableContext;
    import org.morefluent.api.SignalObservationVerifier;
    import org.morefluent.api.VerifiableObservation;
    import org.morefluent.api.VerifyingOnNonRegisteredObserver;
    import org.osflash.signals.utils.SignalSync;
    import org.osflash.signals.utils.SignalSyncEvent;
    
    public class BaseSignalVerifier implements SignalObservationVerifier
    {    
        public function verify(context:AssertableContext, target:SignalSync):void
        {
            var observersOf:Array = context.observersOf(target, SignalSyncEvent.CALLED, false);

            if (observersOf.length == 0)
                throw new VerifyingOnNonRegisteredObserver("Not listening on " + target + ". " +
                                                           "Did you forget to to add observing('" + target + "); ?");
        }
    }
}