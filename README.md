## Introduction

While working on local API gateway projects, switching between multiple versions of the decK tool can be a hassle. While in automation setups or CI/CD pipelines, you often specify a specific decK version, **DVM is designed specifically to make local development easier**. With a few simple commands, you can install, switch, and list decK versions locally as needed.

### Motivation

I developed DVM while working on a customer upgrade project where I had to validate API gateway configurations across multiple versions of Kong and decK. My task was to:

- Test decK configurations against Kong 2.8.
- Convert these configurations to a format compatible with Kong 3.4.
- Verify the configurations using newer versions of decK.

Each time, I found myself manually downloading different decK versions and fixing installation issues, which quickly became tedious. To streamline this process, I created DVM to manage decK version switches seamlessly. 

By using DVM, you can seamlessly switch between decK versions for local development and testing.

## How to Install and Use decK Version Manager

### Prerequisites

Before using DVM, make sure you have the following installed:

- `curl` for downloading files from GitHub.
- `tar` for extracting downloaded archives.

### Installation

1. **Download and Install the Script**

    First, clone the DVM script from the repository and install it using the following commands:

    ```bash
    # Clone the repository
    git clone git@github.com:bhatikuldeep/dvm.git

    # Navigate to the DVM directory
    cd dvm

    # Run the installation script
    chmod +x install.sh && ./install.sh
    ```

    > Important to note: If you previously installed decK via Homebrew, remove it to avoid conflicts with DVM using: `brew uninstall deck`

2. **Usage**

    - Install a Specific Version
    
        To install a specific version of decK, use the following command:

        ```bash
        dvm install <version>
        # Example:
        dvm install 1.39.4
        ```
                
    - Switch to a Specific Version
        After installing multiple versions, switch between them using:

        ```bash    
        dvm switch <version>
        # Example:
        dvm switch 1.38.0
        ```

    - List Installed Versions
        To see a list of all installed versions:

        ```bash    
        dvm list
        # Example output:
        Installed decK versions:
        * 1.39.4 (current)
        1.38.0
        ```

        This will display all installed versions, highlighting the currently active one.

3. **Uninstallation**

    - If you ever need to uninstall DVM, simply run the provided uninstall script:

        ```bash    
        chmod +x uninstall.sh && ./uninstall.sh
        ```
    
    This will remove the symbolic link for dvm and optionally remove all installed decK versions.

## Conclusion

For developers using decK locally, DVM is a simple yet powerful tool. It eliminates the hassle of manual version management and lets you focus on what matters—developing and testing your Kong configurations. Try DVM for yourself and experience a streamlined local decK Version Manager setup!