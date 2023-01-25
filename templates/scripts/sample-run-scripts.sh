#!/usr/bin/env bash
fio --section=layout-output main.fio
fio --section=4k-randread main.fio
