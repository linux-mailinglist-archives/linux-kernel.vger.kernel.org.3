Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B861572B63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiGMCms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGMCmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:42:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970A774A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657680164; x=1689216164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bASeb/bI2wTIGm4pAuDNCdMU3wR1TB9dFhSh8xnMDrg=;
  b=Dwpl1LXH3INTdgandu9Cus7djEEe47dNpfsF7lNxpHtuoOdN40DKOgi6
   j74Fv8EG5U7v+Eoy+UFERYwQYivJNTUViqAyaniAjC25JDqP4yIQUYM4C
   kOJSAGSo417wwwkZTaNVYFyItm5Wkr30f3EoOrFUSkpP/3QbPKpXMvywO
   jdWUu81rK0wraYhxGRloYlrwWrGqAJKafmuSvVsO+TjUg2WB2sj0x7Idb
   1zKc0U/oUawgD2qkOtbqYUcjgTI1xfiBSVMx9cWDOMAUudEYZY/LVjR1l
   aUWLPq3cWfaRBKaE+ZN2YjG4c8CGpm6hTqsj0tJ/i2GCnPmpZBBuDm6/J
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285838212"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285838212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 19:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="628124176"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2022 19:42:43 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBSKo-0002zF-Qf;
        Wed, 13 Jul 2022 02:42:42 +0000
Date:   Wed, 13 Jul 2022 10:42:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 4/13] arch/x86/mm/tlb.c:496:23: warning: unused variable
 'prev_lam'
Message-ID: <202207131026.3B0WbQwF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   ca9762d59aa41bc0a580c2f7668038d31c991f59
commit: ce8762cf0c572b53a82a08a369376c28cfb6fda4 [4/13] x86/mm: Handle LAM on context switch
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220713/202207131026.3B0WbQwF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=ce8762cf0c572b53a82a08a369376c28cfb6fda4
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout ce8762cf0c572b53a82a08a369376c28cfb6fda4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/mm/tlb.c: In function 'switch_mm_irqs_off':
>> arch/x86/mm/tlb.c:496:23: warning: unused variable 'prev_lam' [-Wunused-variable]
     496 |         unsigned long prev_lam = tlbstate_lam_cr3_mask();
         |                       ^~~~~~~~


vim +/prev_lam +496 arch/x86/mm/tlb.c

   490	
   491	void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
   492				struct task_struct *tsk)
   493	{
   494		struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
   495		u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 > 496		unsigned long prev_lam = tlbstate_lam_cr3_mask();
   497		unsigned long new_lam = mm_lam_cr3_mask(next);
   498		bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
   499		unsigned cpu = smp_processor_id();
   500		u64 next_tlb_gen;
   501		bool need_flush;
   502		u16 new_asid;
   503	
   504		/*
   505		 * NB: The scheduler will call us with prev == next when switching
   506		 * from lazy TLB mode to normal mode if active_mm isn't changing.
   507		 * When this happens, we don't assume that CR3 (and hence
   508		 * cpu_tlbstate.loaded_mm) matches next.
   509		 *
   510		 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
   511		 */
   512	
   513		/* We don't want flush_tlb_func() to run concurrently with us. */
   514		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
   515			WARN_ON_ONCE(!irqs_disabled());
   516	
   517		/*
   518		 * Verify that CR3 is what we think it is.  This will catch
   519		 * hypothetical buggy code that directly switches to swapper_pg_dir
   520		 * without going through leave_mm() / switch_mm_irqs_off() or that
   521		 * does something like write_cr3(read_cr3_pa()).
   522		 *
   523		 * Only do this check if CONFIG_DEBUG_VM=y because __read_cr3()
   524		 * isn't free.
   525		 */
   526	#ifdef CONFIG_DEBUG_VM
   527		if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
   528			/*
   529			 * If we were to BUG here, we'd be very likely to kill
   530			 * the system so hard that we don't see the call trace.
   531			 * Try to recover instead by ignoring the error and doing
   532			 * a global flush to minimize the chance of corruption.
   533			 *
   534			 * (This is far from being a fully correct recovery.
   535			 *  Architecturally, the CPU could prefetch something
   536			 *  back into an incorrect ASID slot and leave it there
   537			 *  to cause trouble down the road.  It's better than
   538			 *  nothing, though.)
   539			 */
   540			__flush_tlb_all();
   541		}
   542	#endif
   543		if (was_lazy)
   544			this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
   545	
   546		/*
   547		 * The membarrier system call requires a full memory barrier and
   548		 * core serialization before returning to user-space, after
   549		 * storing to rq->curr, when changing mm.  This is because
   550		 * membarrier() sends IPIs to all CPUs that are in the target mm
   551		 * to make them issue memory barriers.  However, if another CPU
   552		 * switches to/from the target mm concurrently with
   553		 * membarrier(), it can cause that CPU not to receive an IPI
   554		 * when it really should issue a memory barrier.  Writing to CR3
   555		 * provides that full memory barrier and core serializing
   556		 * instruction.
   557		 */
   558		if (real_prev == next) {
   559			VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
   560				   next->context.ctx_id);
   561	
   562			/*
   563			 * Even in lazy TLB mode, the CPU should stay set in the
   564			 * mm_cpumask. The TLB shootdown code can figure out from
   565			 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
   566			 */
   567			if (WARN_ON_ONCE(real_prev != &init_mm &&
   568					 !cpumask_test_cpu(cpu, mm_cpumask(next))))
   569				cpumask_set_cpu(cpu, mm_cpumask(next));
   570	
   571			/*
   572			 * If the CPU is not in lazy TLB mode, we are just switching
   573			 * from one thread in a process to another thread in the same
   574			 * process. No TLB flush required.
   575			 */
   576			if (!was_lazy)
   577				return;
   578	
   579			/*
   580			 * Read the tlb_gen to check whether a flush is needed.
   581			 * If the TLB is up to date, just use it.
   582			 * The barrier synchronizes with the tlb_gen increment in
   583			 * the TLB shootdown code.
   584			 */
   585			smp_mb();
   586			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
   587			if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
   588					next_tlb_gen)
   589				return;
   590	
   591			/*
   592			 * TLB contents went out of date while we were in lazy
   593			 * mode. Fall through to the TLB switching code below.
   594			 */
   595			new_asid = prev_asid;
   596			need_flush = true;
   597		} else {
   598			/*
   599			 * Apply process to process speculation vulnerability
   600			 * mitigations if applicable.
   601			 */
   602			cond_mitigation(tsk);
   603	
   604			/*
   605			 * Stop remote flushes for the previous mm.
   606			 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
   607			 * but the bitmap manipulation can cause cache line contention.
   608			 */
   609			if (real_prev != &init_mm) {
   610				VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
   611							mm_cpumask(real_prev)));
   612				cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
   613			}
   614	
   615			/*
   616			 * Start remote flushes and then read tlb_gen.
   617			 */
   618			if (next != &init_mm)
   619				cpumask_set_cpu(cpu, mm_cpumask(next));
   620			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
   621	
   622			choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
   623	
   624			/* Let nmi_uaccess_okay() know that we're changing CR3. */
   625			this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
   626			barrier();
   627		}
   628	
   629		set_tlbstate_cr3_lam_mask(new_lam);
   630		if (need_flush) {
   631			this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
   632			this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
   633			load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
   634	
   635			trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
   636		} else {
   637			/* The new ASID is already up to date. */
   638			load_new_mm_cr3(next->pgd, new_asid, new_lam, false);
   639	
   640			trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
   641		}
   642	
   643		/* Make sure we write CR3 before loaded_mm. */
   644		barrier();
   645	
   646		this_cpu_write(cpu_tlbstate.loaded_mm, next);
   647		this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
   648	
   649		if (next != real_prev) {
   650			cr4_update_pce_mm(next);
   651			switch_ldt(real_prev, next);
   652		}
   653	}
   654	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
