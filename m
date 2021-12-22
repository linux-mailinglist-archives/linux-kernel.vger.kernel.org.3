Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506BD47CFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbhLVKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:17:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:58682 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234441AbhLVKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640168263; x=1671704263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=epYEwYOZgIPJXASGul5ZHxymCUvH/Gw2nSb6TlgYV/8=;
  b=b8qeTPXlIVMmrn43ipwvOy0r4Yz5sY5lz4/bman444tzSOA4n3s8UcGF
   cdPFL3469cjVBoincpR8dFxot5ht6ugaY4fUezvxNrXmGcCrqirr7K6Va
   C/M/1VamgWwZ0AKFg+g/5q88FZ4z23ThMsitEfYPSW5Qy8h9Fq4U61dmx
   aWw5wCGQEMcUdJ61LMU/zM4dGBYHiWnsrcjmrEUKWgBhgk+3X81r0Lkzp
   wa8NVCSTluujfYtZ3jzJIe8nzkG7sNu3tJRun/MpTarHsI4rC+0Hr3n8h
   2eC69uVzvgP2rp/gTF5962sKDutCYVJnhNIzEA0+U0tG1/rj2nvajrkbD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240544081"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240544081"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 02:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="617088377"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2021 02:17:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzygl-0000LT-8G; Wed, 22 Dec 2021 10:17:39 +0000
Date:   Wed, 22 Dec 2021 18:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/time/hrtimer.c:276:20: warning: unused function
 'is_migration_base'
Message-ID: <202112221841.gfrIYr9j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
commit: 81d741d3460ca422843ce0ec8351083f259c6166 hrtimer: Avoid unnecessary SMP function calls in clock_was_set()
date:   4 months ago
config: mips-buildonly-randconfig-r003-20211222 (https://download.01.org/0day-ci/archive/20211222/202112221841.gfrIYr9j-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81d741d3460ca422843ce0ec8351083f259c6166
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 81d741d3460ca422843ce0ec8351083f259c6166
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/ kernel/time/ sound/pci/hda/

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
>> kernel/time/hrtimer.c:276:20: warning: unused function 'is_migration_base'
   static inline bool is_migration_base(struct hrtimer_clock_base
   ^
>> kernel/time/hrtimer.c:1816:20: warning: unused function '__hrtimer_peek_ahead_timers'
   static inline void __hrtimer_peek_ahead_timers(void)
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
   clang version 14.0.0 (git://gitmirror/llvm_project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-de4e0195ae/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers fs include kernel mm nr_bisected scripts sound source usr


vim +/is_migration_base +276 kernel/time/hrtimer.c

c0a3132963db68 kernel/hrtimer.c      Thomas Gleixner           2006-01-09  275  
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04 @276  static inline bool is_migration_base(struct hrtimer_clock_base *base)
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  277  {
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  278  	return false;
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  279  }
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  280  

:::::: The code at line 276 was first introduced by commit
:::::: 5d2295f3a93b04986d069ebeaf5b07725f9096c1 hrtimer: Add a missing bracket and hide `migration_base' on !SMP

:::::: TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
