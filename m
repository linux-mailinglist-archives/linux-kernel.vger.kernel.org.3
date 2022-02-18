Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D974BB36C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiBRHdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:33:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiBRHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:33:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5D29A55A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645169599; x=1676705599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2ovBAY+X/7UhDUZdaPOalwBTMM25xCH0YwNPpTpTrdM=;
  b=dyYLxJgS2d1A2VhUlgjnwBc2kLFRs4VfDQB9rWH36pbIl5jQCbVXODBd
   c9hvgJqKlMYN8fARZ8gQKE+YLWcHNH8dwCDGqEY8vwYOM1aEzLSi9/rdY
   YWEIiHsU9H4P5rWb0OFZzRvDmEZy/y132lSizZCsBURbEuVgeayaE2Ns0
   qm9gOUpKyfahkfSuE5DRtRJUrjQ8hvyJ5wAxnD3QgJDEozmDzlRz4A0jy
   JSgWtgTOXGvHaefIYTQ303VX58GGIJ4KTEi+m0dVuTPxA06VrxbDx/6JY
   jIpDQxwwSvzZF25sSvfcEFC8vy7Ra0f9q2kfTpW3kNqmi3HohPHzxjDru
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250828740"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="250828740"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="530811264"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2022 23:33:17 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKxlU-00014v-G6; Fri, 18 Feb 2022 07:33:16 +0000
Date:   Fri, 18 Feb 2022 15:33:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 2786/4461] arch/arm64/kvm/arm.c:2011:46: error: 'smccc_trng_available'
 undeclared
Message-ID: <202202181558.uVIihgU4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   8f3d3d547d2c725afdb67b3a4ffb4a2f0f9dd339
commit: 888643ea37b504cb32afdd6430698d1e92a79a71 [2786/4461] ANDROID: KVM: arm64: relay entropy requests from protected guests directly to secure
config: arm64-randconfig-r003-20220217 (https://download.01.org/0day-ci/archive/20220218/202202181558.uVIihgU4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/888643ea37b504cb32afdd6430698d1e92a79a71
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout 888643ea37b504cb32afdd6430698d1e92a79a71
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kvm/arm.c: In function 'kvm_hyp_init_protection':
>> arch/arm64/kvm/arm.c:2011:46: error: 'smccc_trng_available' undeclared (first use in this function)
    2011 |         kvm_nvhe_sym(smccc_trng_available) = smccc_trng_available;
         |                                              ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/arm.c:2011:46: note: each undeclared identifier is reported only once for each function it appears in


vim +/smccc_trng_available +2011 arch/arm64/kvm/arm.c

  1997	
  1998	static int kvm_hyp_init_protection(u32 hyp_va_bits)
  1999	{
  2000		void *addr = phys_to_virt(hyp_mem_base);
  2001		int ret;
  2002	
  2003		kvm_nvhe_sym(id_aa64pfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
  2004		kvm_nvhe_sym(id_aa64pfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
  2005		kvm_nvhe_sym(id_aa64isar0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR0_EL1);
  2006		kvm_nvhe_sym(id_aa64isar1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
  2007		kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
  2008		kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
  2009		kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
  2010		kvm_nvhe_sym(__icache_flags) = __icache_flags;
> 2011		kvm_nvhe_sym(smccc_trng_available) = smccc_trng_available;
  2012	
  2013		ret = create_hyp_mappings(addr, addr + hyp_mem_size, PAGE_HYP);
  2014		if (ret)
  2015			return ret;
  2016	
  2017		ret = init_stage2_iommu();
  2018		if (ret < 0)
  2019			return ret;
  2020	
  2021		ret = do_pkvm_init(hyp_va_bits, (enum kvm_iommu_driver)ret);
  2022		if (ret)
  2023			return ret;
  2024	
  2025		free_hyp_pgds();
  2026	
  2027		return 0;
  2028	}
  2029	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
