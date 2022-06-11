Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD8547622
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiFKPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiFKPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:32:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784E1037
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654961542; x=1686497542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IqLH4Zu4HtkTYqSjSsjZ6kb6pJzyU6E4b1onXBE5wRM=;
  b=iXJvi5vObNH1ldmwqn/WgTrld7vVuGAAS/c4qArW46JbiGTzeQW41GL+
   HIZZj9qtdejz3KsRHABQuDVElE9utVMcGQ/Z+A6vend8Y1yaJ8DB8ENCo
   66Z66KG5HYyIXEKlYdq4DfEyBQeZ6WTiW2TqCRJdkAWhq+mEioZeqposi
   JXn7pneLewKypFP1bMBsarkiVyl2rypOWXCTm43UCDC9477/4XomzgF9Q
   IJ2ueLbajgiUd4bMx/R0+UkmRrMmm1buc2X9qhwqwJiM6WicHs/Gasx6u
   AhJavE2Kv2EIxt7RCosm0V0p91DxQiB6DG8i/owY9GaLiiswG7klOEEx9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258335135"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="258335135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 08:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="650444530"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2022 08:32:19 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0362-000J1Z-PQ;
        Sat, 11 Jun 2022 15:32:18 +0000
Date:   Sat, 11 Jun 2022 23:31:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 443/453]
 arch/x86/kvm/mmu/mmu.c:982:28: warning: variable 'type' set but not used
Message-ID: <202206112358.498m1lmx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   64f3ddf316eab9398414b94e62a01d185e6e94c8
commit: d4ee16fc8532473025338c594b8fbe6a6faa0887 [443/453] KVM: x86/mmu: update lpage_info on changing page_type
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220611/202206112358.498m1lmx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/d4ee16fc8532473025338c594b8fbe6a6faa0887
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout d4ee16fc8532473025338c594b8fbe6a6faa0887
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kvm_host.h:47,
                    from arch/x86/kvm/irq.h:15,
                    from arch/x86/kvm/mmu/mmu.c:18:
   include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   arch/x86/kvm/mmu/mmu.c: In function 'split_page_type':
>> arch/x86/kvm/mmu/mmu.c:982:28: warning: variable 'type' set but not used [-Wunused-but-set-variable]
     982 |         enum kvm_page_type type;
         |                            ^~~~
   In file included from include/linux/kvm_host.h:47,
                    from arch/x86/kvm/irq.h:15,
                    from arch/x86/kvm/mmu/mmu.c:18:
   At top level:
   include/linux/memfile_notifier.h:93:13: warning: 'memfile_unregister_notifier' defined but not used [-Wunused-function]
      93 | static void memfile_unregister_notifier(struct memfile_notifier *notifier)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:82:13: warning: 'memfile_notifier_invalidate' defined but not used [-Wunused-function]
      82 | static void memfile_notifier_invalidate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:77:13: warning: 'memfile_notifier_populate' defined but not used [-Wunused-function]
      77 | static void memfile_notifier_populate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:72:12: warning: 'memfile_node_set_flags' defined but not used [-Wunused-function]
      72 | static int memfile_node_set_flags(struct file *file, unsigned long flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:68:13: warning: 'memfile_register_backing_store' defined but not used [-Wunused-function]
      68 | static void memfile_register_backing_store(struct memfile_backing_store *bs)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/type +982 arch/x86/kvm/mmu/mmu.c

7c45d6a017129b Xiaoyao Li     2021-08-31  977  
09cbecc5a0e81f Xiaoyao Li     2022-05-25  978  static void split_page_type(gfn_t gfn, struct kvm_memory_slot *slot,
09cbecc5a0e81f Xiaoyao Li     2022-05-25  979  			    enum pg_level level)
7c45d6a017129b Xiaoyao Li     2021-08-31  980  {
7c45d6a017129b Xiaoyao Li     2021-08-31  981  	struct kvm_page_attr *page_attr = page_attr_slot(gfn, slot, level);
7c45d6a017129b Xiaoyao Li     2021-08-31 @982  	enum kvm_page_type type;
7c45d6a017129b Xiaoyao Li     2021-08-31  983  	gfn_t base_gfn;
7c45d6a017129b Xiaoyao Li     2021-08-31  984  
7c45d6a017129b Xiaoyao Li     2021-08-31  985  	if (WARN_ON_ONCE(!kvm_page_type_valid(page_attr) || level <= PG_LEVEL_4K))
7c45d6a017129b Xiaoyao Li     2021-08-31  986  		return;
7c45d6a017129b Xiaoyao Li     2021-08-31  987  
7c45d6a017129b Xiaoyao Li     2021-08-31  988  	base_gfn = gfn & ~(KVM_PAGES_PER_HPAGE(level) - 1);
7c45d6a017129b Xiaoyao Li     2021-08-31  989  	type = page_attr->type;
09cbecc5a0e81f Xiaoyao Li     2022-05-25  990  
7c45d6a017129b Xiaoyao Li     2021-08-31  991  	/*
7c45d6a017129b Xiaoyao Li     2021-08-31  992  	 * Set the type to KVM_PAGE_TYPE_MIXED in advance since when a large
7c45d6a017129b Xiaoyao Li     2021-08-31  993  	 * page needs to be split means one of the 4K page of it needs to be
7c45d6a017129b Xiaoyao Li     2021-08-31  994  	 * changed to oppsite type
7c45d6a017129b Xiaoyao Li     2021-08-31  995  	 */
d4ee16fc853247 Isaku Yamahata 2022-06-02  996  	page_type_set(page_attr, KVM_PAGE_TYPE_MIXED, base_gfn, slot, level);
7c45d6a017129b Xiaoyao Li     2021-08-31  997  }
7c45d6a017129b Xiaoyao Li     2021-08-31  998  

:::::: The code at line 982 was first introduced by commit
:::::: 7c45d6a017129b913c57fb0a2cc14a866f2434a4 KVM: MMU: Update page_attr->type when guest converts the page

:::::: TO: Xiaoyao Li <xiaoyao.li@intel.com>
:::::: CC: Isaku Yamahata <isaku.yamahata@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
