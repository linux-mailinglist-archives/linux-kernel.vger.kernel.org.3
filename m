Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0C956C406
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiGHWmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGHWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:42:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF2B13B469
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657320134; x=1688856134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qubbRfi0xdqdhJnB01xhIJVXEJ0TvRCr5886tA066dc=;
  b=YHC9t4GnydZnHjsRUmag1LBbindM68Igu/UNZEniHU0g1mWYCO7ONWT5
   o1IXdeUWmOzcGgLlXfcZglN21ttn+HPo5cmTMcXfJWSb4hxDrD7rWxsO1
   Jdg73QRUATYep3JAjP/EfnGpxm0dfVH4RF9/MmGGZAqMSri6Fgpz7mBIC
   gw3adzGBYrL9yyBf5UKF0D60MgXRcZzTctQJsqnNXQx2HhWTLw0IL7uEy
   UozsRGQBNsyJODK2GKjYyV0LOakE3p7hEYStPmfXk+6AOlACebgfvfGmz
   sKyoo7YPTeNDzwObbtcEplcU+ZkyB/6bYEJu8jt0BU9ASZfqiV3tkrBPP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="346065528"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="346065528"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 15:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="921151105"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2022 15:42:11 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9wfq-000O0w-RH;
        Fri, 08 Jul 2022 22:42:10 +0000
Date:   Sat, 9 Jul 2022 06:41:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 177/411]
 arch/x86/kvm/mmu/tdp_mmu.c:651:17: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202207090603.yuv3ek6F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   36253a6ed7e922a2e6888cde465578b98145404e
commit: c602b2f7cd6637d6149fd47022a75349ac414a59 [177/411] KVM: x86/tdp_mmu: Support TDX private mapping for TDP MMU
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220709/202207090603.yuv3ek6F-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/c602b2f7cd6637d6149fd47022a75349ac414a59
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout c602b2f7cd6637d6149fd47022a75349ac414a59
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kvm/mmu/tdp_mmu.c:651:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu * @@
   arch/x86/kvm/mmu/tdp_mmu.c:651:17: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:651:17: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>> arch/x86/kvm/mmu/tdp_mmu.c:1344:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1344:25: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1344:25: sparse:     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:1611:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1611:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1611:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:416:9: sparse: sparse: context imbalance in 'tdp_mmu_unlink_sp' - different lock contexts for basic block
>> arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c: note: in included file (through include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h, ...):
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in '__tdp_mmu_zap_root' - unexpected unlock
>> arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     got unsigned long long [usertype] *sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     got unsigned long long [usertype] *sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     got unsigned long long [usertype] *sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     got unsigned long long [usertype] *sptep
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in 'tdp_mmu_alloc_sp_for_split' - unexpected unlock
>> arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     got unsigned long long [usertype] *sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:754:42: sparse:     got unsigned long long [usertype] *sptep

vim +651 arch/x86/kvm/mmu/tdp_mmu.c

   533	
   534	/**
   535	 * __handle_changed_spte - handle bookkeeping associated with an SPTE change
   536	 * @kvm: kvm instance
   537	 * @as_id: the address space of the paging structure the SPTE was a part of
   538	 * @gfn: the base GFN that was mapped by the SPTE
   539	 * @private_spte: the SPTE is private or not
   540	 * @old_spte: The value of the SPTE before the change
   541	 * @new_spte: The value of the SPTE after the change
   542	 * @level: the level of the PT the SPTE is part of in the paging structure
   543	 * @shared: This operation may not be running under the exclusive use of
   544	 *	    the MMU lock and the operation must synchronize with other
   545	 *	    threads that might be modifying SPTEs.
   546	 *
   547	 * Handle bookkeeping that might result from the modification of a SPTE.
   548	 * This function must be called for all TDP SPTE modifications.
   549	 */
   550	static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
   551					  bool private_spte, u64 old_spte,
   552					  u64 new_spte, int level, bool shared)
   553	{
   554		bool was_present = is_shadow_present_pte(old_spte);
   555		bool is_present = is_shadow_present_pte(new_spte);
   556		bool was_leaf = was_present && is_last_spte(old_spte, level);
   557		bool is_leaf = is_present && is_last_spte(new_spte, level);
   558		kvm_pfn_t old_pfn = spte_to_pfn(old_spte);
   559		kvm_pfn_t new_pfn = spte_to_pfn(new_spte);
   560		bool pfn_changed = old_pfn != new_pfn;
   561		struct kvm_spte_change change = {
   562			.gfn = gfn,
   563			.level = level,
   564			.old = {
   565				.pfn = old_pfn,
   566				.is_present = was_present,
   567				.is_leaf = was_leaf,
   568			},
   569			.new = {
   570				.pfn = new_pfn,
   571				.is_present = is_present,
   572				.is_leaf = is_leaf,
   573			},
   574		};
   575	
   576		WARN_ON(level > PT64_ROOT_MAX_LEVEL);
   577		WARN_ON(level < PG_LEVEL_4K);
   578		WARN_ON(gfn & (KVM_PAGES_PER_HPAGE(level) - 1));
   579	
   580		/*
   581		 * If this warning were to trigger it would indicate that there was a
   582		 * missing MMU notifier or a race with some notifier handler.
   583		 * A present, leaf SPTE should never be directly replaced with another
   584		 * present leaf SPTE pointing to a different PFN. A notifier handler
   585		 * should be zapping the SPTE before the main MM's page table is
   586		 * changed, or the SPTE should be zeroed, and the TLBs flushed by the
   587		 * thread before replacement.
   588		 */
   589		if (was_leaf && is_leaf && pfn_changed) {
   590			pr_err("Invalid SPTE change: cannot replace a present leaf\n"
   591			       "SPTE with another present leaf SPTE mapping a\n"
   592			       "different PFN!\n"
   593			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   594			       as_id, gfn, old_spte, new_spte, level);
   595	
   596			/*
   597			 * Crash the host to prevent error propagation and guest data
   598			 * corruption.
   599			 */
   600			BUG();
   601		}
   602	
   603		if (old_spte == new_spte)
   604			return;
   605	
   606		trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
   607	
   608		if (is_leaf)
   609			check_spte_writable_invariants(new_spte);
   610	
   611		/*
   612		 * The only times a SPTE should be changed from a non-present to
   613		 * non-present state is when an MMIO entry is installed/modified/
   614		 * removed. In that case, there is nothing to do here.
   615		 */
   616		if (!was_present && !is_present) {
   617			/*
   618			 * If this change does not involve a MMIO SPTE or removed SPTE,
   619			 * it is unexpected. Log the change, though it should not
   620			 * impact the guest since both the former and current SPTEs
   621			 * are nonpresent.
   622			 */
   623			if (WARN_ON(!is_mmio_spte(kvm, old_spte) &&
   624				    !is_mmio_spte(kvm, new_spte) &&
   625				    !is_removed_spte(new_spte)))
   626				pr_err("Unexpected SPTE change! Nonpresent SPTEs\n"
   627				       "should not be replaced with another,\n"
   628				       "different nonpresent SPTE, unless one or both\n"
   629				       "are MMIO SPTEs, or the new SPTE is\n"
   630				       "a temporary removed SPTE.\n"
   631				       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   632				       as_id, gfn, old_spte, new_spte, level);
   633			return;
   634		}
   635	
   636		if (is_leaf != was_leaf)
   637			kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
   638	
   639		if (was_leaf && is_dirty_spte(old_spte) &&
   640		    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
   641			kvm_set_pfn_dirty(old_pfn);
   642	
   643		/*
   644		 * Recursively handle child PTs if the change removed a subtree from
   645		 * the paging structure.  Note the WARN on the PFN changing without the
   646		 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
   647		 * pages are kernel allocations and should never be migrated.
   648		 */
   649		if (was_present && !was_leaf &&
   650		    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 > 651			WARN_ON(private_spte !=
   652				is_private_sptep(spte_to_child_pt(old_spte, level)));
   653			handle_removed_pt(kvm, spte_to_child_pt(old_spte, level),
   654					  private_spte, shared);
   655		}
   656	
   657		/*
   658		 * Special handling for the private mapping.  We are either
   659		 * setting up new mapping at middle level page table, or leaf,
   660		 * or tearing down existing mapping.
   661		 *
   662		 * This is after handling lower page table by above
   663		 * handle_remove_tdp_mmu_page().  S-EPT requires to remove S-EPT tables
   664		 * after removing childrens.
   665		 */
   666		if (private_spte &&
   667		    /* Ignore change of software only bits. e.g. host_writable */
   668		    (was_leaf != is_leaf || was_present != is_present || pfn_changed)) {
   669			void *sept_page = NULL;
   670	
   671			if (is_present && !is_leaf) {
   672				struct kvm_mmu_page *sp = to_shadow_page(pfn_to_hpa(new_pfn));
   673	
   674				sept_page = kvm_mmu_private_sp(sp);
   675				WARN_ON(!sept_page);
   676				WARN_ON(sp->role.level + 1 != level);
   677				WARN_ON(sp->gfn != gfn);
   678			}
   679			change.sept_page = sept_page;
   680	
   681			static_call(kvm_x86_handle_changed_private_spte)(kvm, &change);
   682		}
   683	}
   684	
   685	static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
   686					bool private_spte, u64 old_spte, u64 new_spte,
   687					int level, bool shared)
   688	{
   689		__handle_changed_spte(kvm, as_id, gfn, private_spte,
   690				old_spte, new_spte, level, shared);
   691		handle_changed_spte_acc_track(old_spte, new_spte, level);
   692		handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
   693					      new_spte, level);
   694	}
   695	
   696	/*
   697	 * tdp_mmu_set_spte_atomic - Set a TDP MMU SPTE atomically
   698	 * and handle the associated bookkeeping.  Do not mark the page dirty
   699	 * in KVM's dirty bitmaps.
   700	 *
   701	 * If setting the SPTE fails because it has changed, iter->old_spte will be
   702	 * refreshed to the current value of the spte.
   703	 *
   704	 * @kvm: kvm instance
   705	 * @iter: a tdp_iter instance currently on the SPTE that should be set
   706	 * @new_spte: The value the SPTE should be set to
   707	 * Return:
   708	 * * 0      - If the SPTE was set.
   709	 * * -EBUSY - If the SPTE cannot be set. In this case this function will have
   710	 *            no side-effects other than setting iter->old_spte to the last
   711	 *            known value of the spte.
   712	 */
   713	static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
   714						  struct tdp_iter *iter,
   715						  u64 new_spte)
   716	{
   717		bool freeze_spte = iter->is_private && !is_removed_spte(new_spte);
   718		u64 tmp_spte = freeze_spte ? REMOVED_SPTE : new_spte;
   719		u64 *sptep = rcu_dereference(iter->sptep);
   720		u64 old_spte;
   721	
   722		/*
   723		 * The caller is responsible for ensuring the old SPTE is not a REMOVED
   724		 * SPTE.  KVM should never attempt to zap or manipulate a REMOVED SPTE,
   725		 * and pre-checking before inserting a new SPTE is advantageous as it
   726		 * avoids unnecessary work.
   727		 */
   728		WARN_ON_ONCE(iter->yielded || is_removed_spte(iter->old_spte));
   729	
   730		lockdep_assert_held_read(&kvm->mmu_lock);
   731	
   732		/*
   733		 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
   734		 * does not hold the mmu_lock.
   735		 */
   736		old_spte = cmpxchg64(sptep, iter->old_spte, tmp_spte);
   737		if (old_spte != iter->old_spte) {
   738			/*
   739			 * The page table entry was modified by a different logical
   740			 * CPU. Refresh iter->old_spte with the current value so the
   741			 * caller operates on fresh data, e.g. if it retries
   742			 * tdp_mmu_set_spte_atomic().
   743			 */
   744			iter->old_spte = old_spte;
   745			return -EBUSY;
   746		}
   747	
   748		__handle_changed_spte(
   749			kvm, iter->as_id, iter->gfn, iter->is_private,
   750			iter->old_spte, new_spte, iter->level, true);
   751		handle_changed_spte_acc_track(iter->old_spte, new_spte, iter->level);
   752	
   753		if (freeze_spte)
 > 754			__kvm_tdp_mmu_write_spte(sptep, new_spte);
   755	
   756		return 0;
   757	}
   758	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
