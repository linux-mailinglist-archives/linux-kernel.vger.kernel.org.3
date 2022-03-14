Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE44D887E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbiCNPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiCNPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83711E0CB;
        Mon, 14 Mar 2022 08:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C45612BE;
        Mon, 14 Mar 2022 15:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A396FC340E9;
        Mon, 14 Mar 2022 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647272937;
        bh=s+TtZRwiP40i13W0ONxdEk+ZBzo1ccAH1/yhq91ObCU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qOZ9SyNSgE5dYpNLYffCb9nmYF2XS1a1E7CXAivcB2D7nSwwlYhvNFeFnJv3GShAz
         K5h4FWPwy3UmipofzaCMWd/cBd+4s5AShvAKtf4r6HO7f/+3zV+A/HdX57WRekLV11
         7ov0FLJ4XqIoYzxeebgZxjt7b500gDNZNY0Rm05cDGJQpjaaCJthdu6HlUhlIgmC9e
         +1/vqHVsb8kG149TaEOCkeH+/voKSmHV7R3FLDBGQSoi8qJxfd4uK0CF11lp/avXcZ
         oMrqVTsJoojIpLTAHP/aHwjtIED910ZSDlQ77pL6DnLtirrmYFAdqSX7WKixXrSu3v
         sit4Xn8H1K9gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4F6635C4167; Mon, 14 Mar 2022 08:48:57 -0700 (PDT)
Date:   Mon, 14 Mar 2022 08:48:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
Subject: Re: [GIT PULL] RCU changes for v5.18
Message-ID: <20220314154857.GA2637810@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314032823.GA2593360@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 08:28:23PM -0700, Paul E. McKenney wrote:
> Hello, Linus,
> 
> Please pull the latest RCU git tree from:

OK, I was apparently unable to distinguish v5.17-rc8 from v5.18 yesterday
evening.  :-/

I will resent both pull requests next week, and please accept my apologies
for the bother.

							Thanx, Paul

> The following changes since commit da123016ca8cb5697366c0b2dd55059b976e67e4:
> 
>   rcu-tasks: Fix computation of CPU-to-list shift counts (2022-01-26 13:04:05 -0800) tags/rcu-urgent.2022.01.26a
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.03.13a
> 
>   # HEAD: d5578190bed3d110203e3b6b29c5a7a39d51c6c0 Merge branches 'exp.2022.02.24a', 'fixes.2022.02.14a', 'rcu_barrier.2022.02.08a', 'rcu-tasks.2022.02.08a', 'rt.2022.02.01b', 'torture.2022.02.01b' and 'torturescript.2022.02.08a' into HEAD (2022-02-24 09:38:46 -0800)
> 
> RCU changes for this cycle were:
> 
> exp.2022.02.24a: Contains a fix for idle detection from Neeraj Upadhyay
> 	and missing access marking detected by KCSAN.
> 
> fixes.2022.02.14a: Miscellaneous fixes.
> 
> rcu_barrier.2022.02.08a: Reduces coupling between rcu_barrier() and
> 	CPU-hotplug operations, so that rcu_barrier() no longer needs
> 	to do cpus_read_lock().  This may also someday allow system
> 	boot to bring CPUs online concurrently.
> 
> rcu-tasks.2022.02.08a: Enable more aggressive movement to per-CPU
> 	queueing when reacting to excessive lock contention due
> 	to workloads placing heavy update-side stress on RCU tasks.
> 
> rt.2022.02.01b: Improvements to RCU priority boosting, including
> 	changes from Neeraj Upadhyay, Zqiang, and Alison Chaiken.
> 
> torture.2022.02.01b: Various fixes improving test robustness and
> 	debug information.
> 
> torturescript.2022.02.08a: Add tests for SRCU size transitions, further
> 	compress torture.sh build products, and improve debug output.
> 
> ----------------------------------------------------------------
> Alison Chaiken (4):
>       rcu: Move kthread_prio bounds-check to a separate function
>       rcu: Make priority of grace-period thread consistent
>       rcu: Elevate priority of offloaded callback threads
>       rcu: Update documentation regarding kthread_prio cmdline parameter
> 
> David Woodhouse (2):
>       rcu: Kill rnp->ofl_seq and use only rcu_state.ofl_lock for exclusion
>       rcu: Add mutex for rcu boost kthread spawning and affinity setting
> 
> Ingo Molnar (2):
>       rcu: Uninline multi-use function: finish_rcuwait()
>       rcu: Remove __read_mostly annotations from rcu_scheduler_active externs
> 
> Neeraj Upadhyay (3):
>       rcu/exp: Fix check for idle context in rcu_exp_handler
>       rcu/nocb: Handle concurrent nocb kthreads creation
>       rcu: Remove unused rcu_state.boost
> 
> Paul E. McKenney (34):
>       rcu: Mark ->expmask access in synchronize_rcu_expedited_wait()
>       rcu: Mark accesses to boost_starttime
>       rcu: Don't deboost before reporting expedited quiescent state
>       rcutorture: Print message before invoking ->cb_barrier()
>       torture: Distinguish kthread stopping and being asked to stop
>       rcutorture: Increase visibility of forward-progress hangs
>       rcutorture: Make rcu_fwd_cb_nodelay be a counter
>       rcutorture: Add end-of-test check to rcu_torture_fwd_prog() loop
>       rcutorture: Fix rcu_fwd_mutex deadlock
>       torture: Wake up kthreads after storing task_struct pointer
>       rcutorture: Enable limited callback-flooding tests of SRCU
>       torture: Drop trailing ^M from console output
>       torture: Allow four-digit repetition numbers for --configs parameter
>       torture: Output per-failed-run summary lines from torture.sh
>       torture: Make kvm.sh summaries note runs having only KCSAN reports
>       torture: Indicate which torture.sh runs' bugs are all KCSAN reports
>       torture: Compress KCSAN as well as KASAN vmlinux files
>       torture: Make kvm-remote.sh try multiple times to download tarball
>       torture: Print only one summary line per run
>       torture: Make kvm-find-errors.sh notice missing vmlinux file
>       torture: Change KVM environment variable to RCUTORTURE
>       rcu: Refactor rcu_barrier() empty-list handling
>       rcu: Rework rcu_barrier() and callback-migration logic
>       rcu: Make rcu_barrier() no longer block CPU-hotplug operations
>       rcu: Create and use an rcu_rdp_cpu_online()
>       rcu-tasks: Use order_base_2() instead of ilog2()
>       rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention
>       torture: Make torture.sh help message match reality
>       rcutorture: Test SRCU size transitions
>       rcutorture: Provide non-power-of-two Tasks RCU scenarios
>       MAINTAINERS:  Add Frederic and Neeraj to their RCU files
>       rcu: Inline __call_rcu() into call_rcu()
>       rcu: Mark writes to the rcu_segcblist structure's ->flags field
>       Merge branches 'exp.2022.02.24a', 'fixes.2022.02.14a', 'rcu_barrier.2022.02.08a', 'rcu-tasks.2022.02.08a', 'rt.2022.02.01b', 'torture.2022.02.01b' and 'torturescript.2022.02.08a' into HEAD
> 
> Uladzislau Rezki (Sony) (1):
>       rcu: Fix description of kvfree_rcu()
> 
> Yury Norov (1):
>       rcu: Replace cpumask_weight with cpumask_empty where appropriate
> 
> Zqiang (3):
>       rcu: Create per-cpu rcuc kthreads only when rcutree.use_softirq=0
>       rcu: Add per-CPU rcuc task dumps to RCU CPU stall warnings
>       kasan: Record work creation stack trace with interrupts enabled
> 
>  Documentation/admin-guide/kernel-parameters.txt    |   2 +
>  MAINTAINERS                                        |   2 +
>  include/linux/rcupdate.h                           |   4 +-
>  include/linux/rcutree.h                            |   2 +-
>  include/linux/rcuwait.h                            |   6 +-
>  include/trace/events/rcu.h                         |   9 +-
>  kernel/rcu/rcu_segcblist.h                         |   4 +-
>  kernel/rcu/rcutorture.c                            |  41 ++-
>  kernel/rcu/tasks.h                                 |   6 +-
>  kernel/rcu/tree.c                                  | 328 ++++++++++++---------
>  kernel/rcu/tree.h                                  |  18 +-
>  kernel/rcu/tree_exp.h                              |   5 +-
>  kernel/rcu/tree_nocb.h                             |  18 +-
>  kernel/rcu/tree_plugin.h                           |  31 +-
>  kernel/rcu/tree_stall.h                            |  35 +++
>  kernel/rcu/update.c                                |   7 +
>  kernel/torture.c                                   |   6 +-
>  .../selftests/rcutorture/bin/console-badness.sh    |   2 +-
>  .../testing/selftests/rcutorture/bin/kvm-again.sh  |   4 +-
>  .../selftests/rcutorture/bin/kvm-check-branches.sh |   4 +-
>  .../selftests/rcutorture/bin/kvm-end-run-stats.sh  |   4 +-
>  .../selftests/rcutorture/bin/kvm-find-errors.sh    |   6 +
>  .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   2 +-
>  .../testing/selftests/rcutorture/bin/kvm-remote.sh |  25 +-
>  tools/testing/selftests/rcutorture/bin/kvm.sh      |  16 +-
>  .../selftests/rcutorture/bin/parse-console.sh      |  10 +
>  tools/testing/selftests/rcutorture/bin/torture.sh  |  38 ++-
>  .../selftests/rcutorture/configs/rcu/RUDE01        |   2 +-
>  .../selftests/rcutorture/configs/rcu/SRCU-N.boot   |   1 +
>  .../selftests/rcutorture/configs/rcu/SRCU-P.boot   |   2 +
>  .../selftests/rcutorture/configs/rcu/TRACE01       |   2 +-
>  31 files changed, 400 insertions(+), 242 deletions(-)
