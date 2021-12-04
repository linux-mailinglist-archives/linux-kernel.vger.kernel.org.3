Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC84683FC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350265AbhLDKZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:25:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:42545 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344782AbhLDKZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:25:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217133918"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="217133918"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 02:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="562047147"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2021 02:21:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtSAs-000IrZ-FK; Sat, 04 Dec 2021 10:21:46 +0000
Date:   Sat, 4 Dec 2021 18:20:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     yongw.pur@gmail.com, bsingharora@gmail.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn
Subject: Re: [PATCH linux-next] delayacct: track delays from memory compact
Message-ID: <202112041804.vsvLifnA-lkp@intel.com>
References: <1638542272-15187-1-git-send-email-wang.yong12@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638542272-15187-1-git-send-email-wang.yong12@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20211203]

url:    https://github.com/0day-ci/linux/commits/yongw-pur-gmail-com/delayacct-track-delays-from-memory-compact/20211203-224016
base:    7afeac307a9561e3a93682c1e7eb22f918aa1187
config: x86_64-randconfig-a011-20211203 (https://download.01.org/0day-ci/archive/20211204/202112041804.vsvLifnA-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f1d1854eb1450d352663ee732235893c5782237)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ccd829e34aa6aefecf6428975fa82384c6139fd1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review yongw-pur-gmail-com/delayacct-track-delays-from-memory-compact/20211203-224016
        git checkout ccd829e34aa6aefecf6428975fa82384c6139fd1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from init/main.c:58:
>> include/linux/delayacct.h:48:6: error: duplicate member 'freepages_start'
           u64 freepages_start;
               ^
   include/linux/delayacct.h:39:6: note: previous declaration is here
           u64 freepages_start;
               ^
   init/main.c:783:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:783:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
   1 warning and 1 error generated.
--
   In file included from kernel/delayacct.c:14:
>> include/linux/delayacct.h:48:6: error: duplicate member 'freepages_start'
           u64 freepages_start;
               ^
   include/linux/delayacct.h:39:6: note: previous declaration is here
           u64 freepages_start;
               ^
   1 error generated.
--
   In file included from mm/page_alloc.c:77:
>> include/linux/delayacct.h:48:6: error: duplicate member 'freepages_start'
           u64 freepages_start;
               ^
   include/linux/delayacct.h:39:6: note: previous declaration is here
           u64 freepages_start;
               ^
   mm/page_alloc.c:3820:15: warning: no previous prototype for function 'should_fail_alloc_page' [-Wmissing-prototypes]
   noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
                 ^
   mm/page_alloc.c:3820:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
            ^
            static 
   1 warning and 1 error generated.
--
   In file included from kernel/sched/core.c:13:
   In file included from kernel/sched/sched.h:47:
>> include/linux/delayacct.h:48:6: error: duplicate member 'freepages_start'
           u64 freepages_start;
               ^
   include/linux/delayacct.h:39:6: note: previous declaration is here
           u64 freepages_start;
               ^
   kernel/sched/core.c:3450:6: warning: no previous prototype for function 'sched_set_stop_task' [-Wmissing-prototypes]
   void sched_set_stop_task(int cpu, struct task_struct *stop)
        ^
   kernel/sched/core.c:3450:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sched_set_stop_task(int cpu, struct task_struct *stop)
   ^
   static 
   1 warning and 1 error generated.
--
   In file included from kernel/sched/fair.c:23:
   In file included from kernel/sched/sched.h:47:
>> include/linux/delayacct.h:48:6: error: duplicate member 'freepages_start'
           u64 freepages_start;
               ^
   include/linux/delayacct.h:39:6: note: previous declaration is here
           u64 freepages_start;
               ^
   kernel/sched/fair.c:11094:6: warning: no previous prototype for function 'task_vruntime_update' [-Wmissing-prototypes]
   void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
        ^
   kernel/sched/fair.c:11094:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
   ^
   static 
   1 warning and 1 error generated.
--
   In file included from kernel/sched/rt.c:6:
   In file included from kernel/sched/sched.h:47:
>> include/linux/delayacct.h:48:6: error: duplicate member 'freepages_start'
           u64 freepages_start;
               ^
   include/linux/delayacct.h:39:6: note: previous declaration is here
           u64 freepages_start;
               ^
   kernel/sched/rt.c:675:6: warning: no previous prototype for function 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
        ^
   kernel/sched/rt.c:675:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
   ^
   static 
   1 warning and 1 error generated.


vim +/freepages_start +48 include/linux/delayacct.h

    11	
    12	#ifdef CONFIG_TASK_DELAY_ACCT
    13	struct task_delay_info {
    14		raw_spinlock_t	lock;
    15	
    16		/* For each stat XXX, add following, aligned appropriately
    17		 *
    18		 * struct timespec XXX_start, XXX_end;
    19		 * u64 XXX_delay;
    20		 * u32 XXX_count;
    21		 *
    22		 * Atomicity of updates to XXX_delay, XXX_count protected by
    23		 * single lock above (split into XXX_lock if contention is an issue).
    24		 */
    25	
    26		/*
    27		 * XXX_count is incremented on every XXX operation, the delay
    28		 * associated with the operation is added to XXX_delay.
    29		 * XXX_delay contains the accumulated delay time in nanoseconds.
    30		 */
    31		u64 blkio_start;
    32		u64 blkio_delay;	/* wait for sync block io completion */
    33		u64 swapin_start;
    34		u64 swapin_delay;	/* wait for swapin */
    35		u32 blkio_count;	/* total count of the number of sync block */
    36					/* io operations performed */
    37		u32 swapin_count;	/* total count of swapin */
    38	
    39		u64 freepages_start;
    40		u64 freepages_delay;	/* wait for memory reclaim */
    41	
    42		u64 thrashing_start;
    43		u64 thrashing_delay;	/* wait for thrashing page */
    44	
    45		u64 compact_start;
    46		u64 compact_delay;	/* wait for memory compact */
    47	
  > 48		u64 freepages_start;
    49		u32 freepages_count;	/* total count of memory reclaim */
    50		u32 thrashing_count;	/* total count of thrash waits */
    51		u32 compact_count;	/* total count of memory compact */
    52	};
    53	#endif
    54	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
