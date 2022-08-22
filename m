Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8659CA43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiHVUmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHVUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:42:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DD653D2B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661200929; x=1692736929;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p2YWaAsDyeWZyoASTFcbiEUdWVACU1m2FDHcZFxqE1A=;
  b=LYVQbynEVLLHno7q3gj+g+QAC58CNcBZN+ERuAvCZ3sGQdSyTNR3h1VO
   NJlZnV0Swd1Fe/rZU0lmJclJm/7ZxNZQo0DiekPH0JfMz3uiTEfQOrrlU
   pcE85kFimVWHH7ZDwMmgm6AkbbCuQMKYVn+fSenjeTk/wvMaTXoc6sLhd
   blfdJ6RahKiihkxsIDyiS+S3sRcywzlSnG4QJOvKqMFuM3Yymn4p5e6LP
   /3plCzSQPs72CMPPrMA3D8dyqyqSytSMcQtVGAN2GnNmjoL4HpsAPmdzf
   pGwc3zxMgLMGfivl9yQlKCozOzjrTqNauHNFXnMrGKVuMUO911L8SWqti
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="292258859"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="292258859"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="559892309"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2022 13:42:08 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQEFL-0000iB-1K;
        Mon, 22 Aug 2022 20:42:07 +0000
Date:   Tue, 23 Aug 2022 04:41:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 5/5] kernel/events/core.c:846:17:
 error: continue statement not within a loop
Message-ID: <202208230433.6XItjKD5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   596b8cc92a97fa8defbff896dc9baedef441b983
commit: 596b8cc92a97fa8defbff896dc9baedef441b983 [5/5] Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220823/202208230433.6XItjKD5-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=596b8cc92a97fa8defbff896dc9baedef441b983
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout 596b8cc92a97fa8defbff896dc9baedef441b983
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/events/core.c: In function 'perf_cgroup_switch':
>> kernel/events/core.c:846:17: error: continue statement not within a loop
     846 |                 continue;
         |                 ^~~~~~~~
   kernel/events/core.c:840:23: warning: unused variable 'flags' [-Wunused-variable]
     840 |         unsigned long flags;
         |                       ^~~~~
   kernel/events/core.c:839:27: warning: unused variable 'list' [-Wunused-variable]
     839 |         struct list_head *list;
         |                           ^~~~
   kernel/events/core.c: In function 'perf_rotate_context':
   kernel/events/core.c:4220:36: warning: variable 'task_ctx' set but not used [-Wunused-but-set-variable]
    4220 |         struct perf_event_context *task_ctx = NULL;
         |                                    ^~~~~~~~
   kernel/events/core.c: At top level:
   kernel/events/core.c:4790:1: warning: no previous prototype for 'find_get_pmu_context' [-Wmissing-prototypes]
    4790 | find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
         | ^~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c: In function 'perf_event_set_output':
   kernel/events/core.c:12029:9: error: implicit declaration of function 'mutex_lock_double'; did you mean 'mutex_lock_killable'? [-Werror=implicit-function-declaration]
   12029 |         mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
         |         ^~~~~~~~~~~~~~~~~
         |         mutex_lock_killable
   cc1: some warnings being treated as errors


vim +846 kernel/events/core.c

e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  831  
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  832  /*
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  833   * reschedule events based on the cgroup constraint of task.
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  834   */
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  835  static void perf_cgroup_switch(struct task_struct *task)
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  836  {
596b8cc92a97fa kernel/events/core.c Peter Zijlstra          2022-06-15  837  	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  838  	struct perf_cgroup *cgrp;
058fe1c0440e68 kernel/events/core.c David Carrillo-Cisneros 2017-01-18  839  	struct list_head *list;
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  840  	unsigned long flags;
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  841  
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  842  	cgrp = perf_cgroup_from_task(task, NULL);
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  843  
058fe1c0440e68 kernel/events/core.c David Carrillo-Cisneros 2017-01-18  844  	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  845  	if (READ_ONCE(cpuctx->cgrp) == cgrp)
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29 @846  		continue;
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  847  
facc43071cc0d4 kernel/events/core.c Peter Zijlstra          2011-04-09  848  	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
6a606214738273 kernel/events/core.c Peter Zijlstra          2022-01-13  849  	perf_ctx_disable(&cpuctx->ctx);
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  850  
6a606214738273 kernel/events/core.c Peter Zijlstra          2022-01-13  851  	ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  852  	/*
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  853  	 * must not be done before ctxswout due
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  854  	 * to update_cgrp_time_from_cpuctx() in
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  855  	 * ctx_sched_out()
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  856  	 */
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  857  	cpuctx->cgrp = cgrp;
95cf59ea72331d kernel/events/core.c Peter Zijlstra          2012-10-02  858  	/*
95cf59ea72331d kernel/events/core.c Peter Zijlstra          2012-10-02  859  	 * set cgrp before ctxsw in to allow
a0827713e298d0 kernel/events/core.c Chengming Zhou          2022-03-29  860  	 * perf_cgroup_set_timestamp() in ctx_sched_in()
a0827713e298d0 kernel/events/core.c Chengming Zhou          2022-03-29  861  	 * to not have to pass task around
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  862  	 */
6a606214738273 kernel/events/core.c Peter Zijlstra          2022-01-13  863  	ctx_sched_in(&cpuctx->ctx, EVENT_ALL);
96492a6c558acb kernel/events/core.c Chengming Zhou          2022-03-29  864  
6a606214738273 kernel/events/core.c Peter Zijlstra          2022-01-13  865  	perf_ctx_enable(&cpuctx->ctx);
facc43071cc0d4 kernel/events/core.c Peter Zijlstra          2011-04-09  866  	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
facc43071cc0d4 kernel/events/core.c Peter Zijlstra          2011-04-09  867  }
e5d1367f17ba6a kernel/perf_event.c  Stephane Eranian        2011-02-14  868  

:::::: The code at line 846 was first introduced by commit
:::::: 96492a6c558acb56124844d1409d9ef8624a0322 perf/core: Fix perf_cgroup_switch()

:::::: TO: Chengming Zhou <zhouchengming@bytedance.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
