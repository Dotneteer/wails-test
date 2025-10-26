import { forwardRef } from "react";
import { Greet } from "../../../wailsjs/go/main/App";

type Props = {};

export const MessengerNative = forwardRef<HTMLButtonElement, Props>(
  ({}, ref) => {
    return (
      <button
        ref={ref}
        type="button"
        onClick={() => window.alert("Messenger Button Clicked!")}
      >
        Messenger Button
      </button>
    );
  }
);

MessengerNative.displayName = "MessengerNative";
