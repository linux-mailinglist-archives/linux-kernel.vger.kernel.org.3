Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B654706E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbhLJR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:27:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:55018 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhLJR1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639157014; x=1670693014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rTfF76K0FsB4XBpW8sWa4r3qEyc0/4HPl1FjiP6CD4o=;
  b=UDaMQetuepA0Lv4cisTmctQrJxSnf3pM61UH0NAM+sRpDAjYx/YIOmxq
   N4PZG1qXzM+++QUM8KNbM2C45kWq851WqVJ4qHjtiYT9b3Wlw0Zq1PCj3
   ofiKFrlDXCWag6+jhahzM17OKdTJz4dUCno7aKnCDilqAt+7O/7kgYyWL
   Pd2VatBhnnw6cpebyADqExaMF7prRjogPds/yRSOcF//7qvdGy02EqeU3
   +Vs1g/fjKO8RdCDy4rvJfvaPP8oFwRuRclhKgpxITzV+HhUhNNPdxO1Re
   cyrg4qN9ERPoX6gQvNDEwwxIPFbeQnAqT3PvYYDNbifykC12AURygmhOE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="225662882"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225662882"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="612992661"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2021 09:23:12 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvjbz-0003Qo-UK; Fri, 10 Dec 2021 17:23:11 +0000
Date:   Sat, 11 Dec 2021 01:22:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.16-rc3 32/33]
 include/linux/iommufd.h:30:1: error: expected identifier or '('
Message-ID: <202112110116.DbhBjj3j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.16-rc3
head:   44f89b130eec28760e6b655facd4be49c5bcc3f9
commit: 219a6860a2c8c2c89d71793ce4f9375f3e7bb61f [32/33] vfio/pci: Add VFIO_DEVICE_ATTACH_IOASPT
config: hexagon-randconfig-r011-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110116.DbhBjj3j-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/219a6860a2c8c2c89d71793ce4f9375f3e7bb61f
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.16-rc3
        git checkout 219a6860a2c8c2c89d71793ce4f9375f3e7bb61f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/vfio/vfio.c:35:
>> include/linux/iommufd.h:30:1: error: expected identifier or '('
   {
   ^
   1 error generated.


vim +30 include/linux/iommufd.h

8a81aeff73cead Jason Gunthorpe 2021-11-11  26  
8a81aeff73cead Jason Gunthorpe 2021-11-11  27  #else /* !CONFIG_IOMMUFD */
8a81aeff73cead Jason Gunthorpe 2021-11-11  28  static inline struct iommufd_device *
8a81aeff73cead Jason Gunthorpe 2021-11-11  29  iommufd_bind_pci_device(int fd, struct pci_dev *pdev, u32 *id, u64 dev_cookie);
8a81aeff73cead Jason Gunthorpe 2021-11-11 @30  {
8a81aeff73cead Jason Gunthorpe 2021-11-11  31  	return ERR_PTR(-EOPNOTSUPP);
8a81aeff73cead Jason Gunthorpe 2021-11-11  32  }
8a81aeff73cead Jason Gunthorpe 2021-11-11  33  

:::::: The code at line 30 was first introduced by commit
:::::: 8a81aeff73cead826a9b7d26e9af4f09c9fd700f iommufd: Add kAPI toward external drivers

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Liu Yi L <yi.l.liu@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
