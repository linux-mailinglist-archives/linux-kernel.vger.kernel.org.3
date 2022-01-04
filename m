Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF612484A9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiADWWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:22:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:7062 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232763AbiADWWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641334937; x=1672870937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=doiUaCtmxcEJGCQ9a67B0IGilBF15/RhKNjWrGFLzxE=;
  b=iEjIDtDE6F+Xhp5XO7XhgB5jBs5QN5EzJE/ZGmNZghLZlcfNLRVBIgbH
   oICA+arefH0ys28U7Eg40uxM8iLG/2if7KeIWR1zqoGszI8NYKTyVJWoU
   N2pcnfTs5VVlwrCkVz+BAzSfBcsKU6fOUi+DiNDo2Mi8Ogl2Julg+plp8
   R2ymZvS7XhNtYCDqTPn423Nt2wUZEb9yjhUz2NrIRaiu9i1QNbWuedBtY
   Eij6jCYiHAVIw+nEfVcvcRhDXyaL6H10aAMTIyj2LHhOSZu2D13n7blqb
   0QRaD2ygb0JgHbhdZVPSKX52s4uAE2qvE5wVCfqm8cOqK7a2QdzjRLw1M
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242107765"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242107765"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 14:22:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="556311969"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2022 14:22:15 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4sC7-000Fwb-22; Tue, 04 Jan 2022 22:22:15 +0000
Date:   Wed, 5 Jan 2022 06:21:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.self 2/2] arch/x86/events/core.c:2735:13:
 error: use of undeclared identifier 'userpf'; did you mean 'userpg'?
Message-ID: <202201050624.8a9rNBhb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.self
head:   63964461fc720e883340d53a8e19345a8c2d243d
commit: 63964461fc720e883340d53a8e19345a8c2d243d [2/2] perf: Better track self-monitoring events
config: x86_64-randconfig-c007-20211228 (https://download.01.org/0day-ci/archive/20220105/202201050624.8a9rNBhb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=63964461fc720e883340d53a8e19345a8c2d243d
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.self
        git checkout 63964461fc720e883340d53a8e19345a8c2d243d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/events/core.c:2735:13: error: use of undeclared identifier 'userpf'; did you mean 'userpg'?
           if (likely(userpf->cap_user_time))
                      ^~~~~~
                      userpg
   include/linux/compiler.h:77:40: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                                               ^
   arch/x86/events/core.c:2720:40: note: 'userpg' declared here
                                  struct perf_event_mmap_page *userpg, u64 now)
                                                               ^
   1 error generated.


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
