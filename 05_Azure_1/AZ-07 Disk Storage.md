# AZ-07 Disk Storage
Create an Azure Managed Disk and connect this to two VM's. After this I will create a snapshot of the disk, mount this snapshot and see of the file still exists.  

## Key-terms  
**Azure managed disks**  
Azure managed disks are block-level storage volumes that are managed by Azure and used with Azure Virtual Machines. Managed disks are like a physical disk in an on-premises server but, virtualized. With managed disks, all you have to do is specify the disk size, the disk type, and provision the disk.  

**Azure Unmanaged Disks**
In Unmanaged Disk storage, you must create a storage account in resources to hold the disks (VHD files) for your Virtual Machines. With Managed Disk Storage, you are no longer limited by the storage account limits. You can have one storage account per region.  

In 2017, Microsoft launched Azure managed disks. They've been enhancing capabilities ever since. Because Azure managed disks now have the full capabilities of unmanaged disks and other advancements, They'll begin deprecating unmanaged disks on September 13, 2022. This functionality will be fully retired on September 30, 2025.  


**Managed disk snapshots**  
A managed disk snapshot is a read-only crash-consistent full copy of a managed disk that is stored as a standard managed disk by default. With snapshots, you can back up your managed disks at any point in time. These snapshots exist independent of the source disk and can be used to create new managed disks.  



## Opdracht
1. First I have created 2 VM's (rogiervm01 & rogiervm02). After previous excercise this has become a lot easier. Below the logins of the VM's on my PC. I used standard SSD drives and selected availability zone 1.

2. Now we create a managed disk. You can do this when you create your VM when selecting the harddrive. You can also do this afterwards via the Disk section of the Azure Portal. You have to select a LUN (Logical Unique Number). This is a number that must be unique in each VM linking it with a HD. After this we go to the second VM and connect the drive via the Disk menu option of this VM menu. Here we discover why it is important that the availability zones match. You ad an excisting disk and if the zones don't match the disk will not show in the menu. When we use the correct setting we can select the drive connect it to the VM number 2 (rogvm02)  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20managed%20disk.jpg)  

3. Now we can go to the Linux shell. I opened two instances, one for each VM. On the first VM we use these commands:
- sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%  
- sudo mkfs.xfs /dev/sdc1  
- sudo partprobe /dev/sdc1  
The "parted"command is to create a partition. "mklabel gpt" makes this a GPT partition. "mkpart xfspart" makes this an partition with an XFS filesystem. The "0% 100%" makes the complete drive part of the partition (from 0% to 100% of the drive.).
The "mkfs.xfs" fromats the drive to the XFS filesystem.
The "partprobe" command makes the kernel aware of the new partition.

4. Now that the partition is created I need to mount it. I make the directory "/datadrive" with the makdir /datdrive" command and mount it with "sudo mount /dev/sdc1 /datadrive". You can find the drives with the command:
- lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd" 
With -o you can select some output coloms. In this example Name, HCTL, size and mountpoint. HCTL is Host, Channel, Target, LUN. I found LUN the most important to ID the correct drive. 

5. On the second VM (rogvm02) we only need to mount the drive, because partitions and filesystem are already created. I first created the directory  "datadrive" and gave it a mount command as in the first VM. At first this didn't work because he didn't recognise the file system. But after reboot of the VM's in the portal this worked and we can see the two mounted drives below.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20vm%20mounts.jpg)  

6. Now create a file on tthe first drive. With "sudo touch testfile.txt" it creates a testfile.txt in the right directory. On the other drive however, this file will not show. You need a failover cluster.  
https://learn.microsoft.com/en-us/answers/questions/874923/why-shared-drive-is-not-showing-content-from-one-a  

7. Now we create a snapshot of the drive. In Azure we go to the Disk page and select the managed drive. On top you can click on "create snapshot". After adjusting some settings about the name, type of drive and availabilty you click on create and a snapshot (rogsnapshot) is created.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20snapshot.jpg)  

9. Now we need to make a disk from the snapshot to mount on the second VM. So we select the snapshot, click on create disk and we create a disk. 


2. 
### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview#managed-disk-snapshots  
https://www.communicationsquare.com/news/azure-managed-disks-vs-unmanaged-disks/  
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu  
https://learn.microsoft.com/en-us/azure/virtual-machines/disks-shared-enable?tabs=azure-portal https://learn.microsoft.com/en-us/answers/questions/874923/why-shared-drive-is-not-showing-content-from-one-a

### Ervaren problemen
Lots of variables needs to be right to make this work (availability zones, harddrive types among others). If you forget a thing you need to start over.

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
