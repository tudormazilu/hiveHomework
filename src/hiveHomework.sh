
USER=jdbc:hive2://quickstart:10000/default
DRIVER=org.apache.hive.jdbc.HiveDriver

OPTION=$1
echo OPTION="$OPTION"
IP=$2
echo IP="$IP"

if [ -n "$OPTION" ]; then
  if [[ $OPTION -lt 1 ||  $OPTION -gt 4 ]]; then
    echo "Please specify a valid option: 1, 2, 3 or 4"
    exit 1
  fi
else
  echo "Please specify what option you want: 1, 2, 3 or 4"
  exit 1
fi

if [[ $OPTION == "1" && -z "$IP" ]]; then
  echo "Option 1 must be specified together with an IP (e.g. ./hiveHomework.sh 1 210.152.157.25)" 
  exit 1
fi


if [ -n "$IP" ]; then
  beeline -u $USER -n admin -d $DRIVER -e "insert overwrite local directory '/tmp/result' SELECT CAST(SUM(size) as BIGINT) AS total_length FROM tokenized_access_logs$OPTION WHERE host = '$IP'"

  beeline -u $USER -n admin -d $DRIVER -f filteredStats.sql -hiveconf totalLength=`cat /tmp/result/000000_0` -hiveconf tableNo=$OPTION -hiveconf ip=$IP
else
  case $OPTION in 
    2) 
      beeline -u $USER -n admin -d $DRIVER -e "insert overwrite local directory '/tmp/result' SELECT CAST(SUM(size) as BIGINT) AS total_length FROM tokenized_access_logs$OPTION"
  
      beeline -u $USER -n admin -d $DRIVER -f allStats.sql -hiveconf totalLength=`cat /tmp/result/000000_0` -hiveconf tableNo=$OPTION
      ;;
    3)
      beeline -u $USER -n admin -d $DRIVER -f urlStats1.sql
      ;;
    4)
      beeline -u $USER -n admin -d $DRIVER -f urlStats2.sql
      ;;
    *) 
      echo "Invalid option"
      ;;
  esac
fi



