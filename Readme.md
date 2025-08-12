
# Recipe NFT Smart Contract (Clarity)

This project contains a minimal **Stacks Clarity** smart contract for creating and managing **Recipe NFTs**.  
Each recipe is stored as a **non-fungible token** (NFT) with an ID, a name, and an owner.

---

## Features

- **Mint unique recipe NFTs**
- **Store recipe name metadata**
- **Query recipe details** (owner + name)
- **Validation checks** to prevent duplicate IDs and empty names

---

## Contract Structure

### 1. NFT Definition
```clarity
(define-non-fungible-token recipe-nft uint)
````

Each recipe NFT is identified by a `uint` ID.

---

### 2. Metadata Storage

```clarity
(define-map recipe-details uint (string-ascii 100))
```

Stores a short recipe name (up to 100 ASCII characters) keyed by the NFT ID.

---

### 3. Minting Function

```clarity
(define-public (mint-recipe (id uint) (name (string-ascii 100)) (recipient principal)) ...)
```

* Validates that the name is not empty
* Ensures the NFT ID has not been minted before
* Mints the NFT to the specified recipient
* Saves the recipe name in the metadata map

**Errors:**

* `u100`: NFT with this ID already exists
* `u101`: Invalid name (empty string)

---

### 4. Query Function

```clarity
(define-read-only (get-recipe (id uint)) ...)
```

Returns:

* `owner`: NFT owner's principal (or `none` if not minted)
* `name`: Recipe name (or `none` if no metadata stored)

---

## Example Usage

### Mint a Recipe NFT

```clarity
(contract-call? .recipe-nft mint-recipe u1 "Chocolate Cake" 'ST3J...ABC)
```

Returns:

```clarity
(ok { id: u1, name: "Chocolate Cake", owner: 'ST3J...ABC })
```

---

### Get Recipe Details

```clarity
(contract-call? .recipe-nft get-recipe u1)
```

Returns:

```clarity
(ok { owner: (some 'ST3J...ABC), name: (some "Chocolate Cake") })
```

---

## Deployment

1. Install [Clarinet](https://github.com/hirosystems/clarinet) for local testing.
2. Place the contract in `contracts/recipe-nft.clar`.
3. Run:

```bash
clarinet check
clarinet console
```

4. Deploy to the Stacks blockchain via [Stacks CLI](https://docs.stacks.co/).

5. cotract address
6. ST9D4QCQ1HR3J59DNDFPYS0Y294E0XT5CTMNJDPG
   <img width="1893" height="666" alt="image" src="https://github.com/user-attachments/assets/63a22080-8d89-495d-ba41-2c4174dbb40b" />

