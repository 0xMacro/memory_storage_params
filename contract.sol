// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.10;

contract str {
  uint[] x = [10];
  function useStore(uint[] storage y) internal view returns (uint) {
    return y[0];
  }
  function useMem(uint[] memory y) internal view returns (uint) {
    return y[0];
  }
  function useMemPure(uint[] memory y) internal pure returns (uint) {
    return y[0];
  }
//   function useCalldata(uint[] calldata y) internal view returns (uint) {
//     return y[0];
//   }
//   function useCalldataPure(uint[] calldata y) internal p returns (uint) {
//     return y[0];
//   }


  function pickFunction(uint n) external view returns (uint) {
      if (n == 0) {
          useStore(x); // 26173 gas (Cost only applies when called by a contract)
      }
      else if (n == 1) {
          useMem(x); // 26512 gas (Cost only applies when called by a contract)
      }
      else if (n == 2) {
          useMemPure(x); // 26528 gas (Cost only applies when called by a contract)
      }
    //   else if (n == 3) {
    //       useCalldata(x); // compiler error: cannot coerce calldata to storage
    //   }
    //   else if (n == 4) {
    //       useCalldataPure(x); // compiler error: cannot coerce calldata to storage
    //   }                  
  } 
}

/*
Explanation:

0 uses the least gas, because x is already in storage. Using memory would required copying x from storage to memory unnecessarily. Meanwhile, implicitly coercing from calldata to storage isn't allowed.

Surprisingly, useMemPure() uses 16 more gas than useMem()! I haven't yet walked through the opcodes to trace that one, but I'd like to get back to that. 
.
Learning objective:

calldata/memory/storage is often one of the things beginners--and even intermediate students--gloss over without really grasping in a meaningful way. When explained, memory/calldata is often pretty straightforward to understand, but I feel like it's rare to hear an explanation of why storage might ever be explicitly declared; why would picking storage over memory or calldata ever be cheaper? It sounds like a paradox when you first learn these options. This problem creates a scenario where calldata is the most wrong choice, and calldata is more expensive than storage! (bonus: pure is more expensive than view!)

- calldata is super cheap when you just need immutable data. Think of it like referencing the raw untouched arguments.
- memory, while still cheap, is a bit more expensive. It's for when you plan to mutate your data.
- so, when should we use storage? When the argument already exists in storage, and we want to avoid copying it over to memory!

I also think this is ripe interview question material. I don't know if it gets used, but it's a nice little detail to sus out solid grasp of fundamentals, imo
*/
