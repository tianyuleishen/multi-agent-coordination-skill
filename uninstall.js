#!/usr/bin/env node

/**
 * Multi-Agent Coordination System Skill Uninstaller
 * Removes the multi-agent coordination system skill
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// 获取目标安装目录
const workspaceDir = path.join(__dirname, '../../../');
const targetDir = path.join(workspaceDir, 'multi-agent-coordination-system');

console.log('🗑️ Uninstalling Multi-Agent Coordination System skill...');

try {
    if (fs.existsSync(targetDir)) {
        console.log(`Removing directory: ${targetDir}`);
        
        // 删除目录
        execSync(`rm -rf "${targetDir}"`, {
            stdio: 'inherit'
        });
        
        console.log('✅ Multi-Agent Coordination System skill removed successfully!');
    } else {
        console.log('⚠️ Multi-Agent Coordination System not found, nothing to uninstall.');
    }
} catch (error) {
    console.error('❌ Uninstallation failed:', error.message);
    process.exit(1);
}