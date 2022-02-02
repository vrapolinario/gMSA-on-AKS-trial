# gMSA-on-AKS-trial

Welcome to the "Deploy AKS for gMSA validation" PowerShell script. 
Use the instructions below to deploy a new Azure environment to try out the gMSA on AKS feature.

## Intro
In a nutshell, gMSA allows applications that are Active Directory (AD) dependent to be containerized. By default, containers don’t understand AD as they can’t be domain-joined. With gMSA, we give the underlying container host the task of authenticating the application inside the container. This feature is currently on Public Preview on AKS.

However, as you can imagine, to even try gMSA on AKS you need to setup a fairly complex environment. You need an Azure vNEt, an AKS cluster, a VM working as Domain Controller, and both the Windows nodes on your AKS cluster and the Domain Controller must be on the same vNet. 
With that in mind, I decided to make the process of spinning up that environment easier. If nothing else, this exercise might also give you some cool insights into how to use PowerShell to manage Azure resources.

**Disclaimer**: This script should not be used for production environments. It’s intended to facilitate the process of spinning up a test environment to try the gMSA on AKS feature. This is personal project. No support provided by Microsoft.

## How to use
Download the ps1 files to your machine. The three files are:

- DeployAKS.ps1:
  - This file should be used first, to deploy the Azure resources. Run this file from any machine capable of running a PowerShell session and internet connectivity.
- ADDS.ps1:
  - This file should be used from inside the VM created with the previous sript. It will promote the VM to a Domain Controller and deploy a new forest domain.
- Cleanup.ps1:
  - Optional file. Can be used to delete the Azure resources created in this exercise.

## Known Issues

- An error with SSH keys occurs when deploying the AKS cluster: This happens because the script is currently hardcoded to "-generatesshkeys".
  - Workaround 1: You can change the script to point to your existing SSH Keys.
  - Workaround 2: If the existing keys are not being used, you can delete existing keys on your user profile and create a new one when running this script.

For questions, comments, and feedback, feel free to reach out to me:
- [E-mail](mailto:viniap@microsoft)
- [Twitter](https://www.twitter.com/vrapolinario)