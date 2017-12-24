from pyspark.sql import *
from pyspark import SparkContext
from pyspark.sql.functions import *
import os  

os.environ['PYSPARK_SUBMIT_ARGS'] = '--jars /home/ubuntu/mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar pyspark-shell'
sc = SparkContext(appName="311Messages")
sqlContext = SQLContext(sc)

dataframe_mysql = sqlContext.read.format("jdbc").options(
    url="jdbc:mysql://localhost:3306/cityopendata",
    driver = "com.mysql.jdbc.Driver",
    dbtable = "311data",
    user="root",
    password="pass123").load()

dataframe_mysql.show(10)

dataframe_mysql=dataframe_mysql.dropDuplicates()
dataframe_mysql.groupBy(["service_name"]).count().show()
dataframe_mysql.groupBy(["status"]).count().show()
