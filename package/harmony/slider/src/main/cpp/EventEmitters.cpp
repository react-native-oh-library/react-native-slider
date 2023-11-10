/**
 * MIT License
 * 
 * Copyright (C) 2021 Huawei Device Co., Ltd.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANT KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <glog/logging.h>
#include "EventEmitters.h"

namespace facebook {
namespace react {

void RNCSliderEventEmitter::onChange(OnChange event) const {
   dispatchEvent("change", [event = std::move(event)](jsi::Runtime &runtime) {
       auto payload = jsi::Object(runtime);
       payload.setProperty(runtime, "value", event.value);
    //    payload.setProperty(runtime, "fromUser", event.fromUser);
       return payload;
   });
}

void RNCSliderEventEmitter::onRNCSliderSlidingStart(OnRNCSliderSlidingStart event) const {
    dispatchEvent("rNCSliderSlidingStart", [event = std::move(event)](jsi::Runtime &runtime) {
        auto payload = jsi::Object(runtime);
        payload.setProperty(runtime, "value", event.value);
//        payload.setProperty(runtime, "fromUser", event.fromUser);
        return payload;
    });
}

void RNCSliderEventEmitter::onRNCSliderSlidingComplete(OnRNCSliderSlidingComplete event) const {
    dispatchEvent("rNCSliderSlidingComplete", [event = std::move(event)](jsi::Runtime &runtime) {
        auto payload = jsi::Object(runtime);
        payload.setProperty(runtime, "value", event.value);
//        payload.setProperty(runtime, "fromUser", event.fromUser);
        return payload;
    });
}

void RNCSliderEventEmitter::onRNCSliderValueChange(OnRNCSliderValueChange event) const {
    dispatchEvent("rNCSliderValueChange", [event = std::move(event)](jsi::Runtime &runtime) {
        auto payload = jsi::Object(runtime);
        payload.setProperty(runtime, "value", event.value);
//        payload.setProperty(runtime, "fromUser", event.fromUser);
        return payload;
    });
}

} // namespace react
} // namespace facebook