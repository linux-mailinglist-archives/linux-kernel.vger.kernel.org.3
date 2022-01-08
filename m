Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3EA4882D5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 10:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiAHJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 04:32:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:22393 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbiAHJcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 04:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641634371; x=1673170371;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TWEkWPHLX2IJoddB7iNldtAD+V2GysZca6V/7YMEAWY=;
  b=B7teS4sWT3eng3xxGtT6k/O1X2g7jx/dZ0Xdq83FjJqMzvNjwNnaJinN
   Udy35vwp2Q+lotQBCnl5xTnb2BNxTJg+q8VEh98VGAJ+2a84Sr3BSpscl
   gPr/pY/rstWu9moEwfjGcpwAQ11Qwx+4UqiupZYTNTcXZ0vZZ++FZVeaE
   pkhuaxQjt4zp8mBq5tC7AMX9omCI/SdZweG3T/MLplLIkiVc4w19Sem+8
   7cBv7EInMInj2MgAndtZpndTETh7fr1uCgkOlU4p/+78e9qnAQP25H5Ci
   CZ9Sp6LSgWloG/85uhQVINB6f2PRXPIWYoQNAwNbzByHwtfFHKkzmxD2Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="222989086"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="222989086"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 01:32:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="622190250"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2022 01:32:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n685h-0000TH-F2; Sat, 08 Jan 2022 09:32:49 +0000
Date:   Sat, 8 Jan 2022 17:32:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.16.y-rt-rebase 102/127]
 kernel/locking/spinlock.c:306:9: error: implicit declaration of function
 '__raw_write_lock_nested'; did you mean '_raw_write_lock_nested'?
Message-ID: <202201081743.6XKFffqI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt-rebase
head:   a6be65cb880860db356744acca5d49bf43ac0e94
commit: a80864a2a62f4fc6fd4061092d0996ef870d7a9d [102/127] locking/rwlocks: introduce write_lock_nested
config: sparc64-randconfig-p002-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081743.6XKFffqI-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=a80864a2a62f4fc6fd4061092d0996ef870d7a9d
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.16.y-rt-rebase
        git checkout a80864a2a62f4fc6fd4061092d0996ef870d7a9d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

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
