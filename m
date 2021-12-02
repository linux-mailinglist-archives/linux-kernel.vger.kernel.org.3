Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA66F466379
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357897AbhLBMX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:23:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:36246 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357873AbhLBMXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:23:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="297494506"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="297494506"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 04:19:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="609959637"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2021 04:19:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msl3i-000GJ8-Ch; Thu, 02 Dec 2021 12:19:30 +0000
Date:   Thu, 2 Dec 2021 20:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [t-kristo-pm:usi-5.16-rfc-v3-bpf 6/24] syscall.c:undefined reference
 to `hid_prog_detach'
Message-ID: <202112022036.K1SyiDen-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v3-bpf
head:   d0f251812c57f49830816624bec858500e4e14c2
commit: 43c0e89d85a05475bbbbcddc3533483f0cd032cb [6/24] HID: bpf: allow to change the report descriptor from an eBPF program
config: openrisc-randconfig-r024-20211201 (https://download.01.org/0day-ci/archive/20211202/202112022036.K1SyiDen-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/t-kristo/linux-pm/commit/43c0e89d85a05475bbbbcddc3533483f0cd032cb
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v3-bpf
        git checkout 43c0e89d85a05475bbbbcddc3533483f0cd032cb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: kernel/bpf/syscall.o: in function `bpf_prog_attach':
   syscall.c:(.text+0x2094): undefined reference to `hid_prog_attach'
   syscall.c:(.text+0x2094): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `hid_prog_attach'
   or1k-linux-ld: kernel/bpf/syscall.o: in function `__sys_bpf':
>> syscall.c:(.text+0xad64): undefined reference to `hid_prog_detach'
   syscall.c:(.text+0xad64): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `hid_prog_detach'
>> or1k-linux-ld: syscall.c:(.text+0xaeac): undefined reference to `hid_prog_query'
   syscall.c:(.text+0xaeac): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `hid_prog_query'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
