Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9401C49BD23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiAYU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:29:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:7289 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbiAYU3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643142560; x=1674678560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gkFbYCmTeJCVIMxoYhif8nzxLeXPgSYKrBuhjeLdX2Y=;
  b=FzM7bIhQlqeBrSoNGTXbDn1gMTnyXw4sL5/8jL8N+CHhb0QUy191z+LL
   RuPJpPMiulYsWL1wvn+P0t29mKVEcoSV8yOorguiy3YHrxZPylUD3O7iX
   f895j3CM0WqVxWdfb9xq0vmggImCEj+n6/ZJmKjAsUrafIgQN2bwtSxw7
   oJ0qgocK//niyZSJHeYeuZ4aqXZk0wQMZwiuui6fcT6iBlBedvAFnqn3Z
   6kZb8YhCaD3Xy6JDjDls69DScSqAYinQ6bsRweyp0ba1PX8CnwOYCLHmA
   HMYqiRWIRuJ92rLivRppXOofzjU1iBJBbdgkpdjiZXF5miLmxX2pzxGdG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307127356"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="307127356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 12:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="479641158"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 12:29:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCSRK-000KPa-7v; Tue, 25 Jan 2022 20:29:18 +0000
Date:   Wed, 26 Jan 2022 04:29:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 86/162]
 arch/x86/kvm/mmu/tdp_mmu.c:558:17: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202201260459.BfJHKutL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   9ba9d8e36b0fa25f5f20109a0ae61619a421f550
commit: 331cf28aff787269534af7c86fd5948fb585a798 [86/162] KVM: x86/tdp_mmu: Support TDX private mapping for TDP MMU
config: x86_64-randconfig-s021-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260459.BfJHKutL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel/tdx/commit/331cf28aff787269534af7c86fd5948fb585a798
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 331cf28aff787269534af7c86fd5948fb585a798
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kvm/mmu/tdp_mmu.c:558:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu * @@
   arch/x86/kvm/mmu/tdp_mmu.c:558:17: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:558:17: sparse:     got unsigned long long [noderef] [usertype] __rcu *
   arch/x86/kvm/mmu/tdp_mmu.c:1287:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1287:33: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1287:33: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1338:13: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1338:13: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:329:9: sparse: sparse: context imbalance in 'tdp_mmu_unlink_page' - different lock contexts for basic block
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:591:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:614:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:696:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:703:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep

vim +558 arch/x86/kvm/mmu/tdp_mmu.c

   436	
   437	/**
   438	 * __handle_changed_spte - handle bookkeeping associated with an SPTE change
   439	 * @kvm: kvm instance
   440	 * @as_id: the address space of the paging structure the SPTE was a part of
   441	 * @gfn: the base GFN that was mapped by the SPTE
   442	 * @private_spte: the SPTE is private or not
   443	 * @old_spte: The value of the SPTE before the change
   444	 * @new_spte: The value of the SPTE after the change
   445	 * @level: the level of the PT the SPTE is part of in the paging structure
   446	 * @shared: This operation may not be running under the exclusive use of
   447	 *	    the MMU lock and the operation must synchronize with other
   448	 *	    threads that might be modifying SPTEs.
   449	 *
   450	 * Handle bookkeeping that might result from the modification of a SPTE.
   451	 * This function must be called for all TDP SPTE modifications.
   452	 */
   453	static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
   454					  bool private_spte, u64 old_spte,
   455					  u64 new_spte, int level, bool shared)
   456	{
   457		bool was_present = is_shadow_present_pte(old_spte);
   458		bool is_present = is_shadow_present_pte(new_spte);
   459		bool was_leaf = was_present && is_last_spte(old_spte, level);
   460		bool is_leaf = is_present && is_last_spte(new_spte, level);
   461		kvm_pfn_t old_pfn = spte_to_pfn(old_spte);
   462		kvm_pfn_t new_pfn = spte_to_pfn(new_spte);
   463		bool pfn_changed = old_pfn != new_pfn;
   464	
   465		WARN_ON(level > PT64_ROOT_MAX_LEVEL);
   466		WARN_ON(level < PG_LEVEL_4K);
   467		WARN_ON(gfn & (KVM_PAGES_PER_HPAGE(level) - 1));
   468	
   469		/*
   470		 * If this warning were to trigger it would indicate that there was a
   471		 * missing MMU notifier or a race with some notifier handler.
   472		 * A present, leaf SPTE should never be directly replaced with another
   473		 * present leaf SPTE pointing to a different PFN. A notifier handler
   474		 * should be zapping the SPTE before the main MM's page table is
   475		 * changed, or the SPTE should be zeroed, and the TLBs flushed by the
   476		 * thread before replacement.
   477		 */
   478		if (was_leaf && is_leaf && pfn_changed) {
   479			pr_err("Invalid SPTE change: cannot replace a present leaf\n"
   480			       "SPTE with another present leaf SPTE mapping a\n"
   481			       "different PFN!\n"
   482			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   483			       as_id, gfn, old_spte, new_spte, level);
   484	
   485			/*
   486			 * Crash the host to prevent error propagation and guest data
   487			 * corruption.
   488			 */
   489			BUG();
   490		}
   491	
   492		if (old_spte == new_spte)
   493			return;
   494	
   495		trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
   496	
   497		/*
   498		 * The only times a SPTE should be changed from a non-present to
   499		 * non-present state is when an MMIO entry is installed/modified/
   500		 * removed. In that case, there is nothing to do here.
   501		 */
   502		if (!was_present && !is_present) {
   503			/*
   504			 * If this change does not involve a MMIO SPTE or removed SPTE,
   505			 * it is unexpected. Log the change, though it should not
   506			 * impact the guest since both the former and current SPTEs
   507			 * are nonpresent.
   508			 */
   509			if (WARN_ON(!is_mmio_spte(kvm, old_spte) &&
   510				    !is_mmio_spte(kvm, new_spte) &&
   511				    !is_removed_spte(new_spte)))
   512				pr_err("Unexpected SPTE change! Nonpresent SPTEs\n"
   513				       "should not be replaced with another,\n"
   514				       "different nonpresent SPTE, unless one or both\n"
   515				       "are MMIO SPTEs, or the new SPTE is\n"
   516				       "a temporary removed SPTE.\n"
   517				       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   518				       as_id, gfn, old_spte, new_spte, level);
   519			return;
   520		}
   521	
   522		if (is_leaf != was_leaf)
   523			kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
   524	
   525		if (was_leaf && is_dirty_spte(old_spte) &&
   526		    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
   527			kvm_set_pfn_dirty(old_pfn);
   528	
   529		/*
   530		 * Special handling for the private mapping.  We are either
   531		 * setting up new mapping at middle level page table, or leaf,
   532		 * or tearing down existing mapping.
   533		 */
   534		if (private_spte) {
   535			void *sept_page = NULL;
   536	
   537			if (is_present && !is_leaf) {
   538				struct kvm_mmu_page *sp = to_shadow_page(pfn_to_hpa(new_pfn));
   539	
   540				sept_page = sp->private_sp;
   541				WARN_ON(!sp->role.private);
   542				WARN_ON(!sp->private_sp);
   543				WARN_ON(sp->role.level + 1 != level);
   544				WARN_ON(sp->gfn != gfn);
   545			}
   546	
   547			static_call(kvm_x86_handle_changed_private_spte)(
   548				kvm, gfn, level,
   549				old_pfn, was_present, was_leaf,
   550				new_pfn, is_present, is_leaf, sept_page);
   551		}
   552	
   553		/*
   554		 * Recursively handle child PTs if the change removed a subtree from
   555		 * the paging structure.
   556		 */
   557		if (was_present && !was_leaf && (pfn_changed || !is_present)) {
 > 558			WARN_ON(private_spte !=
   559				is_private_spte(spte_to_child_pt(old_spte, level)));
   560			handle_removed_tdp_mmu_page(kvm,
   561					spte_to_child_pt(old_spte, level), shared);
   562		}
   563	}
   564	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
