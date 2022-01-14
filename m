Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD248F21E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiANVth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:49:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:43105 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbiANVta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642196970; x=1673732970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=itffkzDe+Il4JzFZB2Jw4OTWUo631sKz/op75lSih44=;
  b=Tdxb7IkDO8w1JJ7+aefCZ8gwtiSP5cBfKRSqT1J/Nlyn3FE6J2qWGOdm
   7HuiC1BdLlWatmOp6dGbmCQDiD6JEOlsfJ/+ZFyDc3501d3Spc9aqPr5k
   BiY6FNrVTfJNM0K64RYZCkPvRwOcQO6mcqiPiBpEHiW+D3xkcx2aUlUUj
   jUxRjiaEuYJI4kTAkVOkj/4TWyFLnEYxvvYfcmBPHAAFiE93Q9Ij1Q58G
   nrwCw1KF19uL5oWWiF53onlY0RX3qQ4CL82B81jA2I7iAQ+GdShxiz2KM
   uEfS+jABkA48pL0Bm+HieBw9iVbNaqoqUWcWo78RP2aG9z7L/HZ3DeHa6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="231686621"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="231686621"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 13:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="559623948"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2022 13:49:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8URr-00092F-VM; Fri, 14 Jan 2022 21:49:27 +0000
Date:   Sat, 15 Jan 2022 05:48:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.self 9/9] arch/x86/events/core.c:2725:48:
 error: 'PERF_X86_EVENT_RDPMC_ALLOWED' undeclared; did you mean
 'PERF_X86_EVENT_AUTO_RELOAD'?
Message-ID: <202201150505.POFRV19D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.self
head:   1b4635e33f629e20b5bbecd62d27c9191d5ec390
commit: 1b4635e33f629e20b5bbecd62d27c9191d5ec390 [9/9] perf: Better track self-monitoring events
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220115/202201150505.POFRV19D-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=1b4635e33f629e20b5bbecd62d27c9191d5ec390
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.self
        git checkout 1b4635e33f629e20b5bbecd62d27c9191d5ec390
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/events/core.c: In function 'arch_perf_update_userpage':
>> arch/x86/events/core.c:2725:48: error: 'PERF_X86_EVENT_RDPMC_ALLOWED' undeclared (first use in this function); did you mean 'PERF_X86_EVENT_AUTO_RELOAD'?
    2725 |  userpg->cap_user_rdpmc = !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                PERF_X86_EVENT_AUTO_RELOAD
   arch/x86/events/core.c:2725:48: note: each undeclared identifier is reported only once for each function it appears in


vim +2725 arch/x86/events/core.c

  2718	
  2719	void arch_perf_update_userpage(struct perf_event *event,
  2720				       struct perf_event_mmap_page *userpg, u64 now)
  2721	{
  2722		struct cyc2ns_data data;
  2723		u64 offset;
  2724	
> 2725		userpg->cap_user_rdpmc = !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
  2726		userpg->pmc_width = x86_pmu.cntval_bits;
  2727	
  2728		if (unlikely(!using_native_sched_clock() || !sched_clock_stable())) {
  2729			userpg->cap_user_time = 0;
  2730			userpg->cap_user_time_zero = 0;
  2731			return;
  2732		}
  2733	
  2734		/* already set the time fields before */
  2735		if (likely(userpg->cap_user_time))
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
