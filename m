Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47D747F5BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 08:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhLZH5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 02:57:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:40719 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhLZH5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 02:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640505459; x=1672041459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NuX6nngFQtTXu7k+vB5zT3o8zKqFbePkKEZ8vk2NqOw=;
  b=X630G/ut1vawLbcStLq7mM33LkScgEfswQ6p6stvGVwQUfbymWQFTM5c
   d4KPX/h5FnnEWEbvnwlYQB/h7XsDcZ+knqFFTAuVgsbLnTCckiQgtGmRe
   /ADnXaRlxvV5z56kyPhxqlC/kG/+QHI5mucZgAszVo9XlGWiADiYltyPg
   L7pWwzrEv1ob9DOl6u+PGRASwHERYY5ZGPh+CNUDdVWY2OyepP03C83OF
   Vo8kvrKAkTBdYbN7/wVqkvo/1wEp+olY2sOxdkenNmQCoeaKJXQvJFxyN
   ndrHsE0dScJRzcnv87ladezi9II0GimXpoiezAtXtnAQQvFjjGBHzvpfV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="228393497"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="228393497"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 23:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="485746919"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Dec 2021 23:57:35 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1OPP-0005DD-5L; Sun, 26 Dec 2021 07:57:35 +0000
Date:   Sun, 26 Dec 2021 15:57:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/irqchip/irq-bcm7038-l1.c:89:28: warning: unused function
 'reg_mask_status'
Message-ID: <202112261532.AJEnMzCL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   438645193e59e91761ccb3fa55f6ce70b615ff93
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   1 year, 3 months ago
config: mips-randconfig-c004-20211226 (https://download.01.org/0day-ci/archive/20211226/202112261532.AJEnMzCL-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 0c553cc1af2e4c14100df6cf4a6fc91987e778e6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash block/ drivers/irqchip/ drivers/scsi/ufs/ kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-bcm7038-l1.c:89:28: warning: unused function 'reg_mask_status'
   static inline unsigned int reg_mask_status(struct bcm7038_l1_chip
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 133, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   and $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 0c553cc1af2e4c14100df6cf4a6fc91987e778e6)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-0c553cc1af/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel mm nr_bisected scripts sound source usr
--
   kernel/time/hrtimer.c:120:21: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_REALTIME,
   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:22: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_MONOTONIC,
   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:21: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_BOOTTIME,
   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:17: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_TAI,
   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:1487:7: warning: variable 'expires_in_hardirq' set but not used
   bool expires_in_hardirq;
   ^
   kernel/time/hrtimer.c:147:20: warning: unused function 'is_migration_base'
   static inline bool is_migration_base(struct hrtimer_clock_base
   ^
>> kernel/time/hrtimer.c:621:19: warning: unused function 'hrtimer_hres_active'
   static inline int hrtimer_hres_active(void)
   ^
   kernel/time/hrtimer.c:1726:20: warning: unused function '__hrtimer_peek_ahead_timers'
   static inline void __hrtimer_peek_ahead_timers(void) { }
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 21, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 0c553cc1af2e4c14100df6cf4a6fc91987e778e6)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-0c553cc1af/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel mm nr_bisected scripts sound source usr


vim +/reg_mask_status +89 drivers/irqchip/irq-bcm7038-l1.c

5f7f0317ed28b8 Kevin Cernekee 2014-12-25  88  
5f7f0317ed28b8 Kevin Cernekee 2014-12-25 @89  static inline unsigned int reg_mask_status(struct bcm7038_l1_chip *intc,
5f7f0317ed28b8 Kevin Cernekee 2014-12-25  90  					   unsigned int word)
5f7f0317ed28b8 Kevin Cernekee 2014-12-25  91  {
5f7f0317ed28b8 Kevin Cernekee 2014-12-25  92  	return (1 * intc->n_words + word) * sizeof(u32);
5f7f0317ed28b8 Kevin Cernekee 2014-12-25  93  }
5f7f0317ed28b8 Kevin Cernekee 2014-12-25  94  

:::::: The code at line 89 was first introduced by commit
:::::: 5f7f0317ed28b86bdae9baf65bb72d405b6f79ee IRQCHIP: Add new driver for BCM7038-style level 1 interrupt controllers

:::::: TO: Kevin Cernekee <cernekee@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
