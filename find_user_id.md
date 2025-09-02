# How to Find Your Discord User ID

You need your Discord User ID to set as the owner of the bot. Here are several ways to get it:

## Method 1: Using Discord Developer Mode (Recommended)

1. **Enable Developer Mode:**
   - Open Discord
   - Click on the gear icon (⚙️) next to your username (User Settings)
   - Go to "Advanced" on the left side
   - Turn ON "Developer Mode"

2. **Get Your User ID:**
   - Right-click on your username anywhere in Discord
   - Click "Copy User ID"
   - This will copy your 17-18 digit User ID

## Method 2: Using Discord on Web/Desktop

1. Open Discord in a web browser or desktop app
2. In the URL bar (web) or by right-clicking your name, you can see your User ID
3. The User ID is the long number (17-18 digits)

## Method 3: Using a Bot Command (if you have access to another bot)

If you have access to any Discord server with a bot that has user info commands:
- Try `!userinfo @yourusername` or similar commands
- This will usually display your User ID

## What to Do Next

Once you have your User ID:

1. **Edit config.txt:**
   - Replace `0 // OWNER ID` with your User ID
   - For example: `owner = 123456789012345678`

2. **Update Java (Required):**
   Your current Java version (8) is too old for JMusicBot 0.4.3.
   Download Java 17 or newer from:
   - [Oracle Java](https://www.oracle.com/java/technologies/downloads/)
   - [OpenJDK](https://adoptium.net/)

3. **Run the bot:**
   - After updating Java, run `run_bot.bat`
   - Or manually: `java -jar JMusicBot-0.4.3.jar`

## Your Bot Details

From your old backup, I found:
- **Discord Token:** Already configured ✅
- **Bot ID:** 411247390893277194
- **Command Prefix:** ! (exclamation mark)

You just need your **User ID** to complete the setup!
