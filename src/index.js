// Nexss PROGRAMMER 2.0.0 - Clipboard - Win32
// STDIN
process.stdin.on("data", function(NexssStdin) {
  let NexssStdout;
  try {
    NexssStdout = JSON.parse(NexssStdin.toString());
    const clipboardy = require("clipboardy");
    const cliArgs = require("minimist")(process.argv.slice(2));

    // Write DIRECT NEW EXTERNAL Value
    // EG. nexss Clipboard --write="myvalue to store"
    // EG2. echo {"write": "my value to store w/pipe"} | nexss Clipboard
    const write = cliArgs.Write || cliArgs.write;
    if (write) {
      clipboardy.writeSync(cliArgs.write + "");
      if (NexssStdout.debug || NexssStdout.verbose) {
        console.log(`Clipboard stored.`);
      }
    } else if (cliArgs.fields) {
      let result = "";
      cliArgs.fields.split(",").forEach(field => {
        result +=
          NexssStdout[field] + "\n"
            ? NexssStdout[field]
            : `${field} is empty.\n`;
      });
      clipboardy.writeSync(result);
      if (NexssStdout.debug || NexssStdout.verbose) {
        console.log(`Clipboard stored.`);
      }
    } else {
      try {
        NexssStdout["Clipboard"] = clipboardy.readSync();
      } catch (error) {
        console.log("Is the Clipboard is empty?");
      }

      if (NexssStdout.debug || NexssStdout.verbose) {
        console.log(`Clipboard read. DATA: ${NexssStdout["Clipboard"]}`);
      }
    }
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
  // STDOUT
  process.stdout.write(JSON.stringify(NexssStdout));
});

process.stdin.on("end", function() {
  //On Windows below is not needed.
  process.exit(0);
});
