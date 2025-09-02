# Use OpenJDK 17 for JMusicBot compatibility
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Install necessary packages for audio processing and ffmpeg
RUN apt-get update && apt-get install -y \
    ffmpeg \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy the JMusicBot jar file
COPY JMusicBot-0.4.3.jar /app/musicbot.jar

# Copy configuration files
COPY config.example.txt /app/config.example.txt

# Create directories for data persistence
RUN mkdir -p /app/Playlists /app/logs

# Create a non-root user for security
RUN groupadd -r musicbot && useradd -r -g musicbot musicbot
RUN chown -R musicbot:musicbot /app
USER musicbot

# Expose port for potential web interface (if enabled)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD pgrep -f "musicbot.jar" || exit 1

# Environment variables with defaults
ENV JAVA_OPTS="-Xmx512m -Xms256m"
ENV LOG_LEVEL="info"

# Start the bot
CMD java $JAVA_OPTS -jar musicbot.jar
