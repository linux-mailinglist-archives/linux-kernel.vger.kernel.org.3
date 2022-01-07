Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D305487E08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiAGVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:10:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:63950 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbiAGVKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641589817; x=1673125817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZiH5XvkEy3rBJJsprYg7YQRVNMcngBzBe3wm7GQ5srs=;
  b=n6joSYsCUl+537gUoT3YUx76/Rt1WNLluMQnXXQ0zzz1H3FH7439kQRM
   b61z8xVgz2tcYhLWmGPIpui0FvVhYjvZpF8Q50OvlMk+2yV15DOtYGZ+8
   8vaJ/Bb1Tc4a/AO6SOlxkqqpM+6MtUkOLAK5VMX7Fpr9/rtx8nA94bYlC
   SBYpfQIqqJQpa+AB3Y8S7cixBOWKHAV8fL3H74W2ojWEBQ4BJlOi48Zp6
   OAAL9Pce8uyFSTvLIUhL5tK59giTCXLzJ74I8DuBxLHFnb92hiM9wyKec
   V3rxKTwsz4JKuHxO+WvAQjxVneKSCwuFD+tyd37tauIWOuHdu3uBwf1qJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="229749672"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="229749672"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:10:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="622064024"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 13:10:16 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5wV5-000J2d-Ev; Fri, 07 Jan 2022 21:10:15 +0000
Date:   Sat, 8 Jan 2022 05:10:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 625/2372]
 include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No
 such file or directory
Message-ID: <202201080531.7YdO04Xs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: 625b17b2e0d914f895af230aeab06adad7f70223 [625/2372] headers/deps: Add header dependencies to .h files: <asm/vdso/processor.h>
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220108/202201080531.7YdO04Xs-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=625b17b2e0d914f895af230aeab06adad7f70223
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 625b17b2e0d914f895af230aeab06adad7f70223
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arc/Makefile:26: ** WARNING ** CONFIG_ARC_TUNE_MCPU flag '' is unknown, fallback to ''
   In file included from arch/arc/include/asm/barrier.h:42,
                    from arch/arc/include/asm/cmpxchg.h:12,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:28,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No such file or directory
      16 | #include <asm/vdso/processor.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +16 include/asm-generic/barrier.h

    15	
  > 16	#include <asm/vdso/processor.h>
    17	#include <linux/compiler.h>
    18	#include <asm/rwonce.h>
    19	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
