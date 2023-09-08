#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.greenrenovatedbondscore/greenrenovatedbondsd.pid file instead
greenrenovatedbonds_pid=$(<~/.greenrenovatedbondscore/testnet3/greenrenovatedbondsd.pid)
sudo gdb -batch -ex "source debug.gdb" greenrenovatedbondsd ${greenrenovatedbonds_pid}
