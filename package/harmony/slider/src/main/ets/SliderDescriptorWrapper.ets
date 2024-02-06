import { convertColorValueToRGBA, Descriptor, convertColorSegmentsToString, ViewDescriptorWrapperBase, ViewBaseProps,
  ColorSegments } from 'rnoh';
import { SliderProps, SliderSate, SliderRawProps } from './Slider'

const LIMIT_MIN_VALUE = Number.MIN_VALUE;
const LIMIT_MAX_VALUE = Number.MAX_VALUE;

export class SliderDescriptorWrapper extends ViewDescriptorWrapperBase<string, SliderProps, SliderSate, SliderRawProps> {
  constructor(descriptor: Descriptor<string, SliderProps, SliderSate, SliderRawProps>) {
    super(descriptor)
  }

  public get source(): Resource {
    if (this.descriptor.props.thumbImage?.startsWith("asset://")) {
      return $rawfile(this.descriptor.props.thumbImage?.replace("asset://", "assets/"));
    }
    if (this.descriptor.props.thumbImage?.startsWith("file://assets/src/assets/")) {
      return $rawfile(this.descriptor.props.thumbImage?.replace("file://assets/src/assets/", "assets/"));
    }
    return $rawfile(this.descriptor.props.thumbImage);
  }

  public get BlockStyle(): SliderBlockStyle {
    if (this.descriptor.props.thumbImage) {
      return {
        type: SliderBlockType.IMAGE,
        image: this.source
      };
    }
    return { type: SliderBlockType.DEFAULT };
  }

  public get value(): number {
    return this.rawProps.value ?? 0
  }

  public get maximumValue(): number {
    return this.rawProps.maximumValue ?? LIMIT_MAX_VALUE
  }

  public get minimumValue(): number {
    return this.rawProps.minimumValue ?? LIMIT_MIN_VALUE
  }

  public get upperLimit(): number {
    return this.rawProps.upperLimit ?? this.maximumValue
  }

  public get lowerLimit(): number {
    return this.rawProps.lowerLimit ?? this.minimumValue;
  }


  public get direction(): Axis {
    return this.rawProps.vertical ? Axis.Vertical : Axis.Horizontal;
  }

  public get reverse(): boolean {
    return this.rawProps.inverted ? true : false;
  }

  public get enabled(): boolean {
    return this.rawProps.disabled ? false : true;
  }

  public get blockColor(): string | undefined {
    return convertColorSegmentsToString(this.descriptor.props.thumbTintColor);
  }

  public get trackColor(): string | undefined {
    return convertColorSegmentsToString(this.descriptor.props.maximumTrackTintColor);
  }

  public get selectedColor(): string | undefined {
    return convertColorSegmentsToString(this.descriptor.props.minimumTrackTintColor);
  }

}