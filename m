Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2953DAB1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 09:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350775AbiFEH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiFEH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:26:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7D4D9FF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 00:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654413996; x=1685949996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=psmPL6wrZ1BzqA3TxvWVXGyvbI/P1wZJwtJCZHBaqM0=;
  b=jxlLyxZFBbyVsAORtUvFlXFOa/UV4wxrH3oLFx/O1orJEMXSjNi32yB2
   o+pS4hnhccxSIhS1WBCvSK60w6q1D2viVMnQk2vTMuvlC3MQBhpwX7rQw
   EuLWwwFEUIZERnvjdFjLU3GF4wgjbHUwuLSGwatwkYUY5OJqohNXBjniz
   FCcNgmQsjWL50PsGWIt2i2xH/iLEiMa5iJtYM9wPcr4ml19c9n2A0yrwF
   4ibQAoCplEhl9ZR+Z6Jf3puNFcIC7PQMNtoB2ld34CMTskUGb4fnz19va
   msZNhRcuo2zVcRedNrqKUojyE/cV7sim6heuToPK8iP6PKC11o3vmHwr/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276293036"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="276293036"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 00:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="531591637"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jun 2022 00:26:35 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxkeg-000Bft-LR;
        Sun, 05 Jun 2022 07:26:34 +0000
Date:   Sun, 5 Jun 2022 15:26:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 31/34]
 arch/x86/xen/enlighten_pv.c:456:27: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202206051518.CDqaUSMi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   1aafd4ba7b78b4ac0013a48a35252654852cb7ab
commit: 43bd244c8a76e91d6f02c0fc3212069609bd9645 [31/34] x86/xen: Make virt_to_pfn() a static inline
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220605/202206051518.CDqaUSMi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=43bd244c8a76e91d6f02c0fc3212069609bd9645
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 43bd244c8a76e91d6f02c0fc3212069609bd9645
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/xen/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/xen/enlighten_pv.c:456:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long va @@
   arch/x86/xen/enlighten_pv.c:456:27: sparse:     expected void const *v
   arch/x86/xen/enlighten_pv.c:456:27: sparse:     got unsigned long va
--
>> arch/x86/xen/setup.c:341:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long buf @@
   arch/x86/xen/setup.c:341:20: sparse:     expected void const *v
   arch/x86/xen/setup.c:341:20: sparse:     got unsigned long buf
   arch/x86/xen/setup.c:504:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long buf @@
   arch/x86/xen/setup.c:504:20: sparse:     expected void const *v
   arch/x86/xen/setup.c:504:20: sparse:     got unsigned long buf
--
>> arch/x86/xen/mmu_pv.c:2196:40: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long vaddr @@
   arch/x86/xen/mmu_pv.c:2196:40: sparse:     expected void const *v
   arch/x86/xen/mmu_pv.c:2196:40: sparse:     got unsigned long vaddr
   arch/x86/xen/mmu_pv.c:2199:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long vaddr @@
   arch/x86/xen/mmu_pv.c:2199:51: sparse:     expected void const *v
   arch/x86/xen/mmu_pv.c:2199:51: sparse:     got unsigned long vaddr
   arch/x86/xen/mmu_pv.c:2202:53: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long vaddr @@
   arch/x86/xen/mmu_pv.c:2202:53: sparse:     expected void const *v
   arch/x86/xen/mmu_pv.c:2202:53: sparse:     got unsigned long vaddr
   arch/x86/xen/mmu_pv.c:2244:49: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long vaddr @@
   arch/x86/xen/mmu_pv.c:2244:49: sparse:     expected void const *v
   arch/x86/xen/mmu_pv.c:2244:49: sparse:     got unsigned long vaddr
>> arch/x86/xen/mmu_pv.c:2321:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long vstart @@
   arch/x86/xen/mmu_pv.c:2321:33: sparse:     expected void const *v
   arch/x86/xen/mmu_pv.c:2321:33: sparse:     got unsigned long vstart
>> arch/x86/xen/mmu_pv.c:2354:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const *v @@     got unsigned long [assigned] vstart @@
   arch/x86/xen/mmu_pv.c:2354:20: sparse:     expected void const *v
   arch/x86/xen/mmu_pv.c:2354:20: sparse:     got unsigned long [assigned] vstart
   arch/x86/xen/mmu_pv.c:648:19: sparse: sparse: context imbalance in 'xen_pte_lock' - wrong count at exit
   arch/x86/xen/mmu_pv.c:660:13: sparse: sparse: context imbalance in 'xen_pte_unlock' - unexpected unlock

vim +456 arch/x86/xen/enlighten_pv.c

e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  441  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  442  /*
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  443   * load_gdt for early boot, when the gdt is only mapped once
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  444   */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  445  static void __init xen_load_gdt_boot(const struct desc_ptr *dtr)
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  446  {
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  447  	unsigned long va = dtr->address;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  448  	unsigned int size = dtr->size + 1;
eb0b4aa89cf21b Laura Abbott     2018-04-18  449  	unsigned long pfn, mfn;
eb0b4aa89cf21b Laura Abbott     2018-04-18  450  	pte_t pte;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  451  
eb0b4aa89cf21b Laura Abbott     2018-04-18  452  	/* @size should be at most GDT_SIZE which is smaller than PAGE_SIZE. */
eb0b4aa89cf21b Laura Abbott     2018-04-18  453  	BUG_ON(size > PAGE_SIZE);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  454  	BUG_ON(va & ~PAGE_MASK);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  455  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14 @456  	pfn = virt_to_pfn(va);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  457  	mfn = pfn_to_mfn(pfn);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  458  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  459  	pte = pfn_pte(pfn, PAGE_KERNEL_RO);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  460  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  461  	if (HYPERVISOR_update_va_mapping((unsigned long)va, pte, 0))
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  462  		BUG();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  463  
eb0b4aa89cf21b Laura Abbott     2018-04-18  464  	if (HYPERVISOR_set_gdt(&mfn, size / sizeof(struct desc_struct)))
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  465  		BUG();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  466  }
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  467  

:::::: The code at line 456 was first introduced by commit
:::::: e1dab14cf68d1e03950135969af3faf322f0db04 x86/xen: split off enlighten_pv.c

:::::: TO: Vitaly Kuznetsov <vkuznets@redhat.com>
:::::: CC: Juergen Gross <jgross@suse.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
