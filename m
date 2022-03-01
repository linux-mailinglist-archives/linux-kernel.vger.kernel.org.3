Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA34C9084
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiCAQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiCAQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:38:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582762C5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646152665; x=1677688665;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xq8o1OwGrWrJswtfuIbrlg6hnMIFmFyMHnjBYysagQs=;
  b=Ot9jpbtjBIkkmHbJiU19nzh23VMfZmd/7K26e9HLlvA9V7qzUXK0nfgP
   wusMgKiPMvPXUk9y/sx4lC4AHxa4gQDHdW9JWFvSfFeJKTqu0IiOH6yj7
   fRYxGpPE5qkR6NMcU1LkuIA30S3vdNGY4n18/MzG7RFASTVMIS3JHoaRl
   RnaDlmu0p6ktErOvgBsUqCoD1Y5Lc+wnlBD0XE0a6krdhdE5gQYIs7ncT
   nvXJiISEb05F93OoZiz0tSJMW/+MRE6SQr9Prwc/I9Hzn9jEOqwFSjPVM
   6ICM71Es8x9fSitxhBCPoGz0fiF5ijkL2Ml/qDwNOaAEecwgEhmCV77fM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="316389267"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="316389267"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="593652839"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2022 08:37:43 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP5VP-0000iz-9o; Tue, 01 Mar 2022 16:37:43 +0000
Date:   Wed, 2 Mar 2022 00:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 29/30]
 drivers/vfio/vfio.c:1800:24: error: implicit declaration of function
 'iommufd_vfio_set_iommu'
Message-ID: <202203020047.jhfhUk35-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   2bca5fa75dad57f41002a93861a950d35d55e568
commit: f8fb748995b4e1156fd76a3860da5ea897536a3c [29/30] vfio: Fix kernel panic in vfio_ioctl_check_extension()
config: mips-randconfig-r015-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020047.jhfhUk35-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/f8fb748995b4e1156fd76a3860da5ea897536a3c
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout f8fb748995b4e1156fd76a3860da5ea897536a3c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/vfio/vfio.c: In function '__vfio_group_unset_container':
   drivers/vfio/vfio.c:1088:17: error: too many arguments to function 'vfio_group_unset_iommufd'
    1088 |                 vfio_group_unset_iommufd(group->iommufd, &group->device_list);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/vfio/vfio.c:35:
   include/linux/iommufd.h:57:20: note: declared here
      57 | static inline void vfio_group_unset_iommufd(void *iommufd)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c: In function 'vfio_group_set_container':
   drivers/vfio/vfio.c:1166:49: error: passing argument 2 of 'vfio_group_set_iommufd' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1166 |                                                 &group->device_list);
         |                                                 ^~~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 struct list_head *
   In file included from drivers/vfio/vfio.c:35:
   include/linux/iommufd.h:51:70: note: expected 'struct iommu_group *' but argument is of type 'struct list_head *'
      51 | static inline int vfio_group_set_iommufd(int fd, struct iommu_group *group,
         |                                                  ~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/vfio/vfio.c:1165:26: error: too few arguments to function 'vfio_group_set_iommufd'
    1165 |         group->iommufd = vfio_group_set_iommufd(container_fd,
         |                          ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/vfio/vfio.c:35:
   include/linux/iommufd.h:51:19: note: declared here
      51 | static inline int vfio_group_set_iommufd(int fd, struct iommu_group *group,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c: In function 'vfio_external_check_extension':
>> drivers/vfio/vfio.c:1800:24: error: implicit declaration of function 'iommufd_vfio_set_iommu' [-Werror=implicit-function-declaration]
    1800 |                 return iommufd_vfio_set_iommu(group->iommufd, arg);
         |                        ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/iommufd_vfio_set_iommu +1800 drivers/vfio/vfio.c

  1796	
  1797	long vfio_external_check_extension(struct vfio_group *group, unsigned long arg)
  1798	{
  1799		if (group->iommufd)
> 1800			return iommufd_vfio_set_iommu(group->iommufd, arg);
  1801	
  1802		return vfio_ioctl_check_extension(group->container, arg);
  1803	}
  1804	EXPORT_SYMBOL_GPL(vfio_external_check_extension);
  1805	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
