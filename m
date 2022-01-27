Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB4F49DFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiA0KrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:47:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:43131 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239603AbiA0Kq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643280416; x=1674816416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m4WRoX2kA9SNWeuDQh2/irazGfRo/Pa1n41wQpvk5Y0=;
  b=KKkvUPcDuHKzifLgUcpevdUaebA2lxxoD9GYkiNT5Eob8e6rbQGSUTu5
   2ggumj6QN1s0/bdv9w9ZWz8PdQqyOQ5RKdXuZLrJFxC1bQjcH//omyKgV
   Xhb2gzHAmAJDd5L3AfV3w80ekaPKewzIkt4RUjJ5LIfeA5fyUi8vJ7KHG
   a8/LjTYP7ZLwo2GvAmRsg+1OiRnP0cEMnq9nI3f4wUwA+7xWQZZKToLaN
   WXx5gWzjSeixIhDUvUWgxMPA1eqD0l09kZFw34oOno4lowvXoZYxzTrcA
   YMChTILnwkZZ7fIw0nLHiuI5Z9lXSoUgEm7vQpADqQaVT8qiHEuFVePoo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234189250"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="234189250"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 02:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="563742823"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2022 02:46:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD2Im-000MUm-Sz; Thu, 27 Jan 2022 10:46:52 +0000
Date:   Thu, 27 Jan 2022 18:46:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:for-yishai 9/19]
 drivers/vfio/pci/vfio_pci_core.c:1129:10: error: use of undeclared
 identifier 'feature'; did you mean 'return'?
Message-ID: <202201271821.gWpB1Xrq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux for-yishai
head:   4425468e2b7ec3b986f1ef6aa34a208bb661b2d8
commit: a77cf53b1c02bdee0ee8bf06dc3bd92d55591c13 [9/19] vfio: Have the core code decode VFIO_DEVICE_FEATURE
config: riscv-randconfig-r042-20220126 (https://download.01.org/0day-ci/archive/20220127/202201271821.gWpB1Xrq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f400a6012c668dfaa73462caf067ceb074e66c47)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/jgunthorpe/linux/commit/a77cf53b1c02bdee0ee8bf06dc3bd92d55591c13
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe for-yishai
        git checkout a77cf53b1c02bdee0ee8bf06dc3bd92d55591c13
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/vfio/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/vfio/pci/vfio_pci_core.c:1129:10: error: use of undeclared identifier 'feature'; did you mean 'return'?
           switch (feature.flags & VFIO_DEVICE_FEATURE_MASK) {
                   ^~~~~~~
                   return
>> drivers/vfio/pci/vfio_pci_core.c:1129:10: error: expected expression
   2 errors generated.


vim +1129 drivers/vfio/pci/vfio_pci_core.c

43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1121  
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1122  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1123  				void __user *arg, size_t argsz)
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1124  {
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1125  	struct vfio_pci_core_device *vdev =
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1126  		container_of(device, struct vfio_pci_core_device, vdev);
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1127  	uuid_t uuid;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1128  
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24 @1129  	switch (feature.flags & VFIO_DEVICE_FEATURE_MASK) {
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1130  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1131  		if (!vdev->vf_token)
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1132  			return -ENOTTY;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1133  
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1134  		/*
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1135  		 * We do not support GET of the VF Token UUID as this could
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1136  		 * expose the token of the previous device user.
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1137  		 */
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1138  		if (flags & VFIO_DEVICE_FEATURE_GET)
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1139  			return -EINVAL;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1140  
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1141  		if (flags & VFIO_DEVICE_FEATURE_PROBE)
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1142  			return 0;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1143  
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1144  		/* Don't SET unless told to do so */
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1145  		if (!(flags & VFIO_DEVICE_FEATURE_SET))
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1146  			return -EINVAL;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1147  
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1148  		if (argsz < sizeof(uuid))
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1149  			return -EINVAL;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1150  
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1151  		if (copy_from_user(&uuid, arg, sizeof(uuid)))
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1152  			return -EFAULT;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1153  
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1154  		mutex_lock(&vdev->vf_token->lock);
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1155  		uuid_copy(&vdev->vf_token->uuid, &uuid);
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1156  		mutex_unlock(&vdev->vf_token->lock);
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1157  		return 0;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1158  	default:
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1159  		return -ENOTTY;
43eeeecc8ed5fa drivers/vfio/pci/vfio_pci.c      Alex Williamson 2020-03-24  1160  	}
8b27ee60bfd6bb drivers/vfio/pci/vfio_pci.c      Alex Williamson 2013-09-04  1161  }
a77cf53b1c02bd drivers/vfio/pci/vfio_pci_core.c Jason Gunthorpe 2022-01-26  1162  EXPORT_SYMBOL_GPL(vfio_pci_core_ioctl_feature);
89e1f7d4c66d85 drivers/vfio/pci/vfio_pci.c      Alex Williamson 2012-07-31  1163  

:::::: The code at line 1129 was first introduced by commit
:::::: 43eeeecc8ed5fa05652d68032a8bfb1308ee9baa vfio: Introduce VFIO_DEVICE_FEATURE ioctl and first user

:::::: TO: Alex Williamson <alex.williamson@redhat.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
