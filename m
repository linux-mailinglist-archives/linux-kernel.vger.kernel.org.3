Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9F4AFA38
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbiBISf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbiBISfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:35:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5780DC050CD4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644431740; x=1675967740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CKvUNdfXAEB+dCnPbYqpYsfnzitS80v+bnVwCtLUUQs=;
  b=esec6hj6SATQ/5nbGQwkvqsPZSp55GQrqkCekS7fROxSqW6280I48Sa2
   M1hg6wj0WSu1DrjG59pSUPLBKuoddRakjc+DGdMC0xlQg3WAL3fRnDy+Q
   yHqNeglw0if7oqaXD8eYO7reP/z9ZzezTnopV83nWhG3/OipnOOWhYc2a
   cupCWxPo5pBemJbftS5qje7fkRDHEfktxqcu7tYUuvfjzXjAUGRdpkKQl
   4mtOtEcV83kp8zrRCdilDIXos+xDLmZzayPJHLBqdJV4LWnkaNq1TAvfW
   e3eQiZBZjRMqh3P9TBiia40JFTPM4B2x5hfmbcTdPiGqBmfIhxnjicL79
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249056297"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249056297"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="568340321"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2022 10:25:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHreJ-0002AI-L8; Wed, 09 Feb 2022 18:25:03 +0000
Date:   Thu, 10 Feb 2022 02:24:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc1 22/28] undefined reference to
 `interval_tree_iter_first'
Message-ID: <202202100218.hAw3qxNg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc1
head:   ebf68af0385d0d5c209e63e8065d31db938275d8
commit: e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8 [22/28] vfio/pci: Add bind_iommufd() support
config: parisc-randconfig-r014-20220209 (https://download.01.org/0day-ci/archive/20220210/202202100218.hAw3qxNg-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc1
        git checkout e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
>> (.text+0xe8): undefined reference to `interval_tree_iter_first'
>> hppa-linux-ld: (.text+0x104): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `__iopt_unmap_iova':
>> (.text+0x1c4): undefined reference to `interval_tree_remove'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
>> (.text+0x394): undefined reference to `interval_tree_span_iter_first'
>> hppa-linux-ld: (.text+0x3c0): undefined reference to `interval_tree_span_iter_next'
>> hppa-linux-ld: (.text+0x40c): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x464): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_map_user_pages':
>> (.text+0x680): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_get_pages':
   (.text+0x6ec): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_copy_iova':
   (.text+0x8c8): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_iova':
   (.text+0x924): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unmap_all':
   (.text+0x9d4): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unaccess_pages':
   (.text+0xa8c): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0xaf0): undefined reference to `interval_tree_iter_first'
>> hppa-linux-ld: (.text+0xb1c): undefined reference to `interval_tree_iter_next'
>> hppa-linux-ld: (.text+0xb34): undefined reference to `interval_tree_remove'
   hppa-linux-ld: (.text+0xba0): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_access_pages':
   (.text+0xc90): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0xd10): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0xd3c): undefined reference to `interval_tree_iter_next'
>> hppa-linux-ld: (.text+0xdd8): undefined reference to `interval_tree_insert'
   hppa-linux-ld: (.text+0xe30): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   (.text+0xf54): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   (.text+0xfac): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0xfcc): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: (.text+0xfe4): undefined reference to `interval_tree_remove'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_table_add_domain':
   (.text+0x11dc): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x1234): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: (.text+0x124c): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x1284): undefined reference to `interval_tree_insert'
   hppa-linux-ld: (.text+0x12a0): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x12dc): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_table_enforce_group_iova':
   (.text+0x162c): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x1668): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/ioas_pt.o: in function `iommufd_ioas_pagetable_iova_ranges':
   (.text+0x24c): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x2dc): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   (.text+0x424): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x450): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x518): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: (.text+0x52c): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   (.text+0xc20): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0xd28): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `__iopt_area_unfill_domain':
   (.text+0xdc0): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0xdfc): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   (.text+0x104c): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x113c): undefined reference to `interval_tree_insert'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   (.text+0x12b0): undefined reference to `interval_tree_remove'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   (.text+0x1328): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x1364): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: (.text+0x13e4): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x147c): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: (.text+0x14bc): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x14dc): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   (.text+0x1708): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x171c): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x184c): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_unfill_domain':
   (.text+0x1918): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x193c): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x1984): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: (.text+0x19b8): undefined reference to `interval_tree_span_iter_next'
   hppa-linux-ld: (.text+0x19e0): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x1a08): undefined reference to `interval_tree_remove'
   hppa-linux-ld: (.text+0x1a38): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/pages.o: in function `iopt_fill_domain':
   (.text+0x1aac): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x1b68): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0x1c18): undefined reference to `interval_tree_iter_first'
   hppa-linux-ld: (.text+0x1c48): undefined reference to `interval_tree_insert'
   hppa-linux-ld: (.text+0x1c64): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: (.text+0x1c9c): undefined reference to `interval_tree_remove'
   hppa-linux-ld: (.text+0x1cd0): undefined reference to `interval_tree_iter_next'
   hppa-linux-ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   (.text+0x4c): undefined reference to `interval_tree_span_iter_first'
   hppa-linux-ld: (.text+0xe0): undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO_PCI_CORE && VFIO && PCI && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
