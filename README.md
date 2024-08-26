# DIFFERENT_INV_PARTY_CHECK_MIRO
The following REPO contains code to enhance your MIRO functionality for invoice party check as an error. 
As per standard SAP MIRO process, if you are posting the document for a PO, then it would post for the same vendor which is present in your purchase order, now let's say that 
you want to change the Vendor ( SAP allows it ), and will issue a warning message M8 , 286. Saying that you are posting the document to a different vendor as compared to PO. 

## How to prevent the posting to other vendor under certain conditions ?
Let's say that you don't want the document to be posted for another vendor for only few company codes...then we will have to convert this warning message as eror message. 
To do that we cannot use OMRM as it will be globally, now for conditions we need to implement the ENHANCEMENT SPOT - ES_SAPLMRMC, lmrmcu07_01. 

![image](https://github.com/user-attachments/assets/ff15933c-8685-47af-a183-3ae805c0f210)

After implementation of the point in FM - MRM_FINAL_CHECK, you can write your logic as follows in Program - ZMRM_INV_PTY_CHK.abap 
( take it as an include we can copy past in enhc implementation directly ). Let us discuss the conditions now - 

1# This conversion should be done only when the BUKRS is one of 25 values provided by Customer ( we will be taking it as dummy ) 
2# For few vendors the conversion should not happen , for ex - if in BUKRS - XX00, vendor is changed by value - 000145, then it should allow , so for this also there should be 
   an exception coded 

### Before 

![image](https://github.com/user-attachments/assets/7e1091b4-2130-48dd-8893-f57dfbb8b877)


### After 

![image](https://github.com/user-attachments/assets/c0446119-3859-4aaa-a59d-641156956b2c)


