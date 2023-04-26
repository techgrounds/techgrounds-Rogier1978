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
1. First I have created 2 VM's (rogiervm01 & rogiervm02). After previous excercise this has become a lot easier. Below the logins of the VM's on my PC.  

2. 
### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview#managed-disk-snapshots  
https://www.communicationsquare.com/news/azure-managed-disks-vs-unmanaged-disks/  
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu  
https://learn.microsoft.com/en-us/azure/virtual-machines/disks-shared-enable?tabs=azure-portal  

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]
