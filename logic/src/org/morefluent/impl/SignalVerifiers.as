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
package org.morefluent.impl
{
    import org.hamcrest.Matcher;
    import org.hamcrest.number.greaterThanOrEqualTo;
    import org.hamcrest.object.equalTo;
    import org.morefluent.api.SignalObservationVerifier;
    
    public class SignalVerifiers
    {
        public static function once():SignalObservationVerifier
        {
            return times(equalTo(1));
        }
        
        public static function never():SignalObservationVerifier
        {
            return times(equalTo(0));
        }
    
        public static function atLeast(value:uint):SignalObservationVerifier
        {
            return times(greaterThanOrEqualTo(value));
        }
        
        public static function times(numberMatcher:Matcher):SignalObservationVerifier
        {
            return new SignalTimes(numberMatcher);
        }
        
        public static function withArguments(... rest):SignalObservationVerifier
        {
            return new SignalArgumentsVerifier(rest);
        }
    }
}