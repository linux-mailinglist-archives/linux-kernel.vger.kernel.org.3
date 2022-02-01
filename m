Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B644A5891
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiBAIee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:34:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:8479 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235533AbiBAIea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643704470; x=1675240470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EF3Yqvdh6j2b4Wm1XImKI+jJN5u1BtKAxq6OZbs+ktY=;
  b=TcWBh/ug3lCoK8iRIEYJeRH8nYQ/Znaa9Sc14SuYJa6rzWHXnEVOMfr2
   p+ZmiIlMw/sQ5/zvnA7wmPrKM8HWzixBjuiUYbvGmPn/iES1xYvrJaAJa
   dOaVrstkjr0fn7edmt6P3T5iQGck/zGadW2PZN1ORo8kLXtVToz5bFAd/
   FSYBqBXJDaE6KG2E6IvjPYnsj6Hnjb8ZCzfk6BWpyiyfHoX8jb0y11WLU
   Xhu7NRpkBlKeY/rVvOwItMLIJwHWAl1non3i7uEy1bEcZPTPO14cmj14i
   KsoxJi1MQovqS4JWMo0Zn3MZ1pG/eO4+wUVcNbksenk7halR3AlXer3l/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246478262"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="246478262"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 00:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="537716068"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2022 00:34:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEocN-000T1X-IZ; Tue, 01 Feb 2022 08:34:27 +0000
Date:   Tue, 1 Feb 2022 16:33:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 23/29]
 drivers/iommu/iommufd/io_pagetable.c:488:6: warning: comparison of distinct
 pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length
 - 1) *' (aka 'unsigned int *'))
Message-ID: <202202011657.SZg7SZfW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   086f3f78da96ed1f11c2ac71115bb46e940e141e
commit: b944c7f08293cd7b049be615e67622f5d0d74cfb [23/29] iommufd: Data structure to provide IOVA to PFN mapping
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220201/202202011657.SZg7SZfW-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/b944c7f08293cd7b049be615e67622f5d0d74cfb
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout b944c7f08293cd7b049be615e67622f5d0d74cfb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/io_pagetable.c:488:6: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           if (check_add_overflow(iova, length - 1, &last_iova))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   drivers/iommu/iommufd/io_pagetable.c:548:14: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
               WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   2 warnings generated.


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
