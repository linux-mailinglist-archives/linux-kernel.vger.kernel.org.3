Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17041545525
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiFITrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiFITru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:47:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5039852A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654804068; x=1686340068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=52tgPGTVshAq19zapEG0dqbIeUV8fyVkPhB4pJo1VUQ=;
  b=WnIsMf7QgBCRnCfa715QR/QT863QxERn5hCseXFjp5YmlsnBNw44ibGb
   HNqAI6U2ig/78LB12FH+OhpXQHYylfAy0zBoNs4tI3TJke0WV1KnAoPUP
   HTCYaYz7s3mhSW8DqfpzCGEzJ4mQ4/41hOzRXFPcUISLTaZeV9YiPh4mz
   YDX9EGO3v1MXTkvcBgCSE2R967hudHJcpumVTtT0cHio4GMdSgo4mDk8y
   dqPEbZUOqf1k0a/aP5hdVDwatauUNyltXXarwd73MkD+/litNhftaIe1g
   vRNK1c9IfbOTtR4XvqUi//V+09Jmhxuf7VEIVd2tcTSZCDzhPg04yCWOJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276170217"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="276170217"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 12:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="671486578"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2022 12:47:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzO8A-000GKP-Jf;
        Thu, 09 Jun 2022 19:47:46 +0000
Date:   Fri, 10 Jun 2022 03:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 443/453]
 arch/x86/kvm/mmu/mmu.c:982:21: warning: variable 'type' set but not used
Message-ID: <202206100310.NiXH6ebe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   64f3ddf316eab9398414b94e62a01d185e6e94c8
commit: d4ee16fc8532473025338c594b8fbe6a6faa0887 [443/453] KVM: x86/mmu: update lpage_info on changing page_type
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220610/202206100310.NiXH6ebe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/d4ee16fc8532473025338c594b8fbe6a6faa0887
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout d4ee16fc8532473025338c594b8fbe6a6faa0887
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kvm/mmu/mmu.c:18:
   In file included from arch/x86/kvm/irq.h:15:
   In file included from include/linux/kvm_host.h:47:
   include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
>> arch/x86/kvm/mmu/mmu.c:982:21: warning: variable 'type' set but not used [-Wunused-but-set-variable]
           enum kvm_page_type type;
                              ^
   1 warning and 1 error generated.


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
