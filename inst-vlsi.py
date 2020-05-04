#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#  cli_driver.py
#
#  Copyright 2017-2018 Edward Wang <edward.c.wang@compdigitec.com>
#
#  CLI entry point to the Hammer VLSI abstraction.

import argparse
import json
import os
import subprocess
import sys

import hammer_vlsi
from hammer_vlsi import CLIDriver
from inst_hooks import *

from typing import List, Dict, Tuple, Any, Iterable, Callable, Optional

class InstDriver(CLIDriver):

    def action_map(self) -> Dict[str, Callable[[hammer_vlsi.HammerDriver, Callable[[str], None]], Optional[dict]]]:
        """Return the mapping of valid actions -> functions for each action of the command-line driver."""
        par_action = self.create_par_action(custom_hooks=[
            hammer_vlsi.HammerTool.make_removal_hook("clock_tree")
        ])

        new_dict = dict(super().action_map())
        new_dict.update({
            "par": par_action
        })
        return new_dict

    def par_action(self, driver: hammer_vlsi.HammerDriver, append_error_func: Callable[[str], None]) -> Optional[dict]:
        if not driver.load_par_tool():
            return None
        success, par_output = driver.run_par(hook_actions=[
            hammer_vlsi.HammerTool.make_removal_hook("clock_tree")
        ])
        return par_output

if __name__ == '__main__':
    InstDriver().main()
