Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CF4D5328
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbiCJUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242722AbiCJUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:41:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84B107A97
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646944807; x=1678480807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WemAqurawjFOGCVq/P1zvkqNigDJ3v/Ajx7s/G3e5r4=;
  b=CoeF7Ns5zN/oOmOOFuTWZ/cUIN+/KAG2yMz+eFFxky5BOdP4AmlZuwec
   09zkz9AOGTOzZCxZYpTHhmcFTTy91JT0rKkJQBm0ZW2GEh9zDakf/F6/c
   84q4+ySKkBz9WO7cnbJ9RRExSS+iHodAw0EXiOZK9eoG16+6irJVmM6G+
   mHTaox1A//OJxorXT8xNcf4J/Fgf0Au6TBHaj6N/Ha2BTINzxlW90rOl+
   GMzOnKEvec/gaoC05keHKtx3RyRA+TRKRnMyZVJt2ZQ7XpSyZnLGANEKw
   FDRyAydBl8XpzKZbzLxOwEYajE5Ms0b3taF21aA4GwCCdEec+4PkCWl0r
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255325130"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255325130"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 12:40:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="496409463"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2022 12:40:02 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSPZp-0005NR-IX; Thu, 10 Mar 2022 20:40:01 +0000
Date:   Fri, 11 Mar 2022 04:39:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc6 37/41] arm-linux-gnueabi-ld:
 vfio_compat.c:undefined reference to `interval_tree_span_iter_next'
Message-ID: <202203110400.pzAhW2v5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc6
head:   fc7890730af65b13691ccd7371b2f571338ffa74
commit: a3f133279ae994c62f5a14dbcd334564651484c8 [37/41] vfio: Add iommufd VFIO compat support to group_fd
config: arm-randconfig-p002-20220310 (https://download.01.org/0day-ci/archive/20220311/202203110400.pzAhW2v5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/a3f133279ae994c62f5a14dbcd334564651484c8
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc6
        git checkout a3f133279ae994c62f5a14dbcd334564651484c8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/softirq.o: in function `spawn_ksoftirqd':
   softirq.c:(.init.text+0x14): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   softirq.c:(.init.text+0x30): relocation truncated to fit: R_ARM_PC24 against symbol `__cpuhp_setup_state' defined in .text section in kernel/cpu.o
   softirq.c:(.init.text+0x38): relocation truncated to fit: R_ARM_PC24 against symbol `smpboot_register_percpu_thread' defined in .text section in kernel/smpboot.o
   kernel/softirq.o: in function `softirq_init':
   softirq.c:(.init.text+0x68): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   kernel/softirq.o: in function `early_irq_init':
   softirq.c:(.init.text+0xb8): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   kernel/softirq.o: in function `arch_probe_nr_irqs':
   softirq.c:(.init.text+0xd4): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   kernel/softirq.o: in function `arch_early_irq_init':
   softirq.c:(.init.text+0xf0): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x10): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0x38): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x64): relocation truncated to fit: R_ARM_PC24 against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/entry-ftrace.o
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x90): additional relocation overflows omitted from the output
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
   io_pagetable.c:(.text+0x278): undefined reference to `interval_tree_span_iter_first'
>> arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x2a4): undefined reference to `interval_tree_span_iter_next'
>> arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x2bc): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x2e4): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   io_pagetable.c:(.text+0x3a4): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
   io_pagetable.c:(.text+0x4b0): undefined reference to `interval_tree_insert'
>> arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x4f4): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_abort_area':
   io_pagetable.c:(.text+0x5f8): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   io_pagetable.c:(.text+0x620): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   io_pagetable.c:(.text+0x78c): undefined reference to `interval_tree_insert'
>> arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x7f4): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unfill_domain':
   io_pagetable.c:(.text+0xa7c): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   io_pagetable.c:(.text+0x126c): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   io_pagetable.c:(.text+0x12bc): undefined reference to `interval_tree_iter_first'
>> arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x12d4): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x12f0): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/ioas.o: in function `iommufd_ioas_iova_ranges':
   ioas.c:(.text+0x344): undefined reference to `interval_tree_span_iter_first'
>> arm-linux-gnueabi-ld: ioas.c:(.text+0x400): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_init':
   pages.c:(.text+0x47c): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `interval_tree_fully_covers':
   pages.c:(.text+0x4cc): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   pages.c:(.text+0x60c): undefined reference to `interval_tree_span_iter_first'
>> arm-linux-gnueabi-ld: pages.c:(.text+0x624): undefined reference to `interval_tree_span_iter_next'
>> arm-linux-gnueabi-ld: pages.c:(.text+0x63c): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x650): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_get_exact_user':
   pages.c:(.text+0xb4c): undefined reference to `interval_tree_iter_first'
>> arm-linux-gnueabi-ld: pages.c:(.text+0xb74): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   pages.c:(.text+0x11f8): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x12e8): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_unmap_domain':
   pages.c:(.text+0x1928): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x1954): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   pages.c:(.text+0x1c1c): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   pages.c:(.text+0x1dec): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   pages.c:(.text+0x1ef8): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x1f20): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: pages.c:(.text+0x1f58): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x1fd4): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   pages.c:(.text+0x21a4): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x22cc): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_add_user':
   pages.c:(.text+0x2424): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_remove_user':
   pages.c:(.text+0x24a8): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   vfio_compat.c:(.text+0x1c8): undefined reference to `interval_tree_span_iter_first'
>> arm-linux-gnueabi-ld: vfio_compat.c:(.text+0x244): undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO && MMU && (X86 || S390 || ARM || ARM64)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
