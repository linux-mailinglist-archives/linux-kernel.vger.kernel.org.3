Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B258C2D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiHHF3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiHHF3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:29:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0035E0EC
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 22:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659936548; x=1691472548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y4z2lH6h1oCW6Mkd39QRZq3DC3hJYuVM2SRtVdltgpI=;
  b=MaeWgIX/vM1TQnBvgZxFhznFGucEfH24WbZsPz25nem6AdbQ6nlGPOMz
   4qNSu/yGYf2KuZXbr7OpWUOvvyI7HRceioaFwO3A84yHdRZC0zXP8moTP
   dCSIH/bSXzG1rQ409dgOE1uefg4gbwbre92aIiMAJSGxsJRwtpeARKNER
   eCQC5ZrprOH9303skK2pMbqTVqaNt0r8Aw/vAMdIJ80rxTCof9SuNFJmI
   QRsipCfKJKLEZBf1NPExZAM3VBa0/tadluEooMvqhYbyjxWJpGUkN/k3o
   AX3nkpJEroXCjVST3qXRDRAe89CfxJLF56OuxcnLPOweVWg+H5tlOI0F1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="270891914"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="270891914"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 22:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931898301"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 22:29:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKvK6-000Lvt-2q;
        Mon, 08 Aug 2022 05:29:06 +0000
Date:   Mon, 8 Aug 2022 13:28:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 625/846]
 arch/x86/kvm/mmu/mmu.c:4234:14: error: implicit declaration of function
 'kvm_mem_is_private'; did you mean 'kvm_gpa_private'?
Message-ID: <202208081351.yf7GwyHy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   d2f4a2362378fcfa26297befc778815836aecd3b
commit: c88b7037e410dea368496319a8427f8924a7585f [625/846] KVM: x86/mmu: Let vcpu re-try when faulting page type conflict
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220808/202208081351.yf7GwyHy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c88b7037e410dea368496319a8427f8924a7585f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout c88b7037e410dea368496319a8427f8924a7585f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/mmu/mmu.c: In function 'mmu_topup_shadow_page_cache':
   arch/x86/kvm/mmu/mmu.c:696:53: error: incompatible type for argument 1 of 'kvm_mmu_topup_memory_cache'
     696 |         return kvm_mmu_topup_memory_cache(vcpu->arch.mmu_shadow_page_cache,
         |                                           ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     struct kvm_mmu_memory_cache
   In file included from arch/x86/kvm/irq.h:15,
                    from arch/x86/kvm/mmu/mmu.c:18:
   include/linux/kvm_host.h:1369:61: note: expected 'struct kvm_mmu_memory_cache *' but argument is of type 'struct kvm_mmu_memory_cache'
    1369 | int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min);
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_faultin_pfn':
>> arch/x86/kvm/mmu/mmu.c:4234:14: error: implicit declaration of function 'kvm_mem_is_private'; did you mean 'kvm_gpa_private'? [-Werror=implicit-function-declaration]
    4234 |             (kvm_mem_is_private(vcpu->kvm, fault->gfn) != fault->is_private))
         |              ^~~~~~~~~~~~~~~~~~
         |              kvm_gpa_private
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_zap_collapsible_spte':
   arch/x86/kvm/mmu/mmu.c:6565:19: warning: variable 'pfn' set but not used [-Wunused-but-set-variable]
    6565 |         kvm_pfn_t pfn;
         |                   ^~~
   arch/x86/kvm/mmu/mmu.c: In function 'mmu_topup_shadow_page_cache':
   arch/x86/kvm/mmu/mmu.c:698:1: error: control reaches end of non-void function [-Werror=return-type]
     698 | }
         | ^
   cc1: some warnings being treated as errors


vim +4234 arch/x86/kvm/mmu/mmu.c

  4200	
  4201	static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
  4202	{
  4203		struct kvm_memory_slot *slot = fault->slot;
  4204		bool async;
  4205	
  4206		/*
  4207		 * Retry the page fault if the gfn hit a memslot that is being deleted
  4208		 * or moved.  This ensures any existing SPTEs for the old memslot will
  4209		 * be zapped before KVM inserts a new MMIO SPTE for the gfn.
  4210		 */
  4211		if (slot && (slot->flags & KVM_MEMSLOT_INVALID))
  4212			return RET_PF_RETRY;
  4213	
  4214		if (!kvm_is_visible_memslot(slot)) {
  4215			/* Don't expose private memslots to L2. */
  4216			if (is_guest_mode(vcpu)) {
  4217				fault->slot = NULL;
  4218				fault->pfn = KVM_PFN_NOSLOT;
  4219				fault->map_writable = false;
  4220				return RET_PF_CONTINUE;
  4221			}
  4222			/*
  4223			 * If the APIC access page exists but is disabled, go directly
  4224			 * to emulation without caching the MMIO access or creating a
  4225			 * MMIO SPTE.  That way the cache doesn't need to be purged
  4226			 * when the AVIC is re-enabled.
  4227			 */
  4228			if (slot && slot->id == APIC_ACCESS_PAGE_PRIVATE_MEMSLOT &&
  4229			    !kvm_apicv_activated(vcpu->kvm))
  4230				return RET_PF_EMULATE;
  4231		}
  4232	
  4233		if (kvm_gfn_shared_mask(vcpu->kvm) &&
> 4234		    (kvm_mem_is_private(vcpu->kvm, fault->gfn) != fault->is_private))
  4235			return RET_PF_RETRY;
  4236	
  4237		async = false;
  4238		fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
  4239						  fault->write, &fault->map_writable,
  4240						  &fault->hva);
  4241		if (!async)
  4242			return RET_PF_CONTINUE; /* *pfn has correct page already */
  4243	
  4244		if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
  4245			trace_kvm_try_async_get_page(fault->addr, fault->gfn);
  4246			if (kvm_find_async_pf_gfn(vcpu, fault->gfn)) {
  4247				trace_kvm_async_pf_doublefault(fault->addr, fault->gfn);
  4248				kvm_make_request(KVM_REQ_APF_HALT, vcpu);
  4249				return RET_PF_RETRY;
  4250			} else if (kvm_arch_setup_async_pf(vcpu, fault->addr, fault->gfn)) {
  4251				return RET_PF_RETRY;
  4252			}
  4253		}
  4254	
  4255		fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, NULL,
  4256						  fault->write, &fault->map_writable,
  4257						  &fault->hva);
  4258		return RET_PF_CONTINUE;
  4259	}
  4260	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
