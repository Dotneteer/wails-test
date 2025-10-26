import { createComponentRenderer, createMetadata, d, parseScssVar } from "xmlui";
import { MessengerNative } from "./MessengerNative";

const COMP = "Messenger";

export const MessengerMd = createMetadata({
  status: "stable",
  description: "A custom messenger button",
});

export const messengerComponentRenderer = createComponentRenderer(
  COMP,
  MessengerMd,
  () => {
    return (
      <MessengerNative />
    );
  },
);
