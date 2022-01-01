Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48EA4826D0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiAAGvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 01:51:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:56822 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbiAAGve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 01:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641019894; x=1672555894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ks9yCcSxMhbRSf8kpAuo58zy3dnJgOysskevQbfxejU=;
  b=bnHreu1btawD6giE25v2PLCb/nIZ5U3vtg0bOZWDe5Umv6gx8pSseirG
   JSHLXwmjHH3AbQkUBD5CoEAklNCAa5HTbgU4Xv3aoWmc8nSbkJkPQ4j1r
   tY++MSFGh/WJ9LEYzLk4iDADxmWzzYMn726XCzsPf7CactD50TjDAqcVQ
   IrEN+Hav0Soi/JQVW098zamMO9C+bpDxd7DvoYSg6EeO/o9RFEw1s9nRN
   kmJDedmrlieLuah7JIGZrmLWcm9L4DlcE+CnP1iMgCFj25y8cWroWH40A
   MT3iTbv7joyMLXHqqfDjhtdgN2vIOJXi5ORzpgtB4EcuWUVv8EvBmcjfW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="239419462"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="239419462"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 22:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="619802063"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2021 22:51:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3YEj-000C8g-S6; Sat, 01 Jan 2022 06:51:29 +0000
Date:   Sat, 1 Jan 2022 14:50:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Scull <ascull@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: arch/arm64/kvm/handle_exit.c:295:24: warning: no previous prototype
 for 'nvhe_hyp_panic_handler'
Message-ID: <202201011459.th7AJ0tn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: aec0fae62e47050019474936248a311a0ab08705 KVM: arm64: Log source when panicking from nVHE hyp
date:   9 months ago
config: arm64-randconfig-r035-20211231 (https://download.01.org/0day-ci/archive/20220101/202201011459.th7AJ0tn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aec0fae62e47050019474936248a311a0ab08705
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aec0fae62e47050019474936248a311a0ab08705
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/handle_exit.c:177:35: warning: initialized field overwritten [-Woverride-init]
     177 |         [ESR_ELx_EC_WFx]        = kvm_handle_wfx,
         |                                   ^~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:177:35: note: (near initialization for 'arm_exit_handlers[1]')
   arch/arm64/kvm/handle_exit.c:178:35: warning: initialized field overwritten [-Woverride-init]
     178 |         [ESR_ELx_EC_CP15_32]    = kvm_handle_cp15_32,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:178:35: note: (near initialization for 'arm_exit_handlers[3]')
   arch/arm64/kvm/handle_exit.c:179:35: warning: initialized field overwritten [-Woverride-init]
     179 |         [ESR_ELx_EC_CP15_64]    = kvm_handle_cp15_64,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:179:35: note: (near initialization for 'arm_exit_handlers[4]')
   arch/arm64/kvm/handle_exit.c:180:35: warning: initialized field overwritten [-Woverride-init]
     180 |         [ESR_ELx_EC_CP14_MR]    = kvm_handle_cp14_32,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:180:35: note: (near initialization for 'arm_exit_handlers[5]')
   arch/arm64/kvm/handle_exit.c:181:35: warning: initialized field overwritten [-Woverride-init]
     181 |         [ESR_ELx_EC_CP14_LS]    = kvm_handle_cp14_load_store,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:181:35: note: (near initialization for 'arm_exit_handlers[6]')
   arch/arm64/kvm/handle_exit.c:182:35: warning: initialized field overwritten [-Woverride-init]
     182 |         [ESR_ELx_EC_CP14_64]    = kvm_handle_cp14_64,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:182:35: note: (near initialization for 'arm_exit_handlers[12]')
   arch/arm64/kvm/handle_exit.c:183:35: warning: initialized field overwritten [-Woverride-init]
     183 |         [ESR_ELx_EC_HVC32]      = handle_hvc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:183:35: note: (near initialization for 'arm_exit_handlers[18]')
   arch/arm64/kvm/handle_exit.c:184:35: warning: initialized field overwritten [-Woverride-init]
     184 |         [ESR_ELx_EC_SMC32]      = handle_smc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:184:35: note: (near initialization for 'arm_exit_handlers[19]')
   arch/arm64/kvm/handle_exit.c:185:35: warning: initialized field overwritten [-Woverride-init]
     185 |         [ESR_ELx_EC_HVC64]      = handle_hvc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:185:35: note: (near initialization for 'arm_exit_handlers[22]')
   arch/arm64/kvm/handle_exit.c:186:35: warning: initialized field overwritten [-Woverride-init]
     186 |         [ESR_ELx_EC_SMC64]      = handle_smc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:186:35: note: (near initialization for 'arm_exit_handlers[23]')
   arch/arm64/kvm/handle_exit.c:187:35: warning: initialized field overwritten [-Woverride-init]
     187 |         [ESR_ELx_EC_SYS64]      = kvm_handle_sys_reg,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:187:35: note: (near initialization for 'arm_exit_handlers[24]')
   arch/arm64/kvm/handle_exit.c:188:35: warning: initialized field overwritten [-Woverride-init]
     188 |         [ESR_ELx_EC_SVE]        = handle_sve,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:188:35: note: (near initialization for 'arm_exit_handlers[25]')
   arch/arm64/kvm/handle_exit.c:189:35: warning: initialized field overwritten [-Woverride-init]
     189 |         [ESR_ELx_EC_IABT_LOW]   = kvm_handle_guest_abort,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:189:35: note: (near initialization for 'arm_exit_handlers[32]')
   arch/arm64/kvm/handle_exit.c:190:35: warning: initialized field overwritten [-Woverride-init]
     190 |         [ESR_ELx_EC_DABT_LOW]   = kvm_handle_guest_abort,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:190:35: note: (near initialization for 'arm_exit_handlers[36]')
   arch/arm64/kvm/handle_exit.c:191:35: warning: initialized field overwritten [-Woverride-init]
     191 |         [ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:191:35: note: (near initialization for 'arm_exit_handlers[50]')
   arch/arm64/kvm/handle_exit.c:192:35: warning: initialized field overwritten [-Woverride-init]
     192 |         [ESR_ELx_EC_WATCHPT_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:192:35: note: (near initialization for 'arm_exit_handlers[52]')
   arch/arm64/kvm/handle_exit.c:193:35: warning: initialized field overwritten [-Woverride-init]
     193 |         [ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:193:35: note: (near initialization for 'arm_exit_handlers[48]')
   arch/arm64/kvm/handle_exit.c:194:35: warning: initialized field overwritten [-Woverride-init]
     194 |         [ESR_ELx_EC_BKPT32]     = kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:194:35: note: (near initialization for 'arm_exit_handlers[56]')
   arch/arm64/kvm/handle_exit.c:195:35: warning: initialized field overwritten [-Woverride-init]
     195 |         [ESR_ELx_EC_BRK64]      = kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:195:35: note: (near initialization for 'arm_exit_handlers[60]')
   arch/arm64/kvm/handle_exit.c:196:35: warning: initialized field overwritten [-Woverride-init]
     196 |         [ESR_ELx_EC_FP_ASIMD]   = handle_no_fpsimd,
         |                                   ^~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:196:35: note: (near initialization for 'arm_exit_handlers[7]')
   arch/arm64/kvm/handle_exit.c:197:35: warning: initialized field overwritten [-Woverride-init]
     197 |         [ESR_ELx_EC_PAC]        = kvm_handle_ptrauth,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:197:35: note: (near initialization for 'arm_exit_handlers[9]')
>> arch/arm64/kvm/handle_exit.c:295:24: warning: no previous prototype for 'nvhe_hyp_panic_handler' [-Wmissing-prototypes]
     295 | void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,
         |                        ^~~~~~~~~~~~~~~~~~~~~~


vim +/nvhe_hyp_panic_handler +295 arch/arm64/kvm/handle_exit.c

   294	
 > 295	void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
