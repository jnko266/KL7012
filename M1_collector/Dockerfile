# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set the working directory to /app
WORKDIR /app

# Create a directory for app data
RUN mkdir /appdata

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
RUN rm /app/requirements.txt

# Copy only M1_collector.py into the container at /app
COPY M1_collector.py /app/

# Make the script executable
RUN chmod +x /app/M1_collector.py

# Ensure Python runs in unbuffered mode
ENV PYTHONUNBUFFERED=1

# Command to run on container start
CMD ["python", "-u", "./M1_collector.py"]