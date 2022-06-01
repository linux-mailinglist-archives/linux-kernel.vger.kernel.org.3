Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56A8539C52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349545AbiFAEnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiFAEnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:43:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA159C2FA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654058628; x=1685594628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v83w+pcu1rKKOY5FjT6tu+qdUXMlHJHuYL50RQr/FiM=;
  b=eGf5acefH+iHdTpq5/py8rblvjBIhzyq5g6urf7G/iCNDHhRuwNMmi1Q
   6HCTOtbByBAVeUa8g465dyCM56T3RdGv43P9cIfMD/pLMhq5LPE7u/ntM
   N2jkhP5z24plBtG6nybaNEM0ZhIx2NHZQE6vQRmhjMZLlw7ByM/mw7KGT
   hwMrr3iW/7M5CLMF5ErTgUrQe0n4jKNIHuA6Jxwk/o+kf0y6bBUocOPNh
   zOfNjU+LddnfonmzchajF5imtEvPdha3TTA4BrVKYRDtKj/rsG+K0PTe8
   3A9WxPOYBTZAMzsp6tRbd73VJasX6dIf/lJAOZgz/wQyMHTnYI61/sUtK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="336126269"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="336126269"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 21:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="667244876"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2022 21:43:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwGCu-0003Y2-AR;
        Wed, 01 Jun 2022 04:43:44 +0000
Date:   Wed, 1 Jun 2022 12:42:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 422/422]
 arch/x86/kvm/mmu/mmu.c:4546:6: error: call to undeclared function
 'get_user_page_fast'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202206011249.nbPtIS94-lkp@intel.com>
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
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220601/202206011249.nbPtIS94-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/4e487b52e144ed36e4ae202e7103e63679710095
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 4e487b52e144ed36e4ae202e7103e63679710095
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

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
>> arch/x86/kvm/mmu/mmu.c:4546:6: error: call to undeclared function 'get_user_page_fast'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (get_user_page_fast(hva, FOLL_WRITE, page))
               ^
   arch/x86/kvm/mmu/mmu.c:4546:6: note: did you mean 'get_user_pages_fast'?
   include/linux/mm.h:1931:5: note: 'get_user_pages_fast' declared here
   int get_user_pages_fast(unsigned long start, int nr_pages,
       ^
   2 errors generated.


vim +/get_user_page_fast +4546 arch/x86/kvm/mmu/mmu.c

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
