import { getAccount } from "./pk";

(async () => {
  const hero = getAccount("hero");
  console.log({ hero });
})();
