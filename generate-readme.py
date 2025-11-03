#!/usr/bin/env python3
"""
SOLTI README Generator
Collects README files from component repositories and generates unified README.md
"""

import os
import re
from datetime import datetime
from pathlib import Path

# Repository configuration
REPOS = {
    'solti-monitoring': {
        'github': 'https://github.com/jackaltx/solti-monitoring',
        'status': '✅ Production Ready',
        'path': '../solti-monitoring'
    },
    'solti-containers': {
        'github': 'https://github.com/jackaltx/solti-containers',
        'status': '✅ Production Ready',
        'path': '../solti-containers'
    },
    'solti-ensemble': {
        'github': 'https://github.com/jackaltx/solti-ensemble',
        'status': '🚧 In Development',
        'path': '../solti-ensemble'
    },
    'solti-conductor': {
        'github': 'https://github.com/jackaltx/solti-conductor',
        'status': '📋 Planned',
        'path': None  # Not yet created
    },
    'solti-score': {
        'github': 'https://github.com/jackaltx/solti-score',
        'status': '📋 Planned',
        'path': None  # Not yet created
    }
}

def read_file(filepath):
    """Read file content if it exists"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return None

def extract_section(content, section_name):
    """Extract a specific markdown section from content"""
    if not content:
        return None

    # Match ## Section or # Section
    pattern = rf'^#+\s+{re.escape(section_name)}\s*$'
    lines = content.split('\n')

    section_lines = []
    in_section = False
    section_level = 0

    for line in lines:
        if re.match(pattern, line, re.IGNORECASE):
            in_section = True
            section_level = len(line.split()[0])  # Count # symbols
            continue
        elif in_section:
            # Check if we've hit another section of same or higher level
            if line.startswith('#'):
                current_level = len(line.split()[0])
                if current_level <= section_level:
                    break
            section_lines.append(line)

    return '\n'.join(section_lines).strip() if section_lines else None

def extract_summary(content, max_lines=5):
    """Extract first few meaningful lines as summary"""
    if not content:
        return "No README available"

    lines = content.split('\n')
    summary_lines = []

    for line in lines:
        line = line.strip()
        # Skip title lines, empty lines, and horizontal rules
        if line and not line.startswith('#') and not line.startswith('---'):
            summary_lines.append(line)
            if len(summary_lines) >= max_lines:
                break

    return '\n'.join(summary_lines) if summary_lines else "No description available"

def collect_component_info(repo_name, config):
    """Collect information from a component repository"""
    info = {
        'name': repo_name,
        'github': config['github'],
        'status': config['status'],
        'summary': None,
        'features': None,
        'readme_exists': False
    }

    if config['path']:
        readme_path = Path(config['path']) / 'README.md'
        content = read_file(readme_path)

        if content:
            info['readme_exists'] = True
            info['summary'] = extract_summary(content)

            # Try to extract features/key components
            for section_name in ['Features', 'Key Features', 'Components', 'Services', 'Current Implementation']:
                features = extract_section(content, section_name)
                if features:
                    info['features'] = features
                    break

    return info

def generate_readme():
    """Generate the unified README.md"""

    # Read base README0.md
    base_content = read_file('README0.md')

    # Collect component information
    components = {}
    for repo_name, config in REPOS.items():
        components[repo_name] = collect_component_info(repo_name, config)

    # Generate README
    readme = []

    # Header
    readme.append("# SOLTI - Systems Oriented Laboratory Testing & Integration")
    readme.append("")
    readme.append("> *Auto-generated from component repositories*")
    readme.append(f"> *Last updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*")
    readme.append("")

    # Extract and add overview from README0.md
    if base_content:
        overview = extract_section(base_content, 'Overview')
        if overview:
            readme.append("## Overview")
            readme.append("")
            readme.append(overview)
            readme.append("")

        goal = extract_section(base_content, 'Goal')
        if goal:
            readme.append("## 🎯 Goal")
            readme.append("")
            readme.append(goal)
            readme.append("")

    # Component Repositories
    readme.append("## 📦 Component Repositories")
    readme.append("")

    for repo_name, info in components.items():
        readme.append(f"### [{repo_name}]({info['github']})")
        readme.append(f"**Status:** {info['status']}")
        readme.append("")

        if info['readme_exists']:
            readme.append(info['summary'])
            readme.append("")

            if info['features']:
                readme.append(info['features'])
                readme.append("")
        else:
            if info['status'] == '📋 Planned':
                readme.append("*This component is planned for future development*")
            else:
                readme.append("*README not yet available*")
            readme.append("")

        readme.append("---")
        readme.append("")

    # Add remaining sections from README0.md
    if base_content:
        for section in ['Name Origin', 'Testing Philosophy', 'Key Features',
                       'Technology Stack', 'Development Guidelines', 'Testing Methodology',
                       'Deployment', 'Security Considerations', 'Future Directions',
                       'License', 'Contact']:
            section_content = extract_section(base_content, section)
            if section_content:
                # Add emoji for some sections
                emoji_map = {
                    'Name Origin': '🎵',
                    'Testing Philosophy': '🧪',
                    'Technology Stack': '🛠️',
                    'Security Considerations': '🔒',
                    'License': '📄',
                    'Contact': '📞'
                }
                section_title = section
                if section in emoji_map:
                    section_title = f"{emoji_map[section]} {section}"

                readme.append(f"## {section_title}")
                readme.append("")
                readme.append(section_content)
                readme.append("")

    return '\n'.join(readme)

if __name__ == '__main__':
    print("Generating unified README.md from component repositories...")
    print()

    # Generate README
    readme_content = generate_readme()

    # Write to README.md
    with open('README.md', 'w', encoding='utf-8') as f:
        f.write(readme_content)

    print("✅ README.md generated successfully!")
    print()
    print("Component repositories processed:")
    for repo_name, config in REPOS.items():
        if config['path']:
            readme_path = Path(config['path']) / 'README.md'
            exists = "✅" if readme_path.exists() else "❌"
            print(f"  {exists} {repo_name}")
        else:
            print(f"  📋 {repo_name} (planned)")
