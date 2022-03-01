Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452DB4C9107
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiCARBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiCARBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:01:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588C11C04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646154024; x=1677690024;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qFx2K2BkSCOgXk2XRt2r5V5uRFSKNupKTOGKHA8XF+M=;
  b=Fv0nPVkep0GfzlPzpE6WEm8JvXiaqnin/d1/As2vdEvgW4JuCrF3NcLY
   E9OUaBk/H3Lw6fwtjEZiH5ZUSF7o3rZJorQT5Xvq57X15L17eT2OuzFDS
   OoiZmEo6QdINF4n0CNmTLyfK+I0rM/GslUxEwKBYQBZrMMjbNTU04bFsy
   DX3tv2yteFAdgDeFaxlXer+Ed5uvyezmGgz8HAtxjc78ESc3PFciqsrhS
   vINjSDwwZ/kfxs8fmj0XG/uEYWSpdu4DZ6wmwd6ZJmRsfZCauNOOmapDg
   lHxLNqb5Y7f+c0xAJ7nl19uhsy6Fwf2f0iVT7+h3UsG3h1bAawFub5eaY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252915520"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252915520"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:58:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="608868643"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2022 08:58:45 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP5pk-0000m5-RU; Tue, 01 Mar 2022 16:58:44 +0000
Date:   Wed, 2 Mar 2022 00:58:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 29/30]
 drivers/vfio/vfio.c:1800:10: error: implicit declaration of function
 'iommufd_vfio_set_iommu'
Message-ID: <202203020051.lJg5pB22-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   2bca5fa75dad57f41002a93861a950d35d55e568
commit: f8fb748995b4e1156fd76a3860da5ea897536a3c [29/30] vfio: Fix kernel panic in vfio_ioctl_check_extension()
config: hexagon-randconfig-r041-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020051.lJg5pB22-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/f8fb748995b4e1156fd76a3860da5ea897536a3c
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout f8fb748995b4e1156fd76a3860da5ea897536a3c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/vfio/vfio.c:1088:44: error: too many arguments to function call, expected single argument 'iommufd', have 2 arguments
                   vfio_group_unset_iommufd(group->iommufd, &group->device_list);
                   ~~~~~~~~~~~~~~~~~~~~~~~~                 ^~~~~~~~~~~~~~~~~~~
   include/linux/iommufd.h:57:20: note: 'vfio_group_unset_iommufd' declared here
   static inline void vfio_group_unset_iommufd(void *iommufd)
                      ^
   drivers/vfio/vfio.c:1166:26: error: too few arguments to function call, expected 3, have 2
                                                   &group->device_list);
                                                                      ^
   include/linux/iommufd.h:51:19: note: 'vfio_group_set_iommufd' declared here
   static inline int vfio_group_set_iommufd(int fd, struct iommu_group *group,
                     ^
>> drivers/vfio/vfio.c:1800:10: error: implicit declaration of function 'iommufd_vfio_set_iommu' [-Werror,-Wimplicit-function-declaration]
                   return iommufd_vfio_set_iommu(group->iommufd, arg);
                          ^
   3 errors generated.


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
