Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACA54DCDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiCQSkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiCQSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:40:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515891DF869
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647542327; x=1679078327;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bZv2kfeMA1oxhsy9LXjkW3SL4xzOfnb5Z53AlUSUlFc=;
  b=QNgYXiq9horP8wDXBkF2U3uPOmuE/HOW7JUCW3+mILlR79cNury3NynG
   jNYh/5ZUuLlYt+yrHxkF5Tz4DbjxIdpXCDdO9giZNrcSW1IQRSivww2yQ
   cKoyPDKZbQEOpF+h80JVe1DSVfgHYKDujdBSmxV5NXorsdl0YjlJTyK/M
   0OA/CUeIZg3e+7xoyzW8u1w7225AsrHwSVy6LE/ljLaQNhb1WbNo9MpkV
   CGXjZM496Pxjm8v53ZGgJJjn3STPJHrXh1SRpyxUr0Wj1o5ENvxBJBs+W
   jjmprZPTeMZ9gfKN/mvTigPo+3JGLNT6csJdfs1W97TMvlfqo05eD5YkJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281746896"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="281746896"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="558057420"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2022 11:38:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUv1I-000DvG-4M; Thu, 17 Mar 2022 18:38:44 +0000
Date:   Fri, 18 Mar 2022 02:37:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yi Liu <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc6 38/40] arm-linux-gnueabi-ld:
 io_pagetable.c:undefined reference to `interval_tree_insert'
Message-ID: <202203180234.AUFoT1cz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc6
head:   5ab19f95878da0c393e4b8c3f5b0bb51efb9f99a
commit: a7d1827d76767fe3e5366ef50efd50ebea0ed089 [38/40] vfio: Add iommufd VFIO compat support to group_fd
config: arm-randconfig-c002-20220317 (https://download.01.org/0day-ci/archive/20220318/202203180234.AUFoT1cz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/a7d1827d76767fe3e5366ef50efd50ebea0ed089
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc6
        git checkout a7d1827d76767fe3e5366ef50efd50ebea0ed089
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
   io_pagetable.c:(.text+0x1d0): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x208): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x264): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x314): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
   io_pagetable.c:(.text+0x754): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x80c): undefined reference to `interval_tree_iter_first'
>> arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x8a0): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `__iopt_unmap_iova.constprop.0':
   io_pagetable.c:(.text+0xb34): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unfill_domain':
   io_pagetable.c:(.text+0xe14): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0xeb4): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0xf3c): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x102c): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x10f8): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   io_pagetable.c:(.text+0x136c): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x1490): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x15a4): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x15bc): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x1638): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x16a0): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_map_pages':
   io_pagetable.c:(.text+0x1a8c): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_get_pages':
   io_pagetable.c:(.text+0x1d00): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_iova':
   io_pagetable.c:(.text+0x2008): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_all':
   io_pagetable.c:(.text+0x2224): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unaccess_pages':
   io_pagetable.c:(.text+0x2330): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x24b0): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_access_pages':
   io_pagetable.c:(.text+0x2660): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x2800): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   io_pagetable.c:(.text+0x2994): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x2a9c): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   io_pagetable.c:(.text+0x2ae8): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x2b04): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x2b5c): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_table_add_domain':
   io_pagetable.c:(.text+0x31d0): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: io_pagetable.c:(.text+0x328c): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/ioas.o: in function `iommufd_ioas_iova_ranges':
   ioas.c:(.text+0x7fc): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: ioas.c:(.text+0x9ec): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   pages.c:(.text+0xa38): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0xa80): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0xe74): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: pages.c:(.text+0xe90): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_get_exact_user':
   pages.c:(.text+0x1fe0): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x2050): undefined reference to `interval_tree_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   pages.c:(.text+0x396c): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x3e84): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `__iopt_area_unfill_domain':
   pages.c:(.text+0x4418): undefined reference to `interval_tree_iter_first'
>> arm-linux-gnueabi-ld: pages.c:(.text+0x4598): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_init':
   pages.c:(.text+0x4d78): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_unmap_domain':
   pages.c:(.text+0x5918): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x5974): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   pages.c:(.text+0x6244): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   pages.c:(.text+0x67ec): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   pages.c:(.text+0x6a3c): undefined reference to `interval_tree_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x6b10): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x6b40): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: pages.c:(.text+0x6c58): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x6d7c): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: pages.c:(.text+0x6e0c): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   pages.c:(.text+0x72f4): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: pages.c:(.text+0x7614): undefined reference to `interval_tree_span_iter_next'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_add_user':
   pages.c:(.text+0x7948): undefined reference to `interval_tree_insert'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_remove_user':
   pages.c:(.text+0x79ec): undefined reference to `interval_tree_remove'
   arm-linux-gnueabi-ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   vfio_compat.c:(.text+0x50c): undefined reference to `interval_tree_span_iter_first'
   arm-linux-gnueabi-ld: vfio_compat.c:(.text+0x63c): undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO && MMU && (X86 || S390 || ARM || ARM64)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
