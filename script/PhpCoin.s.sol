// SPDX-License-Identifier:MIT
pragma solidity 0.8.25;
import {Script, console} from "../lib/forge-std/src/Script.sol";
import {PhpCoin} from "../src/PhpCoin.sol";

contract PhpScript is Script{
    PhpCoin internal phpcoin;
    function run() public {
        vm.startBroadcast();
        phpcoin= new PhpCoin();
        vm.stopBroadcast();
        }
}
