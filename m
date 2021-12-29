Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82365481303
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhL2NFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:05:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:5203 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236629AbhL2NFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783103; x=1672319103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YrJYi3rB27UVEu1poGL4tE6la3ODs9SmPbhzhaXlgQE=;
  b=UGUu9P0GXKnpzIm/5cBAA46E20RBih8ec7djoty1YDLZbqmb3btX1xpE
   1zb/jTRAWmzpXQTpygTSpNa8VSxxL+ovLmxAEJvMoqgIivWws8FJ35Aia
   DlYdo7EAfPp1EcVW7cJd8yOCQkrgjSKBMXNC3tmxFiB5A35/0ppi+LJjW
   m4T0sQAHzQandZRjWJTaI9yLcGqLgtwYp4VzpnhC/uBf5VexsDr4gD6RG
   cEgbmov+YAqnJcgFhLKe6TVqf6SCJsPm1VORBq221bcGqpEYi5NbQiqH6
   Z+q2njg9k4hYNlwHJbeVaHr6SOnWBUQP2/G3vGSMS8lVY9U64Wu7d6MHO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241727221"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="241727221"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="468477739"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Dec 2021 05:05:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2YdZ-0008vf-3g; Wed, 29 Dec 2021 13:05:01 +0000
Date:   Wed, 29 Dec 2021 21:04:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:cex7 188/188] drivers/bus/fsl-mc/fsl-mc-bus.c:169:44:
 error: no member named 'iommu_fwnode' in 'struct iommu_fwspec'
Message-ID: <202112292120.VAwsCiNc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm cex7
head:   ddd00596d29349aec223615c42a6986f5e3ca509
commit: ddd00596d29349aec223615c42a6986f5e3ca509 [188/188] bus: fsl-mc: add custom .dma_configure implementation
config: arm-randconfig-c002-20211228 (https://download.01.org/0day-ci/archive/20211229/202112292120.VAwsCiNc-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm cex7
        git checkout ddd00596d29349aec223615c42a6986f5e3ca509
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/bus/fsl-mc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/bus/fsl-mc/fsl-mc-bus.c:169:44: error: no member named 'iommu_fwnode' in 'struct iommu_fwspec'
           iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
                                             ~~~~~~  ^
   drivers/bus/fsl-mc/fsl-mc-bus.c:173:39: error: no member named 'iommu_fwnode' in 'struct iommu_fwspec'
           ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
                                        ~~~~~~  ^
>> drivers/bus/fsl-mc/fsl-mc-bus.c:184:9: error: implicit declaration of function 'iommu_probe_device' [-Werror,-Wimplicit-function-declaration]
                   ret = iommu_probe_device(dev);
                         ^
   3 errors generated.


vim +169 drivers/bus/fsl-mc/fsl-mc-bus.c

   139	
   140	static int fsl_mc_dma_configure(struct device *dev)
   141	{
   142		struct device *dma_dev = dev;
   143		struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
   144		u32 input_id = mc_dev->icid;
   145		struct iommu_fwspec *fwspec;
   146		const struct iommu_ops *iommu_ops;
   147		int ret;
   148	
   149		/* Skip DMA setup for devices that are not DMA masters */
   150		if (dev->type == &fsl_mc_bus_dpmcp_type ||
   151		    dev->type == &fsl_mc_bus_dpbp_type ||
   152		    dev->type == &fsl_mc_bus_dpcon_type ||
   153		    dev->type == &fsl_mc_bus_dpio_type)
   154			return 0;
   155	
   156		while (dev_is_fsl_mc(dma_dev))
   157			dma_dev = dma_dev->parent;
   158	
   159	
   160	#if 0
   161		if (dev_of_node(dma_dev))
   162			return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
   163	
   164		return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
   165	#else
   166		fwspec = dev_iommu_fwspec_get(dma_dev);
   167		if (!fwspec)
   168			return -ENODEV;
 > 169		iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
   170		if (!iommu_ops)
   171			return -ENODEV;
   172	
   173		ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
   174		if (ret)
   175			return ret;
   176	
   177		ret = iommu_fwspec_add_ids(dev, &input_id, 1);
   178		if (ret) {
   179			iommu_fwspec_free(dev);
   180			return ret;
   181		}
   182	
   183		if (!device_iommu_mapped(dev)) {
 > 184			ret = iommu_probe_device(dev);
   185			if (ret) {
   186				iommu_fwspec_free(dev);
   187				return ret;
   188			}
   189		}
   190	
   191		arch_setup_dma_ops(dev, 0, *dma_dev->dma_mask + 1, iommu_ops, true);
   192	
   193		return 0;
   194	#endif
   195	}
   196	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
