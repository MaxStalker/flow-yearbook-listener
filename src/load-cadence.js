import { loadCadenceFile } from "./parser";
import { query, config } from "@onflow/fcl";

(async () => {
  const [cadence, err] = loadCadenceFile("script/check-yearbook-created");
  if (!err) {
    const admin = "0x63ffd70144f80d07";
    const other = "0x5593df7d286bcdb8";
    const user = other;

    const args = (arg, t) => [arg(user, t.Address)];
    const result = await query({
      args,
      cadence,
    });

    console.log(`${user} account have Yearbook in storage: ${result}`);
  } else {
    console.error(err);
  }
})();
