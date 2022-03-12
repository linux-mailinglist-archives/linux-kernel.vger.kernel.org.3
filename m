Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2254D70F4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiCLVHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiCLVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:07:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2D89728D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647119203; x=1678655203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1QXwCOzHZpW8NZwWdJoXOyjrDiYdpRlnfaO2sNbNef4=;
  b=SPzvTdC44JyzRgDJ9lOb11KdE31fGDHWBynE8BwUsn5uSBJFgFCo7i8D
   BXu4Nx7n/GopA7SiVEKBWiurKsN1yU+STdJtwZTrmeIqT8OGt00O8O0rm
   iVLSVW8FmVDabNABqmFYXJd69pUojD3DNFcvFltA3CiOKJFvYVEQxKZw5
   kM3gtsVftxHQ4+Nt3lQmwQrq3EXUfd4wrh972dga1QkLGYvg85IS3wnpk
   6dq66oyb42+KaJM11yaLyEKshPDSzgE8/67tsk0IGtRJyDWTurFZ0Iwuz
   YAidaQPBmfzg8Xs5bSSKGR3VXAyXfrXvMMvDpzCM3Etz4Fl/8MK9fpX/b
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="255771474"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="255771474"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 13:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="713263683"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2022 13:06:41 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT8wi-0008HH-MN; Sat, 12 Mar 2022 21:06:40 +0000
Date:   Sun, 13 Mar 2022 05:05:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 26/31]
 drivers/iommu/iommufd/io_pagetable.c:192: undefined reference to
 `interval_tree_remove'
Message-ID: <202203130550.B8DSnbi0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   d0e769d6ae11d7abe38d2f0598926ba499bf3ec1
commit: a117b0048812d24e105878f9608b04d84da8361b [26/31] vfio: Select iommufd
config: i386-randconfig-a016 (https://download.01.org/0day-ci/archive/20220313/202203130550.B8DSnbi0-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/luxis1999/iommufd/commit/a117b0048812d24e105878f9608b04d84da8361b
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout a117b0048812d24e105878f9608b04d84da8361b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_abort_area':
>> drivers/iommu/iommufd/io_pagetable.c:192: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
>> drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
>> drivers/iommu/iommufd/io_pagetable.c:89: undefined reference to `interval_tree_span_iter_first'
>> ld: drivers/iommu/iommufd/io_pagetable.c:97: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_area':
>> drivers/iommu/iommufd/io_pagetable.c:179: undefined reference to `interval_tree_insert'
>> ld: drivers/iommu/iommufd/io_pagetable.c:161: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_alloc_iova':
>> drivers/iommu/iommufd/io_pagetable.c:101: undefined reference to `interval_tree_span_iter_next'
>> ld: drivers/iommu/iommufd/io_pagetable.c:92: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
>> drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
>> ld: drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
>> ld: drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
>> drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
>> drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
>> drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
>> drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_reserve_iova':
   drivers/iommu/iommufd/io_pagetable.c:528: undefined reference to `interval_tree_insert'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_remove_reserved_iova':
>> drivers/iommu/iommufd/io_pagetable.c:537: undefined reference to `interval_tree_iter_first'
>> ld: drivers/iommu/iommufd/io_pagetable.c:543: undefined reference to `interval_tree_iter_next'
>> ld: drivers/iommu/iommufd/io_pagetable.c:546: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
>> drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
>> drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   drivers/iommu/iommufd/io_pagetable.c:678: undefined reference to `interval_tree_insert'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_fill_domain':
   drivers/iommu/iommufd/io_pagetable.c:697: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_first':
   drivers/iommu/iommufd/io_pagetable.h:91: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_unfill_domain':
   drivers/iommu/iommufd/io_pagetable.c:635: undefined reference to `interval_tree_remove'
   ld: drivers/iommu/iommufd/io_pagetable.o: in function `iopt_area_iter_next':
   drivers/iommu/iommufd/io_pagetable.h:103: undefined reference to `interval_tree_iter_next'
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
   ld: drivers/iommu/iommufd/pages.c:577: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_pages_find_domain_area':
   drivers/iommu/iommufd/pages.c:164: undefined reference to `interval_tree_iter_first'
   ld: drivers/iommu/iommufd/pages.o: in function `pfn_reader_next':
   drivers/iommu/iommufd/pages.c:653: undefined reference to `interval_tree_span_iter_next'
   ld: drivers/iommu/iommufd/pages.o: in function `iopt_unmap_domain':
   drivers/iommu/iommufd/pages.c:870: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/pages.c:873: undefined reference to `interval_tree_span_iter_next'
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
   drivers/iommu/iommufd/vfio_compat.c:249: undefined reference to `interval_tree_span_iter_first'
   ld: drivers/iommu/iommufd/vfio_compat.c:252: undefined reference to `interval_tree_span_iter_next'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO && MMU && (X86 || S390 || ARM || ARM64)


vim +192 drivers/iommu/iommufd/io_pagetable.c

7faa632a737a8f4 Jason Gunthorpe 2021-11-11   57  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   58  /*
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   59   * Automatically find a block of IOVA that is not being used and not reserved.
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   60   * Does not return a 0 IOVA even if it is valid.
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   61   */
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   62  static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   63  			   unsigned long uptr, unsigned long length)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   64  {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   65  	struct interval_tree_span_iter reserved_span;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   66  	unsigned long page_offset = uptr % PAGE_SIZE;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   67  	struct interval_tree_span_iter area_span;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   68  	unsigned long iova_alignment;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   69  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   70  	lockdep_assert_held(&iopt->iova_rwsem);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   71  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   72  	/* Protect roundup_pow-of_two() from overflow */
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   73  	if (length == 0 || length >= ULONG_MAX / 2)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   74  		return -EINVAL;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   75  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   76  	/*
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   77  	 * Keep alignment present in the uptr when building the IOVA, this
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   78  	 * increases the chance we can map a THP.
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   79  	 */
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   80  	if (!uptr)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   81  		iova_alignment = roundup_pow_of_two(length);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   82  	else
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   83  		iova_alignment =
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   84  			min_t(unsigned long, roundup_pow_of_two(length),
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   85  			      1UL << __ffs64(uptr));
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   86  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   87  	if (iova_alignment < iopt->iova_alignment)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   88  		return -EINVAL;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  @89  	for (interval_tree_span_iter_first(&area_span, &iopt->area_itree,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   90  					   PAGE_SIZE, ULONG_MAX - PAGE_SIZE);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   91  	     !interval_tree_span_iter_done(&area_span);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  @92  	     interval_tree_span_iter_next(&area_span)) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   93  		if (!__alloc_iova_check_hole(&area_span, length, iova_alignment,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   94  					     page_offset))
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   95  			continue;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   96  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  @97  		for (interval_tree_span_iter_first(
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   98  			     &reserved_span, &iopt->reserved_iova_itree,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11   99  			     area_span.start_hole, area_span.last_hole);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  100  		     !interval_tree_span_iter_done(&reserved_span);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11 @101  		     interval_tree_span_iter_next(&reserved_span)) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  102  			if (!__alloc_iova_check_hole(&reserved_span, length,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  103  						     iova_alignment,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  104  						     page_offset))
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  105  				continue;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  106  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  107  			*iova = reserved_span.start_hole;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  108  			return 0;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  109  		}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  110  	}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  111  	return -ENOSPC;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  112  }
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  113  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  114  /*
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  115   * The area takes a slice of the pages from start_bytes to start_byte + length
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  116   */
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  117  static struct iopt_area *
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  118  iopt_alloc_area(struct io_pagetable *iopt, struct iopt_pages *pages,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  119  		unsigned long iova, unsigned long start_byte,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  120  		unsigned long length, int iommu_prot, unsigned int flags)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  121  {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  122  	struct iopt_area *area;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  123  	int rc;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  124  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  125  	area = kzalloc(sizeof(*area), GFP_KERNEL);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  126  	if (!area)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  127  		return ERR_PTR(-ENOMEM);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  128  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  129  	area->iopt = iopt;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  130  	area->iommu_prot = iommu_prot;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  131  	area->page_offset = start_byte % PAGE_SIZE;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  132  	area->pages_node.start = start_byte / PAGE_SIZE;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  133  	if (check_add_overflow(start_byte, length - 1, &area->pages_node.last))
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  134  		return ERR_PTR(-EINVAL);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  135  	area->pages_node.last = area->pages_node.last / PAGE_SIZE;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  136  	if (WARN_ON(area->pages_node.last >= pages->npages))
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  137  		return ERR_PTR(-EINVAL);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  138  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  139  	down_write(&iopt->iova_rwsem);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  140  	if (flags & IOPT_ALLOC_IOVA) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  141  		rc = iopt_alloc_iova(iopt, &iova,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  142  				     (uintptr_t)pages->uptr + start_byte,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  143  				     length);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  144  		if (rc)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  145  			goto out_unlock;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  146  	}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  147  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  148  	if (check_add_overflow(iova, length - 1, &area->node.last)) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  149  		rc = -EOVERFLOW;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  150  		goto out_unlock;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  151  	}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  152  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  153  	if (!(flags & IOPT_ALLOC_IOVA)) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  154  		if ((iova & (iopt->iova_alignment - 1)) ||
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  155  		    (length & (iopt->iova_alignment - 1)) || !length) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  156  			rc = -EINVAL;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  157  			goto out_unlock;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  158  		}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  159  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  160  		/* No reserved IOVA intersects the range */
7faa632a737a8f4 Jason Gunthorpe 2021-11-11 @161  		if (interval_tree_iter_first(&iopt->reserved_iova_itree, iova,
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  162  					     area->node.last)) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  163  			rc = -ENOENT;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  164  			goto out_unlock;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  165  		}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  166  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  167  		/* Check that there is not already a mapping in the range */
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  168  		if (iopt_area_iter_first(iopt, iova, area->node.last)) {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  169  			rc = -EADDRINUSE;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  170  			goto out_unlock;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  171  		}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  172  	}
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  173  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  174  	/*
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  175  	 * The area is inserted with a NULL pages indicating it is not fully
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  176  	 * initialized yet.
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  177  	 */
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  178  	area->node.start = iova;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11 @179  	interval_tree_insert(&area->node, &area->iopt->area_itree);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  180  	up_write(&iopt->iova_rwsem);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  181  	return area;
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  182  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  183  out_unlock:
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  184  	up_write(&iopt->iova_rwsem);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  185  	kfree(area);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  186  	return ERR_PTR(rc);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  187  }
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  188  
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  189  static void iopt_abort_area(struct iopt_area *area)
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  190  {
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  191  	down_write(&area->iopt->iova_rwsem);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11 @192  	interval_tree_remove(&area->node, &area->iopt->area_itree);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  193  	up_write(&area->iopt->iova_rwsem);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  194  	kfree(area);
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  195  }
7faa632a737a8f4 Jason Gunthorpe 2021-11-11  196  

:::::: The code at line 192 was first introduced by commit
:::::: 7faa632a737a8f47a479eed52aca8fc54bbc7003 iommufd: Data structure to provide IOVA to PFN mapping

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
