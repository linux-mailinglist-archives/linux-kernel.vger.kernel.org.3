Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF93539BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349492AbiFADvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiFADvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:51:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A36351
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654055505; x=1685591505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LiEkjX4N1vdnbHmjpR+CLTsoDmY7Jy5fEGVgFts5Ufc=;
  b=FAdwf2RQnS764VZhZgVOzw1MME4dBUVj482/uWfTBiexst/iBvO/P5oD
   H+QBxalorVqv0p/M19IfUf2qiizLu8rW3YcJuykENV4fc6ScpzQBCGXpG
   Ej4mcsyNPD2dCkaGM8vzFkj7R8DcHQQlZg+TgJHzVdw+Ov4ynZ7rrbieA
   N0LfMoQgyYbdSueJaX51uILiEKtWEV/ilj9glWuRoW5m9ovFw4QPZO9GH
   IkXLfJGoPIbam8ZphJLTooYjupW01CN94EZo70W6rQSn1bRTCRDi7u3zJ
   XkkrlQZpDT/HOX8oyOzIlIvAT2pVH+nVJuskIgZWIvQkyrOHlPiseZtkS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255938785"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="255938785"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 20:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="529888872"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2022 20:51:42 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwFOY-0003US-8J;
        Wed, 01 Jun 2022 03:51:42 +0000
Date:   Wed, 1 Jun 2022 11:51:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 422/422]
 arch/x86/kvm/mmu/mmu.c:4546:13: error: implicit declaration of function
 'get_user_page_fast'; did you mean 'get_user_pages_fast'?
Message-ID: <202206011134.9CrAT8m1-lkp@intel.com>
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
head:   4e487b52e144ed36e4ae202e7103e63679710095
commit: 4e487b52e144ed36e4ae202e7103e63679710095 [422/422] KVM: x86/mmu: Use get_user_page_fast instead of get_user_page_fast_only
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220601/202206011134.9CrAT8m1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/4e487b52e144ed36e4ae202e7103e63679710095
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 4e487b52e144ed36e4ae202e7103e63679710095
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kvm_host.h:47,
                    from arch/x86/kvm/irq.h:15,
                    from arch/x86/kvm/mmu/mmu.c:18:
   include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   arch/x86/kvm/mmu/mmu.c: In function 'kvm_faultin_pfn_private_mapped':
>> arch/x86/kvm/mmu/mmu.c:4546:13: error: implicit declaration of function 'get_user_page_fast'; did you mean 'get_user_pages_fast'? [-Werror=implicit-function-declaration]
    4546 |         if (get_user_page_fast(hva, FOLL_WRITE, page))
         |             ^~~~~~~~~~~~~~~~~~
         |             get_user_pages_fast
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
   cc1: some warnings being treated as errors


vim +4546 arch/x86/kvm/mmu/mmu.c

  4527	
  4528	/*
  4529	 * Private page can't be release on mmu_notifier without losing page contents.
  4530	 * The help, callback, from backing store is needed to allow page migration.
  4531	 * For now, pin the page.
  4532	 */
  4533	static int kvm_faultin_pfn_private_mapped(struct kvm_vcpu *vcpu,
  4534					    struct kvm_page_fault *fault)
  4535	{
  4536		hva_t hva = gfn_to_hva_memslot(fault->slot, fault->gfn);
  4537		struct page *page[1];
  4538	
  4539		fault->map_writable = false;
  4540		fault->pfn = KVM_PFN_ERR_FAULT;
  4541		if (hva == KVM_HVA_ERR_RO_BAD || hva == KVM_HVA_ERR_BAD)
  4542			return RET_PF_INVALID;
  4543	
  4544		/* TDX allows only RWX.  Read-only isn't supported. */
  4545		WARN_ON_ONCE(!fault->write);
> 4546		if (get_user_page_fast(hva, FOLL_WRITE, page))
  4547			return RET_PF_INVALID;
  4548	
  4549		fault->map_writable = true;
  4550		fault->pfn = page_to_pfn(page[0]);
  4551		return RET_PF_CONTINUE;
  4552	}
  4553	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
