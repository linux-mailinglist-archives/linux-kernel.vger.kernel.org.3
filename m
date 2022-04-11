Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793644FB255
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiDKD2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiDKD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:28:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28D2AC73
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649647588; x=1681183588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r7n/gda/obIceYoMJf4Oz+zHhJbov663V91+SWaqRsw=;
  b=elWrcXtSFrjJv5Uj0zV6uZmMFXbGb6wxFaQ8rnPEZfDdC0mTlZZMwk74
   +IbJ5+6ojEavqMpZdmISIly922kXz58aFWqBIEu0fhAwInvXEjALLxHmn
   x9DQX9BMpC6VFp80FF4i3iIN+9H1gWd6It40qWMvHM6VTtKMhMwvkPyVV
   9IxHXG5Fv30nFy4a7aGF54VBr64whYZq+zQsyXnL1DdGXki4SejTiRl4Q
   2mVAZ0A8iQqxHDYxVUvnknu51JRD3MXkWMjbB+3xMeBaRXrCNI/wF+sou
   l17jVGcLUEOY1ErFysCn3rQ0LgifzCIWRMOaWpdCP4H/hGJM2wrC5IM8Z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243908084"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="243908084"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 20:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="589672924"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2022 20:26:26 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndkh8-0001Mt-AU;
        Mon, 11 Apr 2022 03:26:26 +0000
Date:   Mon, 11 Apr 2022 11:25:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 9297/9999]
 arch/arm/mm/dma-mapping.c:1009:6: warning: no previous prototype for
 'arch_sync_dma_for_device'
Message-ID: <202204111138.VtjigEGJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 22bd488f5bfd457167372ea73c57300d586ca53e [9297/9999] CHROMIUM: arm: add arch_sync_dma_for_*()
config: arm-pxa255-idp_defconfig (https://download.01.org/0day-ci/archive/20220411/202204111138.VtjigEGJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/22bd488f5bfd457167372ea73c57300d586ca53e
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 22bd488f5bfd457167372ea73c57300d586ca53e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mm/dma-mapping.c:459:13: warning: no previous prototype for 'dma_contiguous_early_fixup' [-Wmissing-prototypes]
     459 | void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mm/dma-mapping.c:1009:6: warning: no previous prototype for 'arch_sync_dma_for_device' [-Wmissing-prototypes]
    1009 | void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mm/dma-mapping.c:1050:6: warning: no previous prototype for 'arch_sync_dma_for_cpu' [-Wmissing-prototypes]
    1050 | void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
         |      ^~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mm/dma-mapping.c:1061:7: warning: no previous prototype for 'arch_dma_alloc' [-Wmissing-prototypes]
    1061 | void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
         |       ^~~~~~~~~~~~~~
>> arch/arm/mm/dma-mapping.c:1066:6: warning: no previous prototype for 'arch_dma_free' [-Wmissing-prototypes]
    1066 | void arch_dma_free(struct device *dev, size_t size, void *vaddr,
         |      ^~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c: In function 'dma_contiguous_early_fixup':
   arch/arm/mm/dma-mapping.c:461:22: warning: array subscript <unknown> is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Warray-bounds]
     461 |         dma_mmu_remap[dma_mmu_remap_num].base = base;
         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c:455:40: note: while referencing 'dma_mmu_remap'
     455 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
         |                                        ^~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c:462:22: warning: array subscript <unknown> is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Warray-bounds]
     462 |         dma_mmu_remap[dma_mmu_remap_num].size = size;
         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c:455:40: note: while referencing 'dma_mmu_remap'
     455 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
         |                                        ^~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c: In function 'dma_contiguous_remap':
   arch/arm/mm/dma-mapping.c:470:50: warning: array subscript i is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Warray-bounds]
     470 |                 phys_addr_t start = dma_mmu_remap[i].base;
         |                                     ~~~~~~~~~~~~~^~~
   arch/arm/mm/dma-mapping.c:455:40: note: while referencing 'dma_mmu_remap'
     455 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
         |                                        ^~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c:471:56: warning: array subscript i is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Warray-bounds]
     471 |                 phys_addr_t end = start + dma_mmu_remap[i].size;
         |                                           ~~~~~~~~~~~~~^~~
   arch/arm/mm/dma-mapping.c:455:40: note: while referencing 'dma_mmu_remap'
     455 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
         |                                        ^~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c:132: warning: Function parameter or member 'attrs' not described in 'arm_dma_map_page'
   arch/arm/mm/dma-mapping.c:161: warning: Function parameter or member 'attrs' not described in 'arm_dma_unmap_page'
   arch/arm/mm/dma-mapping.c:1089: warning: Function parameter or member 'attrs' not described in 'arm_dma_map_sg'
   arch/arm/mm/dma-mapping.c:1123: warning: Function parameter or member 'attrs' not described in 'arm_dma_unmap_sg'
   arch/arm/mm/dma-mapping.c:1818: warning: Function parameter or member 'attrs' not described in 'arm_coherent_iommu_map_sg'
   arch/arm/mm/dma-mapping.c:1836: warning: Function parameter or member 'attrs' not described in 'arm_iommu_map_sg'
   arch/arm/mm/dma-mapping.c:1870: warning: Function parameter or member 'attrs' not described in 'arm_coherent_iommu_unmap_sg'
   arch/arm/mm/dma-mapping.c:1887: warning: Function parameter or member 'attrs' not described in 'arm_iommu_unmap_sg'
   arch/arm/mm/dma-mapping.c:1940: warning: Function parameter or member 'attrs' not described in 'arm_coherent_iommu_map_page'
   arch/arm/mm/dma-mapping.c:1974: warning: Function parameter or member 'attrs' not described in 'arm_iommu_map_page'
   arch/arm/mm/dma-mapping.c:1992: warning: Function parameter or member 'attrs' not described in 'arm_coherent_iommu_unmap_page'
   arch/arm/mm/dma-mapping.c:2016: warning: Function parameter or member 'attrs' not described in 'arm_iommu_unmap_page'
   arch/arm/mm/dma-mapping.c:2043: warning: Function parameter or member 'attrs' not described in 'arm_iommu_map_resource'
   arch/arm/mm/dma-mapping.c:2077: warning: Function parameter or member 'attrs' not described in 'arm_iommu_unmap_resource'


vim +/arch_sync_dma_for_device +1009 arch/arm/mm/dma-mapping.c

  1008	
> 1009	void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
  1010			size_t size, enum dma_data_direction dir)
  1011	{
  1012		__dma_page_cpu_to_dev(phys_to_page(paddr), paddr % PAGE_SIZE, size, dir);
  1013	}
  1014	EXPORT_SYMBOL_GPL(arch_sync_dma_for_device);
  1015	
  1016	static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
  1017		size_t size, enum dma_data_direction dir)
  1018	{
  1019		phys_addr_t paddr = page_to_phys(page) + off;
  1020	
  1021		/* FIXME: non-speculating: not required */
  1022		/* in any case, don't bother invalidating if DMA to device */
  1023		if (dir != DMA_TO_DEVICE) {
  1024			outer_inv_range(paddr, paddr + size);
  1025	
  1026			dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
  1027		}
  1028	
  1029		/*
  1030		 * Mark the D-cache clean for these pages to avoid extra flushing.
  1031		 */
  1032		if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
  1033			unsigned long pfn;
  1034			size_t left = size;
  1035	
  1036			pfn = page_to_pfn(page) + off / PAGE_SIZE;
  1037			off %= PAGE_SIZE;
  1038			if (off) {
  1039				pfn++;
  1040				left -= PAGE_SIZE - off;
  1041			}
  1042			while (left >= PAGE_SIZE) {
  1043				page = pfn_to_page(pfn++);
  1044				set_bit(PG_dcache_clean, &page->flags);
  1045				left -= PAGE_SIZE;
  1046			}
  1047		}
  1048	}
  1049	
> 1050	void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
  1051			size_t size, enum dma_data_direction dir)
  1052	{
  1053		__dma_page_dev_to_cpu(phys_to_page(paddr), paddr % PAGE_SIZE, size, dir);
  1054	}
  1055	EXPORT_SYMBOL_GPL(arch_sync_dma_for_cpu);
  1056	
  1057	/*
  1058	 * arch_dma_{alloc,free} fail-stubs needed to avoid link-errors in dma/direct.c
  1059	 * (which is not actually used on arch/arm)
  1060	 */
> 1061	void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
  1062			gfp_t flags, unsigned long attrs)
  1063	{
  1064		return NULL;
  1065	}
> 1066	void arch_dma_free(struct device *dev, size_t size, void *vaddr,
  1067			dma_addr_t dma_handle, unsigned long attrs)
  1068	{
  1069	}
  1070	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
