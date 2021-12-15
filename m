Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F14751DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbhLOFIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:08:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:60408 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236684AbhLOFIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639544927; x=1671080927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+AEdYU4ZuYqOGfLqU8zUxvFikcszv+90A04AzldWiG8=;
  b=ePXlrNq+4hzyjZsAeb3ePY7D704dOOF+RQ8CNIakv2OtMl9uNfo+BVc8
   yW8Yg2z0ThBOKt6blz/aNaeyNmpTcbyjgutP00uGjMl8RBpovYwm9sKWZ
   KzJz6eijArnkGF75v54NRlxJyU3btJdh9vGTtSCi3LhoXtL4LNtqnAWMP
   pF5E+5DMXJw6UtcxwK57Hih004guNNnaCYvGVTfgNh1NEPyTHblJrjgTN
   m/bJnwyYj0yV3eg4GFJ5+UoF4F9c84xtNNUpJv4sh97+IuCdQ9P0y/2sO
   G3rq5njt1bQfzdhB7ZcorEvY10uj4wO+FuDIIAbxYDiyoFbXc41Yz7kEe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219163921"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219163921"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 21:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="584053146"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2021 21:08:45 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxMWy-0001Ig-MV; Wed, 15 Dec 2021 05:08:44 +0000
Date:   Wed, 15 Dec 2021 13:07:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.12.09b 35/37] kernel/rcu/tree.c:4072:16:
 warning: variable 'lseq' set but not used
Message-ID: <202112151339.x3VR9Ztf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.09b
head:   0f1825f9df5a83cfeca5f1ecce96633223bf78d2
commit: ca34220fecf856ef7521c912a8812f2c1ea53ab3 [35/37] rcu: Rework rcu_barrier() and callback-migration logic
config: x86_64-randconfig-a011-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151339.x3VR9Ztf-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=ca34220fecf856ef7521c912a8812f2c1ea53ab3
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2021.12.09b
        git checkout ca34220fecf856ef7521c912a8812f2c1ea53ab3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/rcu/tree.c:1180:19: warning: variable 'rnp' set but not used [-Wunused-but-set-variable]
           struct rcu_node *rnp;
                            ^
>> kernel/rcu/tree.c:4072:16: warning: variable 'lseq' set but not used [-Wunused-but-set-variable]
           unsigned long lseq;
                         ^
   2 warnings generated.


vim +/lseq +4072 kernel/rcu/tree.c

  4058	
  4059	/**
  4060	 * rcu_barrier - Wait until all in-flight call_rcu() callbacks complete.
  4061	 *
  4062	 * Note that this primitive does not necessarily wait for an RCU grace period
  4063	 * to complete.  For example, if there are no RCU callbacks queued anywhere
  4064	 * in the system, then rcu_barrier() is within its rights to return
  4065	 * immediately, without waiting for anything, much less an RCU grace period.
  4066	 */
  4067	void rcu_barrier(void)
  4068	{
  4069		uintptr_t cpu;
  4070		unsigned long flags;
  4071		unsigned long gseq;
> 4072		unsigned long lseq;
  4073		struct rcu_data *rdp;
  4074		unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
  4075	
  4076		rcu_barrier_trace(TPS("Begin"), -1, s);
  4077	
  4078		/* Take mutex to serialize concurrent rcu_barrier() requests. */
  4079		mutex_lock(&rcu_state.barrier_mutex);
  4080	
  4081		/* Did someone else do our work for us? */
  4082		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
  4083			rcu_barrier_trace(TPS("EarlyExit"), -1, rcu_state.barrier_sequence);
  4084			smp_mb(); /* caller's subsequent code after above check. */
  4085			mutex_unlock(&rcu_state.barrier_mutex);
  4086			return;
  4087		}
  4088	
  4089		/* Mark the start of the barrier operation. */
  4090		lseq = rcu_state.barrier_sequence;
  4091		rcu_seq_start(&rcu_state.barrier_sequence);
  4092		gseq = rcu_state.barrier_sequence;
  4093		rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
  4094	
  4095		/*
  4096		 * Initialize the count to two rather than to zero in order
  4097		 * to avoid a too-soon return to zero in case of an immediate
  4098		 * invocation of the just-enqueued callback (or preemption of
  4099		 * this task).  Exclude CPU-hotplug operations to ensure that no
  4100		 * offline non-offloaded CPU has callbacks queued.
  4101		 */
  4102		init_completion(&rcu_state.barrier_completion);
  4103		atomic_set(&rcu_state.barrier_cpu_count, 2);
  4104		cpus_read_lock();
  4105	
  4106		/*
  4107		 * Force each CPU with callbacks to register a new callback.
  4108		 * When that callback is invoked, we will know that all of the
  4109		 * corresponding CPU's preceding callbacks have been invoked.
  4110		 */
  4111		for_each_possible_cpu(cpu) {
  4112			rdp = per_cpu_ptr(&rcu_data, cpu);
  4113	retry:
  4114			if (READ_ONCE(rdp->barrier_seq_snap) == gseq)
  4115				continue;
  4116			if (!rcu_segcblist_n_cbs(&rdp->cblist)) {
  4117				raw_spin_lock_irqsave(&rdp->barrier_lock, flags);
  4118				WRITE_ONCE(rdp->barrier_seq_snap, gseq);
  4119				raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
  4120				rcu_barrier_trace(TPS("NQ"), cpu, rcu_state.barrier_sequence);
  4121				continue;
  4122			}
  4123			if (rcu_rdp_cpu_online(rdp)) {
  4124				if (smp_call_function_single(cpu, rcu_barrier_handler, (void *)cpu, 1)) {
  4125					schedule_timeout_uninterruptible(1);
  4126					goto retry;
  4127				}
  4128				WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
  4129				rcu_barrier_trace(TPS("OnlineQ"), cpu, rcu_state.barrier_sequence);
  4130				continue;
  4131			}
  4132			if (!rcu_barrier_entrain_if_ofl(rdp)) {
  4133				schedule_timeout_uninterruptible(1);
  4134				goto retry;
  4135			}
  4136			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
  4137			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu, rcu_state.barrier_sequence);
  4138		}
  4139		cpus_read_unlock();
  4140	
  4141		/*
  4142		 * Now that we have an rcu_barrier_callback() callback on each
  4143		 * CPU, and thus each counted, remove the initial count.
  4144		 */
  4145		if (atomic_sub_and_test(2, &rcu_state.barrier_cpu_count))
  4146			complete(&rcu_state.barrier_completion);
  4147	
  4148		/* Wait for all rcu_barrier_callback() callbacks to be invoked. */
  4149		wait_for_completion(&rcu_state.barrier_completion);
  4150	
  4151		/* Mark the end of the barrier operation. */
  4152		rcu_barrier_trace(TPS("Inc2"), -1, rcu_state.barrier_sequence);
  4153		rcu_seq_end(&rcu_state.barrier_sequence);
  4154		gseq = rcu_state.barrier_sequence;
  4155		for_each_possible_cpu(cpu) {
  4156			rdp = per_cpu_ptr(&rcu_data, cpu);
  4157	
  4158			WRITE_ONCE(rdp->barrier_seq_snap, gseq);
  4159		}
  4160	
  4161		/* Other rcu_barrier() invocations can now safely proceed. */
  4162		mutex_unlock(&rcu_state.barrier_mutex);
  4163	}
  4164	EXPORT_SYMBOL_GPL(rcu_barrier);
  4165	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
