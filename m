Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E6657D593
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiGUVJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGUVJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:09:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4190D91
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658437795; x=1689973795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CH/N6RyqWpi3Q/qSWjS6dgtJnWDqQ+JkIVbStP1cE6Y=;
  b=E9CCTbiCRGdSwedUsdec/zcfcSvcS0KjBwfE1az/KjcbzOvp7ODCVvkr
   gPP7BFjwiAZPmVX2O8wiJQwK2mVOJzWUFlJ5XKJQJYqMYxszofNbxL/oH
   YWxZ3Prt3iKGwKfuEzT2hmlaOocT84Kql5sIhmKQ2B6h/69VPBWN15drl
   LoAbX5erLvtA5d3gGs11v3tEf9XReEXHuvWockqyyJEYuN9pdgv/wPxRx
   +1it1veXe85TM0qODP5StDitgGlRmJYNMTbqrqOGsIvZVMYmb4kjC8Nsz
   8HeGI30Yo2iPdADIU4axFSKbysoKEhfzbYAM0Fwdw6WvVXDKedxSRo4w5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="274025316"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="274025316"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 14:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="548934029"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 14:09:53 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEdQe-0000Ym-2r;
        Thu, 21 Jul 2022 21:09:52 +0000
Date:   Fri, 22 Jul 2022 05:09:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arnd-playground:orion-pci-cleanup 2/5]
 arch/arm/plat-orion/pcie.c:325:26: error: use of undeclared identifier
 'pci_common_swizzle'
Message-ID: <202207220513.e5SXpj51-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git orion-pci-cleanup
head:   f154fdd063e0f8e231dbe3c06b03fbb1ec0ffb8c
commit: 1857a2a57968779ee07dae4b4d9f8c6fc73c4547 [2/5] ARM: orion: stop using pci_common_init
config: arm-randconfig-r021-20220718 (https://download.01.org/0day-ci/archive/20220722/202207220513.e5SXpj51-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0c1b32717bcffcf8edf95294e98933bd4c1e76ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=1857a2a57968779ee07dae4b4d9f8c6fc73c4547
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground orion-pci-cleanup
        git checkout 1857a2a57968779ee07dae4b4d9f8c6fc73c4547
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/plat-orion/pcie.c:325:26: error: use of undeclared identifier 'pci_common_swizzle'
                           bridge->swizzle_irq = pci_common_swizzle;
                                                 ^
   arch/arm/plat-orion/pcie.c:337:11: error: call to undeclared function 'pci_scan_root_bus_bridge'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                   ret = pci_scan_root_bus_bridge(bridge);
                                         ^
   arch/arm/plat-orion/pcie.c:379:4: error: call to undeclared function 'pci_bus_claim_resources'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           pci_bus_claim_resources(bus);
                           ^
   arch/arm/plat-orion/pcie.c:383:4: error: call to undeclared function 'pci_bus_size_bridges'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           pci_bus_size_bridges(bus);
                           ^
   arch/arm/plat-orion/pcie.c:384:4: error: call to undeclared function 'pci_bus_assign_resources'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           pci_bus_assign_resources(bus);
                           ^
   arch/arm/plat-orion/pcie.c:384:4: note: did you mean 'pci_assign_resource'?
   include/linux/pci.h:1810:19: note: 'pci_assign_resource' declared here
   static inline int pci_assign_resource(struct pci_dev *dev, int i)
                     ^
   arch/arm/plat-orion/pcie.c:387:5: error: call to undeclared function 'pcie_bus_configure_settings'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                   pcie_bus_configure_settings(child);
                                   ^
   arch/arm/plat-orion/pcie.c:390:3: error: call to undeclared function 'pci_bus_add_devices'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   pci_bus_add_devices(bus);
                   ^
   7 errors generated.


vim +/pci_common_swizzle +325 arch/arm/plat-orion/pcie.c

   289	
   290	static void orion_pcie_init_hw(struct device *parent, struct hw_pci *hw,
   291				    struct list_head *head)
   292	{
   293		struct pci_sys_data *sys = NULL;
   294		int ret;
   295		int nr, busnr;
   296	
   297		for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
   298			struct pci_host_bridge *bridge;
   299	
   300			bridge = pci_alloc_host_bridge(sizeof(struct pci_sys_data));
   301			if (WARN(!bridge, "PCI: unable to allocate bridge!"))
   302				break;
   303	
   304			sys = pci_host_bridge_priv(bridge);
   305	
   306			sys->busnr   = busnr;
   307			sys->swizzle = hw->swizzle;
   308			sys->map_irq = hw->map_irq;
   309			INIT_LIST_HEAD(&sys->resources);
   310	
   311			if (hw->private_data)
   312				sys->private_data = hw->private_data[nr];
   313	
   314			ret = hw->setup(nr, sys);
   315	
   316			if (ret > 0) {
   317	
   318				ret = pcibios_init_resource(nr, sys);
   319				if (ret)  {
   320					pci_free_host_bridge(bridge);
   321					break;
   322				}
   323	
   324				bridge->map_irq = sys->map_irq;
 > 325				bridge->swizzle_irq = pci_common_swizzle;
   326	
   327				if (hw->scan)
   328					ret = hw->scan(nr, bridge);
   329				else {
   330					list_splice_init(&sys->resources,
   331							 &bridge->windows);
   332					bridge->dev.parent = parent;
   333					bridge->sysdata = sys;
   334					bridge->busnr = sys->busnr;
   335					bridge->ops = hw->ops;
   336	
   337					ret = pci_scan_root_bus_bridge(bridge);
   338				}
   339	
   340				if (WARN(ret < 0, "PCI: unable to scan bus!")) {
   341					pci_free_host_bridge(bridge);
   342					break;
   343				}
   344	
   345				sys->bus = bridge->bus;
   346	
   347				busnr = sys->bus->busn_res.end + 1;
   348	
   349				list_add(&sys->node, head);
   350			} else {
   351				pci_free_host_bridge(bridge);
   352				if (ret < 0)
   353					break;
   354			}
   355		}
   356	}
   357	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
