# 🌐 Cybrancee Cloud Deployment Guide

This guide will walk you through deploying your Discord Music Bot to Cybrancee Cloud Platform.

## 🚀 Prerequisites

Before deploying to Cybrancee, ensure you have:

- [ ] A Cybrancee cloud account at [panel.cybrancee.com](https://panel.cybrancee.com)
- [ ] Docker installed on your development machine
- [ ] Your Discord bot token and user ID configured
- [ ] Git repository set up (see GitHub Setup below)

## 📋 Step-by-Step Deployment

### 1. Prepare Your Environment

First, make sure your configuration is ready:

```bash
# Copy example files if you haven't already
cp .env.example .env
cp config.example.txt config.txt

# Edit .env with your actual values
# DISCORD_TOKEN=your_actual_token_here
# OWNER_ID=your_discord_user_id
```

### 2. Test Locally with Docker

Before deploying to the cloud, test your setup locally:

```bash
# Build the Docker image
docker build -t discord-music-bot .

# Test run
docker-compose up -d

# Check logs
docker-compose logs -f musicbot

# Stop when done testing
docker-compose down
```

### 3. Deploy to Cybrancee

#### Option A: Using the Deployment Script (Recommended)

```bash
# Make the script executable
chmod +x deploy.sh

# Deploy to cloud
./deploy.sh deploy

# Check deployment status
./deploy.sh status

# View live logs
./deploy.sh logs
```

#### Option B: Manual Deployment

1. **Login to Cybrancee Panel**
   - Go to [panel.cybrancee.com](https://panel.cybrancee.com)
   - Access your hosting dashboard

2. **Create New Application**
   - Choose "Docker Container" deployment
   - Set application name: `discord-music-bot`
   - Select resource allocation:
     - RAM: 1GB (recommended)
     - CPU: 0.5 cores
     - Storage: 2GB

3. **Configure Environment Variables**
   Set these environment variables in the Cybrancee panel:
   ```
   DISCORD_TOKEN=your_actual_discord_token
   OWNER_ID=your_discord_user_id
   COMMAND_PREFIX=!
   MAX_TIME=600
   STAY_IN_CHANNEL=true
   LOG_LEVEL=info
   ```

4. **Upload Files**
   - Upload your `Dockerfile`
   - Upload `docker-compose.yml`
   - Upload `JMusicBot-0.4.3.jar`
   - Upload `config.txt` (with your actual configuration)

5. **Deploy**
   - Click "Deploy" in the Cybrancee panel
   - Wait for the build process to complete
   - Monitor logs for successful startup

## 🔧 Configuration for Cloud Deployment

### Resource Requirements

For optimal performance on Cybrancee:

```yaml
# Recommended specifications
Memory: 1GB RAM minimum
CPU: 0.5 cores minimum
Storage: 2GB for logs and playlists
Network: Unlimited bandwidth
```

### Environment Variables

| Variable | Value | Description |
|----------|-------|-------------|
| `DISCORD_TOKEN` | Your bot token | Required for Discord connection |
| `OWNER_ID` | Your Discord user ID | Bot owner permissions |
| `COMMAND_PREFIX` | `!` | Command prefix (customizable) |
| `MAX_TIME` | `600` | Max song length in seconds |
| `STAY_IN_CHANNEL` | `true` | Stay in voice channel when queue ends |
| `LOG_LEVEL` | `info` | Logging verbosity |
| `JAVA_OPTS` | `-Xmx1024m -Xms512m` | Java memory settings |

## 📊 Monitoring and Management

### Viewing Logs

```bash
# Real-time logs
./deploy.sh logs

# Or through Cybrancee panel
# Navigate to your application > Logs section
```

### Checking Status

```bash
# Check if bot is running
./deploy.sh status

# Resource usage
docker stats discord-music-bot
```

### Restarting the Bot

```bash
# Restart bot container
./deploy.sh restart

# Or redeploy completely
./deploy.sh stop
./deploy.sh deploy
```

## 🔐 Security Best Practices

1. **Never commit sensitive files**
   - `.env` is in `.gitignore`
   - `config.txt` is in `.gitignore`
   - Always use example files in the repository

2. **Use environment variables**
   - Set tokens through Cybrancee panel environment variables
   - Don't hardcode secrets in configuration files

3. **Regular token rotation**
   - Periodically regenerate your Discord bot token
   - Update the token in Cybrancee panel environment variables

## 🚨 Troubleshooting

### Common Issues

**Bot doesn't start:**
```bash
# Check logs for errors
./deploy.sh logs

# Common fixes:
# 1. Verify Discord token is valid
# 2. Check if bot is added to Discord servers
# 3. Ensure proper environment variables are set
```

**Out of memory errors:**
```bash
# Increase memory allocation in docker-compose.yml
resources:
  limits:
    memory: 2G  # Increase from 1G
```

**Connection issues:**
```bash
# Check network connectivity
docker exec discord-music-bot ping discord.com

# Verify DNS resolution
docker exec discord-music-bot nslookup discord.com
```

### Getting Help

1. **Check logs first**: `./deploy.sh logs`
2. **Review Cybrancee documentation**: Available in your hosting panel
3. **Discord bot troubleshooting**: [JMusicBot Wiki](https://github.com/jagrosh/MusicBot/wiki)

## 🔄 Updates and Maintenance

### Updating the Bot

```bash
# Download latest JMusicBot release
wget https://github.com/jagrosh/MusicBot/releases/latest/download/JMusicBot-X.X.X.jar

# Update Dockerfile to reference new version
# Then redeploy
./deploy.sh stop
./deploy.sh deploy
```

### Backup Important Data

```bash
# Backup playlists and configuration
docker cp discord-music-bot:/app/Playlists ./backup/
docker cp discord-music-bot:/app/serversettings.json ./backup/
```

## 📈 Scaling and Performance

### Horizontal Scaling

For multiple Discord servers, consider:
- Deploy multiple bot instances
- Use different bot tokens for each instance
- Load balance across Cybrancee regions

### Performance Optimization

```yaml
# Optimize Java settings in docker-compose.yml
environment:
  - JAVA_OPTS=-Xmx2048m -Xms1024m -XX:+UseG1GC -XX:G1HeapRegionSize=32m
```

## 💰 Cost Management

- **Resource monitoring**: Use Cybrancee's built-in monitoring
- **Scaling**: Scale resources based on actual usage
- **Optimization**: Optimize Java heap size and container resources

## 🔗 Additional Resources

- [Cybrancee Documentation](https://panel.cybrancee.com/docs)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [JMusicBot Wiki](https://github.com/jagrosh/MusicBot/wiki)
- [Discord Developer Portal](https://discord.com/developers/applications)

---

**Need Help?** Contact Cybrancee support through your hosting panel or check the community forums.

**Author**: HydrikMasqued  
**Last Updated**: 2025  
**Platform**: Cybrancee Cloud
