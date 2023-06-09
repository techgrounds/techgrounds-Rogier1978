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
1. First I have created 2 VM's (rogiervm01 & rogiervm02). After previous excercise this has become an easy task. Below the logins of the VM's on my PC. I used standard SSD drives and selected availability zone 1. Als on the bottom of the screen of the Disk section of the setup you can already create or assign harddrives to the VM.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20create%20a%20new%20data%20disk%20on%20rogvm01.png)  

2. And here we assigned the harddrive created for rogvm01 to rogvm02:
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20rogvm02%20disks.png)  

3. Now we can go to the Linux shell. I opened two instances, one for each VM. On the first VM we use these commands:
- sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%  
- sudo mkfs.xfs /dev/sdc1  
- sudo partprobe /dev/sdc1  
The "parted"command is to create a partition. "mklabel gpt" makes this a GPT partition. "mkpart xfspart" makes this an partition with an XFS filesystem. The "0% 100%" makes the complete drive part of the partition (from 0% to 100% of the drive.).
The "mkfs.xfs" fromats the drive to the XFS filesystem.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20mkfs.png)  
The "partprobe" command makes the kernel aware of the new partition.

4. Now that the partition is created I need to mount it. I make the directory "/datadrive" with the mkdir /datadrive" command and mount it with "sudo mount /dev/sdc1 /datadrive". You can find the drives with the command:
- lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd" 
With -o you can select some output coloms. In this example Name, HCTL, size and mountpoint. HCTL is Host, Channel, Target, LUN. I found LUN and the size the most important to ID the correct drive. 

5. On the second VM (rogvm02) we only need to mount the drive, because partitions and filesystem are already created. I first created the directory  "datadrive" and gave it a mount command as in the first VM. At first this didn't work because he didn't recognise the file system. But after reboot of the VM's in the portal this worked and we can see the two mounted drives below.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20hd%20mounts.png)  

6. Now create a file on tthe first drive. With "sudo touch testfile.txt" it creates a testfile.txt in the right directory. On the other drive however, this file will not show. You need a failover cluster.  
https://learn.microsoft.com/en-us/answers/questions/874923/why-shared-drive-is-not-showing-content-from-one-a  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20testfile.png)  

7. Now we create a snapshot of the drive. In Azure we go to the Disk page and select the managed drive. On top you can click on "create snapshot". After adjusting some settings about the name, type of drive and availabilty you click on create and a snapshot (rogsnapshot) is created.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20create%20snapshot.png)

9. Now we need to make a disk from the snapshot to mount on the second VM. So we select the snapshot, click on create disk and we create a disk. We attach this to VM02 (rogvm02) in the VM page in the portal. 
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20vm02%20snapshotdrive.png)  

10. Now we can look the disk up in the Linux shell of vm02 with the lsblk command, and mount it to a directory I created called "snapshot". When this was succeful the snapshot drive could be seen and the file we created on the first VM was also found.  
![](https://github.com/techgrounds/techgrounds-Rogier1978/blob/main/00_includes/05_Azure_1/AZ_07%20vm02%20mount%20snapshotdrive.png)  


### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview#managed-disk-snapshots  
https://www.communicationsquare.com/news/azure-managed-disks-vs-unmanaged-disks/  
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu  
https://learn.microsoft.com/en-us/azure/virtual-machines/disks-shared-enable?tabs=azure-portal https://learn.microsoft.com/en-us/answers/questions/874923/why-shared-drive-is-not-showing-content-from-one-a

### Ervaren problemen
Lots of variables needs to be right to make this work (availability zones, harddrive types among others). If you forget a thing you need to start over. You need to restart the VM's to make the drives appear in the Linux shell.  
This was challenging, but I improved my navigation skills in Azure and how (not so) fast things react. I now have a basic knowledge about storage in Azure.

### Resultaat
In the final screenshot you see the testfile created in step 6 is shown in VM by copying the drive to a snapshot and mount the drive created from the snapshot in VM02.
