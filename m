Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4420B57F751
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiGXW2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:28:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D9C101D9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658701713; x=1690237713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JHYSUCSXHO4emwsRBKjCjkEyNlnDkDmGolsQUXxazM8=;
  b=QJn8kLrp5YPllnJpCmgregLPawH+lFzu+5K/ojDczvJBKrZKpt5/n6UU
   m4wgjwRK5U8bm9pvcmdxnfd3bMOJQWD8KCoKv+XUMRt+ug9KqzGu3j19n
   uvvAVrcAjwAtYSfU1cWwCApKA0m1lVyRcKIFlQsTPfl3tQIbxvwSBF++W
   r/GxQLO/UQ9v1Ax9/YECxuooXrE+GJoaZ9yHu7eGZWwlVzje1faYUYqFt
   h3U/rsUPdWNd2rSOoKoJ6sE4Q24zdjCAFrtbVqmSEY9KJ8ATmtw9+coGB
   tfAAILdTcFscahGeFNPCcRZwjfa6xY9W/DPd5DHkFL0idH9b/BfSl1DQh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288758641"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="288758641"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 15:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="627213712"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Jul 2022 15:28:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFk5P-0004Lh-0B;
        Sun, 24 Jul 2022 22:28:31 +0000
Date:   Mon, 25 Jul 2022 06:27:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arnd-playground:orion-pci-cleanup 4/5]
 arch/arm/mach-orion5x/pci.c:537:10: warning: variable 'ret' is uninitialized
 when used here
Message-ID: <202207250651.oVxG50vj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git orion-pci-cleanup
head:   f154fdd063e0f8e231dbe3c06b03fbb1ec0ffb8c
commit: a6ab62c0b851be42f112f08681f361157dd7466b [4/5] ARM: orion5x: split up PCI/PCIe driver in two
config: arm-mvebu_v5_defconfig (https://download.01.org/0day-ci/archive/20220725/202207250651.oVxG50vj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0c1b32717bcffcf8edf95294e98933bd4c1e76ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=a6ab62c0b851be42f112f08681f361157dd7466b
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground orion-pci-cleanup
        git checkout a6ab62c0b851be42f112f08681f361157dd7466b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-orion5x/pci.c:537:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                   return ret;
                          ^~~
   arch/arm/mach-orion5x/pci.c:495:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +/ret +537 arch/arm/mach-orion5x/pci.c

   489	
   490	int __init orion5x_pci_init(int (*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin))
   491	{
   492		struct pci_host_bridge *bridge;
   493		struct orion5x_pci_sys_data *sys;
   494		int nr = 1;
   495		int ret;
   496	
   497		pci_add_flags(PCI_REASSIGN_ALL_BUS);
   498	
   499		bridge = pci_alloc_host_bridge(sizeof(struct orion5x_pci_sys_data));
   500		if (!bridge) {
   501			pr_err("PCI: unable to allocate bridge!");
   502			return -ENOMEM;
   503		}
   504	
   505		sys = pci_host_bridge_priv(bridge);
   506	
   507		bridge->ops = &pci_ops;
   508		bridge->map_irq = map_irq;
   509		bridge->swizzle_irq = pci_common_swizzle;
   510	
   511		orion5x_pci_set_bus_nr(bridge->busnr);
   512	
   513		/*
   514		 * Point PCI unit MBUS decode windows to DRAM space.
   515		 */
   516		orion5x_setup_pci_wins();
   517	
   518		/*
   519		 * Master + Slave enable
   520		 */
   521		orion5x_pci_master_slave_enable();
   522	
   523		/*
   524		 * Force ordering
   525		 */
   526		orion5x_setbits(PCI_CMD, PCI_CMD_HOST_REORDER);
   527	
   528		/*
   529		 * IORESOURCE_MEM
   530		 */
   531		sys->mem_res.name = "PCI Memory Space";
   532		sys->mem_res.flags = IORESOURCE_MEM;
   533		sys->mem_res.start = ORION5X_PCI_MEM_PHYS_BASE;
   534		sys->mem_res.end = sys->mem_res.start + ORION5X_PCI_MEM_SIZE - 1;
   535		if (request_resource(&iomem_resource, &sys->mem_res)) {
   536			pr_err("PCI: unable to allocate I/O port region (%d)\n", ret);
 > 537			return ret;
   538		}
   539		pci_add_resource(&bridge->windows, &sys->mem_res);
   540	
   541		/*
   542		 * IORESOURCE_IO
   543		 */
   544		sys->io_res.start = (nr * SZ_64K) ?  : pcibios_min_io;
   545		sys->io_res.end = (nr + 1) * SZ_64K - 1;
   546		sys->io_res.flags = IORESOURCE_IO;
   547		sys->io_res.name = "PCI I/O";
   548		ret = request_resource(&ioport_resource, &sys->io_res);
   549		if (ret) {
   550			pr_err("PCI: unable to allocate I/O port region (%d)\n", ret);
   551			return ret;
   552		}
   553		pci_remap_iospace(&sys->io_res, ORION5X_PCI_IO_PHYS_BASE);
   554		pci_add_resource(&bridge->windows, &sys->io_res);
   555	
   556		ret = pci_host_probe(bridge);
   557	
   558		if (WARN(ret < 0, "PCI: unable to scan bus!"))
   559			pci_free_host_bridge(bridge);
   560	
   561		return ret;
   562	}
   563	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
