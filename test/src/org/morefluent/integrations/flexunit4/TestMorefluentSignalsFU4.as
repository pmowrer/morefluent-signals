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

package org.morefluent.integrations.flexunit4
{
    import flash.utils.setTimeout;
    
    import org.flexunit.rules.IMethodRule;
    import org.morefluent.integrations.flexunit4.never;
    import org.osflash.signals.Signal;

    public class TestMorefluentSignalsFU4
    {
        [Rule]
        public var morefluentRule:IMethodRule = new MorefluentRule();
    
        [Test(async)]
        public function shouldPassOnSignal():void
        {
            var signal:Signal = new Signal();
    
            afterSignal(signal, 1000).pass();
            
            setTimeout(new Function(), 500);
            
            signal.dispatch();
        }
        
        [Test(async, expects="flexunit.framework::AssertionFailedError")]
        public function shouldFailOnSignal():void
        {
            var signal:Signal = new Signal();
            
            afterSignal(signal, 1000).fail();
            
            setTimeout(new Function(), 500);
            
            signal.dispatch();
        }
        
        [Test(async, expects="Error")]
        public function shouldTimeout():void
        {
            var signal:Signal = new Signal();
            
            afterSignal(signal).pass();
        }
        
        [Test(async)]
        public function shouldCatchSignalAndAssertOnArguments():void
        {
            var signal:Signal = new Signal(String, Number);
            
            afterSignal(signal).assertOnArguments().equals(["stringArg", 12345]);
            
            signal.dispatch("stringArg", 12345);
        }
        
        [Test(async, expects="flexunit.framework::AssertionFailedError")]
        public function shouldFailWhenAssertingAgainstIncorrectArguments():void
        {
            var signal:Signal = new Signal(String, Number);
            
            afterSignal(signal).assertOnArguments().equals(["stringArg", 54321]);
            
            signal.dispatch("stringArg", 12345);
        }
        
        [Test]
        public function shouldAllowSynchronousVerificationOfSignalDispatchments():void
        {
            var signal:Signal = new Signal();
            
            observingSignal(signal);
            
            signal.dispatch();
            
            assertSignal(signal).dispatched(once());
        }
        
        [Test(expects="flexunit.framework.AssertionFailedError")]
        public function shouldFailSynchronousVerificationOfSignalDispatchments():void
        {
            var signal:Signal = new Signal();
            
            observingSignal(signal);
            
            signal.dispatch();
            
            assertSignal(signal).dispatched(never());
        }
        
        [Test]
        public function shouldVerifySignalArgumentsSynchronously():void
        {
            var signal:Signal = new Signal(String, Number);
            
            observingSignal(signal);
            
            signal.dispatch("stringArg", 12345);
            
            assertSignal(signal).dispatched(withArguments(["stringArg", 12345]));
        }

        [Test(expects="flexunit.framework.AssertionFailedError")]
        public function shouldFailVerifingSignalArgumentsSynchronously():void
        {
            var signal:Signal = new Signal(String, Number);
            
            observingSignal(signal);
            
            signal.dispatch("stringArg", 12345);
            
            assertSignal(signal).dispatched(withArguments(["stringArg", 54321]));
        }
    }
}