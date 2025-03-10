
# DATOS CREDENCIALES
%run /Workspace/Users/lesusanibar@indracompany.com/credentials

host_name="g1luisserver.database.windows.net"
database_name="g1luisdatabase"
port="1433"
table_name="T1"

# PROBAR CONEXION A SQL DE LECTURA
df=(
spark.read 
.format("sqlserver")
.option("host",host_name)
.option("port",port)
.option("user",user_name)
.option("password",password)
.option("database",database_name)
.option("dbtable",table_name)
.load()
)

# PARAMETRIZAR TABLA DE ENTRADA

dbutils.widgets.text("table_name", "dbo.departments")
table_name=dbutils.widgets.get("table_name")

connection_properties= {
    "user": user_name,
    "password": password,
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}


jdbc_url=f"jdbc:sqlserver://g1luisserver.database.windows.net:1433;database=g1luisdatabase"

df_t1=spark.read.jdbc(url=jdbc_url, table=f"{table_name}", properties=connection_properties)

# INGESTA TODA LA DATA EN TABLA DELTA
df_t1.write.mode("overwrite").saveAsTable("departments")
