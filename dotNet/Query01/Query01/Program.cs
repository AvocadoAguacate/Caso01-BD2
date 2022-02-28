using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Query01
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var datasource = @"localhost";
            var database = "Caso01_DB2_Esteban"; 
            var username = "sa"; 
            var password = "pass123"; 
            string connString = @"Data Source=" + datasource + ";Initial Catalog="
                        + database + ";Persist Security Info=True;User ID=" + username + ";Password=" + password;
            SqlConnection conn = new SqlConnection(connString);
            var threads = new ArrayList();
            for (int i = 0; i < 10; i++)
            {
                var canton_thread = (i * 5) + 10;
                threads.Add(new Thread(() => ExecQuery01(canton_thread, connString)));
            }
            System.Threading.Thread.Sleep(1000);
            for (int i = 0; i < threads.Count; i++)
            {
                Thread temp = (Thread)threads[i];
                temp.Start();
            }
            Console.Read();
        }
        static void ExecQuery01(int canton_id, string connString)
        {
            SqlConnection conn = new SqlConnection(connString);
            try
            {
                var watch = System.Diagnostics.Stopwatch.StartNew();
                conn.Open();
                SqlCommand sqlCommand = new SqlCommand("query01", conn);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("canton_id", canton_id);
                sqlCommand.ExecuteNonQuery();
                conn.Close();
                watch.Stop();
                Console.WriteLine("Time:" + watch.ElapsedMilliseconds + " for canton:" + canton_id);
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
        }
    }
}
