# Protocol Documentation
<a name="top"/>

## Table of Contents

- [fishy.proto](#fishy.proto)
    - [BlacklistRequest](#fishyv3.BlacklistRequest)
    - [BlacklistResponse](#fishyv3.BlacklistResponse)
    - [BuyBaitRequest](#fishyv3.BuyBaitRequest)
    - [BuyBaitResponse](#fishyv3.BuyBaitResponse)
    - [BuyItemRequest](#fishyv3.BuyItemRequest)
    - [BuyItemResponse](#fishyv3.BuyItemResponse)
    - [CheckGatherBaitRequest](#fishyv3.CheckGatherBaitRequest)
    - [CheckGatherBaitResponse](#fishyv3.CheckGatherBaitResponse)
    - [CheckTimeRequest](#fishyv3.CheckTimeRequest)
    - [CheckTimeResponse](#fishyv3.CheckTimeResponse)
    - [GetBaitInventoryRequest](#fishyv3.GetBaitInventoryRequest)
    - [GetBaitInventoryResponse](#fishyv3.GetBaitInventoryResponse)
    - [GetBaitTierRequest](#fishyv3.GetBaitTierRequest)
    - [GetBaitTierResponse](#fishyv3.GetBaitTierResponse)
    - [GetLocationRequest](#fishyv3.GetLocationRequest)
    - [GetLocationResponse](#fishyv3.GetLocationResponse)
    - [InventoryRequest](#fishyv3.InventoryRequest)
    - [InventoryResponse](#fishyv3.InventoryResponse)
    - [LeaderboardRequest](#fishyv3.LeaderboardRequest)
    - [LeaderboardResponse](#fishyv3.LeaderboardResponse)
    - [LeaderboardUser](#fishyv3.LeaderboardUser)
    - [SellFishRequest](#fishyv3.SellFishRequest)
    - [SellFishResponse](#fishyv3.SellFishResponse)
    - [SetBaitTierRequest](#fishyv3.SetBaitTierRequest)
    - [SetBaitTierResponse](#fishyv3.SetBaitTierResponse)
    - [SetLocationRequest](#fishyv3.SetLocationRequest)
    - [SetLocationResponse](#fishyv3.SetLocationResponse)
    - [StartGatherBaitRequest](#fishyv3.StartGatherBaitRequest)
    - [StartGatherBaitResponse](#fishyv3.StartGatherBaitResponse)
    - [UnblacklistRequest](#fishyv3.UnblacklistRequest)
    - [UnblacklistResponse](#fishyv3.UnblacklistResponse)
  
    - [BaitTier](#fishyv3.BaitTier)
    - [FishCategory](#fishyv3.FishCategory)
    - [Item](#fishyv3.Item)
    - [Location](#fishyv3.Location)
  
  
    - [Fishy](#fishyv3.Fishy)
  

- [lmao.proto](#lmao.proto)
    - [BaitInventory](#fishyv3.BaitInventory)
    - [FishInventory](#fishyv3.FishInventory)
    - [FishRequest](#fishyv3.FishRequest)
    - [FishResponse](#fishyv3.FishResponse)
    - [UserItem](#fishyv3.UserItem)
    - [UserItems](#fishyv3.UserItems)
  
  
  
  

- [Scalar Value Types](#scalar-value-types)



<a name="fishy.proto"/>
<p align="right"><a href="#top">Top</a></p>

## fishy.proto



<a name="fishyv3.BlacklistRequest"/>

### BlacklistRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.BlacklistResponse"/>

### BlacklistResponse







<a name="fishyv3.BuyBaitRequest"/>

### BuyBaitRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |
| tier | [BaitTier](#fishyv3.BaitTier) |  |  |
| amount | [int32](#int32) |  |  |






<a name="fishyv3.BuyBaitResponse"/>

### BuyBaitResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| new | [int32](#int32) |  |  |






<a name="fishyv3.BuyItemRequest"/>

### BuyItemRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| item | [Item](#fishyv3.Item) |  |  |
| tier | [int32](#int32) |  |  |






<a name="fishyv3.BuyItemResponse"/>

### BuyItemResponse







<a name="fishyv3.CheckGatherBaitRequest"/>

### CheckGatherBaitRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.CheckGatherBaitResponse"/>

### CheckGatherBaitResponse







<a name="fishyv3.CheckTimeRequest"/>

### CheckTimeRequest







<a name="fishyv3.CheckTimeResponse"/>

### CheckTimeResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| time | [string](#string) |  |  |
| morning | [bool](#bool) |  |  |
| night | [bool](#bool) |  |  |






<a name="fishyv3.GetBaitInventoryRequest"/>

### GetBaitInventoryRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.GetBaitInventoryResponse"/>

### GetBaitInventoryResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| max_bait | [int32](#int32) |  |  |
| current_count | [int32](#int32) |  |  |
| bait | [BaitInventory](#fishyv3.BaitInventory) |  |  |
| current_tier | [int32](#int32) |  |  |
| baitbox_tier | [int32](#int32) |  |  |






<a name="fishyv3.GetBaitTierRequest"/>

### GetBaitTierRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.GetBaitTierResponse"/>

### GetBaitTierResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tier | [BaitTier](#fishyv3.BaitTier) |  |  |






<a name="fishyv3.GetLocationRequest"/>

### GetLocationRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.GetLocationResponse"/>

### GetLocationResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [Location](#fishyv3.Location) |  |  |






<a name="fishyv3.InventoryRequest"/>

### InventoryRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.InventoryResponse"/>

### InventoryResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| items | [UserItems](#fishyv3.UserItems) |  |  |
| fish | [FishInventory](#fishyv3.FishInventory) |  |  |
| max_fish | [int32](#int32) |  |  |
| max_bait | [int32](#int32) |  |  |
| user_tier | [int32](#int32) |  |  |






<a name="fishyv3.LeaderboardRequest"/>

### LeaderboardRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| global | [bool](#bool) |  |  |
| page | [int32](#int32) |  |  |
| user | [string](#string) |  |  |
| guild | [string](#string) |  |  |
| guild_name | [string](#string) |  |  |






<a name="fishyv3.LeaderboardResponse"/>

### LeaderboardResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| users | [LeaderboardUser](#fishyv3.LeaderboardUser) | repeated |  |






<a name="fishyv3.LeaderboardUser"/>

### LeaderboardUser



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |
| score | [int32](#int32) |  |  |






<a name="fishyv3.SellFishRequest"/>

### SellFishRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |
| type | [FishCategory](#fishyv3.FishCategory) |  |  |






<a name="fishyv3.SellFishResponse"/>

### SellFishResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| worth | [int32](#int32) |  |  |






<a name="fishyv3.SetBaitTierRequest"/>

### SetBaitTierRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |
| tier | [BaitTier](#fishyv3.BaitTier) |  |  |






<a name="fishyv3.SetBaitTierResponse"/>

### SetBaitTierResponse







<a name="fishyv3.SetLocationRequest"/>

### SetLocationRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |
| location | [Location](#fishyv3.Location) |  |  |






<a name="fishyv3.SetLocationResponse"/>

### SetLocationResponse







<a name="fishyv3.StartGatherBaitRequest"/>

### StartGatherBaitRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.StartGatherBaitResponse"/>

### StartGatherBaitResponse







<a name="fishyv3.UnblacklistRequest"/>

### UnblacklistRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [string](#string) |  |  |






<a name="fishyv3.UnblacklistResponse"/>

### UnblacklistResponse






 


<a name="fishyv3.BaitTier"/>

### BaitTier


| Name | Number | Description |
| ---- | ------ | ----------- |
| T1 | 0 |  |
| T2 | 1 |  |
| T3 | 2 |  |
| T4 | 3 |  |
| T5 | 4 |  |



<a name="fishyv3.FishCategory"/>

### FishCategory


| Name | Number | Description |
| ---- | ------ | ----------- |
| FISH | 0 |  |
| LEGENDARY | 1 |  |
| GARBAGE | 2 |  |
| ALL | 3 |  |



<a name="fishyv3.Item"/>

### Item


| Name | Number | Description |
| ---- | ------ | ----------- |
| BAIT | 0 |  |
| ROD | 1 |  |
| HOOK | 2 |  |
| VEHICLE | 3 |  |
| BAITBOX | 4 |  |



<a name="fishyv3.Location"/>

### Location


| Name | Number | Description |
| ---- | ------ | ----------- |
| LAKE | 0 |  |
| RIVER | 1 |  |
| OCEAN | 2 |  |


 

 


<a name="fishyv3.Fishy"/>

### Fishy


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Fishy | [FishRequest](#fishyv3.FishRequest) | [FishResponse](#fishyv3.FishRequest) |  |
| Inventory | [InventoryRequest](#fishyv3.InventoryRequest) | [InventoryResponse](#fishyv3.InventoryRequest) |  |
| GetLocation | [GetLocationRequest](#fishyv3.GetLocationRequest) | [GetLocationResponse](#fishyv3.GetLocationRequest) |  |
| SetLocation | [SetLocationRequest](#fishyv3.SetLocationRequest) | [SetLocationResponse](#fishyv3.SetLocationRequest) |  |
| BuyItem | [BuyItemRequest](#fishyv3.BuyItemRequest) | [BuyItemResponse](#fishyv3.BuyItemRequest) |  |
| Blacklist | [BlacklistRequest](#fishyv3.BlacklistRequest) | [BlacklistResponse](#fishyv3.BlacklistRequest) |  |
| Unblacklist | [UnblacklistRequest](#fishyv3.UnblacklistRequest) | [UnblacklistResponse](#fishyv3.UnblacklistRequest) |  |
| StartGatherBait | [StartGatherBaitRequest](#fishyv3.StartGatherBaitRequest) | [StartGatherBaitResponse](#fishyv3.StartGatherBaitRequest) |  |
| CheckGatherBait | [CheckGatherBaitRequest](#fishyv3.CheckGatherBaitRequest) | [CheckGatherBaitResponse](#fishyv3.CheckGatherBaitRequest) |  |
| Leaderboard | [LeaderboardRequest](#fishyv3.LeaderboardRequest) | [LeaderboardResponse](#fishyv3.LeaderboardRequest) |  |
| CheckTime | [CheckTimeRequest](#fishyv3.CheckTimeRequest) | [CheckTimeResponse](#fishyv3.CheckTimeRequest) |  |
| GetBaitInventory | [GetBaitInventoryRequest](#fishyv3.GetBaitInventoryRequest) | [GetBaitInventoryResponse](#fishyv3.GetBaitInventoryRequest) |  |
| BuyBait | [BuyBaitRequest](#fishyv3.BuyBaitRequest) | [BuyBaitResponse](#fishyv3.BuyBaitRequest) |  |
| GetBaitTier | [GetBaitTierRequest](#fishyv3.GetBaitTierRequest) | [GetBaitTierResponse](#fishyv3.GetBaitTierRequest) |  |
| SetBaitTier | [SetBaitTierRequest](#fishyv3.SetBaitTierRequest) | [SetBaitTierResponse](#fishyv3.SetBaitTierRequest) |  |
| SellFish | [SellFishRequest](#fishyv3.SellFishRequest) | [SellFishResponse](#fishyv3.SellFishRequest) |  |

 



<a name="lmao.proto"/>
<p align="right"><a href="#top">Top</a></p>

## lmao.proto



<a name="fishyv3.BaitInventory"/>

### BaitInventory



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| t1 | [int32](#int32) |  |  |
| t2 | [int32](#int32) |  |  |
| t3 | [int32](#int32) |  |  |
| t4 | [int32](#int32) |  |  |
| t5 | [int32](#int32) |  |  |






<a name="fishyv3.FishInventory"/>

### FishInventory



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| fish | [int32](#int32) |  |  |
| garbage | [int32](#int32) |  |  |
| legendaries | [int32](#int32) |  |  |
| worth | [int32](#int32) |  |  |






<a name="fishyv3.FishRequest"/>

### FishRequest







<a name="fishyv3.FishResponse"/>

### FishResponse







<a name="fishyv3.UserItem"/>

### UserItem



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| current | [int32](#int32) |  |  |
| owned | [int32](#int32) | repeated |  |






<a name="fishyv3.UserItems"/>

### UserItems



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bait | [UserItem](#fishyv3.UserItem) |  |  |
| rod | [UserItem](#fishyv3.UserItem) |  |  |
| hook | [UserItem](#fishyv3.UserItem) |  |  |
| vehicle | [UserItem](#fishyv3.UserItem) |  |  |
| bait_box | [UserItem](#fishyv3.UserItem) |  |  |





 

 

 

 



## Scalar Value Types

| .proto Type | Notes | C++ Type | Java Type | Python Type |
| ----------- | ----- | -------- | --------- | ----------- |
| <a name="double" /> double |  | double | double | float |
| <a name="float" /> float |  | float | float | float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long |
| <a name="bool" /> bool |  | bool | boolean | boolean |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str |

