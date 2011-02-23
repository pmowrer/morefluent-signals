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
    import org.morefluent.api.AssertableContext;
    import org.morefluent.api.AssertedValue;
    import org.morefluent.api.Assertion;
    import org.morefluent.api.AssertionSpecifier;
    import org.morefluent.api.ObservationVerifier;
    import org.morefluent.api.SignalAssertion;
    import org.morefluent.api.Verifiers;
    import org.osflash.signals.utils.SignalSyncEvent;

    public class ImmediateSignalAssertion extends BaseAssertion implements SignalAssertion
    {
        public function ImmediateSignalAssertion(context:AssertableContext, assertedValue:AssertedValue, assertionSpecifier:AssertionSpecifier)
        {
            super(context, assertedValue, assertionSpecifier);
        }
    
        override protected function thatAsserter(asserter:Asserter):Assertion
        {
            asserter.assert(context, assertedValue.value);
            return this;
        }
        
        public function dispatched(verifier:ObservationVerifier = null):Assertion
        {
            return thatAsserter(new ObservedEventAsserter(SignalSyncEvent.CALLED, verifier || Verifiers.once()));
        }
    }
}