# Use the specified Python image
FROM python:3.9.17-bookworm

# Ensure the output of Python is sent straight to the terminal without buffering
ENV PYTHONUNBUFFERED=True

# Set the application directory in the container
ENV APP_HOME=/back-end
WORKDIR $APP_HOME

# Copy the current directory contents into the container at /back-end
COPY . ./

# Install system dependencies required for OpenCV
RUN apt-get update && \
    apt-get install -y libgl1-mesa-glx && \
    apt-get clean

# Install pip and the required Python packages
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the app will run on
EXPOSE 8080

# Start the application using Gunicorn
# CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "1", "--threads", "8", "--timeout", "0", "app:app"]
CMD ["gunicorn", "app:app"]

