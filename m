Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973F84AFF6D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiBIVsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:48:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiBIVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:48:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDEDC03BFF4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644443294; x=1675979294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6YG/qzcHtXk1BaoygPXgccopBbnN9tAE0n8obSnZ3g4=;
  b=GuPTzI/bkzqf/BKdzChUStdzb0h5TxFG33bZ21+0UbACC1RXU0MfvICm
   hF8scGDcW79xu9pPuc+MSX9u5YZ3tODqndXBL+VpxvYKUiosQ8lN3Yq3u
   sUhQKZpbPkAfLR0RiDHyVDfNaeWjduSm6jTxS0BQ594yGmGks4IdBMXfa
   5m1Q6v6csl4EmoYEVffOZLfKaaK/fdsDVBbESSFaexSjZOTuBi7KxBQYO
   EHpZTf4uula2nP8am5IfM7zCaAm9dWX3lp9/GEWnchoJxhlNlr+YbYG1Q
   36nu0aKrZ6DBCOU1cMdF64HHwzciuUQ1Ji9/toYJIvzQ0y2+u+uJUrlo+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249294430"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249294430"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 13:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="526188082"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2022 13:48:11 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHuot-0002JG-7y; Wed, 09 Feb 2022 21:48:11 +0000
Date:   Thu, 10 Feb 2022 05:47:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc1 22/28] microblaze-linux-ld:
 undefined reference to `interval_tree_iter_next'
Message-ID: <202202100557.pXDp0sNZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc1
head:   ebf68af0385d0d5c209e63e8065d31db938275d8
commit: e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8 [22/28] vfio/pci: Add bind_iommufd() support
config: microblaze-randconfig-r002-20220209 (https://download.01.org/0day-ci/archive/20220210/202202100557.pXDp0sNZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc1
        git checkout e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_pages_get_exact_user':
   (.text+0x34): undefined reference to `interval_tree_iter_first'
>> microblaze-linux-ld: (.text+0x6c): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area.part.0':
   (.text+0x2a0): undefined reference to `interval_tree_iter_first'
>> microblaze-linux-ld: (.text+0x334): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `__iopt_unmap_iova':
   (.text+0x3d8): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
   (.text+0x890): undefined reference to `interval_tree_span_iter_first'
>> microblaze-linux-ld: (.text+0x8f4): undefined reference to `interval_tree_span_iter_first'
>> microblaze-linux-ld: (.text+0x998): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x9b0): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_map_user_pages':
   (.text+0xd04): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_get_pages':
   (.text+0xe74): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_copy_iova':
   (.text+0x1114): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_iova':
   (.text+0x1314): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_all':
   (.text+0x13e8): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unaccess_pages':
   (.text+0x14a0): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x152c): undefined reference to `interval_tree_iter_next'
>> microblaze-linux-ld: (.text+0x1644): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_access_pages':
   (.text+0x1820): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x1908): undefined reference to `interval_tree_iter_next'
>> microblaze-linux-ld: (.text+0x1a40): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   (.text+0x1bf0): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   (.text+0x1c60): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x1c84): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x1cdc): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_table_add_domain':
   (.text+0x207c): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x20d8): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x210c): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2180): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x21d0): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: (.text+0x22cc): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_table_enforce_group_iova':
   (.text+0x26f4): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2914): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/ioas_pt.o: in function `iommufd_ioas_pagetable_iova_ranges':
   (.text+0x3f4): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x4d8): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   (.text+0x3a4): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x3c8): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x428): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x544): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   (.text+0x13fc): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x14b0): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `__iopt_area_unfill_domain':
   (.text+0x16bc): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x16ec): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_init':
   (.text+0x19e4): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   (.text+0x1f68): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   (.text+0x2030): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   (.text+0x2110): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2164): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x2188): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x2254): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x227c): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: (.text+0x23c0): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   (.text+0x2740): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x27a8): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_unfill_domain':
   (.text+0x298c): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x29c0): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: (.text+0x29f8): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x2a64): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2a8c): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x2adc): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x2afc): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x2b2c): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_fill_domain':
   (.text+0x2c18): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2c60): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x2cbc): undefined reference to `interval_tree_insert'
   microblaze-linux-ld: (.text+0x2d6c): undefined reference to `interval_tree_iter_first'
   microblaze-linux-ld: (.text+0x2db8): undefined reference to `interval_tree_iter_next'
   microblaze-linux-ld: (.text+0x2df8): undefined reference to `interval_tree_remove'
   microblaze-linux-ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   (.text+0x26c): undefined reference to `interval_tree_span_iter_first'
   microblaze-linux-ld: (.text+0x364): undefined reference to `interval_tree_span_iter_next'
   microblaze-linux-ld: net/core/sock.o: in function `sk_destruct':
   (.text+0x3fec): undefined reference to `__sk_defer_free_flush'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO_PCI_CORE && VFIO && PCI && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
