Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD84B52FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355024AbiBNORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:17:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiBNORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:17:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDECFA187
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644848230; x=1676384230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3sFlm92IDjvtUnk1YcNHebLidnZh8FzoTXE56MfSJNo=;
  b=lGcs2R3DYr5f4SnAaXIO7eF8qhaDUSbSVMfuuI4e/NDtnnBsALfhwaia
   VYURt59DLWonnwxjLPwnOaDxBPS7GyzBEiOQCbz6LhGgdJeoC6kkbEg9R
   FBiFFTyFJld+BWkKi2E3f1PXs+Rf0yDlE+CRUS0NnbBqwUkHt3JSxtqGt
   FYk/+Kmv4eq9/00IOQ9X+DY6BIq6G0nHUWKrp0FkxMAhmNxWuoUEka/y2
   Pbz0w3FeTRZOlWEUhSC0PJ/mEDltVWQNeLt7TWBNnPi7M9KYrtO33V7zt
   TgP7FnpIkwb+zw/nnNL+K4/xVLkUyZDfsXDmVTDe/B2CiXV/l3VlAsh6D
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249846128"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249846128"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="773064971"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2022 06:17:08 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJcA8-0008dn-2Z; Mon, 14 Feb 2022 14:17:08 +0000
Date:   Mon, 14 Feb 2022 22:16:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 23/31]
 drivers/iommu/iommufd/io_pagetable.c:488:6: error: comparison of distinct
 pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length
 - 1) *' (aka 'unsigned int *'))
Message-ID: <202202142244.2jylcKcV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   6b5b3f20ed6b64824c2d447b4f4555fcb390bf3b
commit: 01c5309803286f2c29a6f40bca7f489fce968c42 [23/31] iommufd: Data structure to provide IOVA to PFN mapping
config: i386-randconfig-a004-20220214 (https://download.01.org/0day-ci/archive/20220214/202202142244.2jylcKcV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/01c5309803286f2c29a6f40bca7f489fce968c42
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 01c5309803286f2c29a6f40bca7f489fce968c42
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/iommufd/io_pagetable.c:488:6: error: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Werror,-Wcompare-distinct-pointer-types]
           if (check_add_overflow(iova, length - 1, &last_iova))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   drivers/iommu/iommufd/io_pagetable.c:548:14: error: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Werror,-Wcompare-distinct-pointer-types]
               WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   2 errors generated.


vim +488 drivers/iommu/iommufd/io_pagetable.c

   462	
   463	/**
   464	* iopt_access_pages - Return a list of pages under the iova
   465	*
   466	* Reads @npages starting at iova and returns the struct page * pointers. These
   467	* can be kmap'd by the caller for CPU access.
   468	*
   469	* The caller must perform iopt_unaccess_pages() when done to balance this.
   470	*
   471	* iova can be unaligned from PAGE_SIZE. The first returned byte starts at
   472	* page_to_phys(out_pages[0]) + (iova % PAGE_SIZE). The caller promises not
   473	* to touch memory outside the requested iova slice.
   474	*
   475	* FIXME: callers that need a DMA mapping via a sgl should create another
   476	* interface to build the SGL efficiently
   477	*/
   478	int iopt_access_pages(struct io_pagetable *iopt, unsigned long iova,
   479			      size_t length, struct page **out_pages, bool write)
   480	{
   481		unsigned long cur_iova = iova;
   482		unsigned long last_iova;
   483		struct iopt_area *area;
   484		int rc;
   485	
   486		if (!length)
   487			return -EINVAL;
 > 488		if (check_add_overflow(iova, length - 1, &last_iova))
   489			return -EOVERFLOW;
   490	
   491		down_read(&iopt->rwsem);
   492		for (area = iopt_area_iter_first(iopt, iova, last_iova); area;
   493		     area = iopt_area_iter_next(area, iova, last_iova)) {
   494			unsigned long last = min(last_iova, iopt_area_last_iova(area));
   495			unsigned long last_index;
   496			unsigned long index;
   497	
   498			/* Need contiguous areas in the access */
   499			if (iopt_area_iova(area) < cur_iova) {
   500				rc = -EINVAL;
   501				goto out_remove;
   502			}
   503	
   504			index = iopt_iova_to_index(area, cur_iova);
   505			last_index = iopt_iova_to_index(area, last);
   506			rc = iopt_pages_add_user(area->pages, index, last_index,
   507						 out_pages, write);
   508			if (rc)
   509				goto out_remove;
   510			if (last == last_iova)
   511				break;
   512			/*
   513			 * Can't cross areas that are not aligned to the system page
   514			 * size with this API.
   515			 */
   516			if (cur_iova % PAGE_SIZE) {
   517				rc = -EINVAL;
   518				goto out_remove;
   519			}
   520			cur_iova = last + 1;
   521			out_pages += last_index - index;
   522			atomic_inc(&area->num_users);
   523		}
   524	
   525		up_read(&iopt->rwsem);
   526		return 0;
   527	
   528	out_remove:
   529		if (cur_iova != iova)
   530			iopt_unaccess_pages(iopt, iova, cur_iova - iova);
   531		return rc;
   532	}
   533	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
