Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76CE4DC098
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiCQIFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiCQIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:05:10 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026955A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647504234; x=1679040234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IKndJ0o2gBcCWv1GodCMWM4hw6LUBWMLE3aRRQQfsTU=;
  b=O4xkLN1Z22CeC1AeAIFz1zAEnyvNmf8KTNsYGu5zXwN6ZOqDPDy3+CMr
   OOh5hmJM13BLUFm5BzSaH8rDcuzffkThYtfAIf5uWuIvCZu8wF/4vbGTn
   YYwFF9KYtDsdi7AS07P+mxBzV6p3dQK5QBokoQdF3RQxtDUAdVS4ouWOG
   CDTUeANm08gzb3WktGxFWfB+ov3wHQ8T8MHk76lKwmZ8Gcj4P6KEZBMOu
   kGhtrDr86CrDNmskLx8f8XiVauTJcCXQunx5hTJvETSuZYimKspcHzHdr
   foAEWGTfKzR3liVsi5Xfd8u3xlQn4wsh44egVvugCS7Y8FTf3A+cy0Ls6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317529223"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="317529223"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="714944650"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 01:03:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUl64-000DTj-QI; Thu, 17 Mar 2022 08:03:00 +0000
Date:   Thu, 17 Mar 2022 16:02:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Quentin Perret <quentin.perret@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-q-release
 43/7636] kernel/sched/tune.c:290:33: warning: 'struct cgroup_taskset'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202203171642.uVKJqHxx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-q-release
head:   1a3500dc59324a85c20f025cfa6485a1a0debbdf
commit: 68dbff9ce92ae2f923321d150fb72a6d8b05e640 [43/7636] ANDROID: sched: fair/tune: Add schedtune with cgroups interface
config: s390-randconfig-r035-20220317 (https://download.01.org/0day-ci/archive/20220317/202203171642.uVKJqHxx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/68dbff9ce92ae2f923321d150fb72a6d8b05e640
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-q-release
        git checkout 68dbff9ce92ae2f923321d150fb72a6d8b05e640
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/tune.c:81:36: error: field 'css' has incomplete type
      81 |         struct cgroup_subsys_state css;
         |                                    ^~~
   kernel/sched/tune.c: In function 'task_schedtune':
   kernel/sched/tune.c:101:23: error: implicit declaration of function 'task_css'; did you mean 'task_cpu'? [-Werror=implicit-function-declaration]
     101 |         return css_st(task_css(tsk, schedtune_cgrp_id));
         |                       ^~~~~~~~
         |                       task_cpu
   kernel/sched/tune.c:101:37: error: 'schedtune_cgrp_id' undeclared (first use in this function); did you mean 'schedtune_spc_rdiv'?
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
   kernel/sched/tune.c:306:9: error: implicit declaration of function 'cgroup_taskset_for_each' [-Werror=implicit-function-declaration]
     306 |         cgroup_taskset_for_each(task, css, tset) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:306:49: error: expected ';' before '{' token
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
   kernel/sched/tune.c:486:22: error: array type has incomplete element type 'struct cftype'
     486 | static struct cftype files[] = {
         |                      ^~~~~
   kernel/sched/tune.c:583:8: error: variable 'schedtune_cgrp_subsys' has initializer but incomplete type
     583 | struct cgroup_subsys schedtune_cgrp_subsys = {
         |        ^~~~~~~~~~~~~
   kernel/sched/tune.c:584:10: error: 'struct cgroup_subsys' has no member named 'css_alloc'
     584 |         .css_alloc      = schedtune_css_alloc,
         |          ^~~~~~~~~
>> kernel/sched/tune.c:584:27: warning: excess elements in struct initializer
     584 |         .css_alloc      = schedtune_css_alloc,
         |                           ^~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:584:27: note: (near initialization for 'schedtune_cgrp_subsys')
   kernel/sched/tune.c:585:10: error: 'struct cgroup_subsys' has no member named 'css_free'
     585 |         .css_free       = schedtune_css_free,
         |          ^~~~~~~~
   kernel/sched/tune.c:585:27: warning: excess elements in struct initializer
     585 |         .css_free       = schedtune_css_free,
         |                           ^~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:585:27: note: (near initialization for 'schedtune_cgrp_subsys')
   kernel/sched/tune.c:586:10: error: 'struct cgroup_subsys' has no member named 'can_attach'
     586 |         .can_attach     = schedtune_can_attach,
         |          ^~~~~~~~~~
   kernel/sched/tune.c:586:27: warning: excess elements in struct initializer
     586 |         .can_attach     = schedtune_can_attach,
         |                           ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:586:27: note: (near initialization for 'schedtune_cgrp_subsys')
   kernel/sched/tune.c:587:10: error: 'struct cgroup_subsys' has no member named 'cancel_attach'
     587 |         .cancel_attach  = schedtune_cancel_attach,
         |          ^~~~~~~~~~~~~
   kernel/sched/tune.c:587:27: warning: excess elements in struct initializer
     587 |         .cancel_attach  = schedtune_cancel_attach,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/tune.c:587:27: note: (near initialization for 'schedtune_cgrp_subsys')
   kernel/sched/tune.c:588:10: error: 'struct cgroup_subsys' has no member named 'legacy_cftypes'
     588 |         .legacy_cftypes = files,
         |          ^~~~~~~~~~~~~~
   kernel/sched/tune.c:588:27: warning: excess elements in struct initializer
     588 |         .legacy_cftypes = files,
         |                           ^~~~~
   kernel/sched/tune.c:588:27: note: (near initialization for 'schedtune_cgrp_subsys')
   kernel/sched/tune.c:589:10: error: 'struct cgroup_subsys' has no member named 'early_init'
     589 |         .early_init     = 1,
         |          ^~~~~~~~~~
   kernel/sched/tune.c:589:27: warning: excess elements in struct initializer
     589 |         .early_init     = 1,
         |                           ^
   kernel/sched/tune.c:589:27: note: (near initialization for 'schedtune_cgrp_subsys')
   kernel/sched/tune.c:583:22: error: storage size of 'schedtune_cgrp_subsys' isn't known
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


vim +290 kernel/sched/tune.c

    98	
    99	static inline struct schedtune *task_schedtune(struct task_struct *tsk)
   100	{
 > 101		return css_st(task_css(tsk, schedtune_cgrp_id));
   102	}
   103	
   104	static inline struct schedtune *parent_st(struct schedtune *st)
   105	{
   106		return css_st(st->css.parent);
   107	}
   108	
   109	/*
   110	 * SchedTune root control group
   111	 * The root control group is used to defined a system-wide boosting tuning,
   112	 * which is applied to all tasks in the system.
   113	 * Task specific boost tuning could be specified by creating and
   114	 * configuring a child control group under the root one.
   115	 * By default, system-wide boosting is disabled, i.e. no boosting is applied
   116	 * to tasks which are not into a child control group.
   117	 */
   118	static struct schedtune
   119	root_schedtune = {
   120		.boost	= 0,
   121		.prefer_idle = 0,
   122	};
   123	
   124	/*
   125	 * Maximum number of boost groups to support
   126	 * When per-task boosting is used we still allow only limited number of
   127	 * boost groups for two main reasons:
   128	 * 1. on a real system we usually have only few classes of workloads which
   129	 *    make sense to boost with different values (e.g. background vs foreground
   130	 *    tasks, interactive vs low-priority tasks)
   131	 * 2. a limited number allows for a simpler and more memory/time efficient
   132	 *    implementation especially for the computation of the per-CPU boost
   133	 *    value
   134	 */
   135	#define BOOSTGROUPS_COUNT 5
   136	
   137	/* Array of configured boostgroups */
   138	static struct schedtune *allocated_group[BOOSTGROUPS_COUNT] = {
   139		&root_schedtune,
   140		NULL,
   141	};
   142	
   143	/* SchedTune boost groups
   144	 * Keep track of all the boost groups which impact on CPU, for example when a
   145	 * CPU has two RUNNABLE tasks belonging to two different boost groups and thus
   146	 * likely with different boost values.
   147	 * Since on each system we expect only a limited number of boost groups, here
   148	 * we use a simple array to keep track of the metrics required to compute the
   149	 * maximum per-CPU boosting value.
   150	 */
   151	struct boost_groups {
   152		/* Maximum boost value for all RUNNABLE tasks on a CPU */
   153		int boost_max;
   154		struct {
   155			/* True when this boost group maps an actual cgroup */
   156			bool valid;
   157			/* The boost for tasks on that boost group */
   158			int boost;
   159			/* Count of RUNNABLE tasks on that boost group */
   160			unsigned tasks;
   161		} group[BOOSTGROUPS_COUNT];
   162		/* CPU's boost group locking */
   163		raw_spinlock_t lock;
   164	};
   165	
   166	/* Boost groups affecting each CPU in the system */
   167	DEFINE_PER_CPU(struct boost_groups, cpu_boost_groups);
   168	
   169	static void
   170	schedtune_cpu_update(int cpu)
   171	{
   172		struct boost_groups *bg = &per_cpu(cpu_boost_groups, cpu);
   173		int boost_max;
   174		int idx;
   175	
   176		/* The root boost group is always active */
   177		boost_max = bg->group[0].boost;
   178		for (idx = 1; idx < BOOSTGROUPS_COUNT; ++idx) {
   179	
   180			/* Ignore non boostgroups not mapping a cgroup */
   181			if (!bg->group[idx].valid)
   182				continue;
   183	
   184			/*
   185			 * A boost group affects a CPU only if it has
   186			 * RUNNABLE tasks on that CPU
   187			 */
   188			if (bg->group[idx].tasks == 0)
   189				continue;
   190	
   191			boost_max = max(boost_max, bg->group[idx].boost);
   192		}
   193	
   194		/* Ensures boost_max is non-negative when all cgroup boost values
   195		 * are neagtive. Avoids under-accounting of cpu capacity which may cause
   196		 * task stacking and frequency spikes.*/
   197		boost_max = max(boost_max, 0);
   198		bg->boost_max = boost_max;
   199	}
   200	
   201	static int
   202	schedtune_boostgroup_update(int idx, int boost)
   203	{
   204		struct boost_groups *bg;
   205		int cur_boost_max;
   206		int old_boost;
   207		int cpu;
   208	
   209		/* Update per CPU boost groups */
   210		for_each_possible_cpu(cpu) {
   211			bg = &per_cpu(cpu_boost_groups, cpu);
   212	
   213			/* CGroups are never associated to non active cgroups */
   214			BUG_ON(!bg->group[idx].valid);
   215	
   216			/*
   217			 * Keep track of current boost values to compute the per CPU
   218			 * maximum only when it has been affected by the new value of
   219			 * the updated boost group
   220			 */
   221			cur_boost_max = bg->boost_max;
   222			old_boost = bg->group[idx].boost;
   223	
   224			/* Update the boost value of this boost group */
   225			bg->group[idx].boost = boost;
   226	
   227			/* Check if this update increase current max */
   228			if (boost > cur_boost_max && bg->group[idx].tasks) {
   229				bg->boost_max = boost;
   230				continue;
   231			}
   232	
   233			/* Check if this update has decreased current max */
   234			if (cur_boost_max == old_boost && old_boost > boost) {
   235				schedtune_cpu_update(cpu);
   236				continue;
   237			}
   238		}
   239	
   240		return 0;
   241	}
   242	
   243	#define ENQUEUE_TASK  1
   244	#define DEQUEUE_TASK -1
   245	
   246	static inline void
   247	schedtune_tasks_update(struct task_struct *p, int cpu, int idx, int task_count)
   248	{
   249		struct boost_groups *bg = &per_cpu(cpu_boost_groups, cpu);
   250		int tasks = bg->group[idx].tasks + task_count;
   251	
   252		/* Update boosted tasks count while avoiding to make it negative */
   253		bg->group[idx].tasks = max(0, tasks);
   254	
   255		/* Boost group activation or deactivation on that RQ */
   256		if (tasks == 1 || tasks == 0)
   257			schedtune_cpu_update(cpu);
   258	}
   259	
   260	/*
   261	 * NOTE: This function must be called while holding the lock on the CPU RQ
   262	 */
   263	void schedtune_enqueue_task(struct task_struct *p, int cpu)
   264	{
   265		struct boost_groups *bg = &per_cpu(cpu_boost_groups, cpu);
   266		unsigned long irq_flags;
   267		struct schedtune *st;
   268		int idx;
   269	
   270		if (unlikely(!schedtune_initialized))
   271			return;
   272	
   273		/*
   274		 * Boost group accouting is protected by a per-cpu lock and requires
   275		 * interrupt to be disabled to avoid race conditions for example on
   276		 * do_exit()::cgroup_exit() and task migration.
   277		 */
   278		raw_spin_lock_irqsave(&bg->lock, irq_flags);
   279		rcu_read_lock();
   280	
   281		st = task_schedtune(p);
   282		idx = st->idx;
   283	
   284		schedtune_tasks_update(p, cpu, idx, ENQUEUE_TASK);
   285	
   286		rcu_read_unlock();
   287		raw_spin_unlock_irqrestore(&bg->lock, irq_flags);
   288	}
   289	
 > 290	int schedtune_can_attach(struct cgroup_taskset *tset)
   291	{
   292		struct task_struct *task;
   293		struct cgroup_subsys_state *css;
   294		struct boost_groups *bg;
   295		struct rq_flags rq_flags;
   296		unsigned int cpu;
   297		struct rq *rq;
   298		int src_bg; /* Source boost group index */
   299		int dst_bg; /* Destination boost group index */
   300		int tasks;
   301	
   302		if (unlikely(!schedtune_initialized))
   303			return 0;
   304	
   305	
   306		cgroup_taskset_for_each(task, css, tset) {
   307	
   308			/*
   309			 * Lock the CPU's RQ the task is enqueued to avoid race
   310			 * conditions with migration code while the task is being
   311			 * accounted
   312			 */
   313			rq = task_rq_lock(task, &rq_flags);
   314	
   315			if (!task->on_rq) {
   316				task_rq_unlock(rq, task, &rq_flags);
   317				continue;
   318			}
   319	
   320			/*
   321			 * Boost group accouting is protected by a per-cpu lock and requires
   322			 * interrupt to be disabled to avoid race conditions on...
   323			 */
   324			cpu = cpu_of(rq);
   325			bg = &per_cpu(cpu_boost_groups, cpu);
   326			raw_spin_lock(&bg->lock);
   327	
   328			dst_bg = css_st(css)->idx;
   329			src_bg = task_schedtune(task)->idx;
   330	
   331			/*
   332			 * Current task is not changing boostgroup, which can
   333			 * happen when the new hierarchy is in use.
   334			 */
   335			if (unlikely(dst_bg == src_bg)) {
   336				raw_spin_unlock(&bg->lock);
   337				task_rq_unlock(rq, task, &rq_flags);
   338				continue;
   339			}
   340	
   341			/*
   342			 * This is the case of a RUNNABLE task which is switching its
   343			 * current boost group.
   344			 */
   345	
   346			/* Move task from src to dst boost group */
   347			tasks = bg->group[src_bg].tasks - 1;
   348			bg->group[src_bg].tasks = max(0, tasks);
   349			bg->group[dst_bg].tasks += 1;
   350	
   351			raw_spin_unlock(&bg->lock);
   352			task_rq_unlock(rq, task, &rq_flags);
   353	
   354			/* Update CPU boost group */
   355			if (bg->group[src_bg].tasks == 0 || bg->group[dst_bg].tasks == 1)
   356				schedtune_cpu_update(task_cpu(task));
   357	
   358		}
   359	
   360		return 0;
   361	}
   362	
 > 363	void schedtune_cancel_attach(struct cgroup_taskset *tset)
   364	{
   365		/* This can happen only if SchedTune controller is mounted with
   366		 * other hierarchies ane one of them fails. Since usually SchedTune is
   367		 * mouted on its own hierarcy, for the time being we do not implement
   368		 * a proper rollback mechanism */
   369		WARN(1, "SchedTune cancel attach not implemented");
   370	}
   371	
   372	/*
   373	 * NOTE: This function must be called while holding the lock on the CPU RQ
   374	 */
   375	void schedtune_dequeue_task(struct task_struct *p, int cpu)
   376	{
   377		struct boost_groups *bg = &per_cpu(cpu_boost_groups, cpu);
   378		unsigned long irq_flags;
   379		struct schedtune *st;
   380		int idx;
   381	
   382		if (unlikely(!schedtune_initialized))
   383			return;
   384	
   385		/*
   386		 * Boost group accouting is protected by a per-cpu lock and requires
   387		 * interrupt to be disabled to avoid race conditions on...
   388		 */
   389		raw_spin_lock_irqsave(&bg->lock, irq_flags);
   390		rcu_read_lock();
   391	
   392		st = task_schedtune(p);
   393		idx = st->idx;
   394	
   395		schedtune_tasks_update(p, cpu, idx, DEQUEUE_TASK);
   396	
   397		rcu_read_unlock();
   398		raw_spin_unlock_irqrestore(&bg->lock, irq_flags);
   399	}
   400	
   401	int schedtune_cpu_boost(int cpu)
   402	{
   403		struct boost_groups *bg;
   404	
   405		bg = &per_cpu(cpu_boost_groups, cpu);
   406		return bg->boost_max;
   407	}
   408	
   409	int schedtune_task_boost(struct task_struct *p)
   410	{
   411		struct schedtune *st;
   412		int task_boost;
   413	
   414		if (unlikely(!schedtune_initialized))
   415			return 0;
   416	
   417		/* Get task boost value */
   418		rcu_read_lock();
   419		st = task_schedtune(p);
   420		task_boost = st->boost;
   421		rcu_read_unlock();
   422	
   423		return task_boost;
   424	}
   425	
   426	int schedtune_prefer_idle(struct task_struct *p)
   427	{
   428		struct schedtune *st;
   429		int prefer_idle;
   430	
   431		if (unlikely(!schedtune_initialized))
   432			return 0;
   433	
   434		/* Get prefer_idle value */
   435		rcu_read_lock();
   436		st = task_schedtune(p);
   437		prefer_idle = st->prefer_idle;
   438		rcu_read_unlock();
   439	
   440		return prefer_idle;
   441	}
   442	
   443	static u64
 > 444	prefer_idle_read(struct cgroup_subsys_state *css, struct cftype *cft)
   445	{
   446		struct schedtune *st = css_st(css);
   447	
   448		return st->prefer_idle;
   449	}
   450	
   451	static int
   452	prefer_idle_write(struct cgroup_subsys_state *css, struct cftype *cft,
   453		    u64 prefer_idle)
   454	{
   455		struct schedtune *st = css_st(css);
   456		st->prefer_idle = !!prefer_idle;
   457	
   458		return 0;
   459	}
   460	
   461	static s64
   462	boost_read(struct cgroup_subsys_state *css, struct cftype *cft)
   463	{
   464		struct schedtune *st = css_st(css);
   465	
   466		return st->boost;
   467	}
   468	
   469	static int
   470	boost_write(struct cgroup_subsys_state *css, struct cftype *cft,
   471		    s64 boost)
   472	{
   473		struct schedtune *st = css_st(css);
   474	
   475		if (boost < 0 || boost > 100)
   476			return -EINVAL;
   477	
   478		st->boost = boost;
   479	
   480		/* Update CPU boost */
   481		schedtune_boostgroup_update(st->idx, st->boost);
   482	
   483		return 0;
   484	}
   485	
 > 486	static struct cftype files[] = {
   487		{
   488			.name = "boost",
   489			.read_s64 = boost_read,
   490			.write_s64 = boost_write,
   491		},
   492		{
   493			.name = "prefer_idle",
   494			.read_u64 = prefer_idle_read,
   495			.write_u64 = prefer_idle_write,
   496		},
   497		{ }	/* terminate */
   498	};
   499	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
