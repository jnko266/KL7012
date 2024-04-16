# KL7012 Assignment 1 / Q10
## Northumbria University | Department of Computer and Information Sciences | Student ID w20018878

This repository contains the code used for deployment of a simple [Python script](M1_collector/M1_collector.py) that downloads average speed data on the M1 from a [Traffic England API](https://www.trafficengland.com/api/network/getJunctionSections?roadName=M1), which is normally displayed on the [Traffic England website](https://www.trafficengland.com/traffic-report). The script will then store the data to a SQLite database for subsequent analysis.  
The script is meant to be containerised and deployed on an always-on computer (such as a server or even a Raspberry Pi), where the script can then be scheduled to run periodically (i.e. using [cron](https://crontab.guru)) using the below command:  

```bash
docker run --rm -v /local/path/to/db/M1_speeds.sqlite:/appdata/M1_speeds.sqlite m1-monitor
```

The container can be built using the provided [Dockerfile](M1_collector/Dockerfile) and the following command:  

```bash
docker build -t m1-monitor .
```

As can be seen above, the script requires a SQLite database file to be mounted to the container at `/appdata/M1_speeds.sqlite`.  
The database file should be created on the host machine before running the script, and necessary tables should be created using the [provided DDL file](M1_collector/DDL.sql), which also inserts some data to helper tables, such as `junction_order` or `run_time_config`. Recommended software for creating and managing SQLite databases is [DBeaver](https://dbeaver.io/download/).  
The values in these tables may have to be amended to reflect current order of junctions (accurate as of 16th April 2024), or to fit the analysis requirements.  
The `run_time_config` table defines different periods of each day for which readings will be grouped and averaged. This is useful for analysing traffic patterns at different times of the day. By default, the following periods are defined (using the DDL file):  

| Start time | End time | Period |
| --- | --- | --- |
| 06:00:00 | 09:30:00 | morning |
| 11:00:00 | 12:30:00 | mid-day |
| 14:00:00 | 15:30:00 | afternoon |
| 16:00:00 | 19:30:00 | evening |
| 21:00:00 | 23:30:00 | night |

The views created by the DDL rely on this table and if no records are present, the views will not show any data, as **data that does not fit into any period will be ignored**.  
The raw data collected by the deployed script can be found in the [raw_data](raw_data) directory - specifically the collected data is in files [run.csv](raw_data/run.csv) and [speed_reading.csv](raw_data/speed_reading.csv). This data was collected on an hourly basis for a period of 1 week starting on 8th of April (Monday) and finishing on 14th of April 2024 (Sunday).