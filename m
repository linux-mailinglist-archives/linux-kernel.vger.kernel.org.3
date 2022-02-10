Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB74B02E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiBJCAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:00:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiBJB7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC8727D65
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456876; x=1675992876;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CnOSWYoXr4bC9YQTX0CWWYKZDGp0EePO33bXWv9JyVM=;
  b=df7/lccGDX+cDSa0/1HgdMS5xGbjRC0aZKWKQ+t1yS9UK87iEqhXEHaH
   qzZ8xTbqZhmQYWtwfBVwF7n/yoMqkuyBser5yqLGjLaQfxHNKIV5XemHZ
   V0/GZRc3YLX4RkF419VouMV0WhXG1yWYUPPw9Da3mNYOxpPf0P3gpP67a
   51y7i8pP7VFL49SKoBnz/NgSKu1n6QiBV78VqXcU8WOglD8FQgBUd8pf0
   SbNXw26hV77nS9KuFQWu39HvpElnaPKALCPrD0dW0VJix/JFWxtOwO9Gb
   +x17f9la5nO7qM/BK+ZNlOUwdqyWxHB6nCxmrJDIyci+a/v3R2jqVaGu+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="273920855"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="273920855"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="585774824"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2022 16:31:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHxMi-0002Sq-U8; Thu, 10 Feb 2022 00:31:16 +0000
Date:   Thu, 10 Feb 2022 08:30:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:perf/core 16/17] drivers/acpi/acpi_pad.c:168:4: error:
 implicit declaration of function 'perf_lopwr_cb'
Message-ID: <202202100823.E5rjIvVT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
head:   c23483152838201e7eb9d179d121e0ed0189269e
commit: e879a335a574ca071f76684b8160a56d9147db27 [16/17] ACPI: add perf low power callback
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220210/202202100823.E5rjIvVT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=e879a335a574ca071f76684b8160a56d9147db27
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/core
        git checkout e879a335a574ca071f76684b8160a56d9147db27
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/acpi/acpi_pad.c:168:4: error: implicit declaration of function 'perf_lopwr_cb' [-Werror,-Wimplicit-function-declaration]
                           perf_lopwr_cb(true);
                           ^
   1 error generated.


vim +/perf_lopwr_cb +168 drivers/acpi/acpi_pad.c

   135	
   136	static unsigned int idle_pct = 5; /* percentage */
   137	static unsigned int round_robin_time = 1; /* second */
   138	static int power_saving_thread(void *data)
   139	{
   140		int do_sleep;
   141		unsigned int tsk_index = (unsigned long)data;
   142		u64 last_jiffies = 0;
   143	
   144		sched_set_fifo_low(current);
   145	
   146		while (!kthread_should_stop()) {
   147			unsigned long expire_time;
   148	
   149			/* round robin to cpus */
   150			expire_time = last_jiffies + round_robin_time * HZ;
   151			if (time_before(expire_time, jiffies)) {
   152				last_jiffies = jiffies;
   153				round_robin_cpu(tsk_index);
   154			}
   155	
   156			do_sleep = 0;
   157	
   158			expire_time = jiffies + HZ * (100 - idle_pct) / 100;
   159	
   160			while (!need_resched()) {
   161				if (tsc_detected_unstable && !tsc_marked_unstable) {
   162					/* TSC could halt in idle, so notify users */
   163					mark_tsc_unstable("TSC halts in idle");
   164					tsc_marked_unstable = 1;
   165				}
   166				local_irq_disable();
   167	
 > 168				perf_lopwr_cb(true);
   169	
   170				tick_broadcast_enable();
   171				tick_broadcast_enter();
   172				stop_critical_timings();
   173	
   174				mwait_idle_with_hints(power_saving_mwait_eax, 1);
   175	
   176				start_critical_timings();
   177				tick_broadcast_exit();
   178	
   179				perf_lopwr_cb(false);
   180	
   181				local_irq_enable();
   182	
   183				if (time_before(expire_time, jiffies)) {
   184					do_sleep = 1;
   185					break;
   186				}
   187			}
   188	
   189			/*
   190			 * current sched_rt has threshold for rt task running time.
   191			 * When a rt task uses 95% CPU time, the rt thread will be
   192			 * scheduled out for 5% CPU time to not starve other tasks. But
   193			 * the mechanism only works when all CPUs have RT task running,
   194			 * as if one CPU hasn't RT task, RT task from other CPUs will
   195			 * borrow CPU time from this CPU and cause RT task use > 95%
   196			 * CPU time. To make 'avoid starvation' work, takes a nap here.
   197			 */
   198			if (unlikely(do_sleep))
   199				schedule_timeout_killable(HZ * idle_pct / 100);
   200	
   201			/* If an external event has set the need_resched flag, then
   202			 * we need to deal with it, or this loop will continue to
   203			 * spin without calling __mwait().
   204			 */
   205			if (unlikely(need_resched()))
   206				schedule();
   207		}
   208	
   209		exit_round_robin(tsk_index);
   210		return 0;
   211	}
   212	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
