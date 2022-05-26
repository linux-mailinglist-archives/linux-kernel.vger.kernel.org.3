Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4549534A39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 07:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbiEZFi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 01:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbiEZFiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 01:38:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C9B38791
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653543533; x=1685079533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x0E2eJhSoB02GqAn050NXHPHIqNim8wXEIwrtG/UOT8=;
  b=Z/3mPk3U2MnkS4+cPSUNl8nExprkO+GA47HVAOyTfC9pcsU0XlfiAper
   hmam/zP3d57Vb5LXKP0pTR/SUknxnChcokEuYVE9LTHGUK90rwfLV50t6
   T+L2pmhsc7ATEJMPRwFQr5mgurD4rTaopWwz+8XhqVydFID4bPpKaIhMQ
   p8+jH8LpDoFEQk3GkO20eIr6lXD+Gul/lzl+zjIQD+q66Zf3G6SUNDDDX
   4MNJ0AxvUCv8TTPZgfEratKAyojw5gebz4gfi7pvCEeQik+jgLWRCxj7c
   8p+yo1+VWEa4O5Tq34aaCaxnzIacz7Mu0pWtdTzYKhQD08LmDFTe+sJUS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="272856338"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="272856338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 22:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="549398576"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2022 22:38:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nu6Cw-0003dM-VV;
        Thu, 26 May 2022 05:38:51 +0000
Date:   Thu, 26 May 2022 13:38:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/19]
 arch/arm/mm/init.c:213: undefined reference to `kernel_sec_start'
Message-ID: <202205261345.Ua1PVD1d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   3e0251249eddfbc62975f7ae9ad77d0a8ec93713
commit: 01745426f3ddddf6442f6612743c06be252dc2a6 [8/19] ARM: Compile the kernel into VMALLOC
config: arm-randconfig-c003-20220524 (https://download.01.org/0day-ci/archive/20220526/202205261345.Ua1PVD1d-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=01745426f3ddddf6442f6612743c06be252dc2a6
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 01745426f3ddddf6442f6612743c06be252dc2a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mm/init.o: in function `arm_memblock_init':
>> arch/arm/mm/init.c:213: undefined reference to `kernel_sec_start'
   arm-linux-gnueabi-ld: drivers/gpu/drm/drm_gem_shmem_helper.o: in function `drm_gem_shmem_fault':
   drivers/gpu/drm/drm_gem_shmem_helper.c:561: undefined reference to `vmf_insert_pfn'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +213 arch/arm/mm/init.c

5f41f9198f29609 Marek Szyprowski 2019-05-28  182  
3928624812dcfa3 Russell King     2017-01-16  183  void __init arm_memblock_init(const struct machine_desc *mdesc)
3928624812dcfa3 Russell King     2017-01-16  184  {
01745426f3ddddf Linus Walleij    2021-04-15  185  	/*
01745426f3ddddf Linus Walleij    2021-04-15  186  	 * Register the kernel text, kernel data and initrd with memblock.
01745426f3ddddf Linus Walleij    2021-04-15  187  	 *
01745426f3ddddf Linus Walleij    2021-04-15  188  	 * When using kernel in vmalloc, we have to round up to the closest
01745426f3ddddf Linus Walleij    2021-04-15  189  	 * section size, or the temporary section mapping of the tail of the
01745426f3ddddf Linus Walleij    2021-04-15  190  	 * kernel will be overwritten by memblock allocations. This is not
01745426f3ddddf Linus Walleij    2021-04-15  191  	 * a problem with the linear kernel map, since the allocations can
01745426f3ddddf Linus Walleij    2021-04-15  192  	 * use the 1:1 map in that case.
01745426f3ddddf Linus Walleij    2021-04-15  193  	 */
01745426f3ddddf Linus Walleij    2021-04-15  194  	if (!IS_ENABLED(CONFIG_ARM_KERNEL_IN_VMALLOC))
01745426f3ddddf Linus Walleij    2021-04-15  195  		memblock_reserve(kernel_sec_start, KERNEL_END - KERNEL_START);
01745426f3ddddf Linus Walleij    2021-04-15  196  	else
01745426f3ddddf Linus Walleij    2021-04-15  197  		memblock_reserve(kernel_sec_start, KERNEL_SECTION_SIZE);
3928624812dcfa3 Russell King     2017-01-16  198  
e46e45f00d9ea54 Wang Kefeng      2021-12-22  199  	reserve_initrd_mem();
2778f62056ada44 Russell King     2010-07-09  200  
2778f62056ada44 Russell King     2010-07-09  201  	arm_mm_memblock_reserve();
2778f62056ada44 Russell King     2010-07-09  202  
8d717a52d1b0959 Russell King     2010-05-22  203  	/* reserve any platform specific memblock areas */
8d717a52d1b0959 Russell King     2010-05-22  204  	if (mdesc->reserve)
8d717a52d1b0959 Russell King     2010-05-22  205  		mdesc->reserve();
8d717a52d1b0959 Russell King     2010-05-22  206  
bcedb5f9bd74662 Marek Szyprowski 2014-02-28  207  	early_init_fdt_scan_reserved_mem();
bcedb5f9bd74662 Marek Szyprowski 2014-02-28  208  
99a468d779f6851 George G. Davis  2015-01-16  209  	/* reserve memory for DMA contiguous allocations */
95b0e655f914888 Marek Szyprowski 2014-10-09  210  	dma_contiguous_reserve(arm_dma_limit);
c79095092834a18 Marek Szyprowski 2011-12-29  211  
716a3dc20084da9 Russell King     2012-01-13  212  	arm_memblock_steal_permitted = false;
2778f62056ada44 Russell King     2010-07-09 @213  	memblock_dump_all();
2778f62056ada44 Russell King     2010-07-09  214  }
2778f62056ada44 Russell King     2010-07-09  215  

:::::: The code at line 213 was first introduced by commit
:::::: 2778f62056ada442414392d7ccd41188bb631619 ARM: initial LMB trial

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
