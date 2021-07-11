# From https://www.tutorialkart.com/apache-spark/submit-spark-application-python-example/

import sys

from pyspark import SparkContext, SparkConf
 
if __name__ == "__main__":
 
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Word Count - Python").set("spark.hadoop.yarn.resourcemanager.address", "10.211.55.102:8032")
  sc = SparkContext(conf=conf)
 
  # read in text file and split each document into words
  words = sc.textFile("/input/enwik9").flatMap(lambda line: line.split(" "))
 
  # count the occurrence of each word
  wordCounts = words.map(lambda word: (word, 1)).reduceByKey(lambda a,b:a +b)

  sortedCounts = wordCounts.sortByKey()
  
  print(sortedCounts.take(100))
#  print(wordCounts)
#  wordCounts.saveAsTextFile("/output/wc_spark")
