Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55944B6E54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiBOOIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:08:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiBOOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:08:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A54B7E6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644934074; x=1676470074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J7zCN37fuKDLy5XBcU5zhrZ6lGxiDJe4n3xjoraFqq8=;
  b=O6X/z3jogbzrC96oB1/cpgIm25s89JD2iXUNJNa8khrlWTNAmxaUgBn9
   iMFLnK2db8Y1YzQkeVxtE9OGnmMZHaPxDMLK0LHFdDLSNc1POz/pj6i0S
   6sMAbfOXJMznSQbrF+0NvLWwAIt0nZeIs+puLtkZN4zKgrNXuxjSshkk/
   jWcNbiPBOT2KH+OBYILmtnJT6R2toIYsYH3Io+KuVNsHeaYwrhJ4om6B0
   aLOO5ghsu4sTVslIPCLtKNZeUZXfsd5i8DGSGQ84PADv4vIOoG4FQ+vnI
   JzFDzGJvj0Irb/7mZhuM3Dot59qtVu+dwOfy4X1ODC2tVTKdmikkbS/Xo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250559806"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250559806"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="703700280"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2022 06:07:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJyUg-0009jH-Sw; Tue, 15 Feb 2022 14:07:50 +0000
Date:   Tue, 15 Feb 2022 22:07:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 28/56]
 drivers/iommu/iommufd/selftest.c:198:31: warning: comparison of distinct
 pointer types lacks a cast
Message-ID: <202202152214.sfZjnb0v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220215/202202152214.sfZjnb0v-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/047031aaa50c5daed9c24fa0701f7016d4ff6934
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout 047031aaa50c5daed9c24fa0701f7016d4ff6934
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   drivers/iommu/iommufd/selftest.c:181:22: error: initialization of 'void (*)(struct device *)' from incompatible pointer type 'int (*)(struct iommu_domain *, long unsigned int,  phys_addr_t,  size_t,  size_t,  int,  gfp_t,  size_t *)' {aka 'int (*)(struct iommu_domain *, long unsigned int,  long long unsigned int,  long unsigned int,  long unsigned int,  int,  unsigned int,  long unsigned int *)'} [-Werror=incompatible-pointer-types]
     181 |         .map_pages = mock_domain_map_pages,
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:181:22: note: (near initialization for 'domain_mock_ops.release_device')
   drivers/iommu/iommufd/selftest.c:182:10: error: 'const struct iommu_ops' has no member named 'unmap_pages'
     182 |         .unmap_pages = mock_domain_unmap_pages,
         |          ^~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:182:24: error: initialization of 'void (*)(struct device *)' from incompatible pointer type 'size_t (*)(struct iommu_domain *, long unsigned int,  size_t,  size_t,  struct iommu_iotlb_gather *)' {aka 'long unsigned int (*)(struct iommu_domain *, long unsigned int,  long unsigned int,  long unsigned int,  struct iommu_iotlb_gather *)'} [-Werror=incompatible-pointer-types]
     182 |         .unmap_pages = mock_domain_unmap_pages,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:182:24: note: (near initialization for 'domain_mock_ops.probe_finalize')
   drivers/iommu/iommufd/selftest.c:183:10: error: 'const struct iommu_ops' has no member named 'iova_to_phys'
     183 |         .iova_to_phys = mock_domain_iova_to_phys,
         |          ^~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:183:25: error: initialization of 'struct iommu_group * (*)(struct device *)' from incompatible pointer type 'phys_addr_t (*)(struct iommu_domain *, dma_addr_t)' {aka 'long long unsigned int (*)(struct iommu_domain *, long long unsigned int)'} [-Werror=incompatible-pointer-types]
     183 |         .iova_to_phys = mock_domain_iova_to_phys,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/selftest.c:183:25: note: (near initialization for 'domain_mock_ops.device_group')
   drivers/iommu/iommufd/selftest.c: In function 'get_md_pagetable':
>> drivers/iommu/iommufd/selftest.c:198:31: warning: comparison of distinct pointer types lacks a cast
     198 |         if (hwpt->domain->ops != &domain_mock_ops) {
         |                               ^~
   cc1: some warnings being treated as errors


vim +198 drivers/iommu/iommufd/selftest.c

   185	
   186	static inline struct iommufd_hw_pagetable *
   187	get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
   188			 struct mock_iommu_domain **mock)
   189	{
   190		struct iommufd_hw_pagetable *hwpt;
   191		struct iommufd_object *obj;
   192	
   193		obj = iommufd_get_object(ucmd->ictx, mockpt_id,
   194					 IOMMUFD_OBJ_HW_PAGETABLE);
   195		if (IS_ERR(obj))
   196			return ERR_CAST(obj);
   197		hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
 > 198		if (hwpt->domain->ops != &domain_mock_ops) {
   199			return ERR_PTR(-EINVAL);
   200			iommufd_put_object(&hwpt->obj);
   201		}
   202		*mock = container_of(hwpt->domain, struct mock_iommu_domain, domain);
   203		return hwpt;
   204	}
   205	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
