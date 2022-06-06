Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFC53E923
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiFFJyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiFFJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:54:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651410C318
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509255; x=1686045255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ArqhG0tRhZZJFq4WwSgG34TjtyH3zA5KNBqIVTUBhy4=;
  b=hvy9iuoXbp648P/+VQWqIheeLkd3rgmuazEqNA90a1U21IVKzadAM2Q/
   NFdLhWfVs6Kw7C1YnuGeJnYP115TmlZBPdFITGJrwEO5RtBzCozyuGoFW
   ZVMqf2gJqwsI0S2ALQ0FaY9JtlKSE1BO4IDnwoo451qxRZ7FHIh4EBqrX
   sfLwsKP9xKOLUW+B2J8l5+WPQ5UlsQm9cagJ9F3OnO3KE4W9Hvg7V3+lN
   rLFjLFkINdZG/gmdvLDcF614VQPrzk3Ul0ZyN6AZQX324138ZTZalfcaC
   300ZQfJifdFQWD5fnraPKF6vBljuJMjMkbpTwF0FvUdSYBcalqGeQACBm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276680726"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276680726"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 02:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825742414"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2022 02:54:12 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny9R6-000CeR-9g;
        Mon, 06 Jun 2022 09:54:12 +0000
Date:   Mon, 6 Jun 2022 17:53:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Chris Redpath <chris.redpath@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: [jsarha:topic/cros-sof-v4.19 290/6555] kernel/sched/tune.c:81:36:
 error: field 'css' has incomplete type
Message-ID: <202206061737.NRzsiDJC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: b0d19c6f6707e0ddcd6bd5a243f67301582eea00 [290/6555] ANDROID: sched: fair/tune: Add schedtune with cgroups interface
config: parisc-randconfig-r009-20220606 (https://download.01.org/0day-ci/archive/20220606/202206061737.NRzsiDJC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/b0d19c6f6707e0ddcd6bd5a243f67301582eea00
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout b0d19c6f6707e0ddcd6bd5a243f67301582eea00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/sched/tune.c:81:36: error: field 'css' has incomplete type
      81 |         struct cgroup_subsys_state css;
         |                                    ^~~
   kernel/sched/tune.c: In function 'task_schedtune':
>> kernel/sched/tune.c:101:23: error: implicit declaration of function 'task_css'; did you mean 'task_cpu'? [-Werror=implicit-function-declaration]
     101 |         return css_st(task_css(tsk, schedtune_cgrp_id));
         |                       ^~~~~~~~
         |                       task_cpu
>> kernel/sched/tune.c:101:37: error: 'schedtune_cgrp_id' undeclared (first use in this function); did you mean 'schedtune_spc_rdiv'?
     101 |         return css_st(task_css(tsk, schedtune_cgrp_id));
         |                                     ^~~~~~~~~~~~~~~~~
         |                                     schedtune_spc_rdiv
   kernel/sched/tune.c:101:37: note: each undeclared identifier is reported only once for each function it appears in
   kernel/sched/tune.c: At top level:
>> kernel/sched/tune.c:290:33: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     290 | int schedtune_can_attach(struct cgroup_taskset *tset)
         |                                 ^~~~~~~~~~~~~~
   kernel/sched/tune.c:290:5: warning: no previous prototype for 'schedtune_can_attach' [-Wmissing-prototypes]
     290 | int schedtune_can_attach(struct cgroup_taskset *tset)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c: In function 'schedtune_can_attach':
>> kernel/sched/tune.c:306:9: error: implicit declaration of function 'cgroup_taskset_for_each' [-Werror=implicit-function-declaration]
     306 |         cgroup_taskset_for_each(task, css, tset) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/tune.c:306:49: error: expected ';' before '{' token
     306 |         cgroup_taskset_for_each(task, css, tset) {
         |                                                 ^~
         |                                                 ;
   kernel/sched/tune.c:300:13: warning: unused variable 'tasks' [-Wunused-variable]
     300 |         int tasks;
         |             ^~~~~
   kernel/sched/tune.c:299:13: warning: unused variable 'dst_bg' [-Wunused-variable]
     299 |         int dst_bg; /* Destination boost group index */
         |             ^~~~~~
   kernel/sched/tune.c:298:13: warning: unused variable 'src_bg' [-Wunused-variable]
     298 |         int src_bg; /* Source boost group index */
         |             ^~~~~~
   kernel/sched/tune.c:297:20: warning: unused variable 'rq' [-Wunused-variable]
     297 |         struct rq *rq;
         |                    ^~
   kernel/sched/tune.c:296:22: warning: unused variable 'cpu' [-Wunused-variable]
     296 |         unsigned int cpu;
         |                      ^~~
   kernel/sched/tune.c:295:25: warning: unused variable 'rq_flags' [-Wunused-variable]
     295 |         struct rq_flags rq_flags;
         |                         ^~~~~~~~
   kernel/sched/tune.c:294:30: warning: unused variable 'bg' [-Wunused-variable]
     294 |         struct boost_groups *bg;
         |                              ^~
   kernel/sched/tune.c: At top level:
   kernel/sched/tune.c:363:37: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     363 | void schedtune_cancel_attach(struct cgroup_taskset *tset)
         |                                     ^~~~~~~~~~~~~~
   kernel/sched/tune.c:363:6: warning: no previous prototype for 'schedtune_cancel_attach' [-Wmissing-prototypes]
     363 | void schedtune_cancel_attach(struct cgroup_taskset *tset)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/tune.c:444:58: warning: 'struct cftype' declared inside parameter list will not be visible outside of this definition or declaration
     444 | prefer_idle_read(struct cgroup_subsys_state *css, struct cftype *cft)
         |                                                          ^~~~~~
   kernel/sched/tune.c:452:59: warning: 'struct cftype' declared inside parameter list will not be visible outside of this definition or declaration
     452 | prefer_idle_write(struct cgroup_subsys_state *css, struct cftype *cft,
         |                                                           ^~~~~~
   kernel/sched/tune.c:462:52: warning: 'struct cftype' declared inside parameter list will not be visible outside of this definition or declaration
     462 | boost_read(struct cgroup_subsys_state *css, struct cftype *cft)
         |                                                    ^~~~~~
   kernel/sched/tune.c:470:53: warning: 'struct cftype' declared inside parameter list will not be visible outside of this definition or declaration
     470 | boost_write(struct cgroup_subsys_state *css, struct cftype *cft,
         |                                                     ^~~~~~
>> kernel/sched/tune.c:486:22: error: array type has incomplete element type 'struct cftype'
     486 | static struct cftype files[] = {
         |                      ^~~~~
>> kernel/sched/tune.c:583:8: error: variable 'schedtune_cgrp_subsys' has initializer but incomplete type
     583 | struct cgroup_subsys schedtune_cgrp_subsys = {
         |        ^~~~~~~~~~~~~
>> kernel/sched/tune.c:584:10: error: 'struct cgroup_subsys' has no member named 'css_alloc'
     584 |         .css_alloc      = schedtune_css_alloc,
         |          ^~~~~~~~~
>> kernel/sched/tune.c:584:27: warning: excess elements in struct initializer
     584 |         .css_alloc      = schedtune_css_alloc,
         |                           ^~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:584:27: note: (near initialization for 'schedtune_cgrp_subsys')
>> kernel/sched/tune.c:585:10: error: 'struct cgroup_subsys' has no member named 'css_free'
     585 |         .css_free       = schedtune_css_free,
         |          ^~~~~~~~
   kernel/sched/tune.c:585:27: warning: excess elements in struct initializer
     585 |         .css_free       = schedtune_css_free,
         |                           ^~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:585:27: note: (near initialization for 'schedtune_cgrp_subsys')
>> kernel/sched/tune.c:586:10: error: 'struct cgroup_subsys' has no member named 'can_attach'
     586 |         .can_attach     = schedtune_can_attach,
         |          ^~~~~~~~~~
   kernel/sched/tune.c:586:27: warning: excess elements in struct initializer
     586 |         .can_attach     = schedtune_can_attach,
         |                           ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:586:27: note: (near initialization for 'schedtune_cgrp_subsys')
>> kernel/sched/tune.c:587:10: error: 'struct cgroup_subsys' has no member named 'cancel_attach'
     587 |         .cancel_attach  = schedtune_cancel_attach,
         |          ^~~~~~~~~~~~~
   kernel/sched/tune.c:587:27: warning: excess elements in struct initializer
     587 |         .cancel_attach  = schedtune_cancel_attach,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:587:27: note: (near initialization for 'schedtune_cgrp_subsys')
>> kernel/sched/tune.c:588:10: error: 'struct cgroup_subsys' has no member named 'legacy_cftypes'
     588 |         .legacy_cftypes = files,
         |          ^~~~~~~~~~~~~~
   kernel/sched/tune.c:588:27: warning: excess elements in struct initializer
     588 |         .legacy_cftypes = files,
         |                           ^~~~~
   kernel/sched/tune.c:588:27: note: (near initialization for 'schedtune_cgrp_subsys')
>> kernel/sched/tune.c:589:10: error: 'struct cgroup_subsys' has no member named 'early_init'
     589 |         .early_init     = 1,
         |          ^~~~~~~~~~
   kernel/sched/tune.c:589:27: warning: excess elements in struct initializer
     589 |         .early_init     = 1,
         |                           ^
   kernel/sched/tune.c:589:27: note: (near initialization for 'schedtune_cgrp_subsys')
>> kernel/sched/tune.c:583:22: error: storage size of 'schedtune_cgrp_subsys' isn't known
     583 | struct cgroup_subsys schedtune_cgrp_subsys = {
         |                      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c: In function 'task_schedtune':
   kernel/sched/tune.c:102:1: warning: control reaches end of non-void function [-Wreturn-type]
     102 | }
         | ^
   kernel/sched/tune.c: In function 'schedtune_can_attach':
   kernel/sched/tune.c:361:1: warning: control reaches end of non-void function [-Wreturn-type]
     361 | }
         | ^
   At top level:
   kernel/sched/tune.c:486:22: warning: 'files' defined but not used [-Wunused-variable]
     486 | static struct cftype files[] = {
         |                      ^~~~~
   cc1: some warnings being treated as errors


vim +/css +81 kernel/sched/tune.c

    15	
    16	/*
    17	 * EAS scheduler tunables for task groups.
    18	 *
    19	 * When CGroup support is enabled, we have to synchronize two different
    20	 * paths:
    21	 *  - slow path: where CGroups are created/updated/removed
    22	 *  - fast path: where tasks in a CGroups are accounted
    23	 *
    24	 * The slow path tracks (a limited number of) CGroups and maps each on a
    25	 * "boost_group" index. The fastpath accounts tasks currently RUNNABLE on each
    26	 * "boost_group".
    27	 *
    28	 * Once a new CGroup is created, a boost group idx is assigned and the
    29	 * corresponding "boost_group" marked as valid on each CPU.
    30	 * Once a CGroup is release, the corresponding "boost_group" is marked as
    31	 * invalid on each CPU. The CPU boost value (boost_max) is aggregated by
    32	 * considering only valid boost_groups with a non null tasks counter.
    33	 *
    34	 * .:: Locking strategy
    35	 *
    36	 * The fast path uses a spin lock for each CPU boost_group which protects the
    37	 * tasks counter.
    38	 *
    39	 * The "valid" and "boost" values of each CPU boost_group is instead
    40	 * protected by the RCU lock provided by the CGroups callbacks. Thus, only the
    41	 * slow path can access and modify the boost_group attribtues of each CPU.
    42	 * The fast path will catch up the most updated values at the next scheduling
    43	 * event (i.e. enqueue/dequeue).
    44	 *
    45	 *                                                        |
    46	 *                                             SLOW PATH  |   FAST PATH
    47	 *                              CGroup add/update/remove  |   Scheduler enqueue/dequeue events
    48	 *                                                        |
    49	 *                                                        |
    50	 *                                                        |     DEFINE_PER_CPU(struct boost_groups)
    51	 *                                                        |     +--------------+----+---+----+----+
    52	 *                                                        |     |  idle        |    |   |    |    |
    53	 *                                                        |     |  boost_max   |    |   |    |    |
    54	 *                                                        |  +---->lock        |    |   |    |    |
    55	 *  struct schedtune                  allocated_groups    |  |  |  group[    ] |    |   |    |    |
    56	 *  +------------------------------+         +-------+    |  |  +--+---------+-+----+---+----+----+
    57	 *  | idx                          |         |       |    |  |     |  valid  |
    58	 *  | boots / prefer_idle          |         |       |    |  |     |  boost  |
    59	 *  | perf_{boost/constraints}_idx | <---------+(*)  |    |  |     |  tasks  | <------------+
    60	 *  | css                          |         +-------+    |  |     +---------+              |
    61	 *  +-+----------------------------+         |       |    |  |     |         |              |
    62	 *    ^                                      |       |    |  |     |         |              |
    63	 *    |                                      +-------+    |  |     +---------+              |
    64	 *    |                                      |       |    |  |     |         |              |
    65	 *    |                                      |       |    |  |     |         |              |
    66	 *    |                                      +-------+    |  |     +---------+              |
    67	 *    | zmalloc                              |       |    |  |     |         |              |
    68	 *    |                                      |       |    |  |     |         |              |
    69	 *    |                                      +-------+    |  |     +---------+              |
    70	 *    +                              BOOSTGROUPS_COUNT    |  |     BOOSTGROUPS_COUNT        |
    71	 *  schedtune_boostgroup_init()                           |  +                              |
    72	 *                                                        |  schedtune_{en,de}queue_task()  |
    73	 *                                                        |                                 +
    74	 *                                                        |          schedtune_tasks_update()
    75	 *                                                        |
    76	 */
    77	
    78	/* SchdTune tunables for a group of tasks */
    79	struct schedtune {
    80		/* SchedTune CGroup subsystem */
  > 81		struct cgroup_subsys_state css;
    82	
    83		/* Boost group allocated ID */
    84		int idx;
    85	
    86		/* Boost value for tasks on that SchedTune CGroup */
    87		int boost;
    88	
    89		/* Hint to bias scheduling of tasks on that SchedTune CGroup
    90		 * towards idle CPUs */
    91		int prefer_idle;
    92	};
    93	
    94	static inline struct schedtune *css_st(struct cgroup_subsys_state *css)
    95	{
    96		return css ? container_of(css, struct schedtune, css) : NULL;
    97	}
    98	
    99	static inline struct schedtune *task_schedtune(struct task_struct *tsk)
   100	{
 > 101		return css_st(task_css(tsk, schedtune_cgrp_id));
   102	}
   103	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
