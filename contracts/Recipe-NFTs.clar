;; Recipe NFT Contract
;; Minimal NFT example for recipes

(define-non-fungible-token recipe-nft uint)

;; Storage for recipe details (optional metadata)
(define-map recipe-details uint (string-ascii 100))

;; Helper: validate that the name is not empty
(define-read-only (is-valid-name (n (string-ascii 100)))
  (> (len n) u0) ;; Must be at least 1 character
)

;; Mint a new Recipe NFT
(define-public (mint-recipe (id uint) (name (string-ascii 100)) (recipient principal))
  (begin
    ;; Validate name length
    (asserts! (is-valid-name name) (err u101)) ;; Error 101: invalid name
    ;; Ensure the NFT doesn't already exist
    (asserts! (is-none (nft-get-owner? recipe-nft id)) (err u100)) ;; Error 100: ID exists
    ;; Mint to recipient
    (try! (nft-mint? recipe-nft id recipient))
    ;; Store recipe name
    (map-set recipe-details id name)
    (ok {id: id, name: name, owner: recipient})
  )
)

;; Get the details of a recipe by ID
(define-read-only (get-recipe (id uint))
  (ok {
    owner: (nft-get-owner? recipe-nft id),
    name: (map-get? recipe-details id)
  })
)
