Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40C349E4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiA0OqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:46:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:8881 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242624AbiA0OqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643294778; x=1674830778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m50BIxQ+OrnN/r3td6L/RkYjGST0d2Ie32Y2j7k8wuM=;
  b=jhQ/gwvVwuJApeqz3hcr2KQi7np8gP5VBrBGkT2E5LWIJiDvuf/nw2Ae
   s68I9cFBo5C2cBsbPPbfTKh/c4aN2kR5+0SlY3MpyHLyYwhDzpwyfKec3
   THeVw5Rdc7yhBYIw0AR/AH0oACZlyIQou9m6XdbuIPZfrKrLnWwvgkdW/
   PeaRrhayJL3+M7JT972BMbCXDemSSdnX4X7fsULEzYsPlKaPOqUZY0t4T
   VQfThi+iOZQVHEg8Uc4+Sq5kgosKwYkluO/N5CLj1znjtuV1BgeHBEHCj
   lODpfL5A5lt5DgPtXdy0sVyj26bQS18PScxX0w3hRxCJXDyXHN3iagCNu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244475242"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="244475242"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 06:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="477892503"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2022 06:42:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD5yK-000Mhe-4B; Thu, 27 Jan 2022 14:42:00 +0000
Date:   Thu, 27 Jan 2022 22:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [jgunthorpe:for-yishai 14/19] drivers/vfio/pci/mlx5/main.c:519:10:
 error: 'const struct vfio_device_ops' has no member named 'flags'
Message-ID: <202201272213.k8dXkt0a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux for-yishai
head:   4425468e2b7ec3b986f1ef6aa34a208bb661b2d8
commit: 56686ca194f4c2b4bac10ee8a07080aaeb1a3d03 [14/19] vfio/mlx5: Implement vfio_pci driver for mlx5 devices
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201272213.k8dXkt0a-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/56686ca194f4c2b4bac10ee8a07080aaeb1a3d03
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe for-yishai
        git checkout 56686ca194f4c2b4bac10ee8a07080aaeb1a3d03
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/vfio/pci/mlx5/main.c:519:10: error: 'const struct vfio_device_ops' has no member named 'flags'
     519 |         .flags = VFIO_DEV_FLAG_MIG_P2P,
         |          ^~~~~
>> drivers/vfio/pci/mlx5/main.c:519:18: error: 'VFIO_DEV_FLAG_MIG_P2P' undeclared here (not in a function)
     519 |         .flags = VFIO_DEV_FLAG_MIG_P2P,
         |                  ^~~~~~~~~~~~~~~~~~~~~


vim +519 drivers/vfio/pci/mlx5/main.c

   516	
   517	static const struct vfio_device_ops mlx5vf_pci_ops = {
   518		.name = "mlx5-vfio-pci",
 > 519		.flags = VFIO_DEV_FLAG_MIG_P2P,
   520		.open_device = mlx5vf_pci_open_device,
   521		.close_device = mlx5vf_pci_close_device,
   522		.ioctl = vfio_pci_core_ioctl,
   523		.device_feature = vfio_pci_core_ioctl_feature,
   524		.read = vfio_pci_core_read,
   525		.write = vfio_pci_core_write,
   526		.mmap = vfio_pci_core_mmap,
   527		.request = vfio_pci_core_request,
   528		.match = vfio_pci_core_match,
   529		.migration_set_state = mlx5vf_pci_set_device_state,
   530	};
   531	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
