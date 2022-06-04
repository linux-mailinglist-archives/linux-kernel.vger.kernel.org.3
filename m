Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6353D875
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbiFDToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiFDTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:43:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D02CDD6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654371833; x=1685907833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+ljQfsJeK1+PfmJJfS+J4pMve6NbbryNO9+4yh1XzKs=;
  b=QUoZFdXp5015ECGBN8S7nbYWGg7pim7yBEYl+jrICq1irTRru4ljBHLH
   1Qb/0VnPoCH6pr5c4wEsiky3cdfwvDICA7HGiuMotofr6nmr5/W2CaeyK
   mvcgyMAUOdwHeJgTdPJjlCxafogrSLnp1QvJMvg8mYqIIeDEjC4pVJKp1
   HhmYeU3079lrAgb+xqN1mcLXJk1tM8uv5UmcHIrszjpTvtNM+9HIO8FyD
   sDQA2yMz5bBHxZFJpQljjDwqcFUPIH3ku/ccXShi2NC3ZBZFpiPeCDEo3
   FquYU84s5+ffxQc3Girlu99aKljWnAnrKjCmFEoLq/QtH6ZyeQVW710W2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276536099"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="276536099"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 12:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="553804740"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jun 2022 12:43:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxZgc-000B9x-Mw;
        Sat, 04 Jun 2022 19:43:50 +0000
Date:   Sun, 5 Jun 2022 03:42:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: [jgunthorpe:iommufd 12/14]
 drivers/iommu/iommufd/vfio_compat.c:244:17: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <202206050334.sxxTb3Ar-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   64e1d852f05dde79e9e54bd7e99282f8a5ba8259
commit: cbc039f0577bf8fc8b5203d795fcc63a76aec8cb [12/14] iommufd: vfio container FD ioctl compatibility
config: ia64-randconfig-s031-20220604 (https://download.01.org/0day-ci/archive/20220605/202206050334.sxxTb3Ar-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/jgunthorpe/linux/commit/cbc039f0577bf8fc8b5203d795fcc63a76aec8cb
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout cbc039f0577bf8fc8b5203d795fcc63a76aec8cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/iommufd/vfio_compat.c:244:17: sparse: sparse: cast removes address space '__user' of expression
>> drivers/iommu/iommufd/vfio_compat.c:244:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct vfio_iommu_type1_info_cap_iova_range [noderef] __user *ucap_iovas @@     got struct vfio_iommu_type1_info_cap_iova_range * @@
   drivers/iommu/iommufd/vfio_compat.c:244:17: sparse:     expected struct vfio_iommu_type1_info_cap_iova_range [noderef] __user *ucap_iovas
   drivers/iommu/iommufd/vfio_compat.c:244:17: sparse:     got struct vfio_iommu_type1_info_cap_iova_range *

vim +/__user +244 drivers/iommu/iommufd/vfio_compat.c

   238	
   239	static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
   240					 struct vfio_info_cap_header __user *cur,
   241					 size_t avail)
   242	{
   243		struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
 > 244			container_of(cur, struct vfio_iommu_type1_info_cap_iova_range,
   245				     header);
   246		struct vfio_iommu_type1_info_cap_iova_range cap_iovas = {
   247			.header = {
   248				.id = VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE,
   249				.version = 1,
   250			},
   251		};
   252		struct interval_tree_span_iter span;
   253	
   254		for (interval_tree_span_iter_first(
   255			     &span, &ioas->iopt.reserved_iova_itree, 0, ULONG_MAX);
   256		     !interval_tree_span_iter_done(&span);
   257		     interval_tree_span_iter_next(&span)) {
   258			struct vfio_iova_range range;
   259	
   260			if (!span.is_hole)
   261				continue;
   262			range.start = span.start_hole;
   263			range.end = span.last_hole;
   264			if (avail >= struct_size(&cap_iovas, iova_ranges,
   265						 cap_iovas.nr_iovas + 1) &&
   266			    copy_to_user(&ucap_iovas->iova_ranges[cap_iovas.nr_iovas],
   267					 &range, sizeof(range)))
   268				return -EFAULT;
   269			cap_iovas.nr_iovas++;
   270		}
   271		if (avail >= struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas) &&
   272		    copy_to_user(ucap_iovas, &cap_iovas, sizeof(cap_iovas)))
   273			return -EFAULT;
   274		return struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas);
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
