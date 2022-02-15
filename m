Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581454B7800
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiBORnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:43:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbiBORnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:43:14 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518A8A302
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644946983; x=1676482983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8XtzYT/B74VNG4mzbC7Cmln/RJIa3ubEIcc5/b84Trw=;
  b=f53Ek8MuVWl2h2eDJcq/FmMi4d1BCrcTMjeQ8LL5gm/xXgTQQ4JNLzHr
   yOWNynxA+7jnDBJYr/waI+CkSdgDW/nh8LVIG+VE7eE42WyN8ULmCWy3c
   iM7JkOQhJ9ypAeKDLOznA4dg9M3U1pRYegeQoRWjhvheaRw6MpM5sOHDp
   BrolhUGivZDBl20waj6ebXqUEID6ClruxfYuXKCUh5Z6c6Go+Y3+nmCZY
   5T+B4N4gXdLw8YLpzh5KGwHemP8spobUhXzeAdobbeihlTZQVzRbw/hvF
   jz/UK+jjesFTxcgZQYzwoc0bs8WR0e5+Jqe7Wo4IzaBvyRIWmNEAlbxVN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311150747"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311150747"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 09:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486276323"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2022 09:43:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK1qv-0009tf-2T; Tue, 15 Feb 2022 17:43:01 +0000
Date:   Wed, 16 Feb 2022 01:42:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 28/56]
 drivers/iommu/iommufd/selftest.c:183:25: error: initialization of 'struct
 iommu_group * (*)(struct device *)' from incompatible pointer type
 'phys_addr_t (*)(struct iommu_domain *, dma_addr_t)' {aka 'unsigned int
 (*)(struct iommu_domain *, unsigned int)'}
Message-ID: <202202160138.nI8GEZY7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   94542ac92f6f23784d73c13b39dc95cc4012181c
commit: 047031aaa50c5daed9c24fa0701f7016d4ff6934 [28/56] iommufd: Add a selftest
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220216/202202160138.nI8GEZY7-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/047031aaa50c5daed9c24fa0701f7016d4ff6934
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 047031aaa50c5daed9c24fa0701f7016d4ff6934
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/iommufd/selftest.c: In function 'mock_domain_alloc':
   drivers/iommu/iommufd/selftest.c:69:26: error: assignment to 'const struct iommu_domain_ops *' from incompatible pointer type 'const struct iommu_ops *' [-Werror=incompatible-pointer-types]
      69 |         mock->domain.ops = &domain_mock_ops;
         |                          ^
   drivers/iommu/iommufd/selftest.c: At top level:
   drivers/iommu/iommufd/selftest.c:180:10: error: 'const struct iommu_ops' has no member named 'domain_free'
     180 |         .domain_free = mock_domain_free,
         |          ^~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:180:24: error: initialization of 'struct iommu_device * (*)(struct device *)' from incompatible pointer type 'void (*)(struct iommu_domain *)' [-Werror=incompatible-pointer-types]
     180 |         .domain_free = mock_domain_free,
         |                        ^~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:180:24: note: (near initialization for 'domain_mock_ops.probe_device')
   drivers/iommu/iommufd/selftest.c:181:10: error: 'const struct iommu_ops' has no member named 'map_pages'
     181 |         .map_pages = mock_domain_map_pages,
         |          ^~~~~~~~~
   drivers/iommu/iommufd/selftest.c:181:22: error: initialization of 'void (*)(struct device *)' from incompatible pointer type 'int (*)(struct iommu_domain *, long unsigned int,  phys_addr_t,  size_t,  size_t,  int,  gfp_t,  size_t *)' {aka 'int (*)(struct iommu_domain *, long unsigned int,  unsigned int,  unsigned int,  unsigned int,  int,  unsigned int,  unsigned int *)'} [-Werror=incompatible-pointer-types]
     181 |         .map_pages = mock_domain_map_pages,
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:181:22: note: (near initialization for 'domain_mock_ops.release_device')
   drivers/iommu/iommufd/selftest.c:182:10: error: 'const struct iommu_ops' has no member named 'unmap_pages'
     182 |         .unmap_pages = mock_domain_unmap_pages,
         |          ^~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:182:24: error: initialization of 'void (*)(struct device *)' from incompatible pointer type 'size_t (*)(struct iommu_domain *, long unsigned int,  size_t,  size_t,  struct iommu_iotlb_gather *)' {aka 'unsigned int (*)(struct iommu_domain *, long unsigned int,  unsigned int,  unsigned int,  struct iommu_iotlb_gather *)'} [-Werror=incompatible-pointer-types]
     182 |         .unmap_pages = mock_domain_unmap_pages,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:182:24: note: (near initialization for 'domain_mock_ops.probe_finalize')
   drivers/iommu/iommufd/selftest.c:183:10: error: 'const struct iommu_ops' has no member named 'iova_to_phys'
     183 |         .iova_to_phys = mock_domain_iova_to_phys,
         |          ^~~~~~~~~~~~
>> drivers/iommu/iommufd/selftest.c:183:25: error: initialization of 'struct iommu_group * (*)(struct device *)' from incompatible pointer type 'phys_addr_t (*)(struct iommu_domain *, dma_addr_t)' {aka 'unsigned int (*)(struct iommu_domain *, unsigned int)'} [-Werror=incompatible-pointer-types]
     183 |         .iova_to_phys = mock_domain_iova_to_phys,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:183:25: note: (near initialization for 'domain_mock_ops.device_group')
   drivers/iommu/iommufd/selftest.c: In function 'get_md_pagetable':
   drivers/iommu/iommufd/selftest.c:198:31: warning: comparison of distinct pointer types lacks a cast
     198 |         if (hwpt->domain->ops != &domain_mock_ops) {
         |                               ^~
   cc1: some warnings being treated as errors


vim +183 drivers/iommu/iommufd/selftest.c

   176	
   177	static const struct iommu_ops domain_mock_ops = {
   178		.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
   179		.domain_alloc = mock_domain_alloc,
   180		.domain_free = mock_domain_free,
   181		.map_pages = mock_domain_map_pages,
   182		.unmap_pages = mock_domain_unmap_pages,
 > 183		.iova_to_phys = mock_domain_iova_to_phys,
   184	};
   185	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
