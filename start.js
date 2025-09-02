#!/usr/bin/env node

/**
 * Discord Music Bot - Node.js Wrapper
 * This wrapper allows the Java-based JMusicBot to run in Node.js environments
 * Author: HydrikMasqued
 * Platform: Cybrancee Cloud
 */

const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🎵 Discord Music Bot - Starting...');
console.log('═══════════════════════════════════════');

// Check if Java is available
function checkJava() {
    return new Promise((resolve) => {
        const javaCheck = spawn('java', ['-version'], { stdio: 'pipe' });
        
        javaCheck.on('close', (code) => {
            resolve(code === 0);
        });
        
        javaCheck.on('error', () => {
            resolve(false);
        });
    });
}

// Check if bot JAR file exists
function checkBotFile() {
    const botFile = 'JMusicBot-0.4.3.jar';
    return fs.existsSync(path.join(__dirname, botFile));
}

// Check if configuration files exist
function checkConfig() {
    const configFile = 'config.txt';
    return fs.existsSync(path.join(__dirname, configFile));
}

// Main startup function
async function startBot() {
    console.log('🔍 Checking system requirements...');
    
    // Check Java
    const hasJava = await checkJava();
    if (!hasJava) {
        console.error('❌ Java is not installed or not available in PATH');
        console.error('   Please ensure Java 17+ is installed');
        process.exit(1);
    }
    console.log('✅ Java is available');
    
    // Check bot file
    if (!checkBotFile()) {
        console.error('❌ JMusicBot-0.4.3.jar not found');
        console.error('   Please ensure the JAR file is uploaded to the server');
        process.exit(1);
    }
    console.log('✅ Bot JAR file found');
    
    // Check config
    if (!checkConfig()) {
        console.error('❌ config.txt not found');
        console.error('   Please upload your configuration file');
        process.exit(1);
    }
    console.log('✅ Configuration file found');
    
    console.log('');
    console.log('🚀 Starting Discord Music Bot...');
    console.log('═══════════════════════════════════════');
    
    // Start the Java bot with appropriate memory settings
    const javaArgs = [
        '-Xmx1024m',           // Maximum memory
        '-Xms512m',            // Initial memory  
        '-jar',
        'JMusicBot-0.4.3.jar'
    ];
    
    console.log(`   Command: java ${javaArgs.join(' ')}`);
    console.log('');
    
    const bot = spawn('java', javaArgs, {
        stdio: ['inherit', 'inherit', 'inherit'],
        cwd: __dirname
    });
    
    bot.on('spawn', () => {
        console.log('✅ Bot process started successfully!');
        console.log('📊 Bot is now connecting to Discord...');
        console.log('');
        console.log('🎵 Music Bot Commands:');
        console.log('   !play <song>  - Play music');
        console.log('   !queue        - Show queue');
        console.log('   !skip         - Skip current song');
        console.log('   !stop         - Stop music');
        console.log('   !help         - Show all commands');
        console.log('');
        console.log('🔧 To stop the bot: Press Ctrl+C');
        console.log('═══════════════════════════════════════');
    });
    
    bot.on('close', (code) => {
        console.log('');
        console.log('═══════════════════════════════════════');
        if (code === 0) {
            console.log('✅ Bot shut down gracefully');
        } else {
            console.log(`❌ Bot process exited with code ${code}`);
            console.log('');
            console.log('🔍 Common issues:');
            console.log('   • Invalid Discord token');
            console.log('   • Bot not invited to any servers');
            console.log('   • Network connectivity issues');
            console.log('   • Java memory issues');
        }
        console.log('═══════════════════════════════════════');
        process.exit(code);
    });
    
    bot.on('error', (err) => {
        console.error('');
        console.error('❌ Failed to start bot process:');
        console.error('   ', err.message);
        console.error('');
        console.error('🔍 Possible solutions:');
        console.error('   • Ensure Java is installed');
        console.error('   • Check file permissions');
        console.error('   • Verify JAR file is not corrupted');
        process.exit(1);
    });
    
    // Handle process termination
    process.on('SIGINT', () => {
        console.log('');
        console.log('🛑 Received shutdown signal...');
        console.log('   Stopping Discord Music Bot...');
        bot.kill('SIGTERM');
    });
    
    process.on('SIGTERM', () => {
        console.log('');
        console.log('🛑 Received termination signal...');
        console.log('   Stopping Discord Music Bot...');
        bot.kill('SIGTERM');
    });
}

// Handle uncaught errors
process.on('uncaughtException', (err) => {
    console.error('');
    console.error('❌ Uncaught Exception:', err.message);
    console.error('   Stack:', err.stack);
    process.exit(1);
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('');
    console.error('❌ Unhandled Rejection at:', promise, 'reason:', reason);
    process.exit(1);
});

// Start the bot
if (require.main === module) {
    startBot().catch(console.error);
}

module.exports = { startBot };
