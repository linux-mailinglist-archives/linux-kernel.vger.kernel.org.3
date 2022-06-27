Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1D55D8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiF0V34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbiF0V3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:29:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E7A449
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656365394; x=1687901394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9ZklCJQ9ymc74ewrxNFnhKUYtHVnWa+PrFBy885ZOQ8=;
  b=Y5bbDM/4//4YwZUFd4vgo7lz0qNOaPCf9/Y8TLTErYS98jcaFfu+gbMW
   pzw5P87e/0YrfEALnMAaxhCC071mAzPFQFrXM4iR2ST09/fdRDOMuuJij
   CQTkooa4Zd3ThVzvGjsbj6F9GVHWGwxd6a3Dizvg9E7M95wB9c04v2+h4
   QDFm76MTGVEQiKgHjgGcXNXIGMkZG0Nt83R41rkQQ6YvfEVMaq26FAGCC
   FRIVk6mWmcZ9GDznCUkEZX1E6xV/hQYdHBA4GR8e9/XPMYb9cdpgSY6fd
   7aEmfkzR8snokRt1ZIS2Y/Osr/S1AMjWJjljU2WBCCmZ6heDXEjYwcx5b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264608627"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264608627"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="916896283"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2022 14:29:52 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5wIp-00093q-LF;
        Mon, 27 Jun 2022 21:29:51 +0000
Date:   Tue, 28 Jun 2022 05:29:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 434/442]
 arch/x86/kvm/mmu/mmu.c:981:21: warning: variable 'type' set but not used
Message-ID: <202206280555.alASo2T9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8af973ebaf30642129fc1ca63f155a469f9615ed
commit: 2cf2a8208ae24b96f074aac76f0feef63489137d [434/442] KVM: x86/mmu: update lpage_info on changing page_type
config: x86_64-randconfig-a004-20220627 (https://download.01.org/0day-ci/archive/20220628/202206280555.alASo2T9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/2cf2a8208ae24b96f074aac76f0feef63489137d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 2cf2a8208ae24b96f074aac76f0feef63489137d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/mmu/mmu.c:981:21: warning: variable 'type' set but not used [-Wunused-but-set-variable]
           enum kvm_page_type type;
                              ^
   1 warning generated.


vim +/type +981 arch/x86/kvm/mmu/mmu.c

aa7e272e931503 Xiaoyao Li     2021-08-31  976  
dbe93493d57473 Xiaoyao Li     2022-05-25  977  static void split_page_type(gfn_t gfn, struct kvm_memory_slot *slot,
dbe93493d57473 Xiaoyao Li     2022-05-25  978  			    enum pg_level level)
aa7e272e931503 Xiaoyao Li     2021-08-31  979  {
aa7e272e931503 Xiaoyao Li     2021-08-31  980  	struct kvm_page_attr *page_attr = page_attr_slot(gfn, slot, level);
aa7e272e931503 Xiaoyao Li     2021-08-31 @981  	enum kvm_page_type type;
aa7e272e931503 Xiaoyao Li     2021-08-31  982  	gfn_t base_gfn;
aa7e272e931503 Xiaoyao Li     2021-08-31  983  
aa7e272e931503 Xiaoyao Li     2021-08-31  984  	if (WARN_ON_ONCE(!kvm_page_type_valid(page_attr) || level <= PG_LEVEL_4K))
aa7e272e931503 Xiaoyao Li     2021-08-31  985  		return;
aa7e272e931503 Xiaoyao Li     2021-08-31  986  
aa7e272e931503 Xiaoyao Li     2021-08-31  987  	base_gfn = gfn & ~(KVM_PAGES_PER_HPAGE(level) - 1);
aa7e272e931503 Xiaoyao Li     2021-08-31  988  	type = page_attr->type;
dbe93493d57473 Xiaoyao Li     2022-05-25  989  
aa7e272e931503 Xiaoyao Li     2021-08-31  990  	/*
aa7e272e931503 Xiaoyao Li     2021-08-31  991  	 * Set the type to KVM_PAGE_TYPE_MIXED in advance since when a large
aa7e272e931503 Xiaoyao Li     2021-08-31  992  	 * page needs to be split means one of the 4K page of it needs to be
aa7e272e931503 Xiaoyao Li     2021-08-31  993  	 * changed to oppsite type
aa7e272e931503 Xiaoyao Li     2021-08-31  994  	 */
2cf2a8208ae24b Isaku Yamahata 2022-06-02  995  	page_type_set(page_attr, KVM_PAGE_TYPE_MIXED, base_gfn, slot, level);
aa7e272e931503 Xiaoyao Li     2021-08-31  996  }
aa7e272e931503 Xiaoyao Li     2021-08-31  997  

:::::: The code at line 981 was first introduced by commit
:::::: aa7e272e931503dda524bd4f15d098a0d4ac28d7 KVM: MMU: Update page_attr->type when guest converts the page

:::::: TO: Xiaoyao Li <xiaoyao.li@intel.com>
:::::: CC: Isaku Yamahata <isaku.yamahata@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
