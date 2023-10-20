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

#include <jsi/jsi.h>
#include <react/renderer/components/view/ViewProps.h>
#include <react/renderer/core/PropsParserContext.h>
//#include <react/renderer/graphics/Color.h>
//#include <react/reanderer/core/graphicsConversions.h>
#include <react/renderer/imagemanager/primitives.h>
#include <vector>

namespace facebook {
namespace react {

inline void fromRawValue(const PropsParserContext &context, const RawValue &value, ImageSource &result) {
  if (value.hasType<std::string>()) {
    result = {
      ImageSource::Type::Remote,
      (std::string)value,
    };
    return;
  }

  if (value.hasType<butter::map<std::string, RawValue>>()) {
    auto items = (butter::map<std::string, RawValue>)value;
    result = {};

    result.type = ImageSource::Type::Remote;

    if (items.find("__packager_asset") != items.end()) {
      result.type = ImageSource::Type::Local;
    }

    if (items.find("width") != items.end() && items.find("height") != items.end() && 
        items.at("width").hasType<Float>() && items.at("height").hasType<Float>()) {
        result.size = {(Float)items.at("width"), (Float)items.at("height")};
    }

    if (items.find("scale") != items.end() && 
        items.at("scale").hasType<Float>()) {
        result.scale = (Float)items.at("scale");
    } else {
        result.scale = items.find("deprecated") != items.end() ? 0.0f : 1.0f;
    }

    if (items.find("url") != items.end() && 
        items.at("url").hasType<std::string>()) {
        result.uri = (std::string)items.at("url");
    }

    if (items.find("uri") != items.end() && 
        items.at("uri").hasType<std::string>()) {
        result.uri = (std::string)items.at("uri");
    }

    if (items.find("bundle") != items.end() && 
        items.at("bundle").hasType<std::string>()) {
        result.bundle = (std::string)items.at("bundle");
        result.type = ImageSource::Type::Local;
    }

    return;
  }
  result = {};
  result.type = ImageSource::Type::Invalid;
}

inline std::string toString(const ImageSource &value) { return "{uri: " + value.uri + "}"; }

class JSI_EXPORT RNCSliderProps final : public ViewProps {
public:
  RNCSliderProps() = default;
  RNCSliderProps(const PropsParserContext& context, const RNCSliderProps &sourceProps, const RawProps &rawProps);

#pragma mark - Props

  // std::string accessibilityUnits{};
  // std::vector<std::string> accessibilityIncrements{};
  bool disabled{false};
  bool inverted{false};
  bool vertical{false};
  bool tapToSeek{false};
  // ImageSource maximumTrackImage{};
  SharedColor maximumTrackTintColor{};
  Float maximumValue{0.0};
  // ImageSource minimumTrackImage{};
  SharedColor minimumTrackTintColor{};
  Float minimumValue{0.0};
  Float step{0.0};
  std::string testID{};
  ImageSource thumbImage{};
  SharedColor thumbTintColor{};
  // ImageSource trackImage{};
  Float value{0.0};
  Float lowerLimit{0.0};
  Float upperLimit{0.0};
};

} // namespace react
} // namespace facebook