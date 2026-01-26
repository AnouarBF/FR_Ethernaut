// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {CoinFlipAttack} from "script/CoinflipAttack.s.sol";
import {CoinFlip} from "src/Coinflip.sol";

contract CoinflipAttackTest is Test {
    CoinFlip target;
    address attacker = makeAddr("attacker");
    CoinFlipAttack attackContract;

    function setUp() external {
        attackContract = new CoinFlipAttack();
        target = attackContract.run();
    }

    function test_consecutiveWins() external view {
        assert(target.consecutiveWins() != 0);
    }

    function test_multipleflips() external {
        for (uint i = 0; i < 9; i++) {
            vm.warp(block.timestamp + 10);
            vm.roll(block.number + 2);
            // target.flip();
            attackContract.run();
        }

        assert(target.consecutiveWins() >= 10);
    }
}
