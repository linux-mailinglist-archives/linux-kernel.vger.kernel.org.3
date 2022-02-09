Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01EC4AF740
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiBIQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiBIQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:52:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7937CC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644425578; x=1675961578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MjJkRz5HakU5w6W6+8JbqvXVC2rSCW4kxLByoHF0Rdo=;
  b=KL9VEc9tUcG7zWAHcU1uEviFFWu7PB9uXJ6Zsh1FzL6xaNMpEh+8uG5T
   b86f+R5cAI4BsNYSioCZCSw0cp1amlUV7S5HifDnpqELiVLoMp8X3FIIj
   RbnA14iJM16Tp1R5MVtmyIYrJbNqXDZPLNo8tBGQoURSTpIGjxLOSM0rd
   160RQZ1BHyh2LCUjxHA8qqCwqDLssfhxipcdKaXzZjrKlm3rUZnYijF3O
   Uk612XgcUgafJaTHJgCMCFyOsxUXugdlN6vFcEuvSRjQL+P963jjHkN48
   EAGlZ+3khpkHHBCbHdy9OOwBc8cL62LbZNTxYHJKxIk2tomJog7gNsBWz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249008254"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249008254"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701313860"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2022 08:52:57 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHqDA-00024K-BQ; Wed, 09 Feb 2022 16:52:56 +0000
Date:   Thu, 10 Feb 2022 00:52:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc1 22/28]
 drivers/iommu/iommufd/io_pagetable.c:488:13: sparse: sparse: incompatible
 types in comparison expression (different type sizes):
Message-ID: <202202100006.o4WZWkXH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc1
head:   ebf68af0385d0d5c209e63e8065d31db938275d8
commit: e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8 [22/28] vfio/pci: Add bind_iommufd() support
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220210/202202100006.o4WZWkXH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/luxis1999/iommufd/commit/e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc1
        git checkout e8571fda9f22c4c339a8c908ba5db3dc78bd3fc8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/iommufd/io_pagetable.c:488:13: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> drivers/iommu/iommufd/io_pagetable.c:488:13: sparse:    unsigned long *
>> drivers/iommu/iommufd/io_pagetable.c:488:13: sparse:    unsigned int *
   drivers/iommu/iommufd/io_pagetable.c:548:13: sparse: sparse: incompatible types in comparison expression (different type sizes):
   drivers/iommu/iommufd/io_pagetable.c:548:13: sparse:    unsigned long *
   drivers/iommu/iommufd/io_pagetable.c:548:13: sparse:    unsigned int *
--
>> drivers/iommu/iommufd/vfio_compat.c:240:17: sparse: sparse: cast removes address space '__user' of expression
>> drivers/iommu/iommufd/vfio_compat.c:240:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct vfio_iommu_type1_info_cap_iova_range [noderef] __user *ucap_iovas @@     got struct vfio_iommu_type1_info_cap_iova_range * @@
   drivers/iommu/iommufd/vfio_compat.c:240:17: sparse:     expected struct vfio_iommu_type1_info_cap_iova_range [noderef] __user *ucap_iovas
   drivers/iommu/iommufd/vfio_compat.c:240:17: sparse:     got struct vfio_iommu_type1_info_cap_iova_range *

vim +488 drivers/iommu/iommufd/io_pagetable.c

01c5309803286f Jason Gunthorpe 2021-11-11  462  
01c5309803286f Jason Gunthorpe 2021-11-11  463  /**
01c5309803286f Jason Gunthorpe 2021-11-11  464  * iopt_access_pages - Return a list of pages under the iova
01c5309803286f Jason Gunthorpe 2021-11-11  465  *
01c5309803286f Jason Gunthorpe 2021-11-11  466  * Reads @npages starting at iova and returns the struct page * pointers. These
01c5309803286f Jason Gunthorpe 2021-11-11  467  * can be kmap'd by the caller for CPU access.
01c5309803286f Jason Gunthorpe 2021-11-11  468  *
01c5309803286f Jason Gunthorpe 2021-11-11  469  * The caller must perform iopt_unaccess_pages() when done to balance this.
01c5309803286f Jason Gunthorpe 2021-11-11  470  *
01c5309803286f Jason Gunthorpe 2021-11-11  471  * iova can be unaligned from PAGE_SIZE. The first returned byte starts at
01c5309803286f Jason Gunthorpe 2021-11-11  472  * page_to_phys(out_pages[0]) + (iova % PAGE_SIZE). The caller promises not
01c5309803286f Jason Gunthorpe 2021-11-11  473  * to touch memory outside the requested iova slice.
01c5309803286f Jason Gunthorpe 2021-11-11  474  *
01c5309803286f Jason Gunthorpe 2021-11-11  475  * FIXME: callers that need a DMA mapping via a sgl should create another
01c5309803286f Jason Gunthorpe 2021-11-11  476  * interface to build the SGL efficiently
01c5309803286f Jason Gunthorpe 2021-11-11  477  */
01c5309803286f Jason Gunthorpe 2021-11-11  478  int iopt_access_pages(struct io_pagetable *iopt, unsigned long iova,
01c5309803286f Jason Gunthorpe 2021-11-11  479  		      size_t length, struct page **out_pages, bool write)
01c5309803286f Jason Gunthorpe 2021-11-11  480  {
01c5309803286f Jason Gunthorpe 2021-11-11  481  	unsigned long cur_iova = iova;
01c5309803286f Jason Gunthorpe 2021-11-11  482  	unsigned long last_iova;
01c5309803286f Jason Gunthorpe 2021-11-11  483  	struct iopt_area *area;
01c5309803286f Jason Gunthorpe 2021-11-11  484  	int rc;
01c5309803286f Jason Gunthorpe 2021-11-11  485  
01c5309803286f Jason Gunthorpe 2021-11-11  486  	if (!length)
01c5309803286f Jason Gunthorpe 2021-11-11  487  		return -EINVAL;
01c5309803286f Jason Gunthorpe 2021-11-11 @488  	if (check_add_overflow(iova, length - 1, &last_iova))
01c5309803286f Jason Gunthorpe 2021-11-11  489  		return -EOVERFLOW;
01c5309803286f Jason Gunthorpe 2021-11-11  490  
01c5309803286f Jason Gunthorpe 2021-11-11  491  	down_read(&iopt->rwsem);
01c5309803286f Jason Gunthorpe 2021-11-11  492  	for (area = iopt_area_iter_first(iopt, iova, last_iova); area;
01c5309803286f Jason Gunthorpe 2021-11-11  493  	     area = iopt_area_iter_next(area, iova, last_iova)) {
01c5309803286f Jason Gunthorpe 2021-11-11  494  		unsigned long last = min(last_iova, iopt_area_last_iova(area));
01c5309803286f Jason Gunthorpe 2021-11-11  495  		unsigned long last_index;
01c5309803286f Jason Gunthorpe 2021-11-11  496  		unsigned long index;
01c5309803286f Jason Gunthorpe 2021-11-11  497  
01c5309803286f Jason Gunthorpe 2021-11-11  498  		/* Need contiguous areas in the access */
01c5309803286f Jason Gunthorpe 2021-11-11  499  		if (iopt_area_iova(area) < cur_iova) {
01c5309803286f Jason Gunthorpe 2021-11-11  500  			rc = -EINVAL;
01c5309803286f Jason Gunthorpe 2021-11-11  501  			goto out_remove;
01c5309803286f Jason Gunthorpe 2021-11-11  502  		}
01c5309803286f Jason Gunthorpe 2021-11-11  503  
01c5309803286f Jason Gunthorpe 2021-11-11  504  		index = iopt_iova_to_index(area, cur_iova);
01c5309803286f Jason Gunthorpe 2021-11-11  505  		last_index = iopt_iova_to_index(area, last);
01c5309803286f Jason Gunthorpe 2021-11-11  506  		rc = iopt_pages_add_user(area->pages, index, last_index,
01c5309803286f Jason Gunthorpe 2021-11-11  507  					 out_pages, write);
01c5309803286f Jason Gunthorpe 2021-11-11  508  		if (rc)
01c5309803286f Jason Gunthorpe 2021-11-11  509  			goto out_remove;
01c5309803286f Jason Gunthorpe 2021-11-11  510  		if (last == last_iova)
01c5309803286f Jason Gunthorpe 2021-11-11  511  			break;
01c5309803286f Jason Gunthorpe 2021-11-11  512  		/*
01c5309803286f Jason Gunthorpe 2021-11-11  513  		 * Can't cross areas that are not aligned to the system page
01c5309803286f Jason Gunthorpe 2021-11-11  514  		 * size with this API.
01c5309803286f Jason Gunthorpe 2021-11-11  515  		 */
01c5309803286f Jason Gunthorpe 2021-11-11  516  		if (cur_iova % PAGE_SIZE) {
01c5309803286f Jason Gunthorpe 2021-11-11  517  			rc = -EINVAL;
01c5309803286f Jason Gunthorpe 2021-11-11  518  			goto out_remove;
01c5309803286f Jason Gunthorpe 2021-11-11  519  		}
01c5309803286f Jason Gunthorpe 2021-11-11  520  		cur_iova = last + 1;
01c5309803286f Jason Gunthorpe 2021-11-11  521  		out_pages += last_index - index;
01c5309803286f Jason Gunthorpe 2021-11-11  522  		atomic_inc(&area->num_users);
01c5309803286f Jason Gunthorpe 2021-11-11  523  	}
01c5309803286f Jason Gunthorpe 2021-11-11  524  
01c5309803286f Jason Gunthorpe 2021-11-11  525  	up_read(&iopt->rwsem);
01c5309803286f Jason Gunthorpe 2021-11-11  526  	return 0;
01c5309803286f Jason Gunthorpe 2021-11-11  527  
01c5309803286f Jason Gunthorpe 2021-11-11  528  out_remove:
01c5309803286f Jason Gunthorpe 2021-11-11  529  	if (cur_iova != iova)
01c5309803286f Jason Gunthorpe 2021-11-11  530  		iopt_unaccess_pages(iopt, iova, cur_iova - iova);
01c5309803286f Jason Gunthorpe 2021-11-11  531  	return rc;
01c5309803286f Jason Gunthorpe 2021-11-11  532  }
01c5309803286f Jason Gunthorpe 2021-11-11  533  

:::::: The code at line 488 was first introduced by commit
:::::: 01c5309803286f2c29a6f40bca7f489fce968c42 iommufd: Data structure to provide IOVA to PFN mapping

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
