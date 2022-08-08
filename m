Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBBE58C4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiHHIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:24:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868213E24
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659947060; x=1691483060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+CV9iL8zPPFpRf4Fa9Lqt1CIVWsll8sEGxK705T5c84=;
  b=niGf1b057ZtpzPsli04nkESghM9aUN4GTDqfBgQJjyM4QLaWY1ftY2Pd
   WdDK/GBMnuEs0pQo/Xh4FqV1265m9w9HKpS4UGsNwAuEWV3RKeHsxTTSb
   IhsLE5t77FdWZaRHAeY5K6ghk3Zyvj9P+hRC5vG0ZDEL5Kj9UvGOGLec+
   r4W1R/j7Dc9TjLzW6n8KPufTET30IVHDmx2IozFpc4Ceb7MA0YHlF9WIU
   oTjyI9UGiya9F8mwkEgyRFp6xVgCEItgPRJJA0Expg/GdHcHOdIozt7Lc
   Co4ndOuoQOyL/Dx95A6ZIpYquYTWeHElUOFNcaVBPvfAd85XzdURYES2T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="352262136"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="352262136"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 01:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931961007"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 01:24:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKy3e-000M8I-17;
        Mon, 08 Aug 2022 08:24:18 +0000
Date:   Mon, 8 Aug 2022 16:23:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 627/846]
 arch/x86/kvm/mmu/mmu.c:6776:30: error: 'KVM_MEM_ATTR_PRIVATE' undeclared
Message-ID: <202208081628.vWneWyoS-lkp@intel.com>
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
commit: 1293aaf4ce16f80dc4bf9cd943d399183f0d4d7d [627/846] KVM: x86/tdp_mmu: implement MapGPA hypercall for TDX
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220808/202208081628.vWneWyoS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/1293aaf4ce16f80dc4bf9cd943d399183f0d4d7d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 1293aaf4ce16f80dc4bf9cd943d399183f0d4d7d
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
   arch/x86/kvm/mmu/mmu.c:4234:14: error: implicit declaration of function 'kvm_mem_is_private'; did you mean 'kvm_gpa_private'? [-Werror=implicit-function-declaration]
    4234 |             (kvm_mem_is_private(vcpu->kvm, fault->gfn) != fault->is_private))
         |              ^~~~~~~~~~~~~~~~~~
         |              kvm_gpa_private
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_zap_collapsible_spte':
   arch/x86/kvm/mmu/mmu.c:6604:19: warning: variable 'pfn' set but not used [-Wunused-but-set-variable]
    6604 |         kvm_pfn_t pfn;
         |                   ^~~
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_map_gpa':
>> arch/x86/kvm/mmu/mmu.c:6776:30: error: 'KVM_MEM_ATTR_PRIVATE' undeclared (first use in this function)
    6776 |         attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
         |                              ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/mmu/mmu.c:6776:30: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/kvm/mmu/mmu.c:6776:53: error: 'KVM_MEM_ATTR_SHARED' undeclared (first use in this function)
    6776 |         attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
         |                                                     ^~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/mmu/mmu.c:6784:15: error: implicit declaration of function 'kvm_vm_reserve_mem_attr' [-Werror=implicit-function-declaration]
    6784 |         ret = kvm_vm_reserve_mem_attr(kvm, start, end);
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask.h:14,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from arch/x86/kvm/irq.h:13,
                    from arch/x86/kvm/mmu/mmu.c:18:
>> arch/x86/kvm/mmu/mmu.c:6794:33: error: implicit declaration of function 'kvm_vm_set_mem_attr' [-Werror=implicit-function-declaration]
    6794 |                         WARN_ON(kvm_vm_set_mem_attr(kvm, attr, start, end));
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   arch/x86/kvm/mmu/mmu.c: In function 'mmu_topup_shadow_page_cache':
   arch/x86/kvm/mmu/mmu.c:698:1: error: control reaches end of non-void function [-Werror=return-type]
     698 | }
         | ^
   cc1: some warnings being treated as errors


vim +/KVM_MEM_ATTR_PRIVATE +6776 arch/x86/kvm/mmu/mmu.c

  6763	
  6764	int kvm_mmu_map_gpa(struct kvm_vcpu *vcpu, gfn_t *startp, gfn_t end,
  6765			    bool map_private)
  6766	{
  6767		struct kvm *kvm = vcpu->kvm;
  6768		gfn_t start = *startp;
  6769		int attr;
  6770		int ret;
  6771	
  6772	
  6773		if (!kvm_gfn_shared_mask(kvm))
  6774			return -EOPNOTSUPP;
  6775	
> 6776		attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
  6777		start = start & ~kvm_gfn_shared_mask(kvm);
  6778		end = end & ~kvm_gfn_shared_mask(kvm);
  6779	
  6780		/*
  6781		 * To make the following kvm_vm_set_mem_attr() success within spinlock
  6782		 * without memory allocation.
  6783		 */
> 6784		ret = kvm_vm_reserve_mem_attr(kvm, start, end);
  6785		if (ret)
  6786			return ret;
  6787	
  6788		write_lock(&kvm->mmu_lock);
  6789		if (is_tdp_mmu_enabled(kvm)) {
  6790			gfn_t s = start;
  6791	
  6792			ret = kvm_tdp_mmu_map_gpa(vcpu, &s, end, map_private);
  6793			if (!ret) {
> 6794				WARN_ON(kvm_vm_set_mem_attr(kvm, attr, start, end));
  6795			} else if (ret == -EAGAIN) {
  6796				WARN_ON(kvm_vm_set_mem_attr(kvm, attr, start, s));
  6797				start = s;
  6798			}
  6799		} else {
  6800			ret = -EOPNOTSUPP;
  6801		}
  6802		write_unlock(&kvm->mmu_lock);
  6803	
  6804		if (ret == -EAGAIN) {
  6805			if (map_private)
  6806				*startp = kvm_gfn_private(kvm, start);
  6807			else
  6808				*startp = kvm_gfn_shared(kvm, start);
  6809		}
  6810		return ret;
  6811	}
  6812	EXPORT_SYMBOL_GPL(kvm_mmu_map_gpa);
  6813	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
