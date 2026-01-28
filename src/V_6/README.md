# Ethernaut — Token

## Vulnerability
Arithmetic underflow in Solidity <0.8.0 due to unchecked subtraction.

## Root Cause
The contract subtracts `_value` from the sender’s balance without validation:
```solidity
balances[msg.sender] -= _value;
```

## Exploit
```math
20 - 21 → 2^256 - 1
```