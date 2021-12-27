Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D666247FC82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhL0MJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:09:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:23162 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233695AbhL0MJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640606966; x=1672142966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sJZZTv/IUdPuDW6eBGrJtLGACruSQkiFODy3pTUkwtw=;
  b=J+EMZmD9fctca2A6dbZzVo3GPEuzkjixve1dZRFOVIy0LqmKtDvPwsuJ
   QHqNDM5dJ1mYW2BWbHhTougx7ljXDQmkckxGZWc1KdHLQ7nZ2IAINg56j
   BpT/jmzxGs04n0Av6CttnZUtN/dgZVLGDTDF21rJtdvdDOqy6qY5P+yV4
   5gDTRs8i3baAoVxpkgOOJXQttBVSySBW4rMph/TTyn5Wmr1FMTGJrL8bZ
   ztqbSZX7ULC2fGlOqhDNBK7+doS8TOxO4rJMfQXzAQgcGkkKF9bUhd9+S
   8sPS4/i1foLX1JcAhyvu8wS5oRYpKcJ3UtWjkcOQmZmrCUmTxnF3PO/zR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="221202667"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="221202667"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 04:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="686258241"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 04:09:19 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1ooY-0006Fj-Kx; Mon, 27 Dec 2021 12:09:18 +0000
Date:   Mon, 27 Dec 2021 20:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.16-rc3 24/26]
 include/linux/iommufd.h:30:1: error: expected identifier or '('
Message-ID: <202112272023.qjJGBBbz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.16-rc3
head:   9194d1d84235002ef9e0ae8666bc205840e3be74
commit: e4e0ed3d842fc0ce3952d33315f3d4a56b6f91a4 [24/26] vfio/pci: Add VFIO_DEVICE_ATTACH_IOASPT
config: riscv-randconfig-r032-20211227 (https://download.01.org/0day-ci/archive/20211227/202112272023.qjJGBBbz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/luxis1999/iommufd/commit/e4e0ed3d842fc0ce3952d33315f3d4a56b6f91a4
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.16-rc3
        git checkout e4e0ed3d842fc0ce3952d33315f3d4a56b6f91a4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/vfio/vfio.c:35:
>> include/linux/iommufd.h:30:1: error: expected identifier or '('
   {
   ^
   1 error generated.


vim +30 include/linux/iommufd.h

b72430a4d634e3 Jason Gunthorpe 2021-11-11  26  
b72430a4d634e3 Jason Gunthorpe 2021-11-11  27  #else /* !CONFIG_IOMMUFD */
b72430a4d634e3 Jason Gunthorpe 2021-11-11  28  static inline struct iommufd_device *
b72430a4d634e3 Jason Gunthorpe 2021-11-11  29  iommufd_bind_pci_device(int fd, struct pci_dev *pdev, u32 *id, u64 dev_cookie);
b72430a4d634e3 Jason Gunthorpe 2021-11-11 @30  {
b72430a4d634e3 Jason Gunthorpe 2021-11-11  31  	return ERR_PTR(-EOPNOTSUPP);
b72430a4d634e3 Jason Gunthorpe 2021-11-11  32  }
b72430a4d634e3 Jason Gunthorpe 2021-11-11  33  

:::::: The code at line 30 was first introduced by commit
:::::: b72430a4d634e343ee1bb83e3a9e6bd020f09252 iommufd: Add kAPI toward external drivers

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
