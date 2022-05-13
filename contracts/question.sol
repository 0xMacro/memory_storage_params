pragma solidity 0.8.11;

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
  function useCalldata(uint[] calldata y) internal view returns (uint) {
    return y[0];
  }
  function useCalldataPure(uint[] calldata y) internal pure returns (uint) {
    return y[0];
  }


  function pickFunction(uint n) external view returns (uint) {
    if (n == 0) {
      useStore(x);
    }
    else if (n == 1) {
      useMem(x);
    }
    else if (n == 2) {
      useMemPure(x);
    }
    else if (n == 3) {
      useCalldata(x);
    }
    else if (n == 4) {
      useCalldataPure(x);
    }                  
  } 
}

