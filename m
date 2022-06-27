Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502255C254
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbiF0USy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiF0USw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:18:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C0E1DA62
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656361131; x=1687897131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xJStzFC3vNJ7mv3RFNH75snN/MoIWhXsNUGGMACLErY=;
  b=JEYym6eQ0aUVZWpdH8KhwdlQcGQRlmfr07EPYDvmasPcHBOKVYmlcy4c
   3vi0WgCW3Iz7iqw/1r67HGpefwX9YPJIq6SVNhsqqHde9gZaaENab9yyy
   j1YKdadgI8ZYrpVJLb1/wfKZl91y+oDl6llLZce/sDTKMFMydUjJxXqhd
   0puase0qXo0li1T41VzMBvKx9vop8m0AVZOnMd94EG/Y6bEfAJLtFzlw2
   mTxeOCASATbtHsHDKrMS5xRaMVCL9U5ErFD1F8JeOym+QyaekqVrDRyI7
   Dl3BoU/OQMjD8N67T1BgrLqHKOowvvZZdCnvrDb6fQ/xXZErWwHitR4ie
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264595832"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264595832"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 13:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="916874743"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2022 13:18:49 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5vC4-0008zL-O6;
        Mon, 27 Jun 2022 20:18:48 +0000
Date:   Tue, 28 Jun 2022 04:18:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 434/442]
 arch/x86/kvm/mmu/mmu.c:981:28: warning: variable 'type' set but not used
Message-ID: <202206280410.80DLJ8SU-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220628/202206280410.80DLJ8SU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/2cf2a8208ae24b96f074aac76f0feef63489137d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 2cf2a8208ae24b96f074aac76f0feef63489137d
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
>> arch/x86/kvm/mmu/mmu.c:981:28: warning: variable 'type' set but not used [-Wunused-but-set-variable]
     981 |         enum kvm_page_type type;
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
