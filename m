Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D558C21D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiHHDgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbiHHDgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:36:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1925FAF
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 20:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659929766; x=1691465766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=twk+anSrPY0O0OzPf6RppL680Dpw1L1m7b1gfmbME80=;
  b=OoJvmLBD/1NV3gQ8o2hdQtLLle4MJhHbhM9IhQx1OCpFTI0sxxQJvOrj
   l1AgqA5IyAVW2WajWy5w6rELDjHmZrxpp3UVfs0UMgLt/yTPyMj/LOSFm
   7xTjnbpUQrZLEt7uAm3emcHc1Vp32uUc3QGFv6uRiJuzxyzDqRQX4QGfE
   Lr/3/iPbaVFU68buA3P9YCf9KkBjwHcbUNyO9eiYLY1iUCLKjjs0L+Tz0
   uT4dWNIoLWPNXzaaO920AD4AvLE70Q6YYUfRnM7z+MrtTPim7/gTDGJvZ
   9v4k9o98VvnJaz1a+xxIYMGURV/iuxhP87g6zaB6LedG+u8i8iwqz+ZHd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="277423602"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="277423602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 20:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="607701538"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2022 20:36:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKtYh-000LrD-1x;
        Mon, 08 Aug 2022 03:36:03 +0000
Date:   Mon, 8 Aug 2022 11:35:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 601/846]
 arch/x86/kvm/mmu/mmu.c:689:53: error: incompatible type for argument 1 of
 'kvm_mmu_topup_memory_cache'
Message-ID: <202208081156.UDyRF0Eq-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   d2f4a2362378fcfa26297befc778815836aecd3b
commit: 8aa5fe0bd8b2e79634440087c32a5d32b4dbe1af [601/846] KVM: x86/mmu: Allow non-zero value for non-present SPTE
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220808/202208081156.UDyRF0Eq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/8aa5fe0bd8b2e79634440087c32a5d32b4dbe1af
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 8aa5fe0bd8b2e79634440087c32a5d32b4dbe1af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/mmu/mmu.c: In function 'mmu_topup_shadow_page_cache':
>> arch/x86/kvm/mmu/mmu.c:689:53: error: incompatible type for argument 1 of 'kvm_mmu_topup_memory_cache'
     689 |         return kvm_mmu_topup_memory_cache(vcpu->arch.mmu_shadow_page_cache,
         |                                           ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     struct kvm_mmu_memory_cache
   In file included from arch/x86/kvm/irq.h:15,
                    from arch/x86/kvm/mmu/mmu.c:18:
   include/linux/kvm_host.h:1353:61: note: expected 'struct kvm_mmu_memory_cache *' but argument is of type 'struct kvm_mmu_memory_cache'
    1353 | int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min);
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_zap_collapsible_spte':
   arch/x86/kvm/mmu/mmu.c:6484:19: warning: variable 'pfn' set but not used [-Wunused-but-set-variable]
    6484 |         kvm_pfn_t pfn;
         |                   ^~~
   arch/x86/kvm/mmu/mmu.c: In function 'mmu_topup_shadow_page_cache':
   arch/x86/kvm/mmu/mmu.c:691:1: error: control reaches end of non-void function [-Werror=return-type]
     691 | }
         | ^
   cc1: some warnings being treated as errors


vim +/kvm_mmu_topup_memory_cache +689 arch/x86/kvm/mmu/mmu.c

   666	
   667	static int mmu_topup_shadow_page_cache(struct kvm_vcpu *vcpu)
   668	{
   669		struct kvm_mmu_memory_cache *mc = &vcpu->arch.mmu_shadow_page_cache;
   670		int start, end, i, r;
   671	
   672		start = kvm_mmu_memory_cache_nr_free_objects(mc);
   673		r = kvm_mmu_topup_memory_cache(mc, PT64_ROOT_MAX_LEVEL);
   674	
   675		/*
   676		 * Note, topup may have allocated objects even if it failed to allocate
   677		 * the minimum number of objects required to make forward progress _at
   678		 * this time_.  Initialize newly allocated objects even on failure, as
   679		 * userspace can free memory and rerun the vCPU in response to -ENOMEM.
   680		 */
   681		end = kvm_mmu_memory_cache_nr_free_objects(mc);
   682		for (i = start; i < end; i++)
   683			kvm_init_shadow_page(mc->objects[i]);
   684		return r;
   685	}
   686	#else
   687	static int mmu_topup_shadow_page_cache(struct kvm_vcpu *vcpu)
   688	{
 > 689		return kvm_mmu_topup_memory_cache(vcpu->arch.mmu_shadow_page_cache,
   690						  PT64_ROOT_MAX_LEVEL);
   691	}
   692	#endif /* CONFIG_X86_64 */
   693	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
