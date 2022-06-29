Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA4560448
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiF2PPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiF2PPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:15:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389D13E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656515705; x=1688051705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UK+Pk1CTEhwna1MRInrlEyhGNhzeJwTDQKbLxawS+PE=;
  b=PS7dI2BsnclTkF5zkAEJW+HnLDQI6YTTZvli3jtmtgPRNUQG5KYuqmjT
   SmDeDFvwl0l2McHL+Cpbzi50HVAdD/+/TVUd27csQLLqLW2H5i+gWSoCb
   fXubvuqRN8Vi4hUKCC/nGNiFvRl8CR2odJni4OWpxxMD8jLDPSOQtQ9dI
   9pInQXeQ+ooGHU4TpHvzNpWRNq9XNhHUXpR3f65DUMg5EfO00nJAKEjtX
   pmko5C6xfntYNTJnfEfdBJetXnhwPYAPq0X8x/hK3vr3gVMs2qlZasTnA
   XGC0jpG/ZnU0k6YtAhMl0lrpifgfk/u2OEWs/afo/EAzeffGUbQ0oGEgs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282791363"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="282791363"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="917636890"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 08:15:03 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6ZPC-000BK6-PY;
        Wed, 29 Jun 2022 15:15:02 +0000
Date:   Wed, 29 Jun 2022 23:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 434/442]
 arch/x86/kvm/mmu/mmu.c:981:21: error: variable 'type' set but not used
Message-ID: <202206292314.Byr20MEd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8af973ebaf30642129fc1ca63f155a469f9615ed
commit: 2cf2a8208ae24b96f074aac76f0feef63489137d [434/442] KVM: x86/mmu: update lpage_info on changing page_type
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220629/202206292314.Byr20MEd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/2cf2a8208ae24b96f074aac76f0feef63489137d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 2cf2a8208ae24b96f074aac76f0feef63489137d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kvm/mmu/mmu.c:18:
   In file included from arch/x86/kvm/irq.h:15:
   In file included from include/linux/kvm_host.h:47:
   include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
>> arch/x86/kvm/mmu/mmu.c:981:21: error: variable 'type' set but not used [-Werror,-Wunused-but-set-variable]
           enum kvm_page_type type;
                              ^
   2 errors generated.


vim +/type +981 arch/x86/kvm/mmu/mmu.c

aa7e272e931503d Xiaoyao Li     2021-08-31  976  
dbe93493d574730 Xiaoyao Li     2022-05-25  977  static void split_page_type(gfn_t gfn, struct kvm_memory_slot *slot,
dbe93493d574730 Xiaoyao Li     2022-05-25  978  			    enum pg_level level)
aa7e272e931503d Xiaoyao Li     2021-08-31  979  {
aa7e272e931503d Xiaoyao Li     2021-08-31  980  	struct kvm_page_attr *page_attr = page_attr_slot(gfn, slot, level);
aa7e272e931503d Xiaoyao Li     2021-08-31 @981  	enum kvm_page_type type;
aa7e272e931503d Xiaoyao Li     2021-08-31  982  	gfn_t base_gfn;
aa7e272e931503d Xiaoyao Li     2021-08-31  983  
aa7e272e931503d Xiaoyao Li     2021-08-31  984  	if (WARN_ON_ONCE(!kvm_page_type_valid(page_attr) || level <= PG_LEVEL_4K))
aa7e272e931503d Xiaoyao Li     2021-08-31  985  		return;
aa7e272e931503d Xiaoyao Li     2021-08-31  986  
aa7e272e931503d Xiaoyao Li     2021-08-31  987  	base_gfn = gfn & ~(KVM_PAGES_PER_HPAGE(level) - 1);
aa7e272e931503d Xiaoyao Li     2021-08-31  988  	type = page_attr->type;
dbe93493d574730 Xiaoyao Li     2022-05-25  989  
aa7e272e931503d Xiaoyao Li     2021-08-31  990  	/*
aa7e272e931503d Xiaoyao Li     2021-08-31  991  	 * Set the type to KVM_PAGE_TYPE_MIXED in advance since when a large
aa7e272e931503d Xiaoyao Li     2021-08-31  992  	 * page needs to be split means one of the 4K page of it needs to be
aa7e272e931503d Xiaoyao Li     2021-08-31  993  	 * changed to oppsite type
aa7e272e931503d Xiaoyao Li     2021-08-31  994  	 */
2cf2a8208ae24b9 Isaku Yamahata 2022-06-02  995  	page_type_set(page_attr, KVM_PAGE_TYPE_MIXED, base_gfn, slot, level);
aa7e272e931503d Xiaoyao Li     2021-08-31  996  }
aa7e272e931503d Xiaoyao Li     2021-08-31  997  

:::::: The code at line 981 was first introduced by commit
:::::: aa7e272e931503dda524bd4f15d098a0d4ac28d7 KVM: MMU: Update page_attr->type when guest converts the page

:::::: TO: Xiaoyao Li <xiaoyao.li@intel.com>
:::::: CC: Isaku Yamahata <isaku.yamahata@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
