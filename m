Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE54D7098
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiCLTpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiCLTps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:45:48 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B651F0394
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647114281; x=1678650281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XBua/1eo/f3daZUMkMS4mo0OXd8LQY4SMFLpIQRIdqo=;
  b=kqRBLi2AFeGpsnGBPpd0DKOS5QKuJe4VLw2DzWbgw2axOTm93BbDURZK
   HbjhOPkvHkOF/IBSGUigvv+aep/q0YI801l4MOuDp0XA9qQA4waFvOHK3
   ADm4mfqImqW2VFVltM/4K7nHqMEE+P7r6zAVCQ2n9ZwLNusupeKqNMqdC
   x+hz3n0rqDEAOcI9KZ6PZFyz8NM79UChiM8Dt41eikgiwkwVGmUhUDG8R
   tCtxXQQlTrX4z1WdPYN1Xa8OmuKXDvmED6Lw2EltLSutqPl96zIBfrHr3
   6Nva9hbY6f7y4N7eByW9cI/jmkJwJI0O8Y+exvBhFDtWcKcfVVfwUpEP2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="316539380"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="316539380"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 11:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="713252573"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2022 11:44:39 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT7fL-0008Db-3h; Sat, 12 Mar 2022 19:44:39 +0000
Date:   Sun, 13 Mar 2022 03:44:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 26/31] s390-linux-ld:
 io_pagetable.c:undefined reference to `interval_tree_iter_next'
Message-ID: <202203130324.5oNV9zWb-lkp@intel.com>
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

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   d0e769d6ae11d7abe38d2f0598926ba499bf3ec1
commit: a117b0048812d24e105878f9608b04d84da8361b [26/31] vfio: Select iommufd
config: s390-randconfig-m031-20220313 (https://download.01.org/0day-ci/archive/20220313/202203130324.5oNV9zWb-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/a117b0048812d24e105878f9608b04d84da8361b
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout a117b0048812d24e105878f9608b04d84da8361b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
   clk-lan966x.c:(.text+0x53c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: clk-lan966x.c:(.text+0x734): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_abort_area':
   io_pagetable.c:(.text+0x150): undefined reference to `interval_tree_remove'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_find_exact_area':
   io_pagetable.c:(.text+0x44e): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unfill_domain':
   io_pagetable.c:(.text+0x672): undefined reference to `interval_tree_iter_first'
>> s390-linux-ld: io_pagetable.c:(.text+0x76c): undefined reference to `interval_tree_iter_next'
>> s390-linux-ld: io_pagetable.c:(.text+0x82c): undefined reference to `interval_tree_iter_first'
>> s390-linux-ld: io_pagetable.c:(.text+0x8d2): undefined reference to `interval_tree_remove'
   s390-linux-ld: io_pagetable.c:(.text+0x936): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   io_pagetable.c:(.text+0xa8e): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0xbbe): undefined reference to `interval_tree_iter_first'
>> s390-linux-ld: io_pagetable.c:(.text+0xc40): undefined reference to `interval_tree_insert'
   s390-linux-ld: io_pagetable.c:(.text+0xc7c): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: io_pagetable.c:(.text+0xd4a): undefined reference to `interval_tree_remove'
   s390-linux-ld: io_pagetable.c:(.text+0xdae): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
   io_pagetable.c:(.text+0x1028): undefined reference to `interval_tree_span_iter_first'
>> s390-linux-ld: io_pagetable.c:(.text+0x10ce): undefined reference to `interval_tree_span_iter_first'
>> s390-linux-ld: io_pagetable.c:(.text+0x1120): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: io_pagetable.c:(.text+0x117e): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
   io_pagetable.c:(.text+0x13c0): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0x1454): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0x14d6): undefined reference to `interval_tree_insert'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_all':
   io_pagetable.c:(.text+0x1f5e): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unaccess_pages':
   io_pagetable.c:(.text+0x20e6): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0x21bc): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_access_pages':
   io_pagetable.c:(.text+0x2396): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0x2506): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   io_pagetable.c:(.text+0x2714): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0x27be): undefined reference to `interval_tree_insert'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   io_pagetable.c:(.text+0x283e): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0x286a): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: io_pagetable.c:(.text+0x28aa): undefined reference to `interval_tree_remove'
   s390-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_table_add_domain':
   io_pagetable.c:(.text+0x2c7c): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: io_pagetable.c:(.text+0x2d50): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/ioas.o: in function `iommufd_ioas_iova_ranges':
   ioas.c:(.text+0x48c): undefined reference to `interval_tree_span_iter_first'
>> s390-linux-ld: ioas.c:(.text+0x69e): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_init':
   pages.c:(.text+0x574): undefined reference to `interval_tree_span_iter_first'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `interval_tree_fully_covers':
   pages.c:(.text+0x970): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   pages.c:(.text+0xc06): undefined reference to `interval_tree_span_iter_first'
>> s390-linux-ld: pages.c:(.text+0xc88): undefined reference to `interval_tree_span_iter_first'
>> s390-linux-ld: pages.c:(.text+0xe32): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: pages.c:(.text+0xe4a): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_get_exact_user':
   pages.c:(.text+0x17be): undefined reference to `interval_tree_iter_first'
>> s390-linux-ld: pages.c:(.text+0x182a): undefined reference to `interval_tree_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_fill_span':
   pages.c:(.text+0x2998): undefined reference to `interval_tree_iter_first'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
>> pages.c:(.text+0x2cae): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_unmap_domain':
   pages.c:(.text+0x33bc): undefined reference to `interval_tree_span_iter_first'
   s390-linux-ld: pages.c:(.text+0x3436): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   pages.c:(.text+0x3998): undefined reference to `interval_tree_insert'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   pages.c:(.text+0x3cf6): undefined reference to `interval_tree_remove'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   pages.c:(.text+0x3e80): undefined reference to `interval_tree_span_iter_first'
   s390-linux-ld: pages.c:(.text+0x3f18): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: pages.c:(.text+0x3f7a): undefined reference to `interval_tree_span_iter_first'
   s390-linux-ld: pages.c:(.text+0x40aa): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   pages.c:(.text+0x4746): undefined reference to `interval_tree_span_iter_first'
   s390-linux-ld: pages.c:(.text+0x49dc): undefined reference to `interval_tree_span_iter_next'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_add_user':
   pages.c:(.text+0x4d54): undefined reference to `interval_tree_insert'
   s390-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_remove_user':
   pages.c:(.text+0x4ec0): undefined reference to `interval_tree_remove'
   s390-linux-ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   vfio_compat.c:(.text+0x412): undefined reference to `interval_tree_span_iter_first'
>> s390-linux-ld: vfio_compat.c:(.text+0x556): undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO && MMU && (X86 || S390 || ARM || ARM64)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
