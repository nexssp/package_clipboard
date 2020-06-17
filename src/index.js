const {
  nxsWarn,
} = require(`${process.env.NEXSS_PACKAGES_PATH}/Nexss/Lib/NexssLog.js`);

const NexssIn = require(`${process.env.NEXSS_PACKAGES_PATH}/Nexss/Lib/NexssIn.js`);
let NexssStdout = NexssIn();

const clipboardy = require("clipboardy");

const write = NexssStdout._write;
if (write) {
  clipboardy.writeSync(write + "");
} else {
  try {
    NexssStdout[NexssStdout.resultField_1] = clipboardy.readSync();
  } catch (error) {
    nxsWarn("Is the Clipboard is empty?");
  }
}

delete NexssStdout.nxsIn;
delete NexssStdout.resultField_1;
process.stdout.write(JSON.stringify(NexssStdout));
