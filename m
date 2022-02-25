Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDCF4C444B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiBYMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:08:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F101A12AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645790896; x=1677326896;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WVqYG+DiXIExAcDccN7FBAxpgMaONMHtVx9VTrInYlQ=;
  b=OHCXBEuf19eEKd30VTwJoVukKGAxjVzkC/QAhfZ/VAZqcjZpuiYPChfQ
   pXtPPBkiyHh/SOyBontSkK1aiYHJ9lx5zUjdjz+YjxbhaA5UeQ6xznfxN
   dKozhA1EGzgRocgMlMdxiB6ebVI5DUOeEa1OGYIcLcgv6sxvltFFDQDpa
   y9nbNGy7n2P1TZDjZS4jKslJ3vp3J0+R0YRHQ3GxkOTrRraIPdAsW9NAw
   4N36lMDjw8l/W3vo6lFya6mdxAkodHkrY4PFE9HDQKD37q5+98bhBwRAd
   KyNmEZckNs2gCyFt6eTi/ckw1yDKNX7GZdMoujmHkVaGUj2L76bnAsNmU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232456535"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="232456535"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 04:08:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="574579422"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 04:08:07 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNZOI-0004Hn-L4; Fri, 25 Feb 2022 12:08:06 +0000
Date:   Fri, 25 Feb 2022 20:07:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 2786/4674] arch/arm64/kvm/arm.c:2011:39: error: use of undeclared identifier
 'smccc_trng_available'
Message-ID: <202202252023.bwH1Xekw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   9eab20c98fb13b08ab49ae0bc8c90232e8e56d70
commit: 888643ea37b504cb32afdd6430698d1e92a79a71 [2786/4674] ANDROID: KVM: arm64: relay entropy requests from protected guests directly to secure
config: arm64-randconfig-r011-20220225 (https://download.01.org/0day-ci/archive/20220225/202202252023.bwH1Xekw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/888643ea37b504cb32afdd6430698d1e92a79a71
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout 888643ea37b504cb32afdd6430698d1e92a79a71
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kvm/arm.c:2011:39: error: use of undeclared identifier 'smccc_trng_available'
           kvm_nvhe_sym(smccc_trng_available) = smccc_trng_available;
                                                ^
   1 error generated.


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
