var sql = require("mssql");
import { Worker, isMainThread, parentPort } from "worker_threads";

var config = {
  user: "sa",
  password: "pass123",
  server: "localhost",
  database: "Caso01_DB2_Esteban",
  trustServerCertificate: true,
  pool: {
    max: 10,
    min: 5,
    idleTimeoutMillis: 5000,
  },
};

const query02 = async () => {
  var canton_thread = Math.floor(Math.random() * (101 - 1) + 1);
  const start = new Date().getTime();
  const result = await sql.query`EXEC query01 @canton_id = ${canton_thread}`;
  console.dir(result);
  let elapsed = new Date().getTime() - start;
  parentPort.postMessage(`Time: ${elapsed} for canton:${canton_thread}`);
};

if (isMainThread) {
  var threads: Worker[] = new Array(10);
  sql.connect(config);
  for (let index = 0; index < 10; index++) {
    threads[index] = new Worker(__filename);
  }
  setTimeout(() => {
    console.log("");
  }, 2000);
  for (let index = 0; index < 10; index++) {
    threads[index].on("message", (msg) => {
      console.log(msg);
    });
  }
} else {
  query02();
}
