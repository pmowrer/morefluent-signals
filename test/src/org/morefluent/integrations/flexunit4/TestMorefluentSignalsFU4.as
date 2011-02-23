/**
 * The MIT License
 *
 * Copyright (c) 2009 Morefluent contributors
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
            
            afterSignal(signal).assertOnArguments().equals(["stringParam", 54321]);
            
            signal.dispatch("stringParam", 12345);
        }
        
        [Test]
        public function testShouldAllowSynchronousVerificationOfEvents():void
        {
            // given
            var dispatcher:EventDispatcher = new EventDispatcher();
            observing("someEvent").on(dispatcher);
            // when
            dispatcher.dispatchEvent(new Event("someEvent"));
            // then
            assert(dispatcher).observed("someEvent", once());
        }

    
        /*[Test(async, expects="Error")]
        public function shouldTimeout():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            // then
            after(TimerEvent.TIMER_COMPLETE).on(timer).assert(timer, "currentCount").equals(1);
        }
    
        [Test(async, expects="flexunit.framework.AssertionFailedError")]
        public function shouldRemindOfMissingAssertions():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            // when
            timer.start();
            // then
            //"Did you forget to complete assertions?";
            after(TimerEvent.TIMER_COMPLETE).on(timer).assert(timer, "currentCount");
        }
    
        [Test(async, expects="org.hamcrest::AssertionError")]
        public function shouldCallAfter():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            // when
            timer.start();
            // then
            // by specifyng conditions that should fail we'll verfiy that function has been called
            after(TimerEvent.TIMER_COMPLETE).on(timer).call(checkTimerIs, timer, 2);
    
            function checkTimerIs(timer:Timer, expectedCount:int):void
            {
                assertThat(timer.currentCount, equalTo(expectedCount));
            }
        }
    
        [Test(async)]
        public function shouldPassOnComplexAssertion():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            // when
            timer.start();
            // then
            after(TimerEvent.TIMER_COMPLETE).on(timer)
                    .assert(timer, "currentCount")
                    .equals(1)
                    .and().assert(timer, "repeatCount").equals(1);
        }
    
        [Test(async)]
        public function shouldPassOnComplexAssertionWithPoll():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            var timer2:Timer = new Timer(200, 1);
            // when
            timer.start();
            timer2.start();
            // then
            poll().assert(timer, "currentCount")
                    .equals(1)
                  .and().assert(timer2, "currentCount")
                    .equals(1);
        }
    
        [Test]
        public function shouldPassOnComplexAssertionAsyncEnabledWithRule():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            // when
            timer.start();
            // then
            after(TimerEvent.TIMER_COMPLETE).on(timer)
                    .assert(timer, "currentCount")
                    .equals(1)
                    .and().assert(timer, "repeatCount").equals(1);
        }
    
        [Test]
        public function testShouldAllowSynchronousVerificationOfEvents():void
        {
            // given
            var dispatcher:EventDispatcher = new EventDispatcher();
            observing("someEvent").on(dispatcher);
            // when
            dispatcher.dispatchEvent(new Event("someEvent"));
            // then
            assert(dispatcher).observed("someEvent", once());
        }
    
        [Test(async, expects="flexunit.framework.AssertionFailedError")]
        public function testShouldFailSynchronousVerificationOfEvents():void
        {
            // given
            var dispatcher:EventDispatcher = new EventDispatcher();
            observing("someEvent").on(dispatcher);
            dispatcher.dispatchEvent(new Event("someEvent"));
            // when
            assert(dispatcher).observed("someEvent", never());
        }
    
        [Test(async, expects="flexunit.framework.AssertionFailedError")]
        public function shouldFailIfEventHappen():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            // when
            timer.start();
            // then
            after(TimerEvent.TIMER_COMPLETE).on(timer).fail("should have never happend");
        }
    
        [Test]
        public function testShouldNotFailIfEventTimedOutWhenNotExpectingAnEvent():void
        {
            // given
            var timer:Timer = new Timer(100, 1);
            // then
            after(TimerEvent.TIMER_COMPLETE).on(timer).fail("should have never happend");
        }*/
    }
}