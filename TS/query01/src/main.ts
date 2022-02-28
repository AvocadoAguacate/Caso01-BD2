var sql = require("mssql");
import { Worker, isMainThread, parentPort } from 'worker_threads';

var config = {
  user: "sa",
  password: "pass123",
  server: "localhost",
  database: "Caso01_DB2_Esteban",
  trustServerCertificate: true
};

if(isMainThread){
  var threads:Worker[] = new Array(10)
  for (let index = 0; index < 10; index++) {
    threads[index] = new Worker(__filename);
  }
  setTimeout(() => {console.log("")}, 2000);
  for(let index = 0; index < 10; index++){
    threads[index].on('message', (msg) => { console.log(msg); });
  }
} else {
  var canton_thread = Math.floor(Math.random() * (101 - 1) + 1);
  const start = new Date().getTime();
  sql.connect(config, function (err) {
    if (err) console.log(err);
    var request = new sql.Request();
    request.query(`EXEC query01 @canton_id = ${canton_thread}`, function (err, recordset) {
        if (err) console.log(err);
        sql.close();
        let elapsed = new Date().getTime() - start;
        parentPort.postMessage(`Time: ${elapsed} for canton:${canton_thread}`);
    });
  });
}