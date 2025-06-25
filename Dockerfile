# Use the official Python image as the base
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application code
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set the PORT environment variable
ENV PORT 8000

# Expose the port for external access
EXPOSE 8000

# Run the application
CMD ["python", "runserver.py"]
