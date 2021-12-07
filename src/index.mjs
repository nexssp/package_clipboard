import { createRequire } from "module";
const require = createRequire(import.meta.url);

const {
  nxsWarn,
} = require(`${process.env.NEXSS_PACKAGES_PATH}/Nexss/Lib/NexssLog.js`);

const NexssIn = require(`${process.env.NEXSS_PACKAGES_PATH}/Nexss/Lib/NexssIn.js`);
let NexssStdout = NexssIn();

import clipboard from "clipboardy";

const write = NexssStdout._write;
if (write) {
  await clipboard.write(write + "");
} else {
  try {
    NexssStdout[NexssStdout.resultField_1] = await clipboard.read();
  } catch (error) {
    nxsWarn(
      "Is the Clipboard is empty or an image? If is an image use 'nexss Clipboard/Save filename'"
    );
  }
}

delete NexssStdout.nxsIn;
delete NexssStdout.resultField_1;
process.stdout.write(JSON.stringify(NexssStdout));
