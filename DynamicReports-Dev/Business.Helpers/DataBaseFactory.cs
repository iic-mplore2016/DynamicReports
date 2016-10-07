using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.Configuration;



public class DataBaseFactory
{

    private DbProviderFactory factory;
    private DbConnection dConn;
    private String connString, providerStr = "";

    public void DataFactory() //Default Constructor
    {

        connString = GlobalValues.ServerName;
        providerStr = GlobalValues.ProviderName;

        factory = DbProviderFactories.GetFactory(providerStr);

        //create database connection for connecting to database
        dConn = factory.CreateConnection();

        //set connection string
        dConn.ConnectionString = connString;

        //open the connection
        dConn.Open();
    }

    public DataTable ExecuteSQLQuery(string queryString)
    {
        DataTable dataTable = new DataTable();
        DataFactory();
        using (dConn)
        {
            DbCommand command = factory.CreateCommand();
            command.CommandText = queryString;
            command.Connection = dConn;
            DbDataAdapter adapter = factory.CreateDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(dataTable);
        }

        return dataTable;
    }
    public int ExecuteNoneSP(string spName, SqlParameter[] parameters)
    {
        DataFactory();
        int newID = 0;
        using (dConn)
        {
            DbCommand command = dConn.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandTimeout = 0;
            command.CommandText = spName;
            if (parameters != null)
            {
                foreach (DbParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }
            }
            command.CommandType = CommandType.StoredProcedure;
            command.CommandTimeout = 0;

            DbParameter outPutParameter = factory.CreateParameter();
            outPutParameter.ParameterName = "@rid";
            outPutParameter.DbType = System.Data.DbType.Int16;
            outPutParameter.Direction = System.Data.ParameterDirection.Output;
            command.Parameters.Add(outPutParameter);
            command.ExecuteNonQuery();
            newID = Convert.ToInt16(outPutParameter.Value);

        }
        return newID;
    }
    public int ExecuteNoneSPOrcale(string sql)
    {
        DataFactory();
        int newID = 0;

        using (dConn)
        {
            DbCommand command = dConn.CreateCommand();


            command.CommandText = sql;
            // command.Parameters.Add(new DbParameter("p_rid", DbType.Int16), System.Data.ParameterDirection.ReturnValue);


            DbParameter outPutParameter = factory.CreateParameter();
            outPutParameter.ParameterName = "p_rid";
            outPutParameter.DbType = System.Data.DbType.Int16;
            outPutParameter.Direction = System.Data.ParameterDirection.Output;
            command.Parameters.Add(outPutParameter);
            command.ExecuteNonQuery();
            //command.ExecuteNonQuery();
            newID = Convert.ToInt16(outPutParameter.Value);
            //    newID = command.ExecuteNonQuery();
        }

        return newID;

    }

    public string ExecuteSP(string spName, SqlParameter[] parameters)
    {
        DataTable dataTable = new DataTable();
        string ID = "";
        using (dConn)
        {
            DbCommand command = factory.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandTimeout = 0;
            if (parameters != null)
            {
                foreach (DbParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }
            }
            DbDataAdapter adapter = factory.CreateDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(dataTable);
        }
        return ID;
    }

    public int ExecuteNonQuery(string sql)
    {

        DataFactory();
        int result = 0;

        using (dConn)
        {
            DbCommand command = dConn.CreateCommand();
            command.CommandText = sql;
            result = command.ExecuteNonQuery();
        }
        return result;
    }

}

