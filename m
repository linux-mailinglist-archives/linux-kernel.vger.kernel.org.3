Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E949FBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349327AbiA1Oob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:44:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:1049 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349091AbiA1Oo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643381069; x=1674917069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9MubXPOrZMSDvuDAk4wR9yXEG5Ff3JUogxZoDw218Ag=;
  b=ApYxAwcepOdTxcRZcEtwu2fKfF/w8BNz4XyXGmuCDjdkSAkvaI3Kocbk
   5/JaDnOiM+q5jI/VsDG6KeV9AVR8O3q19nAjSpINngFFsi1M+YUT5AFRq
   J6GnKMP1wfyTJCVD9XaHxDGX7LSEZIo1fwMgK+momCtRFni3Sj16xJ2mA
   2Z3HbVNZbD62gmk+pbHMqKrS9Onm5QXjc4VXMxWRNoJDrlY9q6Zhicd3p
   WlZ2NIMrJhlo5acVUSFGk3jVaUbog2Z0oPCKdgDWQ/CgepOyDNJy6mDNl
   7SdvtrKaPUGdV+suAlSORP8jTfakrqRrAbpwkBvQHaPlaraGKc5ceL76F
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="307846274"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="307846274"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618739123"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 06:44:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDSUD-000NzG-US; Fri, 28 Jan 2022 14:44:25 +0000
Date:   Fri, 28 Jan 2022 22:43:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 2786/2952] arch/arm64/kvm/arm.c:2011:39: error: use of undeclared identifier
 'smccc_trng_available'
Message-ID: <202201282248.FsZz69z1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   0eaf0db549770f64aa4a81fa6361ad40e42c99f9
commit: 888643ea37b504cb32afdd6430698d1e92a79a71 [2786/2952] ANDROID: KVM: arm64: relay entropy requests from protected guests directly to secure
config: arm64-randconfig-r022-20220124 (https://download.01.org/0day-ci/archive/20220128/202201282248.FsZz69z1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f32dccb9a43b02ce4e540d6ba5dbbdb188f2dc7d)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

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
