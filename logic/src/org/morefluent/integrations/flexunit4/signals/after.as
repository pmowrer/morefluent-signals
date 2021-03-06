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
    import org.morefluent.api.SignalSynchronizer;
    import org.morefluent.impl.EventSubjectImpl;
    import org.morefluent.impl.SignalSynchronizerImpl;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.utils.SignalAsync;
    import org.osflash.signals.utils.SignalAsyncEvent;
    import org.morefluent.integrations.flexunit4.FlexUnit4AssertableContext;
    import org.morefluent.integrations.flexunit4.currentTestCase;
    
    public function after(target:ISignal, timeout:int = 1000):SignalSynchronizer
    {
        var subject:EventSubjectImpl = 
            new EventSubjectImpl(SignalAsyncEvent.CALLED, FlexUnit4AssertableContext.contextFor(currentTestCase), timeout);
        
        subject.on(new SignalAsync(target));
        
        return new SignalSynchronizerImpl(subject);
    }
}