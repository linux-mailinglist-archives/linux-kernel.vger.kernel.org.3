Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAA47D758
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhLVTCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:02:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:56401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237491AbhLVTCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640199721; x=1671735721;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r1b9aec9Gp4yxPGV28oJr1G3XkqEDFyXyN1xagHO+YQ=;
  b=J6k65CaYNREfXmOA6J0HvH+zI+DJiZoGwlS9z8Y9fPwaeBaZw2RNFavq
   2+AJdFlZJRh8zvtjnO3zHx4Sllos6WWKjh6kN0exzzKi/rkRDcBMV+l6y
   TDVzv4DYl3TEdT7wYZT79kFLNqw6UjQ+MoYk3ke8nPKD5dSda0shTrqhZ
   cfoID8kywHk4Gqi4hwsX1RYclYDg1EgAOjepb+R+uoOT3ndv0B3lYuW2R
   MgGEeTnkiVwqQTV+TWxaWJlk9h55DBGKZi70AxyJM/Cp0J6yMWr2H+8tG
   1YuTbaRgCnzbBR6hv/RVTr6/opKqABVEmJSS4CATNqW9D/myx3G1mn7Zm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="264894107"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="264894107"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 11:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="508587967"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Dec 2021 11:01:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n06sB-0000sD-4w; Wed, 22 Dec 2021 19:01:59 +0000
Date:   Thu, 23 Dec 2021 03:01:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.16.y-rt-rebase 99/124]
 kernel/locking/spinlock.c:306:9: error: implicit declaration of function
 '__raw_write_lock_nested'; did you mean '_raw_write_lock_nested'?
Message-ID: <202112230216.tS6rkbvk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt-rebase
head:   0e8d33fab0ec59ef16f32af185ba16d93b772adf
commit: c2196e27f8ef1eaff63a3b1783bf5ebab043d898 [99/124] locking/rwlocks: introduce write_lock_nested
config: nds32-randconfig-r036-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230216.tS6rkbvk-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=c2196e27f8ef1eaff63a3b1783bf5ebab043d898
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.16.y-rt-rebase
        git checkout c2196e27f8ef1eaff63a3b1783bf5ebab043d898
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash kernel/locking/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
      68 | void __lockfunc __raw_##op##_lock(locktype##_t *lock)                   \
         |                 ^~~~~~
   kernel/locking/spinlock.c:126:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     126 | BUILD_LOCK_OPS(spin, raw_spinlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
      80 | unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)  \
         |                          ^~~~~~
   kernel/locking/spinlock.c:126:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     126 | BUILD_LOCK_OPS(spin, raw_spinlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
      98 | void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)               \
         |                 ^~~~~~
   kernel/locking/spinlock.c:126:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     126 | BUILD_LOCK_OPS(spin, raw_spinlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
     103 | void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)                \
         |                 ^~~~~~
   kernel/locking/spinlock.c:126:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     126 | BUILD_LOCK_OPS(spin, raw_spinlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
      68 | void __lockfunc __raw_##op##_lock(locktype##_t *lock)                   \
         |                 ^~~~~~
   kernel/locking/spinlock.c:129:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     129 | BUILD_LOCK_OPS(read, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
      80 | unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)  \
         |                          ^~~~~~
   kernel/locking/spinlock.c:129:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     129 | BUILD_LOCK_OPS(read, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
      98 | void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)               \
         |                 ^~~~~~
   kernel/locking/spinlock.c:129:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     129 | BUILD_LOCK_OPS(read, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
     103 | void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)                \
         |                 ^~~~~~
   kernel/locking/spinlock.c:129:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     129 | BUILD_LOCK_OPS(read, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
      68 | void __lockfunc __raw_##op##_lock(locktype##_t *lock)                   \
         |                 ^~~~~~
   kernel/locking/spinlock.c:130:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     130 | BUILD_LOCK_OPS(write, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
      80 | unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)  \
         |                          ^~~~~~
   kernel/locking/spinlock.c:130:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     130 | BUILD_LOCK_OPS(write, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
      98 | void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)               \
         |                 ^~~~~~
   kernel/locking/spinlock.c:130:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     130 | BUILD_LOCK_OPS(write, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]
     103 | void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)                \
         |                 ^~~~~~
   kernel/locking/spinlock.c:130:1: note: in expansion of macro 'BUILD_LOCK_OPS'
     130 | BUILD_LOCK_OPS(write, rwlock);
         | ^~~~~~~~~~~~~~
   kernel/locking/spinlock.c: In function '_raw_write_lock_nested':
>> kernel/locking/spinlock.c:306:9: error: implicit declaration of function '__raw_write_lock_nested'; did you mean '_raw_write_lock_nested'? [-Werror=implicit-function-declaration]
     306 |         __raw_write_lock_nested(lock, subclass);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         _raw_write_lock_nested
   cc1: some warnings being treated as errors


vim +306 kernel/locking/spinlock.c

   303	
   304	void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)
   305	{
 > 306		__raw_write_lock_nested(lock, subclass);
   307	}
   308	EXPORT_SYMBOL(_raw_write_lock_nested);
   309	#endif
   310	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
