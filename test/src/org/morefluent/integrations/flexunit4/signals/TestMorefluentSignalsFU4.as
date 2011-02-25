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

package org.morefluent.integrations.flexunit4.signals
{
    import flash.utils.setTimeout;
    
    import org.flexunit.rules.IMethodRule;
    import org.morefluent.integrations.flexunit4.MorefluentRule;
    import org.morefluent.integrations.flexunit4.signals.never;
    import org.morefluent.integrations.flexunit4.signals.once;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    public class TestMorefluentSignalsFU4
    {
        [Rule]
        public var morefluentRule:IMethodRule = new MorefluentRule();
        
        private var signal:Signal;
        
        [Test(async)]
        public function shouldPassOnSignal():void
        {
            signal = new Signal();
            
            setTimeout(function():void { signal.dispatch(); }, 500);
    
            after(signal, 1000).pass();
        }
        
        [Test(async, expects="flexunit.framework::AssertionFailedError")]
        public function shouldFailOnSignal():void
        {
            signal = new Signal();
            
            setTimeout(function():void { signal.dispatch(); }, 500);
            
            after(signal, 1000).fail();
        }
        
        [Test(async, expects="Error")]
        public function shouldTimeout():void
        {
            signal = new Signal();
            
            after(signal).pass();
        }
        
        [Test(async)]
        public function shouldCatchSignalAndAssertOnArguments():void
        {
            signal = new Signal(String, Number);
            
            setTimeout(function():void { signal.dispatch("stringArg", 12345); }, 500);
            
            after(signal).assertOnArguments().equals(["stringArg", 12345]);
        }
        
        [Test(async, expects="flexunit.framework::AssertionFailedError")]
        public function shouldFailWhenAssertingAgainstIncorrectArguments():void
        {
            signal = new Signal(String, Number);
            
            setTimeout(function():void { signal.dispatch("stringArg", 12345); }, 500);
            
            after(signal).assertOnArguments().equals(["stringArg", 54321]);
        }
        
        [Test]
        public function shouldAllowSynchronousVerificationOfSignalDispatchments():void
        {
            signal = new Signal();
            
            observing(signal);
            
            signal.dispatch();
            
            assert(signal).dispatched(once());
        }
        
        [Test(expects="flexunit.framework.AssertionFailedError")]
        public function shouldFailSynchronousVerificationOfSignalDispatchments():void
        {
            signal = new Signal();
            
            observing(signal);
            
            signal.dispatch();
            
            assert(signal).dispatched(never());
        }
        
        [Test]
        public function shouldVerifySignalArgumentsSynchronously():void
        {
            signal = new Signal(String, Number);
            
            observing(signal);
            
            signal.dispatch("stringArg", 12345);
            
            assert(signal).dispatched(withArguments("stringArg", 12345));
        }

        [Test(expects="flexunit.framework.AssertionFailedError")]
        public function shouldFailVerifingSignalArgumentsSynchronously():void
        {
            signal = new Signal(String, Number);
            
            observing(signal);
            
            signal.dispatch("stringArg", 12345);
            
            assert(signal).dispatched(withArguments("stringArg", 54321));
        }
        
        // Would be nice to assert on the error message here too eventually, but may
        // need to write own FlexUnit utility/hamcrest matcher to do so.
        [Test(expects="org.morefluent.api.VerifyingOnNonRegisteredObserver")]
        public function shouldThrowErrorIfAssertingOnSignalThatIsntObserved():void
        {
            signal = new Signal();
            
            assert(signal).dispatched();
        }
        
        [Test(expects="flexunit.framework.AssertionFailedError")]
        public function shouldFailIfAssertingOnArgumentsButSignalIsNeverDispatched():void
        {
            signal = new Signal(String);
            
            observing(signal);
            
            assert(signal).dispatched(withArguments("stringArg"));
        }
        
        [Test]
        public function shouldPassIfObservingSignalAtLeastANumberOfTimes():void
        {
            signal = new Signal();
            
            observing(signal);
            
            signal.dispatch();
            signal.dispatch();
            
            assert(signal).dispatched(atLeast(1));
        }
        
        [Test(expects="flexunit.framework.AssertionFailedError")]
        public function shouldFailIfNotObservingSignalAtLeastANumberOfTimes():void
        {
            signal = new Signal();
            
            observing(signal);
            
            assert(signal).dispatched(atLeast(1));
        }
    }
}