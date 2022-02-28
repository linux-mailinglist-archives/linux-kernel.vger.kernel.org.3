Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB46E4C6022
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiB1Agd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1Agb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:36:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342EE33898
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 16:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646008553; x=1677544553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ju/ahSvh3V63osNQufDEa/Zwmy86Fj+p0AVW8P94SfY=;
  b=Vckf1RwNxkV5cz2egR1VQG+PC3b8j6rEsjmlXTUpPdUOSSZ+pF9KQExC
   DUn5NcYaWSQWsK2Q4WuCu44+3jUzW22CMUdorkcBWdK5Yyj0jQh1O+rxQ
   Hy+pLfy7LV5+GruhOql3HDB2C558Esn1Hb9LGpZhLv7aX6JIENwFpjysN
   6OQtNeGFnUAZcJdN6lBWxFo6l07NQWirWRHzU2XlXUhS1EtgUk8o9u/yq
   BRPU7ihjXM0naN6ghmYl+XmhwUs7fpC0Href7lYF8cI+pth/VFinp5R7e
   IM/WHdd9iDwXhafyhG+Z6babW7Dtw8l5gt3gbtcH7LI072x8cF3GvQmiG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="252698950"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="252698950"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 16:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="640715463"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2022 16:35:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOU0v-0006tS-2Z; Mon, 28 Feb 2022 00:35:45 +0000
Date:   Mon, 28 Feb 2022 08:34:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-de:wip/uclamp_util_cap 1/2] kernel/sched/fair.c:8262:19: error:
 too few arguments to function 'update_cfs_rq_load_avg'
Message-ID: <202202280821.7AOCORMK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.gitlab.arm.com/linux-arm/linux-de.git wip/uclamp_util_cap
head:   df7ef1cab37eca401198f547fd206c7c180fdac5
commit: adad7d47ad753ee91ed6c61c55a3a078031d99c3 [1/2] sched/fair, pelt: Force rng se/cfs_rq to !rng if se's util_avg>=uclamp_max for tasks
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220228/202202280821.7AOCORMK-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add arm-de https://git.gitlab.arm.com/linux-arm/linux-de.git
        git fetch --no-tags arm-de wip/uclamp_util_cap
        git checkout adad7d47ad753ee91ed6c61c55a3a078031d99c3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c:5514:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5514 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function '__update_blocked_fair':
>> kernel/sched/fair.c:8262:19: error: too few arguments to function 'update_cfs_rq_load_avg'
    8262 |         decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:3698:1: note: declared here
    3698 | update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq, int running)
         | ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:11742:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11742 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11744:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11744 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11749:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11749 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11751:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11751 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/update_cfs_rq_load_avg +8262 kernel/sched/fair.c

9763b67fb9f305 kernel/sched_fair.c Peter Zijlstra   2011-07-13  8247  
367456c756a6b8 kernel/sched/fair.c Peter Zijlstra   2012-02-20  8248  static unsigned long task_h_load(struct task_struct *p)
230059de77a4e0 kernel/sched_fair.c Peter Zijlstra   2009-12-17  8249  {
367456c756a6b8 kernel/sched/fair.c Peter Zijlstra   2012-02-20  8250  	struct cfs_rq *cfs_rq = task_cfs_rq(p);
230059de77a4e0 kernel/sched_fair.c Peter Zijlstra   2009-12-17  8251  
685207963be973 kernel/sched/fair.c Vladimir Davydov 2013-07-15  8252  	update_cfs_rq_h_load(cfs_rq);
9d89c257dfb9c5 kernel/sched/fair.c Yuyang Du        2015-07-15  8253  	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
7ea241afbf4924 kernel/sched/fair.c Yuyang Du        2015-07-15  8254  			cfs_rq_load_avg(cfs_rq) + 1);
230059de77a4e0 kernel/sched_fair.c Peter Zijlstra   2009-12-17  8255  }
230059de77a4e0 kernel/sched_fair.c Peter Zijlstra   2009-12-17  8256  #else
bef69dd87828ef kernel/sched/fair.c Vincent Guittot  2019-11-18  8257  static bool __update_blocked_fair(struct rq *rq, bool *done)
9e3081ca61147b kernel/sched_fair.c Peter Zijlstra   2010-11-15  8258  {
6c1d47c0827304 kernel/sched/fair.c Vincent Guittot  2015-07-15  8259  	struct cfs_rq *cfs_rq = &rq->cfs;
bef69dd87828ef kernel/sched/fair.c Vincent Guittot  2019-11-18  8260  	bool decayed;
b90f7c9d2198d7 kernel/sched/fair.c Vincent Guittot  2019-10-30  8261  
bef69dd87828ef kernel/sched/fair.c Vincent Guittot  2019-11-18 @8262  	decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
bef69dd87828ef kernel/sched/fair.c Vincent Guittot  2019-11-18  8263  	if (cfs_rq_has_blocked(cfs_rq))
bef69dd87828ef kernel/sched/fair.c Vincent Guittot  2019-11-18  8264  		*done = false;
b90f7c9d2198d7 kernel/sched/fair.c Vincent Guittot  2019-10-30  8265  
bef69dd87828ef kernel/sched/fair.c Vincent Guittot  2019-11-18  8266  	return decayed;
9e3081ca61147b kernel/sched_fair.c Peter Zijlstra   2010-11-15  8267  }
9e3081ca61147b kernel/sched_fair.c Peter Zijlstra   2010-11-15  8268  

:::::: The code at line 8262 was first introduced by commit
:::::: bef69dd87828ef5d8ecdab8d857cd3a33cf98675 sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()

:::::: TO: Vincent Guittot <vincent.guittot@linaro.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
