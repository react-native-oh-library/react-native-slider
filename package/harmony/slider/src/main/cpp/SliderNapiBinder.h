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
#pragma once

#include "RNOHCorePackage/ComponentBinders/ViewComponentNapiBinder.h"
#include "Props.h"

namespace rnoh {

class SliderNapiBinder : public ViewComponentNapiBinder {
public:
    napi_value createProps(napi_env env, facebook::react::ShadowView const shadowView) override {
        napi_value napiViewProps = ViewComponentNapiBinder::createProps(env, shadowView);
        if (auto props = std::dynamic_pointer_cast<const facebook::react::RNCSliderProps>(shadowView.props)) {
            return ArkJS(env)
                .getObjectBuilder(napiViewProps)
                .addProperty("disabled", props->disabled)
                .addProperty("inverted", props->inverted)
                .addProperty("vertical", props->vertical)
                .addProperty("tapToSeek", props->tapToSeek)
                .addProperty("maximumTrackTintColor", props->maximumTrackTintColor)
                .addProperty("minimumTrackTintColor", props->minimumTrackTintColor)
                .addProperty("thumbTintColor", props->thumbTintColor)
                .addProperty("testID", props->testID)
                .addProperty("thumbImage", props->thumbImage.uri)
                .addProperty("maximumValue", props->maximumValue)
                .addProperty("minimumValue", props->minimumValue)
                .addProperty("step", props->step)
                .addProperty("value", props->value)
                .addProperty("lowerLimit", props->lowerLimit)
                .addProperty("upperLimit", props->upperLimit)
                .build();
        }
        return napiViewProps;
    };
};
} //namespace rnoh