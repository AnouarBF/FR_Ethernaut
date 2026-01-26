source .env
for i in {1..10}; do
	echo "Run $i/10"
	forge script script/CoinflipAttack.s.sol \
		--rpc-url $RPC_URL_SEPOLIA \
		--broadcast \
		--account testing \
		--sender $ATTACKER \
		-vvvv || break
	sleep 10
done
