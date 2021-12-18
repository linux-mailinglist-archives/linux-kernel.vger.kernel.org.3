Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EF7479AEF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhLRNDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:03:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:34613 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhLRNDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639832626; x=1671368626;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r9+lO289n/FBevgsvoMdHxApWKFMhLuUdJB3/C0lr7c=;
  b=KKkfI9hOjMXK1R4aWRtReOL5OBBSClUMX6lwbGf6ZL/dOtDClEwecYt1
   4VOdTF+7UgvT80Szvv+GNIWIAjOHappYLZ3eySTqpJwIgsT6kmcZX0y3s
   ScwKzZA/WBnEQzb8Y4ILbQ0Fu8aDIyOWfRAQsBQnguHbACtX3Le5wnNDu
   ILgRihlAMLQ1t4/Ice+jziGrNESahZI0iSQcVFyO7eeWL/fM1d6+LTig7
   wunuuMayFfm3aa7d/bHmjsakrwtU2H+B6BxaX0BwFVbPwKs6H5ycquNh7
   jdh3SsUPXj838j0TK2vR+NO3UKCg9l9USy0kCaNckn6iTGfVPInPrccZp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219934497"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="219934497"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 05:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="466827402"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2021 05:03:44 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myZNH-00060P-Lf; Sat, 18 Dec 2021 13:03:43 +0000
Date:   Sat, 18 Dec 2021 21:02:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 132/152] arch/x86/kvm/mmu/tdp_mmu.c:411:71:
 sparse: sparse: incorrect type in argument 4 (different address spaces)
Message-ID: <202112182038.tlccGG67-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 81d423a001d35c498d0c024fa49bba248a916c55 [132/152] KVM, x86/mmu: Support TDX private mapping for TDP MMU
config: x86_64-randconfig-s021-20211216 (https://download.01.org/0day-ci/archive/20211218/202112182038.tlccGG67-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel/tdx/commit/81d423a001d35c498d0c024fa49bba248a916c55
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 81d423a001d35c498d0c024fa49bba248a916c55
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kvm/mmu/tdp_mmu.c:411:71: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:411:71: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:411:71: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:471:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:471:43: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:471:43: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1404:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1404:13: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1404:13: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1443:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1443:33: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1443:33: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1494:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1494:13: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1494:13: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:328:9: sparse: sparse: context imbalance in 'tdp_mmu_unlink_page' - different lock contexts for basic block

vim +411 arch/x86/kvm/mmu/tdp_mmu.c

   331	
   332	/**
   333	 * handle_removed_tdp_mmu_page - handle a pt removed from the TDP structure
   334	 *
   335	 * @kvm: kvm instance
   336	 * @parent_sptep: pointer to the parent SPTE which points to the @pt.
   337	 * @pt: the page removed from the paging structure
   338	 * @shared: This operation may not be running under the exclusive use
   339	 *	    of the MMU lock and the operation must synchronize with other
   340	 *	    threads that might be modifying SPTEs.
   341	 *
   342	 * Given a page table that has been removed from the TDP paging structure,
   343	 * iterates through the page table to clear SPTEs and free child page tables.
   344	 *
   345	 * Note that pt is passed in as a tdp_ptep_t, but it does not need RCU
   346	 * protection. Since this thread removed it from the paging structure,
   347	 * this thread will be responsible for ensuring the page is freed. Hence the
   348	 * early rcu_dereferences in the function.
   349	 */
   350	static void handle_removed_tdp_mmu_page(struct kvm *kvm, tdp_ptep_t parent_sptep,
   351						tdp_ptep_t pt, bool shared)
   352	{
   353		struct kvm_mmu_page *parent_sp =
   354			sptep_to_sp(rcu_dereference(parent_sptep));
   355		struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(pt));
   356		int level = sp->role.level;
   357		gfn_t base_gfn = sp->gfn;
   358		int i;
   359	
   360		WARN_ON(!is_private_sp(parent_sp) != !is_private_sp(sp));
   361	
   362		trace_kvm_mmu_prepare_zap_page(sp);
   363	
   364		tdp_mmu_unlink_page(kvm, sp, shared);
   365	
   366		for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
   367			u64 *sptep = rcu_dereference(pt) + i;
   368			gfn_t gfn = base_gfn + i * KVM_PAGES_PER_HPAGE(level);
   369			u64 old_child_spte;
   370	
   371			if (shared) {
   372				/*
   373				 * Set the SPTE to a nonpresent value that other
   374				 * threads will not overwrite. If the SPTE was
   375				 * already marked as removed then another thread
   376				 * handling a page fault could overwrite it, so
   377				 * set the SPTE until it is set from some other
   378				 * value to the removed SPTE value.
   379				 */
   380				for (;;) {
   381					old_child_spte = xchg(sptep, SHADOW_REMOVED_SPTE);
   382					if (!is_removed_spte(old_child_spte))
   383						break;
   384					cpu_relax();
   385				}
   386			} else {
   387				/*
   388				 * If the SPTE is not MMU-present, there is no backing
   389				 * page associated with the SPTE and so no side effects
   390				 * that need to be recorded, and exclusive ownership of
   391				 * mmu_lock ensures the SPTE can't be made present.
   392				 * Note, zapping MMIO SPTEs is also unnecessary as they
   393				 * are guarded by the memslots generation, not by being
   394				 * unreachable.
   395				 */
   396				old_child_spte = READ_ONCE(*sptep);
   397				if (!is_shadow_present_pte(old_child_spte) &&
   398						!is_zapped_private_pte(old_child_spte))
   399					continue;
   400	
   401				/*
   402				 * Marking the SPTE as a removed SPTE is not
   403				 * strictly necessary here as the MMU lock will
   404				 * stop other threads from concurrently modifying
   405				 * this SPTE. Using the removed SPTE value keeps
   406				 * the two branches consistent and simplifies
   407				 * the function.
   408				 */
   409				WRITE_ONCE(*sptep, SHADOW_REMOVED_SPTE);
   410			}
 > 411			handle_changed_spte(kvm, kvm_mmu_page_as_id(sp), gfn, sptep,
   412					    old_child_spte, SHADOW_REMOVED_SPTE, level,
   413					    shared);
   414		}
   415	
   416		if (sp->private_sp) {
   417	
   418			/*
   419			 * Currently prviate page table (not the leaf page) can only be
   420			 * zapped when VM is being destroyed, because currently
   421			 * kvm_x86_ops->free_private_sp() can only be called after TD
   422			 * has been torn down (after tdx_vm_teardown()).  To make sure
   423			 * this code path can only be reached when the whole page table
   424			 * is being torn down when TD is being destroyed, zapping
   425			 * aliasing only zaps the leaf pages, but not the intermediate
   426			 * page tables.
   427			 */
   428			WARN_ON(!is_private_sp(sp));
   429			/*
   430			 * The level used in kvm_x86_ops->free_private_sp() doesn't
   431			 * matter since PG_LEVEL_4K is always used internally.
   432			 */
   433			if (!__kvm_mmu_free_private_sp(kvm, sp)) {
   434				free_page((unsigned long)sp->private_sp);
   435				sp->private_sp = NULL;
   436			}
   437		}
   438	
   439		kvm_flush_remote_tlbs_with_address(kvm, base_gfn,
   440						   KVM_PAGES_PER_HPAGE(level + 1));
   441	
   442		call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
   443	}
   444	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
