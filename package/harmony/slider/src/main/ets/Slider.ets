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

import {
  Descriptor,
  RNOHContext,
  ViewBaseProps,
  RNViewBase,
  ComponentBuilderContext,
  ColorSegments,
  convertColorSegmentsToString
} from 'rnoh'
import Logger from './Logger'

const TAG: string = "[RNOH] RNCSlider"

export const SLIDER_TYPE: string = "RNCSlider"

export interface SliderProps extends ViewBaseProps {
  disabled: boolean
  inverted: boolean
  vertical: boolean
  tapToSeek: boolean
  maximumTrackTintColor: ColorSegments
  minimumTrackTintColor: ColorSegments
  thumbTintColor: ColorSegments
  testID: string
  thumbImage: string
  maximumValue: number
  minimumValue: number
  step: number
  value: number
  lowerLimit: number
  upperLimit: number
}

export type SliderDescriptor = Descriptor<"RNCSlider", SliderProps>

@Component
export struct RNCSlider {
  ctx!: RNOHContext
  tag: number = 0
  @BuilderParam buildCustomComponent: (componentBuilderContext: ComponentBuilderContext) => void
  @State descriptor: SliderDescriptor = {} as SliderDescriptor
  private unregisterDescriptorChangesListener?: ()=> void = undefined
  @State SliderValue: number = 0
  private lowerLimit = 0
  private upperLimit = 0

  aboutToAppear() {
    this.descriptor = this.ctx.descriptorRegistry.getDescriptor<SliderDescriptor>(this.tag);
    this.unregisterDescriptorChangesListener = this.ctx.descriptorRegistry.subscribeToDescriptorChanges(this.tag,
      (newDescriptor) => {
        this.descriptor = (newDescriptor as SliderDescriptor)
      }
    );
    this.SliderValue = this.descriptor.props.value;
    this.upperLimit = this.descriptor.props.upperLimit ? this.descriptor.props.upperLimit : this.descriptor.props.maximumValue;
    this.lowerLimit = this.descriptor.props.lowerLimit ? this.descriptor.props.lowerLimit : this.descriptor.props.minimumValue;
    Logger.info(TAG, `descriptor props: ${JSON.stringify(this.descriptor.props)}`)
  }

  aboutToDisappear() {
    this.unregisterDescriptorChangesListener?.()
  }

  getSource(source: string) {
    if (source.startsWith("asset://")) {
      return $rawfile(source.replace("asset://", "assets/"));
    }
    if (source.startsWith("file://assets/src/assets/")) {
      return $rawfile(source.replace("file://assets/src/assets/", "assets/"));
    }
    return source;
  }

  onSliderChange(value: number, mode: SliderChangeMode) {
    if (value < this.lowerLimit) {
      value = this.lowerLimit;
    } else if (value > this.upperLimit) {
      value = this.upperLimit;
    }
    this.SliderValue = value
    if (mode === 0) {
      this.ctx.rnInstance.emitComponentEvent(
        this.descriptor.tag,
        SLIDER_TYPE,
        {
          type: "SliderSlidingStart",
          value: value,
          // fromUser: true
        }
      );
    } else if (mode === 1) {
      this.ctx.rnInstance.emitComponentEvent(
        this.descriptor.tag,
        SLIDER_TYPE,
        {
          type: "SliderValueChange",
          value: value,
          // fromUser: true
        }
      );
    } else if (mode === 2) {
      this.ctx.rnInstance.emitComponentEvent(
        this.descriptor.tag,
        SLIDER_TYPE,
        {
          type: "SliderSlidingComplete",
          value: value,
          // fromUser: true
        }
      );
    } else if (mode === 3) {
      this.ctx.rnInstance.emitComponentEvent(
        this.descriptor.tag,
        SLIDER_TYPE,
        {
          type: "SliderValueChange",
          value: value,
          // fromUser: true
        }
      );
    }
  }

  getBlockStyle(): SliderBlockStyle {
    if (this.descriptor.props.thumbImage) {
      return {
        type: SliderBlockType.IMAGE,
        image: this.getSource(this.descriptor.props.thumbImage)
      };
    }
    return { type: SliderBlockType.DEFAULT};
  }

  build() {
    RNViewBase({ ctx: this.ctx, tag: this.tag }) {
      Slider({
        value: this.SliderValue,
        step: this.descriptor.props.step,
        min: this.descriptor.props.minimumValue,
        max: this.descriptor.props.maximumValue,
        direction: (this.descriptor.props.vertical ? Axis.Vertical : Axis.Horizontal),
        reverse: (this.descriptor.props.inverted ? true : false),
        style: SliderStyle.OutSet
      })
        .width("100%")
        .height("100%")
        .enabled(this.descriptor.props.disabled ? false : true)
        .blockColor(convertColorSegmentsToString(this.descriptor.props.thumbTintColor))
        .trackColor(convertColorSegmentsToString(this.descriptor.props.maximumTrackTintColor))
        .selectedColor(convertColorSegmentsToString(this.descriptor.props.minimumTrackTintColor))
        .showSteps(false)
        .blockStyle(this.getBlockStyle())
        .onChange((value: number, mode: SliderChangeMode) => this.onSliderChange(value, mode))
    }
  }
}