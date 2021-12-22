Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0647CF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbhLVJ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:56:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:18957 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231487AbhLVJ4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640167001; x=1671703001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QrewmhUpwejgoHh3cjb0uDzpLJjrv3+OswLbKAsIUsE=;
  b=EezCT2co7LExpmXWtTCobpcW/HpIOsIRmcjcIS9lhR/gddLKZP5XmSzu
   eGYj2cW0583HNnmgnB8RiVZvpreY2CrCe+KyHcOjtroxLDK7eQ8+2G5Nd
   AjBiDzKIE7saRZcob+jg4QwE7fTYb5PvECBiHESbkXEhO/hnQFD6Zgb2K
   D3z/4CfdfZCVA9wWIAkE57C9RRbQWD8EfDETgVfxxBlhESqVqGyOUWfRc
   zyeYZwNjVR2l1Ifgq+eGsP9SFNUwJBWH86Gr4g7Gf/mKN2QK8t/kdl3NZ
   QKG0Nx075yS0+W+cBIKyRy+lu3J6/OAqTQYQuZ9fLUtMSxWtsClodBoCf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="303959257"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="303959257"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="466616759"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 01:56:39 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzyMR-0000Kh-0V; Wed, 22 Dec 2021 09:56:39 +0000
Date:   Wed, 22 Dec 2021 17:56:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.self 2/2] arch/x86/events/core.c:2735:13:
 error: use of undeclared identifier 'userpf'; did you mean 'userpg'?
Message-ID: <202112221712.uiBpvgmY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.self
head:   1e109699c93d9b3d7bedec5f43d852888d035b9d
commit: 1e109699c93d9b3d7bedec5f43d852888d035b9d [2/2] perf: Better track self-monitoring events
config: i386-randconfig-r012-20211222 (https://download.01.org/0day-ci/archive/20211222/202112221712.uiBpvgmY-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=1e109699c93d9b3d7bedec5f43d852888d035b9d
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.self
        git checkout 1e109699c93d9b3d7bedec5f43d852888d035b9d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/events/core.c:2735:13: error: use of undeclared identifier 'userpf'; did you mean 'userpg'?
           if (likely(userpf->cap_user_time))
                      ^~~~~~
                      userpg
   include/linux/compiler.h:45:39: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   arch/x86/events/core.c:2720:40: note: 'userpg' declared here
                                  struct perf_event_mmap_page *userpg, u64 now)
                                                               ^
>> arch/x86/events/core.c:2735:13: error: use of undeclared identifier 'userpf'; did you mean 'userpg'?
           if (likely(userpf->cap_user_time))
                      ^~~~~~
                      userpg
   include/linux/compiler.h:45:66: note: expanded from macro 'likely'
   #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^
   arch/x86/events/core.c:2720:40: note: 'userpg' declared here
                                  struct perf_event_mmap_page *userpg, u64 now)
                                                               ^
   2 errors generated.


vim +2735 arch/x86/events/core.c

  2718	
  2719	void arch_perf_update_userpage(struct perf_event *event,
  2720				       struct perf_event_mmap_page *userpg, u64 now)
  2721	{
  2722		struct cyc2ns_data data;
  2723		u64 offset;
  2724	
  2725		userpg->cap_user_rdpmc = !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
  2726		userpg->pmc_width = x86_pmu.cntval_bits;
  2727	
  2728		if (unlikely(!using_native_sched_clock() || !sched_clock_stable())) {
  2729			userpg->cap_user_time = 0;
  2730			userpg->cap_user_time_zero = 0;
  2731			return;
  2732		}
  2733	
  2734		/* already set the time fields before */
> 2735		if (likely(userpf->cap_user_time))
  2736			return;
  2737	
  2738		cyc2ns_read_begin(&data);
  2739	
  2740		offset = data.cyc2ns_offset + __sched_clock_offset;
  2741	
  2742		/*
  2743		 * Internal timekeeping for enabled/running/stopped times
  2744		 * is always in the local_clock domain.
  2745		 */
  2746		userpg->cap_user_time = 1;
  2747		userpg->time_mult = data.cyc2ns_mul;
  2748		userpg->time_shift = data.cyc2ns_shift;
  2749		userpg->time_offset = offset - now;
  2750	
  2751		/*
  2752		 * cap_user_time_zero doesn't make sense when we're using a different
  2753		 * time base for the records.
  2754		 */
  2755		if (!event->attr.use_clockid) {
  2756			userpg->cap_user_time_zero = 1;
  2757			userpg->time_zero = offset;
  2758		}
  2759	
  2760		cyc2ns_read_end();
  2761	}
  2762	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
