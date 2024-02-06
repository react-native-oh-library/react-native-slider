/**
 * MIT License
 *
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <react/renderer/core/PropsParserContext.h>
#include <react/renderer/core/propsConversions.h>
#include "Props.h"

namespace facebook {
namespace react {

RNCSliderProps::RNCSliderProps(
    const PropsParserContext &context,
    const RNCSliderProps &sourceProps,
    const RawProps &rawProps): ViewProps(context, sourceProps, rawProps),

//    accessibilityUnits(convertRawProp(context, rawProps, "accessibilityUnits", sourceProps.accessibilityUnits, {})),
//    accessibilityIncrements(convertRawProp(context, rawProps, "accessibilityIncrements", sourceProps.accessibilityIncrements, {})),
//    maximumTrackImage(convertRawProp(context, rawProps, "maximumTrackImage", sourceProps.maximumTrackImage, {})),
    maximumTrackTintColor(convertRawProp(context, rawProps, "maximumTrackTintColor", sourceProps.maximumTrackTintColor, {})),
//    minimumTrackImage(convertRawProp(context, rawProps, "minimumTrackImage", sourceProps.minimumTrackImage, {})),
    minimumTrackTintColor(convertRawProp(context, rawProps, "minimumTrackTintColor", sourceProps.minimumTrackTintColor, {})),
    thumbImage(convertRawProp(context, rawProps, "thumbImage", sourceProps.thumbImage, {})),
    thumbTintColor(convertRawProp(context, rawProps, "thumbTintColor", sourceProps.thumbTintColor, {}))
//    trackImage(convertRawProp(context, rawProps, "trackImage", sourceProps.trackImage, {})),
      {}

} // namespace react
} // namespace facebook