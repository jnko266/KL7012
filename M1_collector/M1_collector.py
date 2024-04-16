#!/usr/bin/python3

# Import modules required for this script
from datetime import datetime
import pandas as pd
import requests
import sqlite3
import warnings
import uuid
import pytz

# Ignore warnings
warnings.filterwarnings('ignore')

# URL for getting M1 speed information from (per junction)
url = 'https://www.trafficengland.com/api/network/getJunctionSections?roadName=M1'
sqlite_path = '/appdata/M1_speeds.sqlite'

# Generate a unique identifier for this run
run_id = uuid.uuid4()
# Convert the UUID to a string so it can be stored in SQLite
run_id = str(run_id)

# Get current time in Europe/London
now = datetime.now(pytz.timezone('Europe/London'))

# Convert the time to 3 separate variables for storage in SQLite
# 1) Date in YYYYMMDD
# 2) Time in HHMMSS
# 3) Unix timestamp
date = now.strftime('%Y%m%d')
time = now.strftime('%H%M%S')
timestamp = now.timestamp()

# Create dataframe for storing data for the "run" table
run_data = (run_id, timestamp, date, time)

# Get data from the URL
response = requests.get(url)

# Check if the response was successful
if response.status_code != 200:
	raise Exception('Failed to get data from the API')

# Define pandas dataframe for storing the data, which will then be saved to SQLite
columns = ['speed_reading_run_id', 'speed_reading_junction_from', 'speed_reading_junction_to', 'speed_reading_direction', 'speed_reading']
speed_data = pd.DataFrame(columns=columns)

# Iterate over all junctions in the response
for junction_key, junction_details in response.json().items():
	# Get the junction name
	junction_name = junction_details.get('junctionName')

	# If primaryDownstreamJunctionSection, add record to the dataframe
	if junction_details.get('primaryDownstreamJunctionSection') is not None:
		# Get the speed data and create a new row
		new_row = pd.DataFrame([{
			'speed_reading_run_id': run_id,
			'speed_reading_junction_from': junction_name,
			'speed_reading_junction_to': junction_details.get('primaryDownstreamJunctionSection').get('downStreamJunctionDescription'),
			'speed_reading_direction': junction_details.get('primaryDownstreamJunctionSection').get('direction'),
			'speed_reading': junction_details.get('primaryDownstreamJunctionSection').get('avgSpeed')
		}], columns=columns)
		speed_data = pd.concat([speed_data, new_row], ignore_index=True)

	# If secondaryDownstreamJunctionSection, add record to the dataframe
	if junction_details.get('secondaryDownstreamJunctionSection') is not None:
		# Get the speed data
		new_row = pd.DataFrame([{
			'speed_reading_run_id': run_id,
			'speed_reading_junction_from': junction_name,
			'speed_reading_junction_to': junction_details.get('secondaryDownstreamJunctionSection').get('downStreamJunctionDescription'),
			'speed_reading_direction': junction_details.get('secondaryDownstreamJunctionSection').get('direction'),
			'speed_reading': junction_details.get('secondaryDownstreamJunctionSection').get('avgSpeed')
		}], columns=columns)
		speed_data = pd.concat([speed_data, new_row], ignore_index=True)

# Create a connection to the SQLite database
connection = sqlite3.connect(sqlite_path)
cursor = connection.cursor()

# Insert the data into the "run" table
cursor.execute("INSERT INTO run VALUES (?, ?, ?, ?)", run_data)

# Insert the data into the "speed_reading" table
for index, row in speed_data.iterrows():
	cursor.execute("INSERT INTO speed_reading VALUES (?, ?, ?, ?, ?)", row)

# Commit the changes to the database
connection.commit()

# Close the connection to the database
connection.close()

# Print a message to the console
print(f"{len(speed_data)} speed records successfully stored in SQLite database (run_id: {run_id})")