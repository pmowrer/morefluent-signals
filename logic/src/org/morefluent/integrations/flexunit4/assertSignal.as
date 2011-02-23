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
    import org.morefluent.api.SignalAssertion;
    import org.morefluent.impl.ImmediateAssertionSpecifier;
    import org.morefluent.impl.ImmediateSignalAssertion;
    import org.morefluent.impl.ValueExtractor;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.utils.SignalSync;

    public function assertSignal(target:ISignal):SignalAssertion
    {
        return new ImmediateSignalAssertion(FlexUnit4AssertableContext.contextFor(currentTestCase),
                                          new ValueExtractor(SignalSync.getWrapped(target)),
                                          new ImmediateAssertionSpecifier(assert));
    }
}