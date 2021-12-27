Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93047FC19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhL0LI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:08:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:65147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233404AbhL0LIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640603301; x=1672139301;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gxnIc0tAa2HWujgj0x4BJKdc+d6piJgI/wGTTn9O4Kk=;
  b=QRv4hIiX34s7uPvr2E1ixFKAA+fyfUZVqnIOsWntTq2ZowAQpKrTIsEz
   H4KN6j3WbTBS61L57dZi9k1Vnk4tTZUuETiN+rb7E65xEUdJMu8aaTOyl
   xGYp95ijPIQj2rzROG6NdsFs6kMYu9m8fWQFH7QEa6FkjdB1JyO4o83D0
   F+x+NnZSDE2iy0Lh3yyjysvJEikrVNqjKFhUNMQJgq0bJ/zwmQ9ublxnr
   6leNYv3E5weqy9RAs1Rm4k/4nRZLtYN8b1Ga5WVPvCsMeqA1X1s4hNlC+
   yfgq+r+DWHH9AVfXYcwTNNur9ZadMDiCoDkQ5b2jGmCiZFw4vLI+b10Cl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="265417416"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="265417416"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 03:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="509826213"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Dec 2021 03:08:18 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1nrW-0006Eb-4K; Mon, 27 Dec 2021 11:08:18 +0000
Date:   Mon, 27 Dec 2021 19:07:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.16-rc3 24/26]
 include/linux/iommufd.h:30:1: error: expected identifier or '(' before '{'
 token
Message-ID: <202112271912.pdwOvXhh-lkp@intel.com>
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
config: alpha-randconfig-r016-20211227 (https://download.01.org/0day-ci/archive/20211227/202112271912.pdwOvXhh-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/e4e0ed3d842fc0ce3952d33315f3d4a56b6f91a4
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.16-rc3
        git checkout e4e0ed3d842fc0ce3952d33315f3d4a56b6f91a4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/vfio/vfio.c:35:
>> include/linux/iommufd.h:30:1: error: expected identifier or '(' before '{' token
      30 | {
         | ^
   include/linux/iommufd.h:29:1: warning: 'iommufd_bind_pci_device' declared 'static' but never defined [-Wunused-function]
      29 | iommufd_bind_pci_device(int fd, struct pci_dev *pdev, u32 *id, u64 dev_cookie);
         | ^~~~~~~~~~~~~~~~~~~~~~~


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
