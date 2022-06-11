Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFC54763E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiFKPwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiFKPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:52:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03024E6B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654962741; x=1686498741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hUZ65Rg3EEiHgzz4LA4Q3Vxkj3mq3OjDaPirGkBxR60=;
  b=Y4angcpWru4vXyxSVnKJv00hYuweYre/eNyabWJv4/FYQtYKByJm4pkC
   SD2MtOQkHsFCEDJduTXHyV+OBEAQQhyGkoQBEztLgeqdOD32ReDNMYmSf
   TubIcP20a8h7ZolfHabIS/4SC3WCQ5CBSXqlDQ9iWUnK50oJEzmQgcvi/
   zqnCXh7fCwLnfnmIOEBm3yVBbPuhmjKs1B17UkRpr2LkWfIlhHssyy7yi
   kYhJwUDL6NlUs9mwRJJnId8YsL1rhK/MU06RkTDz2UOvPtGFq8xXxOY+3
   K2ws224bEx8Y06bBiq5FezI0Eat5C1UIUtAymqp2RJEqlZlzuacqWWz4/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="277941065"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="277941065"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 08:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="711363163"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2022 08:52:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o03PP-000J2X-FP;
        Sat, 11 Jun 2022 15:52:19 +0000
Date:   Sat, 11 Jun 2022 23:51:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 443/453]
 arch/x86/kvm/mmu/mmu.c:982:21: error: variable 'type' set but not used
Message-ID: <202206112336.404YWKiT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   64f3ddf316eab9398414b94e62a01d185e6e94c8
commit: d4ee16fc8532473025338c594b8fbe6a6faa0887 [443/453] KVM: x86/mmu: update lpage_info on changing page_type
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220611/202206112336.404YWKiT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/d4ee16fc8532473025338c594b8fbe6a6faa0887
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout d4ee16fc8532473025338c594b8fbe6a6faa0887
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/fpu/ arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the intel-tdx/kvm-upstream-workaround HEAD 64f3ddf316eab9398414b94e62a01d185e6e94c8 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/mmu/mmu.c:18:
   In file included from arch/x86/kvm/irq.h:15:
   In file included from include/linux/kvm_host.h:47:
   include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
>> arch/x86/kvm/mmu/mmu.c:982:21: error: variable 'type' set but not used [-Werror,-Wunused-but-set-variable]
           enum kvm_page_type type;
                              ^
   2 errors generated.


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
