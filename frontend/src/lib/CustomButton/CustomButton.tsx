import { createMetadata, createUserDefinedComponentRenderer } from "xmlui";
import componentSource from "./CustomButton.xmlui";

const COMP = "CustomButton";

export const CustomButtonMd = createMetadata({
  status: "stable",
  description: "A customizable button component with different color variants",
  props: {
    label: {
      type: "string",
      description: "The text to display on the button",
      default: "Button",
    },
    color: {
      type: "string",
      description: "The color variant of the button (primary, secondary, success, default)",
      default: "default",
    },
    onClick: {
      type: "function",
      description: "Callback function when button is clicked",
      optional: true,
    },
  },
});

export const customButtonRenderer = createUserDefinedComponentRenderer(
  CustomButtonMd,
  componentSource,
);
