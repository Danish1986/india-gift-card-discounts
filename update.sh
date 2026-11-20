#!/bin/bash
# Daily refresh: rebuild the dataset from the live Unyfy catalogue and push only if prices changed.
cd /home/ubuntu/india-gift-card-discounts || exit 1
python3 /home/ubuntu/mk_giftcard_dataset.py . 2>>update.log || exit 1
git add -A data README.md
git diff --cached --quiet && exit 0
git -c user.name="Danish Mirza" -c user.email="danish@unyfy.ai" commit -qm "Prices for $(date +%F)" && git push -q origin main
