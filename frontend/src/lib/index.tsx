import { customButtonRenderer } from "./CustomButton/CustomButton";
import { messengerComponentRenderer } from "./Messenger/Messenger";
import { styledTextComponentRenderer } from "./StyledText/StyledText";

export default {
  namespace: "XMLUIExtensions",
  components: [customButtonRenderer, styledTextComponentRenderer, messengerComponentRenderer],
};
