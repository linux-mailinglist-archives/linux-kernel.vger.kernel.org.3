Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1286551448A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355894AbiD2Iq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355836AbiD2Iq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F74C3EA5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651221788; x=1682757788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vA0NqCkhKtzvPRkVpnLt7sgGT5KJ9S+BtpP4+DnoEf0=;
  b=IgHzzyir2QZEYPIShGYItwwJh33omvZ0ZQtYkZ3EKs4+7+7I2sxsMzkJ
   xE1Y/BrFi21tXm7J2CurLMfAUjc+KDy/AvgB2l6IAOepk2MhM85kxDcpA
   PVMHCPRw0FLgqDBWzqyvBQXCVVHMFhxa9ffV8J27R3ufEs54Gorzz2irQ
   P6NqlEWQ8Ll+4Z0Fr30sqOObpaCMUA+hYvaa5f6k79nSryXwHP07TLT9A
   sZqK9NEBxi4InI/xdbaIc6lowibBxAqyFJjCl8QiDbbco6Vw6OuD26iLY
   WKw9gwPC8h4X3FqhxcS0S6jYv302Ghqs53fnaJYU2Gc3WBpkKfSBqtJyU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="291747518"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="291747518"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 01:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="731964086"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2022 01:43:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkMDN-00069f-TY;
        Fri, 29 Apr 2022 08:43:01 +0000
Date:   Fri, 29 Apr 2022 16:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/wip.freezer 4/7] kernel/signal.c:2371:73: error:
 'JOBCTL_TRACE_QUIESCE' undeclared; did you mean 'JOBCTL_TRACED_QUIESCE'?
Message-ID: <202204291627.uVmY0Bhj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   a1b437cfec0d2b0060cf85538c2379c74fb63ad5
commit: 0939e54b718e81f64027116177863954d7d6d879 [4/7] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220429/202204291627.uVmY0Bhj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=0939e54b718e81f64027116177863954d7d6d879
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 0939e54b718e81f64027116177863954d7d6d879
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |  ^
   include/linux/sched/jobctl.h:23:1: error: unknown type name 'q'
      23 | q#define JOBCTL_STOPPED_BIT     25      /* do_signal_stop() */
         | ^
   include/linux/sched/jobctl.h:23:10: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'JOBCTL_STOPPED_BIT'
      23 | q#define JOBCTL_STOPPED_BIT     25      /* do_signal_stop() */
         |          ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h: In function 'kernel_signal_stop':
   include/linux/sched/jobctl.h:36:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      36 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:298:36: note: in expansion of macro 'JOBCTL_STOPPED'
     298 |                 current->jobctl |= JOBCTL_STOPPED;
         |                                    ^~~~~~~~~~~~~~
   include/linux/sched/jobctl.h:36:41: note: each undeclared identifier is reported only once for each function it appears in
      36 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:298:36: note: in expansion of macro 'JOBCTL_STOPPED'
     298 |                 current->jobctl |= JOBCTL_STOPPED;
         |                                    ^~~~~~~~~~~~~~
   include/linux/sched/signal.h: In function 'signal_wake_up':
   include/linux/sched/jobctl.h:36:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      36 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:444:32: note: in expansion of macro 'JOBCTL_STOPPED'
     444 |                 t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE);
         |                                ^~~~~~~~~~~~~~
   In file included from include/uapi/asm-generic/bpf_perf_event.h:4,
                    from ./arch/um/include/generated/asm/bpf_perf_event.h:1,
                    from include/uapi/linux/bpf_perf_event.h:11,
                    from include/linux/perf_event.h:18,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/signal.c:30:
   include/linux/ptrace.h: In function 'ptrace_init_task':
   include/linux/ptrace.h:220:25: error: implicit declaration of function 'task_set_jobctl_pending'; did you mean 'task_clear_jobctl_pending'? [-Werror=implicit-function-declaration]
     220 |                         task_set_jobctl_pending(child, JOBCTL_TRAP_STOP);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                         task_clear_jobctl_pending
   kernel/signal.c: At top level:
   kernel/signal.c:284:6: warning: no previous prototype for 'task_set_jobctl_pending' [-Wmissing-prototypes]
     284 | bool task_set_jobctl_pending(struct task_struct *task, unsigned long mask)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/signal.c:284:6: error: conflicting types for 'task_set_jobctl_pending'; have 'bool(struct task_struct *, long unsigned int)' {aka '_Bool(struct task_struct *, long unsigned int)'}
   In file included from include/uapi/asm-generic/bpf_perf_event.h:4,
                    from ./arch/um/include/generated/asm/bpf_perf_event.h:1,
                    from include/uapi/linux/bpf_perf_event.h:11,
                    from include/linux/perf_event.h:18,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/signal.c:30:
   include/linux/ptrace.h:220:25: note: previous implicit declaration of 'task_set_jobctl_pending' with type 'int()'
     220 |                         task_set_jobctl_pending(child, JOBCTL_TRAP_STOP);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched/signal.h:8,
                    from include/linux/sched/cputime.h:5,
                    from kernel/signal.c:22:
   kernel/signal.c: In function 'prepare_signal':
   include/linux/sched/jobctl.h:36:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      36 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/signal.c:937:47: note: in expansion of macro 'JOBCTL_STOPPED'
     937 |                                 t->jobctl &= ~JOBCTL_STOPPED;
         |                                               ^~~~~~~~~~~~~~
   kernel/signal.c: In function 'wants_signal':
   include/linux/sched/jobctl.h:36:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      36 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched.h:123:70: note: in expansion of macro 'JOBCTL_STOPPED'
     123 | #define task_is_stopped_or_traced(task) ((READ_ONCE(task->jobctl) & (JOBCTL_STOPPED | JOBCTL_TRACED)) != 0)
         |                                                                      ^~~~~~~~~~~~~~
   kernel/signal.c:991:13: note: in expansion of macro 'task_is_stopped_or_traced'
     991 |         if (task_is_stopped_or_traced(p))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from kernel/signal.c:14:
   kernel/signal.c: In function 'do_notify_parent':
   include/linux/sched/jobctl.h:36:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      36 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   kernel/signal.c:2041:9: note: in expansion of macro 'BUG_ON'
    2041 |         BUG_ON(task_is_stopped_or_traced(tsk));
         |         ^~~~~~
   include/linux/sched.h:123:70: note: in expansion of macro 'JOBCTL_STOPPED'
     123 | #define task_is_stopped_or_traced(task) ((READ_ONCE(task->jobctl) & (JOBCTL_STOPPED | JOBCTL_TRACED)) != 0)
         |                                                                      ^~~~~~~~~~~~~~
   kernel/signal.c:2041:16: note: in expansion of macro 'task_is_stopped_or_traced'
    2041 |         BUG_ON(task_is_stopped_or_traced(tsk));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/signal.c: In function 'ptrace_stop':
>> kernel/signal.c:2371:73: error: 'JOBCTL_TRACE_QUIESCE' undeclared (first use in this function); did you mean 'JOBCTL_TRACED_QUIESCE'?
    2371 |         current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_DELAY_WAKEKILL | JOBCTL_TRACE_QUIESCE);
         |                                                                         ^~~~~~~~~~~~~~~~~~~~
         |                                                                         JOBCTL_TRACED_QUIESCE
   In file included from include/linux/sched/signal.h:8,
                    from include/linux/sched/cputime.h:5,
                    from kernel/signal.c:22:
   kernel/signal.c: In function 'do_signal_stop':
   include/linux/sched/jobctl.h:36:41: error: 'JOBCTL_STOPPED_BIT' undeclared (first use in this function); did you mean 'JOBCTL_STOPPED'?
      36 | #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/sched.h:122:69: note: in expansion of macro 'JOBCTL_STOPPED'
     122 | #define task_is_stopped(task)           ((READ_ONCE(task->jobctl) & JOBCTL_STOPPED) != 0)
         |                                                                     ^~~~~~~~~~~~~~
   kernel/signal.c:2482:30: note: in expansion of macro 'task_is_stopped'
    2482 |                         if (!task_is_stopped(t) &&
         |                              ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2371 kernel/signal.c

  2207	
  2208	/*
  2209	 * This must be called with current->sighand->siglock held.
  2210	 *
  2211	 * This should be the path for all ptrace stops.
  2212	 * We always set current->last_siginfo while stopped here.
  2213	 * That makes it a way to test a stopped process for
  2214	 * being ptrace-stopped vs being job-control-stopped.
  2215	 *
  2216	 * Returns the signal the ptracer requested the code resume
  2217	 * with.  If the code did not stop because the tracer is gone,
  2218	 * the stop signal remains unchanged unless clear_code.
  2219	 */
  2220	static int ptrace_stop(int exit_code, int why, int clear_code,
  2221				unsigned long message, kernel_siginfo_t *info)
  2222		__releases(&current->sighand->siglock)
  2223		__acquires(&current->sighand->siglock)
  2224	{
  2225		bool gstop_done = false;
  2226		bool read_code = true;
  2227	
  2228		if (arch_ptrace_stop_needed()) {
  2229			/*
  2230			 * The arch code has something special to do before a
  2231			 * ptrace stop.  This is allowed to block, e.g. for faults
  2232			 * on user stack pages.  We can't keep the siglock while
  2233			 * calling arch_ptrace_stop, so we must release it now.
  2234			 * To preserve proper semantics, we must do this before
  2235			 * any signal bookkeeping like checking group_stop_count.
  2236			 */
  2237			spin_unlock_irq(&current->sighand->siglock);
  2238			arch_ptrace_stop();
  2239			spin_lock_irq(&current->sighand->siglock);
  2240		}
  2241	
  2242		/* Don't stop if the task is dying. */
  2243		if (unlikely(__fatal_signal_pending(current)))
  2244			return exit_code;
  2245	
  2246		/*
  2247		 * schedule() will not sleep if there is a pending signal that
  2248		 * can awaken the task.
  2249		 */
  2250		current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE;
  2251		set_special_state(TASK_TRACED);
  2252	
  2253		/*
  2254		 * We're committing to trapping.  TRACED should be visible before
  2255		 * TRAPPING is cleared; otherwise, the tracer might fail do_wait().
  2256		 * Also, transition to TRACED and updates to ->jobctl should be
  2257		 * atomic with respect to siglock and should be done after the arch
  2258		 * hook as siglock is released and regrabbed across it.
  2259		 *
  2260		 *     TRACER				    TRACEE
  2261		 *
  2262		 *     ptrace_attach()
  2263		 * [L]   wait_on_bit(JOBCTL_TRAPPING)	[S] set_special_state(TRACED)
  2264		 *     do_wait()
  2265		 *       set_current_state()                smp_wmb();
  2266		 *       ptrace_do_wait()
  2267		 *         wait_task_stopped()
  2268		 *           task_stopped_code()
  2269		 * [L]         task_is_traced()		[S] task_clear_jobctl_trapping();
  2270		 */
  2271		smp_wmb();
  2272	
  2273		current->ptrace_message = message;
  2274		current->last_siginfo = info;
  2275		current->exit_code = exit_code;
  2276	
  2277		/*
  2278		 * If @why is CLD_STOPPED, we're trapping to participate in a group
  2279		 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
  2280		 * across siglock relocks since INTERRUPT was scheduled, PENDING
  2281		 * could be clear now.  We act as if SIGCONT is received after
  2282		 * TASK_TRACED is entered - ignore it.
  2283		 */
  2284		if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
  2285			gstop_done = task_participate_group_stop(current);
  2286	
  2287		/* any trap clears pending STOP trap, STOP trap clears NOTIFY */
  2288		task_clear_jobctl_pending(current, JOBCTL_TRAP_STOP);
  2289		if (info && info->si_code >> 8 == PTRACE_EVENT_STOP)
  2290			task_clear_jobctl_pending(current, JOBCTL_TRAP_NOTIFY);
  2291	
  2292		/* entering a trap, clear TRAPPING */
  2293		task_clear_jobctl_trapping(current);
  2294	
  2295		spin_unlock_irq(&current->sighand->siglock);
  2296		read_lock(&tasklist_lock);
  2297		if (likely(current->ptrace)) {
  2298			/*
  2299			 * Notify parents of the stop.
  2300			 *
  2301			 * While ptraced, there are two parents - the ptracer and
  2302			 * the real_parent of the group_leader.  The ptracer should
  2303			 * know about every stop while the real parent is only
  2304			 * interested in the completion of group stop.  The states
  2305			 * for the two don't interact with each other.  Notify
  2306			 * separately unless they're gonna be duplicates.
  2307			 */
  2308			do_notify_parent_cldstop(current, true, why);
  2309			if (gstop_done && ptrace_reparented(current))
  2310				do_notify_parent_cldstop(current, false, why);
  2311	
  2312			/*
  2313			 * Don't want to allow preemption here, because
  2314			 * sys_ptrace() needs this task to be inactive.
  2315			 */
  2316			preempt_disable();
  2317			read_unlock(&tasklist_lock);
  2318			cgroup_enter_frozen(); // XXX broken on PREEMPT_RT !!!
  2319	
  2320			/*
  2321			 * JOBCTL_TRACE_QUIESCE bridges the gap between
  2322			 * set_current_state(TASK_TRACED) above and schedule() below.
  2323			 * There must not be any blocking (specifically anything that
  2324			 * touched ->saved_state on PREEMPT_RT) between here and
  2325			 * schedule().
  2326			 *
  2327			 * ptrace_check_attach() relies on this with its
  2328			 * wait_task_inactive() usage.
  2329			 */
  2330			clear_traced_quiesce();
  2331	
  2332			preempt_enable_no_resched();
  2333			freezable_schedule();
  2334	
  2335			cgroup_leave_frozen(true);
  2336		} else {
  2337			/*
  2338			 * By the time we got the lock, our tracer went away.
  2339			 * Don't drop the lock yet, another tracer may come.
  2340			 *
  2341			 * If @gstop_done, the ptracer went away between group stop
  2342			 * completion and here.  During detach, it would have set
  2343			 * JOBCTL_STOP_PENDING on us and we'll re-enter
  2344			 * TASK_STOPPED in do_signal_stop() on return, so notifying
  2345			 * the real parent of the group stop completion is enough.
  2346			 */
  2347			if (gstop_done)
  2348				do_notify_parent_cldstop(current, false, why);
  2349	
  2350			/* tasklist protects us from ptrace_freeze_traced() */
  2351			__set_current_state(TASK_RUNNING);
  2352			read_code = false;
  2353			if (clear_code)
  2354				exit_code = 0;
  2355			read_unlock(&tasklist_lock);
  2356		}
  2357	
  2358		/*
  2359		 * We are back.  Now reacquire the siglock before touching
  2360		 * last_siginfo, so that we are sure to have synchronized with
  2361		 * any signal-sending on another CPU that wants to examine it.
  2362		 */
  2363		spin_lock_irq(&current->sighand->siglock);
  2364		if (read_code)
  2365			exit_code = current->exit_code;
  2366		current->last_siginfo = NULL;
  2367		current->ptrace_message = 0;
  2368		current->exit_code = 0;
  2369	
  2370		/* LISTENING can be set only during STOP traps, clear it */
> 2371		current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_DELAY_WAKEKILL | JOBCTL_TRACE_QUIESCE);
  2372	
  2373		/*
  2374		 * Queued signals ignored us while we were stopped for tracing.
  2375		 * So check for any that we should take before resuming user mode.
  2376		 * This sets TIF_SIGPENDING, but never clears it.
  2377		 */
  2378		recalc_sigpending_tsk(current);
  2379		return exit_code;
  2380	}
  2381	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
