#!/usr/bin/env bash

BASEDIR=$(cd `dirname $0`; pwd)

JACOCO_HOME=$BASEDIR/..

LIB_HOME=$JACOCO_HOME/lib

CONF_FILE=$JACOCO_HOME/conf/jacoco.conf
. $CONF_FILE

SERVICE_NAME='org.jacoco.startup.ReportGenerator'

LIB_JARS=`ls $LIB_HOME|grep .jar|awk '{print "'$LIB_HOME'/"$0}'|tr "\n" ":"`

# JAVA_OPTS
JAVA_OPTS="-server $JAVA_HEAP_OPTS"
JAVA_OPTS="${JAVA_OPTS} -XX:+UseConcMarkSweepGC -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDetails -XX:HeapDumpPath=$LOG_PATH -Xloggc:$LOG_PATH/gc.log"

# CONFIG_OPTS
CONFIG_OPTS="--db-jdbc-url $DB_JDBC_URL --db-user $DB_USER --db-password $DB_PASSWORD"

java $JAVA_OPTS -cp $LIB_JARS $SERVICE_NAME $CONFIG_OPTS $@ > $LOG_PATH/jacoco.log 2>&1