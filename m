Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7974DD756
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiCRJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiCRJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:50:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE573158542
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647596924; x=1679132924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P6qKm/XoOJ843iRpes+5NJ/mGeJLRW3FgJs3mkfdA1I=;
  b=hEJXpzhyMBZ4x73FjGthJ94GZLqYd6St9s3+g4n15A4iYVVksWTbJWvJ
   WqBznkQoWfF0k82PXj5m3WhCG1dA914B0J8slmif4p6oybk10Traisgz2
   1d3nESsxrds7QSpYwAsFLCgKGIKSgj+PKTnrLDgPW3Ypvn+I530/u7emp
   1gkGcbVTqr/XfRdGc1FoCuwHz86vohMmJF+54NsGlp2g/LPSzK58bwmWo
   w8YJOqDIuRuAgLNdFHME6/A0z+DbbzN7+RSbAxJWmT84fAi8MfivkfgAc
   WiYi1Ez+MagcX/p9o2EzzwvjASahQmuwAZBcQUJilq9yRfD4/uAgD+YgS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254659238"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="254659238"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="715403991"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 02:48:42 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV9Dt-000Ed7-Lh; Fri, 18 Mar 2022 09:48:41 +0000
Date:   Fri, 18 Mar 2022 17:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yi Liu <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc6-wip 38/41] ld:
 drivers/iommu/iommufd/io_pagetable.c:179: undefined reference to
 `interval_tree_insert'
Message-ID: <202203181722.pkToeNJQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc6-wip
head:   d883a7e5a78fb9f4d6fc85a0845f95c6613aaade
commit: 0adb78eac32477a15dcee8f349d406b2f4b780bb [38/41] vfio: Add iommufd VFIO compat support to group_fd
config: x86_64-randconfig-a015-20211216 (https://download.01.org/0day-ci/archive/20220318/202203181722.pkToeNJQ-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/luxis1999/iommufd/commit/0adb78eac32477a15dcee8f349d406b2f4b780bb
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc6-wip
        git checkout 0adb78eac32477a15dcee8f349d406b2f4b780bb
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
   drivers/iommu/iommufd/io_pagetable.c:89: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.c:97: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.c:92: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.c:101: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_abort_area':
   drivers/iommu/iommufd/io_pagetable.c:192: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unfill_domain':
   drivers/iommu/iommufd/io_pagetable.c:635: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   drivers/iommu/iommufd/io_pagetable.c:678: undefined reference to `interval_tree_insert'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   drivers/iommu/iommufd/io_pagetable.c:697: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
   drivers/iommu/iommufd/io_pagetable.c:161: undefined reference to `interval_tree_iter_first'
>> ld: drivers/iommu/iommufd/io_pagetable.c:179: undefined reference to `interval_tree_insert'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   drivers/iommu/iommufd/io_pagetable.c:528: undefined reference to `interval_tree_insert'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
   drivers/iommu/iommufd/io_pagetable.c:537: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.c:543: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.c:546: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/ioas.o: in function `iommufd_ioas_iova_ranges':
   drivers/iommu/iommufd/ioas.c:93: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/ioas.c:96: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_init':
   drivers/iommu/iommufd/pages.c:689: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.o: in function `interval_tree_fully_covers':
   drivers/iommu/iommufd/pages.c:795: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_get_exact_user':
   drivers/iommu/iommufd/pages.c:1232: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/pages.c:1233: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unpin':
   drivers/iommu/iommufd/pages.c:574: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.c:577: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.c:581: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.c:585: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_find_domain_area':
   drivers/iommu/iommufd/pages.c:164: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   drivers/iommu/iommufd/pages.c:653: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_unmap_domain':
   drivers/iommu/iommufd/pages.c:870: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.c:873: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_fill_domains':
   drivers/iommu/iommufd/pages.c:988: undefined reference to `interval_tree_insert'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_area_unfill_domains':
   drivers/iommu/iommufd/pages.c:1046: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_unfill_xarray':
   drivers/iommu/iommufd/pages.c:1096: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.c:1099: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_clean_xarray':
   drivers/iommu/iommufd/pages.c:1065: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.c:1068: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_fill_xarray':
   drivers/iommu/iommufd/pages.c:1179: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.c:1182: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_add_user':
   drivers/iommu/iommufd/pages.c:1283: undefined reference to `interval_tree_insert'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_remove_user':
   drivers/iommu/iommufd/pages.c:1316: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/vfio_compat.o: in function `iommufd_fill_cap_iova':
   drivers/iommu/iommufd/vfio_compat.c:250: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/vfio_compat.c:253: undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO && MMU && (X86 || S390 || ARM || ARM64)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
