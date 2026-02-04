#!/usr/bin/env node

/**
 * Multi-Agent Coordination System Skill Installer
 * Installs the multi-agent coordination system as an OpenClaw skill
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// 获取当前目录和目标安装目录
const skillDir = path.dirname(__filename);
const workspaceDir = path.join(skillDir, '../../../');
const targetDir = path.join(workspaceDir, 'multi-agent-coordination-system');

console.log('🚀 Installing Multi-Agent Coordination System skill...');

try {
    // 检查是否已存在安装
    if (fs.existsSync(targetDir)) {
        console.log('⚠️ Multi-Agent Coordination System already exists, updating...');
    } else {
        console.log('📦 Cloning Multi-Agent Coordination System from GitHub...');
        
        // 克隆项目
        execSync(`git clone https://github.com/tianyuleishen/multi-agent-coordination-system.git ${targetDir}`, {
            stdio: 'inherit'
        });
    }
    
    // 进入目标目录并安装依赖
    console.log('🔧 Installing dependencies...');
    execSync('npm install', {
        cwd: targetDir,
        stdio: 'inherit'
    });
    
    // 验证安装
    const packageJsonPath = path.join(targetDir, 'package.json');
    if (fs.existsSync(packageJsonPath)) {
        const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
        console.log(`✅ Multi-Agent Coordination System v${packageJson.version || 'unknown'} installed successfully!`);
        console.log(`📁 Installed to: ${targetDir}`);
        console.log('\n📋 To use the system:');
        console.log('   cd ~/.openclaw/workspace/multi-agent-coordination-system');
        console.log('   node examples/server.js  # Start coordination server');
        console.log('   node examples/client.js  # Connect a client agent');
        console.log('   node integration_test.js # Run integration tests');
        console.log('   node demo.js             # Run system demo');
    } else {
        throw new Error('Installation verification failed - package.json not found');
    }
    
    console.log('\n🎉 Multi-Agent Coordination System skill installed successfully!');
} catch (error) {
    console.error('❌ Installation failed:', error.message);
    process.exit(1);
}