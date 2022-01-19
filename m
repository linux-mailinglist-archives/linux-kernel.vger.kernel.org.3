Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49D4494304
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357553AbiASWZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:25:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:17079 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357552AbiASWZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642631144; x=1674167144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WN0pvM4jopLSBUBluS3CZLwpDafI5eTwwHlj7194ZwQ=;
  b=AWMxgK56JQXqTQZbFswvexoS6RozCUii5UBj97KrwpQpSs9EREiSsuFq
   dgs80y4W9mF8TOKT1w1tfBbzVKZzqXxXD+uXd4rmtHNH9vj0Dx1FHzfK/
   D3uqwUy+ES+jWpl0koezKuyertc+Pln0jrXGgsCMA/NWZ+d/nPLz+rUVH
   4Izks61fE8rG8l5G4zhU/m1VxvjUMlj6Yqv8aI7WhTo2sBFcv++K84Tce
   fq1FUSGwBkYvofJxDPtOg+Do86qggVxEhWLH3b0ETRYyqz7+seckzAjcx
   yU/jr4WUnwvcBmC0CQzWomcwfez6U+I7d8QdHjwp+8KT0ld4DW5hLHhMk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245165828"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="245165828"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 14:25:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="626064947"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2022 14:25:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAJOf-000DnO-T8; Wed, 19 Jan 2022 22:25:41 +0000
Date:   Thu, 20 Jan 2022 06:25:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:cex7 160/170] drivers/bus/fsl-mc/fsl-mc-bus.c:1111:39:
 error: implicit declaration of function 'iommu_get_dma_domain'; did you mean
 'iommu_is_dma_domain'?
Message-ID: <202201200604.v1t4HdLH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm cex7
head:   cdfacabed5a40f44a694e4254ef37fcb4fee1e62
commit: 9d9cfaf6528a80634c1aa12d94112e3adb05bdbb [160/170] bus: fsl-mc: add IOMMU mappings for MC firmware and DCFG
config: arm-randconfig-r004-20220119 (https://download.01.org/0day-ci/archive/20220120/202201200604.v1t4HdLH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm cex7
        git checkout 9d9cfaf6528a80634c1aa12d94112e3adb05bdbb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/bus/fsl-mc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/bus/fsl-mc/fsl-mc-bus.c: In function 'fsl_mc_setup_iommu':
>> drivers/bus/fsl-mc/fsl-mc-bus.c:1111:39: error: implicit declaration of function 'iommu_get_dma_domain'; did you mean 'iommu_is_dma_domain'? [-Werror=implicit-function-declaration]
    1111 |         struct iommu_domain *domain = iommu_get_dma_domain(dev);
         |                                       ^~~~~~~~~~~~~~~~~~~~
         |                                       iommu_is_dma_domain
>> drivers/bus/fsl-mc/fsl-mc-bus.c:1111:39: warning: initialization of 'struct iommu_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +1111 drivers/bus/fsl-mc/fsl-mc-bus.c

  1108	
  1109	static void fsl_mc_setup_iommu(struct device *dev, struct fsl_mc *mc)
  1110	{
> 1111		struct iommu_domain *domain = iommu_get_dma_domain(dev);
  1112		struct resource dcfg_res = DEFINE_RES_MEM(0x01e00000, 0x10000);
  1113		struct device_node *np;
  1114		u64 firmware_base;
  1115		u64 mc_ram_base;
  1116		u32 mc_ram_size;
  1117		u32 mcfbalr;
  1118		u32 mcfbahr;
  1119		int ret;
  1120	
  1121		if (!domain) {
  1122			dev_err(dev, "Missing IOMMU domain - MC firmware will crash\n");
  1123			return;
  1124		}
  1125	
  1126		mcfbalr = readl(mc->fsl_mc_regs + FSL_MC_FBALR);
  1127		mcfbahr = readl(mc->fsl_mc_regs + FSL_MC_FBAHR);
  1128	
  1129		firmware_base = mcfbalr & MCFBAR_LOW;
  1130		firmware_base |= (u64)(mcfbahr & MCFBAR_HIGH) << 32;
  1131	
  1132		/* Calculate the size of MC RAM. */
  1133		mc_ram_size = mcfbalr & MCFBAR_MEMSZ;
  1134		if (mc_ram_size != 255)
  1135			mc_ram_size = (mc_ram_size + 1) * SZ_256M;
  1136		else
  1137			mc_ram_size = SZ_128M;
  1138	
  1139		/*
  1140		 * Calculate base address of MC RAM. U-Boot says:
  1141		 * "As per MC design document, MC initial base address should be least
  1142		 * significant 512MB address of MC private memory, i.e. address should
  1143		 * point to end address masked with 512MB offset in private DRAM block."
  1144		 * and uses the following calculation:
  1145		 *
  1146		 *    (gd->arch.resv_ram + mc_ram_size - 1) &
  1147		 *       MC_RAM_BASE_ADDR_ALIGNMENT_MASK
  1148		 *
  1149		 * where gd->arch.resv_ram is the start of the MC reserved RAM block,
  1150		 * and is itself aligned to 512MB.
  1151		 *
  1152		 * Hence, if the reserved RAM starts at 0x2780000000 and is 0x70000000
  1153		 * in size, then the firmware address will be 0x27e0000000. However,
  1154		 * if it is 512M, then the reserved RAM and the firmware base addresses
  1155		 * will be identical.
  1156		 */
  1157		mc_ram_base = ALIGN(firmware_base - mc_ram_size + 1, SZ_512M);
  1158	
  1159		/*
  1160		 * Give MC firmware access to the MC RAM, which includes the MC
  1161		 * firmware image itself.
  1162		 */
  1163		ret = iommu_map(domain, mc_ram_base, mc_ram_base, mc_ram_size,
  1164				IOMMU_CACHE | IOMMU_WRITE | IOMMU_READ);
  1165		if (ret)
  1166			dev_err(dev, "Failed to setup IOMMU mapping for MC RAM: %pe\n",
  1167				ERR_PTR(ret));
  1168	
  1169		/* Give firmware access to the DCFG so it can read the SVR register */
  1170		np = of_find_compatible_node(NULL, NULL, "fsl,lx2160a-dcfg");
  1171		if (np) {
  1172			ret = of_address_to_resource(np, 0, &dcfg_res);
  1173			if (ret) {
  1174				dev_err(dev, "Failed to get dcfg resource: %pe\n",
  1175					ERR_PTR(ret));
  1176				return;
  1177			}
  1178		} else {
  1179			dev_warn(dev,
  1180				 "Failed to find dcfg node - using default addresses\n");
  1181		}
  1182	
  1183		ret = iommu_map(domain, dcfg_res.start, dcfg_res.start,
  1184				resource_size(&dcfg_res), IOMMU_READ);
  1185		if (ret)
  1186			dev_err(dev, "Failed to setup IOMMU mapping for DCFG: %pe\n",
  1187				ERR_PTR(ret));
  1188	}
  1189	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
