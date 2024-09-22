# Zenbook Duo Screen Toggle for Linux Mint

## Overview

This bash script provides a simple and effective way to toggle the second screen on Asus Zenbook Duo laptops running Linux Mint. While inspired by more complex solutions, this script is tailored for simplicity and reliability in the Linux Mint environment.

## Features

- Toggles the bottom screen of Asus Zenbook Duo laptops
- Preserves display configurations for other connected monitors
- Works reliably in Linux Mint environment
- Minimal dependencies, using only built-in Linux commands

## Why This Script?

This script was developed as a more rudimentary but effective alternative to more complex solutions available for other Linux distributions. Key differences include:

1. **Simplicity**: Focuses solely on toggling the bottom screen without additional features.
2. **Linux Mint Compatibility**: Tailored to work smoothly with Linux Mint, which may handle display management differently from other distributions.
3. **Configuration Preservation**: Attempts to maintain settings for other connected displays, minimizing disruption to your workspace.

## Prerequisites

- Linux Mint (tested on version [your Linux Mint version])
- xrandr (typically pre-installed on Linux Mint)

## Installation

1. Clone this repository or download the `duotoggle.sh` script.
2. Make the script executable:
   ```
   chmod +x /path/to/duotoggle.sh
   ```
3. Optionally, move the script to a convenient location, e.g., `~/scripts/`:
   ```
   mv duotoggle.sh ~/scripts/
   ```

## Usage

Run the script from the terminal:

```
~/scripts/duotoggle.sh
```

You can also create a desktop shortcut or bind it to a keyboard shortcut for easier access.

## How It Works

The script performs the following steps:

1. Identifies the Zenbook Duo displays.
2. Saves the current display configuration.
3. Toggles the bottom display on or off.
4. Restores the configuration for other displays.
5. Ensures the main display is set correctly.

## Troubleshooting

If you encounter any issues:

1. Ensure the script has execute permissions.
2. Check the output of `xrandr --query` to verify your display setup.
3. Run the script from the terminal to see any error messages.

## Contributing

Contributions, issues, and feature requests are welcome. Feel free to check [issues page](link to your issues page) if you want to contribute.

## License

[Your chosen license, e.g., MIT, GPL, etc.]

## Acknowledgments

- Inspired by [link to the original project or inspiration, if applicable]
- Thanks to the Linux Mint community for their support and feedback
