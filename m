Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EA248E418
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiANGMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:12:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:37965 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239297AbiANGMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642140750; x=1673676750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iH2bAUjpJnt2I7vkj9k8oAio1FRAu/W0AFiLzFSvBWA=;
  b=gIY55ZRFKbs6BNXDf4JKGEvPHVpr75jKqHLCs7iWydabcp3RycvqNioW
   s39n6yPtDJ7yOhNEc3WC/yPgFNIDzTO4S9FDOxkcIyy1v/awtxGLKDkh6
   sBgay2tsiPq4L3sSZDl3s6+K2vLu1u8CR027bHKxvZ+6bb5uO3mHz09U6
   WUvfJf0S9WeWwQi0OsJ+RaTxLtTnAe8TibE+HWJ4OdHQapCy4tGKcgHnE
   xy4zt/zsOdjYqt7q0ydjLPc6qLwS//vdD8bj1m3/L+Noes3BvEU211SbM
   C74aHXZa/MWnv6IhNWFZtG6XJuQZsFbD96lbrEVzGrfsgMYMF28fUefSb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="304922756"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="304922756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 22:12:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="614241326"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jan 2022 22:12:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Fp5-0008Ba-HV; Fri, 14 Jan 2022 06:12:27 +0000
Date:   Fri, 14 Jan 2022 14:12:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: kernel/time/hrtimer.c:650:19: warning: unused function
 'hrtimer_hres_active'
Message-ID: <202201141442.FVgxOEDt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb3b0673b7d5b477ed104949450cd511337ba3c6
commit: 9482fd71dbb8f0d1a61821a83e467dc0a9d7b429 hrtimer: Use raw_cpu_ptr() in clock_was_set()
date:   5 months ago
config: mips-randconfig-r032-20220114 (https://download.01.org/0day-ci/archive/20220114/202201141442.FVgxOEDt-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82c8aca93488730ce8f66101e0f3538f14b551dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   kernel/time/hrtimer.c:276:20: warning: unused function 'is_migration_base'
   static inline bool is_migration_base(struct hrtimer_clock_base
   ^
>> kernel/time/hrtimer.c:650:19: warning: unused function 'hrtimer_hres_active'
   static inline int hrtimer_hres_active(void)
   ^
   kernel/time/hrtimer.c:1887:20: warning: unused function '__hrtimer_peek_ahead_timers'
   static inline void __hrtimer_peek_ahead_timers(void) { }
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 105, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 82c8aca93488730ce8f66101e0f3538f14b551dd)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-82c8aca934/bin
   clang-14: note: diagnostic msg:
   Makefile arch include kernel nr_bisected scripts source usr


vim +/hrtimer_hres_active +650 kernel/time/hrtimer.c

28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  649  
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21 @650  static inline int hrtimer_hres_active(void)
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  651  {
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  652  	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  653  }
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  654  

:::::: The code at line 650 was first introduced by commit
:::::: 28bfd18bf3daa5db8bb3422ea7138c8b7d2444ac hrtimer: Make the hrtimer_cpu_base::hres_active field unconditional, to simplify the code

:::::: TO: Anna-Maria Gleixner <anna-maria@linutronix.de>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
