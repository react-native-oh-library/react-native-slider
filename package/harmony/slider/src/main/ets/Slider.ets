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

import {
  Descriptor,
  RNOHContext,
  ViewBaseProps,
  RNViewBase,
  ColorSegments,
  ViewRawProps,
} from 'rnoh'
import { SliderDescriptorWrapper } from './SliderDescriptorWrapper'
import Logger from './Logger'

const TAG: string = "[RNOH] RNCSlider"

export const SLIDER_TYPE: string = "RNCSlider"

export interface SliderProps extends ViewBaseProps {
  thumbImage?: string
  maximumTrackTintColor?: ColorSegments
  minimumTrackTintColor?: ColorSegments
  thumbTintColor?: ColorSegments
}

export interface SliderSate {}

export interface SliderRawProps extends ViewRawProps {
  disabled?: boolean
  inverted?: boolean
  vertical?: boolean
  tapToSeek?: boolean
  testID?: string
  maximumValue?: number
  minimumValue?: number
  step?: number
  value?: number
  lowerLimit?: number
  upperLimit?: number
}

export type SliderDescriptor = Descriptor<"RNCSlider", SliderProps, SliderSate, SliderRawProps>

@Component
export struct RNCSlider {
  ctx!: RNOHContext
  tag: number = 0
  @State descriptor: SliderDescriptor = {} as SliderDescriptor
  @State private descriptorWrapper: SliderDescriptorWrapper | undefined = undefined
  private unregisterDescriptorChangesListener?: ()=> void = undefined
  @State SliderValue: number = 0
  private lowerLimit = 0
  private upperLimit = 0

  aboutToAppear() {
    this.descriptor = this.ctx.descriptorRegistry.getDescriptor<SliderDescriptor>(this.tag);
    this.descriptorWrapper = new SliderDescriptorWrapper(this.descriptor);
    this.unregisterDescriptorChangesListener = this.ctx.descriptorRegistry.subscribeToDescriptorChanges(this.tag,
      (newDescriptor) => {
        this.descriptor = (newDescriptor as SliderDescriptor)
        this.descriptorWrapper = new SliderDescriptorWrapper(this.descriptor);
        let value = this.descriptorWrapper.value;
        if (value < this.lowerLimit) {
          value = this.lowerLimit;
        } else if (value > this.upperLimit) {
          value = this.upperLimit;
        }
        this.SliderValue = value;
      }
    );
    this.SliderValue = this.descriptorWrapper.value;
    this.upperLimit = this.descriptorWrapper.upperLimit;
    this.lowerLimit = this.descriptorWrapper.lowerLimit;
    Logger.info(TAG, `descriptor props: ${JSON.stringify(this.descriptor.rawProps)}`)
  }

  aboutToDisappear() {
    this.unregisterDescriptorChangesListener?.()
  }

  onSliderChange(value: number, mode: SliderChangeMode) {
    Logger.debug(TAG, `onSliderChange: ${value}, ${mode}`)
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

  build() {
    RNViewBase({ ctx: this.ctx, tag: this.tag }) {
      Slider({
        value: this.SliderValue,
        step: this.descriptor.rawProps.step,
        min: this.descriptorWrapper?.minimumValue,
        max: this.descriptorWrapper?.maximumValue,
        direction: (this.descriptorWrapper?.direction),
        reverse: (this.descriptorWrapper?.reverse),
        style: SliderStyle.OutSet
      })
        .width("100%")
        .height("100%")
        .enabled(this.descriptorWrapper?.enabled)
        .blockColor(this.descriptorWrapper?.blockColor)
        .trackColor(this.descriptorWrapper?.trackColor)
        .selectedColor(this.descriptorWrapper?.selectedColor)
        .showSteps(false)
        .blockStyle(this.descriptorWrapper?.BlockStyle)
        .onChange((value: number, mode: SliderChangeMode) => this.onSliderChange(value, mode))
    }
  }
}