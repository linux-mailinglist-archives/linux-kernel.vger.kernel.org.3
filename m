Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0558E3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiHIXxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHIXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:53:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9180480
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660089185; x=1691625185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rjA1iC6t5N4BF6XjAcfKyGXVErDAjfUWb7Hx6P1OsJ4=;
  b=fWbQ1qVcvHnWjgJL2rKLoh0JUN7kjXC3h9DmMty0FwGQ+LHS4QxLN18E
   cmAemZ0KrXWSy68uqM5X9GtNHaNtHs4Vzjak2xMog7FOXsbaTl322Uoz7
   /YoQGKHpIaQJr35fPCU4JYDx65+18mo1PqD4TKvnHYDdw+jNdqy0jxlmJ
   cNZepg4mSWGsh7QGS9PjrQk3t2w6ZLwbajbBA10YFqt3t6ujCQRIS1z1J
   OwXHTUzsQ1SibuM10GOp3Lqd4Bzccm2R5I180/piPSKiJY1oLrCItQNuu
   L/XQIGTdZnBgkWnH8IS2bLf2Xp4lcmrmplZ46toMS+dvMyQkNGh6M99JX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316902346"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="316902346"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 16:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="555528949"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2022 16:53:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLZ1y-000NMJ-2V;
        Tue, 09 Aug 2022 23:53:02 +0000
Date:   Wed, 10 Aug 2022 07:52:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 693/846]
 arch/x86/kvm/mmu/mmu.c:7264:27: error: 'struct kvm' has no member named
 'mem_attr_array'
Message-ID: <202208100759.CNcZjfEI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   6e62680f6e4094d3986229a4145ebd54390dc110
commit: bb9b2174d4d2edc63bdaf11c0ab09af02f64ca44 [693/846] KVM: Update lpage info when private/shared memory are mixed
config: i386-randconfig-a001-20220808 (https://download.01.org/0day-ci/archive/20220810/202208100759.CNcZjfEI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/bb9b2174d4d2edc63bdaf11c0ab09af02f64ca44
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout bb9b2174d4d2edc63bdaf11c0ab09af02f64ca44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_zap_collapsible_spte':
   arch/x86/kvm/mmu/mmu.c:6667:19: warning: variable 'pfn' set but not used [-Wunused-but-set-variable]
    6667 |         kvm_pfn_t pfn;
         |                   ^~~
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_mmu_map_gpa':
   arch/x86/kvm/mmu/mmu.c:6839:30: error: 'KVM_MEM_ATTR_PRIVATE' undeclared (first use in this function); did you mean 'KVM_MEM_PRIVATE'?
    6839 |         attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
         |                              ^~~~~~~~~~~~~~~~~~~~
         |                              KVM_MEM_PRIVATE
   arch/x86/kvm/mmu/mmu.c:6839:30: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kvm/mmu/mmu.c:6839:53: error: 'KVM_MEM_ATTR_SHARED' undeclared (first use in this function)
    6839 |         attr = map_private ? KVM_MEM_ATTR_PRIVATE : KVM_MEM_ATTR_SHARED;
         |                                                     ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:700,
                    from include/linux/kvm_host.h:16,
                    from arch/x86/kvm/irq.h:15,
                    from arch/x86/kvm/mmu/mmu.c:18:
   arch/x86/kvm/mmu/mmu.c: In function '__mem_attr_is_mixed':
>> arch/x86/kvm/mmu/mmu.c:7264:27: error: 'struct kvm' has no member named 'mem_attr_array'
    7264 |         XA_STATE(xas, &kvm->mem_attr_array, start);
         |                           ^~
   include/linux/xarray.h:1333:15: note: in definition of macro '__XA_STATE'
    1333 |         .xa = array,                                    \
         |               ^~~~~
   arch/x86/kvm/mmu/mmu.c:7264:9: note: in expansion of macro 'XA_STATE'
    7264 |         XA_STATE(xas, &kvm->mem_attr_array, start);
         |         ^~~~~~~~
   arch/x86/kvm/mmu/mmu.c: In function 'mem_attr_is_mixed':
   arch/x86/kvm/mmu/mmu.c:7308:29: error: 'struct kvm' has no member named 'mem_attr_array'
    7308 |         entry = xa_load(&kvm->mem_attr_array, start);
         |                             ^~
   arch/x86/kvm/mmu/mmu.c:7315:33: error: 'struct kvm' has no member named 'mem_attr_array'
    7315 |                 if (xa_load(&kvm->mem_attr_array, gfn) != entry) {
         |                                 ^~
   In file included from include/linux/printk.h:10,
                    from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from arch/x86/kvm/irq.h:13,
                    from arch/x86/kvm/mmu/mmu.c:18:
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_arch_update_mem_attr':
   arch/x86/kvm/mmu/mmu.c:7369:29: error: 'KVM_MEM_ATTR_PRIVATE' undeclared (first use in this function); did you mean 'KVM_MEM_PRIVATE'?
    7369 |         WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
         |                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   arch/x86/kvm/mmu/mmu.c:7369:9: note: in expansion of macro 'WARN_ONCE'
    7369 |         WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
         |         ^~~~~~~~~
   arch/x86/kvm/mmu/mmu.c:7369:52: error: 'KVM_MEM_ATTR_SHARED' undeclared (first use in this function)
    7369 |         WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
         |                                                    ^~~~~~~~~~~~~~~~~~~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   arch/x86/kvm/mmu/mmu.c:7369:9: note: in expansion of macro 'WARN_ONCE'
    7369 |         WARN_ONCE(!(attr & (KVM_MEM_ATTR_PRIVATE | KVM_MEM_ATTR_SHARED)),
         |         ^~~~~~~~~


vim +7264 arch/x86/kvm/mmu/mmu.c

  7261	
  7262	static bool __mem_attr_is_mixed(struct kvm *kvm, gfn_t start, gfn_t end)
  7263	{
> 7264		XA_STATE(xas, &kvm->mem_attr_array, start);
  7265		bool mixed = false;
  7266		gfn_t gfn = start;
  7267		void *s_entry;
  7268		void *entry;
  7269	
  7270		rcu_read_lock();
  7271		s_entry = xas_load(&xas);
  7272		while (gfn < end) {
  7273			if (xas_retry(&xas, entry))
  7274				continue;
  7275	
  7276			KVM_BUG_ON(gfn != xas.xa_index, kvm);
  7277	
  7278			entry = xas_next(&xas);
  7279			if (entry != s_entry) {
  7280				mixed = true;
  7281				break;
  7282			}
  7283			gfn++;
  7284		}
  7285		rcu_read_unlock();
  7286		return mixed;
  7287	}
  7288	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
