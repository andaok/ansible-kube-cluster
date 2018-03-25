#!/bin/bash
token_dir=${TOKEN_DIR:-/tmp/release/certs}
token_file="${token_dir}/token.csv"

create_accounts=($@)

if [ ! -e "${token_file}" ]; then
  touch "${token_file}"
fi

for account in "${create_accounts[@]}"; do
  if grep ",${account}," "${token_file}" ; then
    continue
  fi
  token=$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | head -c 16 /dev/urandom | od -An -t x | tr -d ' ' 2>/dev/null)
  echo "${token},${account},10001,\"system:${account}\"" >> "${token_file}"
  echo "Added ${account}"
done
