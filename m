Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE15A04BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiHXXe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiHXXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:34:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229E8A6E6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661384036; x=1692920036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cRzoh+0jCwcFtwBhNc7irpJXZnKMaTjoktq50zJTNJE=;
  b=ZIWMlOFGVrdjUycqGrkbGO2j8qgO17KaaY0ENvodl1hbwmLvNKp4NmV2
   FzrDQK8nvukfDZttW9fY1V8ruTHSWWUj8EMYvo4Bk0lct3XNZxEUGtZN1
   NjnbYmlOepQV3231T6PwL71itVXMzLF90RILjT4YnFo5wW/R9mhNyYDAG
   Exg94MnQ/SNZVFlKQFlcMk+n9EB38kQB4w+FvvUYwFgRFVgFkRyLCizLw
   OGnAVExmRhwqHfK4uOskzQcQdumsu59XcfIJu+4el7SAc+X7zIdgX/JHj
   naPw2Nnm1t3h/ryaMkO0ccZE8HMfjTTCCh3yRecain/pRRdZo1FEL4RWd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="380392362"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="380392362"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="639338098"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2022 16:33:54 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQzsg-0001OL-0Q;
        Wed, 24 Aug 2022 23:33:54 +0000
Date:   Thu, 25 Aug 2022 07:33:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 1/7] kernel/events/core.c:180:48:
 error: 'cpu_context' redeclared as different kind of symbol
Message-ID: <202208250704.0eOVa3kK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   a64acdeb54df49f556e7185c18c6aa96e5e415c5
commit: 2e88a6dabc89102df01045bf10b9f77917b80228 [1/7] perf: Rewrite core context handling
config: mips-randconfig-r002-20220824 (https://download.01.org/0day-ci/archive/20220825/202208250704.0eOVa3kK-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=2e88a6dabc89102df01045bf10b9f77917b80228
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout 2e88a6dabc89102df01045bf10b9f77917b80228
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/events/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/mips/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/mips/include/asm/atomic.h:17,
                    from include/linux/atomic.h:7,
                    from arch/mips/include/asm/processor.h:14,
                    from arch/mips/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from kernel/events/core.c:11:
>> kernel/events/core.c:180:48: error: 'cpu_context' redeclared as different kind of symbol
     180 | static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
         |                                                ^~~~~~~~~~~
   include/linux/percpu-defs.h:104:44: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     104 |         __PCPU_ATTRS(sec) __typeof__(type) name
         |                                            ^~~~
   kernel/events/core.c:180:8: note: in expansion of macro 'DEFINE_PER_CPU'
     180 | static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
         |        ^~~~~~~~~~~~~~
   In file included from arch/mips/include/asm/tlbflush.h:25,
                    from include/linux/hugetlb.h:30,
                    from kernel/events/core.c:31:
   arch/mips/include/asm/mmu_context.h:106:19: note: previous definition of 'cpu_context' with type 'u64(unsigned int,  const struct mm_struct *)' {aka 'long long unsigned int(unsigned int,  const struct mm_struct *)'}
     106 | static inline u64 cpu_context(unsigned int cpu, const struct mm_struct *mm)
         |                   ^~~~~~~~~~~
   kernel/events/core.c: In function 'perf_rotate_context':
   kernel/events/core.c:4236:36: warning: variable 'task_ctx' set but not used [-Wunused-but-set-variable]
    4236 |         struct perf_event_context *task_ctx = NULL;
         |                                    ^~~~~~~~
   kernel/events/core.c: At top level:
   kernel/events/core.c:4810:1: warning: no previous prototype for 'find_get_pmu_context' [-Wmissing-prototypes]
    4810 | find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
         | ^~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c:180:48: warning: 'cpu_context' defined but not used [-Wunused-variable]
     180 | static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
         |                                                ^~~~~~~~~~~
   include/linux/percpu-defs.h:104:44: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     104 |         __PCPU_ATTRS(sec) __typeof__(type) name
         |                                            ^~~~
   kernel/events/core.c:180:8: note: in expansion of macro 'DEFINE_PER_CPU'
     180 | static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
         |        ^~~~~~~~~~~~~~


vim +/cpu_context +180 kernel/events/core.c

  > 11	#include <linux/fs.h>
    12	#include <linux/mm.h>
    13	#include <linux/cpu.h>
    14	#include <linux/smp.h>
    15	#include <linux/idr.h>
    16	#include <linux/file.h>
    17	#include <linux/poll.h>
    18	#include <linux/slab.h>
    19	#include <linux/hash.h>
    20	#include <linux/tick.h>
    21	#include <linux/sysfs.h>
    22	#include <linux/dcache.h>
    23	#include <linux/percpu.h>
    24	#include <linux/ptrace.h>
    25	#include <linux/reboot.h>
    26	#include <linux/vmstat.h>
    27	#include <linux/device.h>
    28	#include <linux/export.h>
    29	#include <linux/vmalloc.h>
    30	#include <linux/hardirq.h>
    31	#include <linux/hugetlb.h>
    32	#include <linux/rculist.h>
    33	#include <linux/uaccess.h>
    34	#include <linux/syscalls.h>
    35	#include <linux/anon_inodes.h>
    36	#include <linux/kernel_stat.h>
    37	#include <linux/cgroup.h>
    38	#include <linux/perf_event.h>
    39	#include <linux/trace_events.h>
    40	#include <linux/hw_breakpoint.h>
    41	#include <linux/mm_types.h>
    42	#include <linux/module.h>
    43	#include <linux/mman.h>
    44	#include <linux/compat.h>
    45	#include <linux/bpf.h>
    46	#include <linux/filter.h>
    47	#include <linux/namei.h>
    48	#include <linux/parser.h>
    49	#include <linux/sched/clock.h>
    50	#include <linux/sched/mm.h>
    51	#include <linux/proc_ns.h>
    52	#include <linux/mount.h>
    53	#include <linux/min_heap.h>
    54	#include <linux/highmem.h>
    55	#include <linux/pgtable.h>
    56	#include <linux/buildid.h>
    57	
    58	#include "internal.h"
    59	
    60	#include <asm/irq_regs.h>
    61	
    62	typedef int (*remote_function_f)(void *);
    63	
    64	struct remote_function_call {
    65		struct task_struct	*p;
    66		remote_function_f	func;
    67		void			*info;
    68		int			ret;
    69	};
    70	
    71	static void remote_function(void *data)
    72	{
    73		struct remote_function_call *tfc = data;
    74		struct task_struct *p = tfc->p;
    75	
    76		if (p) {
    77			/* -EAGAIN */
    78			if (task_cpu(p) != smp_processor_id())
    79				return;
    80	
    81			/*
    82			 * Now that we're on right CPU with IRQs disabled, we can test
    83			 * if we hit the right task without races.
    84			 */
    85	
    86			tfc->ret = -ESRCH; /* No such (running) process */
    87			if (p != current)
    88				return;
    89		}
    90	
    91		tfc->ret = tfc->func(tfc->info);
    92	}
    93	
    94	/**
    95	 * task_function_call - call a function on the cpu on which a task runs
    96	 * @p:		the task to evaluate
    97	 * @func:	the function to be called
    98	 * @info:	the function call argument
    99	 *
   100	 * Calls the function @func when the task is currently running. This might
   101	 * be on the current CPU, which just calls the function directly.  This will
   102	 * retry due to any failures in smp_call_function_single(), such as if the
   103	 * task_cpu() goes offline concurrently.
   104	 *
   105	 * returns @func return value or -ESRCH or -ENXIO when the process isn't running
   106	 */
   107	static int
   108	task_function_call(struct task_struct *p, remote_function_f func, void *info)
   109	{
   110		struct remote_function_call data = {
   111			.p	= p,
   112			.func	= func,
   113			.info	= info,
   114			.ret	= -EAGAIN,
   115		};
   116		int ret;
   117	
   118		for (;;) {
   119			ret = smp_call_function_single(task_cpu(p), remote_function,
   120						       &data, 1);
   121			if (!ret)
   122				ret = data.ret;
   123	
   124			if (ret != -EAGAIN)
   125				break;
   126	
   127			cond_resched();
   128		}
   129	
   130		return ret;
   131	}
   132	
   133	/**
   134	 * cpu_function_call - call a function on the cpu
   135	 * @cpu:	target cpu to queue this function
   136	 * @func:	the function to be called
   137	 * @info:	the function call argument
   138	 *
   139	 * Calls the function @func on the remote cpu.
   140	 *
   141	 * returns: @func return value or -ENXIO when the cpu is offline
   142	 */
   143	static int cpu_function_call(int cpu, remote_function_f func, void *info)
   144	{
   145		struct remote_function_call data = {
   146			.p	= NULL,
   147			.func	= func,
   148			.info	= info,
   149			.ret	= -ENXIO, /* No such CPU */
   150		};
   151	
   152		smp_call_function_single(cpu, remote_function, &data, 1);
   153	
   154		return data.ret;
   155	}
   156	
   157	static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
   158				  struct perf_event_context *ctx)
   159	{
   160		raw_spin_lock(&cpuctx->ctx.lock);
   161		if (ctx)
   162			raw_spin_lock(&ctx->lock);
   163	}
   164	
   165	static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
   166				    struct perf_event_context *ctx)
   167	{
   168		if (ctx)
   169			raw_spin_unlock(&ctx->lock);
   170		raw_spin_unlock(&cpuctx->ctx.lock);
   171	}
   172	
   173	#define TASK_TOMBSTONE ((void *)-1L)
   174	
   175	static bool is_kernel_event(struct perf_event *event)
   176	{
   177		return READ_ONCE(event->owner) == TASK_TOMBSTONE;
   178	}
   179	
 > 180	static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
   181	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
