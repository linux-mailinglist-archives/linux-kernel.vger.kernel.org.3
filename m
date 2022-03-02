Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E404CA6AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiCBNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiCBNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:55:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99F41603
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646229163; x=1677765163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U9gGXoOCQYczVSGGTrZV7wv6trz14HVbASt8ATn8GAw=;
  b=IwMgAiwZLqQGrTc10SO1SI7vqSoMtns+JzHwm4QE4RjV14zmNBSZT09B
   yu6hHcD1L1PPLQJM8kNw92UHU2UZZWhEDzpdf5pqPfPRr/sVykXvxT9CM
   vo+ikKZTdBhf1XHr5EiCRWsuefpdiQAhmflzYxe7NESkp1R3b29sS0xbI
   J+xtIsUNSh3i/F09ph1wImOrNHrpFfqDNsww6jGBE531QJpgbqNMbbJBf
   SRDCe2W5vKnAFUvMEoson/EKdpQGRtZ6rbbomkR1TCfo8QHd7nVsj6gPM
   FRGfrjASLgvzqaNRmDsMJ+yP3qNuKwP/nfq+ptYlW6Ol5M6YXstQ0czRW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252231841"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="252231841"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="535394633"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 05:52:08 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPPOi-0001ST-8i; Wed, 02 Mar 2022 13:52:08 +0000
Date:   Wed, 2 Mar 2022 21:51:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 21/31] microblaze-linux-ld:
 undefined reference to `interval_tree_iter_first'
Message-ID: <202203022101.Y4kUObwj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   008e1a440da8ca4e1dae3dc1c210b46cb77ce01f
commit: 147fd4fddb93ec8503d590be9fda3a161dccbab4 [21/31] vfio/pci: Add bind_iommufd() support
config: microblaze-randconfig-r036-20220302 (https://download.01.org/0day-ci/archive/20220302/202203022101.Y4kUObwj-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/147fd4fddb93ec8503d590be9fda3a161dccbab4
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 147fd4fddb93ec8503d590be9fda3a161dccbab4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `__iopt_unmap_iova.constprop.0':
   (.text+0x1ec): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
   (.text+0x7f8): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x85c): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x8ec): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x904): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
   (.text+0xc38): undefined reference to `interval_tree_insert'
>> microblaze-linux-ld: (.text+0xc90): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0xcf4): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unfill_domain':
   (.text+0xf28): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0xf80): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: (.text+0x1080): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x118c): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x12a4): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x13d0): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   (.text+0x169c): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x16dc): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x18c4): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: (.text+0x190c): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x1b04): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x1b58): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x1c60): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_map_pages':
   (.text+0x1e3c): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_get_pages':
   (.text+0x2208): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_iova':
   (.text+0x2614): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_all':
   (.text+0x27f0): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unaccess_pages':
   (.text+0x2adc): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2bd0): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_access_pages':
   (.text+0x2fb4): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2fe0): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   (.text+0x3388): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x33e4): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   (.text+0x3534): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x3558): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x35a0): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_table_add_domain':
   (.text+0x3eb8): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x3f0c): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/ioas.o: in function `iommufd_ioas_iova_ranges':
   (.text+0x620): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x708): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   (.text+0x714): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x73c): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x78c): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x8d4): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_get_exact_user':
   (.text+0x1178): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x11b0): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `__iopt_area_unfill_domain':
   (.text+0x25e0): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2660): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   (.text+0x2d70): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2e8c): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_init':
   (.text+0x3050): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_unmap_domain':
   (.text+0x3f28): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x3f4c): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   (.text+0x44c8): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   (.text+0x4600): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   (.text+0x4740): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x47c8): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x47ec): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x4894): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x48bc): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x4a60): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   (.text+0x5048): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x50b0): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_add_user':
   (.text+0x5554): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_remove_user':
   (.text+0x5870): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   (.text+0x6a0): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x7e0): undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO_PCI_CORE && VFIO && PCI && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
