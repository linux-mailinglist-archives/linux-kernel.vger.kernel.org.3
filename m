Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A554C74C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiB1Rqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiB1Rnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:43:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E189BAF2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069743; x=1677605743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RAryok0vKfVpAzge8J2hbvbGTyPUqsIIgGWXo0OVMu4=;
  b=Zam9UHM7pK8ivKOs+rn0xC0znsprEVyxFvvpBF3YeFzHqtZcNGeJ0CPt
   Yeey+PMbGPlD7gUKON/xrQyrgYSa7DRlTxzVSAcRKzmHucfHcjxhzC3vK
   7fIC8jDv6lKdl/rjuxTt6S+330jtYUhGpZqkkGlJcIfoe0jUgioU/DY00
   kSoeVynZxwak/ZYRxuQIlLiKreMyAud/2+UYfX4/F2/P2IjkP1RxX6rBp
   9Fd5DU1nAP/Y7Md1z343ovTo/1UGO6KASNNL6o4Jxvm7iXcMSbyrtBj37
   hO5zCu26A+BGc7ynTcv6jiIhDE+w2MHqJnJZ0E7MNSLaWEs/DmC6xp4HL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="232911588"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="232911588"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="492790835"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2022 09:35:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjvW-0007ZJ-5P; Mon, 28 Feb 2022 17:35:14 +0000
Date:   Tue, 1 Mar 2022 01:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 21/23] io_pagetable.c:undefined
 reference to `interval_tree_remove'
Message-ID: <202202281710.JhYsNhcb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   1b869a792f9bf8455c2a6cd1b29d79d50182dbd1
commit: e5b0b18da497e526cec5aad8c987ab9fd704adcd [21/23] vfio/pci: Add bind_iommufd() support
config: csky-randconfig-c024-20220227 (https://download.01.org/0day-ci/archive/20220228/202202281710.JhYsNhcb-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/e5b0b18da497e526cec5aad8c987ab9fd704adcd
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout e5b0b18da497e526cec5aad8c987ab9fd704adcd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_abort_area':
>> io_pagetable.c:(.text+0x72): undefined reference to `interval_tree_remove'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
>> io_pagetable.c:(.text+0x8a): undefined reference to `interval_tree_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
>> io_pagetable.c:(.text+0x12a): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   io_pagetable.c:(.text+0x1e0): undefined reference to `interval_tree_remove'
>> csky-linux-ld: io_pagetable.c:(.text+0x1ec): undefined reference to `interval_tree_iter_next'
>> csky-linux-ld: io_pagetable.c:(.text+0x21c): undefined reference to `interval_tree_iter_first'
>> csky-linux-ld: io_pagetable.c:(.text+0x242): undefined reference to `interval_tree_insert'
>> csky-linux-ld: io_pagetable.c:(.text+0x28a): undefined reference to `interval_tree_remove'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unfill_domain':
   io_pagetable.c:(.text+0x376): undefined reference to `interval_tree_remove'
   csky-linux-ld: io_pagetable.c:(.text+0x3a0): undefined reference to `interval_tree_insert'
   csky-linux-ld: io_pagetable.c:(.text+0x3b0): undefined reference to `interval_tree_remove'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
>> io_pagetable.c:(.text+0x470): undefined reference to `interval_tree_span_iter_first'
>> csky-linux-ld: io_pagetable.c:(.text+0x490): undefined reference to `interval_tree_span_iter_next'
>> csky-linux-ld: io_pagetable.c:(.text+0x49e): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: io_pagetable.c:(.text+0x4b6): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: io_pagetable.c:(.text+0x4f4): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: io_pagetable.c:(.text+0x4fc): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
>> io_pagetable.c:(.text+0x598): undefined reference to `interval_tree_insert'
   csky-linux-ld: io_pagetable.c:(.text+0x5be): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: io_pagetable.c:(.text+0x614): undefined reference to `interval_tree_insert'
   csky-linux-ld: io_pagetable.c:(.text+0x61c): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   io_pagetable.c:(.text+0xad0): undefined reference to `interval_tree_insert'
   csky-linux-ld: io_pagetable.c:(.text+0xb0c): undefined reference to `interval_tree_insert'
   csky-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   io_pagetable.c:(.text+0xb2c): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: io_pagetable.c:(.text+0xb42): undefined reference to `interval_tree_iter_next'
   csky-linux-ld: io_pagetable.c:(.text+0xb52): undefined reference to `interval_tree_remove'
   csky-linux-ld: io_pagetable.c:(.text+0xb64): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: io_pagetable.c:(.text+0xb68): undefined reference to `interval_tree_iter_next'
   csky-linux-ld: io_pagetable.c:(.text+0xb6c): undefined reference to `interval_tree_remove'
   csky-linux-ld: drivers/iommu/iommufd/ioas.o: in function `iommufd_ioas_iova_ranges':
>> ioas.c:(.text+0x278): undefined reference to `interval_tree_span_iter_first'
>> csky-linux-ld: ioas.c:(.text+0x314): undefined reference to `interval_tree_span_iter_next'
>> csky-linux-ld: ioas.c:(.text+0x36c): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: ioas.c:(.text+0x380): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_init':
>> pages.c:(.text+0x208): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `interval_tree_fully_covers':
>> pages.c:(.text+0x232): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `batch_from_domain':
   pages.c:(.text+0x2c4): undefined reference to `interval_tree_span_iter_first'
>> csky-linux-ld: pages.c:(.text+0x2c8): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   pages.c:(.text+0x2fe): undefined reference to `interval_tree_span_iter_first'
>> csky-linux-ld: pages.c:(.text+0x310): undefined reference to `interval_tree_span_iter_next'
>> csky-linux-ld: pages.c:(.text+0x320): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0x330): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `update_unpinned':
   pages.c:(.text+0x43c): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0x448): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_get_exact_user':
   pages.c:(.text+0x60a): undefined reference to `interval_tree_iter_first'
>> csky-linux-ld: pages.c:(.text+0x620): undefined reference to `interval_tree_iter_next'
   csky-linux-ld: pages.c:(.text+0x660): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: pages.c:(.text+0x664): undefined reference to `interval_tree_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   pages.c:(.text+0xa6a): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: pages.c:(.text+0xb28): undefined reference to `interval_tree_iter_first'
   csky-linux-ld: pages.c:(.text+0xb3a): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_partial_domain':
   pages.c:(.text+0xc44): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_unmap_domain':
   pages.c:(.text+0xe38): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0xe54): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   pages.c:(.text+0xfa2): undefined reference to `interval_tree_insert'
   csky-linux-ld: pages.c:(.text+0xfa8): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0xfb0): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: pages.c:(.text+0xfe8): undefined reference to `interval_tree_insert'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   pages.c:(.text+0x10e0): undefined reference to `interval_tree_remove'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   pages.c:(.text+0x1146): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0x1160): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: pages.c:(.text+0x1190): undefined reference to `interval_tree_remove'
   csky-linux-ld: pages.c:(.text+0x119c): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0x11a4): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: pages.c:(.text+0x11c0): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0x120c): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   pages.c:(.text+0x12ca): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0x130c): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: pages.c:(.text+0x1320): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: pages.c:(.text+0x1466): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: pages.c:(.text+0x14c4): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_add_user':
   pages.c:(.text+0x1562): undefined reference to `interval_tree_insert'
   csky-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_remove_user':
   pages.c:(.text+0x15b6): undefined reference to `interval_tree_remove'
   csky-linux-ld: pages.c:(.text+0x15f8): undefined reference to `interval_tree_insert'
   csky-linux-ld: pages.c:(.text+0x1600): undefined reference to `interval_tree_remove'
   csky-linux-ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   vfio_compat.c:(.text+0x5e): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: vfio_compat.c:(.text+0xb8): undefined reference to `interval_tree_span_iter_next'
   csky-linux-ld: vfio_compat.c:(.text+0x130): undefined reference to `interval_tree_span_iter_first'
   csky-linux-ld: vfio_compat.c:(.text+0x134): undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO_PCI_CORE && VFIO && PCI && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
