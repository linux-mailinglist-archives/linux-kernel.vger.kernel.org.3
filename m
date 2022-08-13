Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F32591C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiHMRpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiHMRpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:45:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38113D05
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660412729; x=1691948729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Nh+AnE2qRV5UnAKe5amktrZRR0ZY7R18AxFrvnSl95o=;
  b=ZYTrirnf7bSveJV68+/uU7gLTJqzXFiSgdRp+Yxmg+0o6267393YmsWy
   XgB8pwMZ1l6ZlZZrMxbo5xA0m9qUgGGhQKXcFzuf4AvUiGhQNMJ4mHiBx
   jWTWlukp24CKgtReRZXQJZ8VrG1KZE8rUBBiuVttfTLvDh0Y7mGIvv2f2
   Ee04XkNWVDWzqLNxJgHxCsSdlQJYD5jJvHBtR9OkcCC/LhWrDc1GxsARB
   +NzdADxIm9v79peNh4Dv+y2eFMlChfUw0rUmsTcG0TfjppjWg2zrwE3tl
   Ats7s5yD82Rtip+CjY41jnNfbK+yMhdU5pd3vP0IRTI+fXQxfuXenww5E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291766989"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="291766989"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="639217951"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Aug 2022 10:45:26 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMvCP-0001vo-2d;
        Sat, 13 Aug 2022 17:45:25 +0000
Date:   Sun, 14 Aug 2022 01:44:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 94/110]
 arch/powerpc/sysdev/fsl_pci.c:601:39: error: 'PCI_CLASS_BRIDGE_PCI_NORMAL'
 undeclared; did you mean 'PCI_CLASS_BRIDGE_PCI'?
Message-ID: <202208140113.RTpvz6BG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   5a4012ec04fef4dc71b490c78915c450959acd80
commit: 512260c03318cdfc789b3b09faba2df60802d713 [94/110] powerpc/fsl-pci: Fix Class Code of PCIe Root Port
config: powerpc-buildonly-randconfig-r002-20220812 (https://download.01.org/0day-ci/archive/20220814/202208140113.RTpvz6BG-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/512260c03318cdfc789b3b09faba2df60802d713
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 512260c03318cdfc789b3b09faba2df60802d713
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/sysdev/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_add_bridge':
>> arch/powerpc/sysdev/fsl_pci.c:601:39: error: 'PCI_CLASS_BRIDGE_PCI_NORMAL' undeclared (first use in this function); did you mean 'PCI_CLASS_BRIDGE_PCI'?
     601 |                         class_code |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                       PCI_CLASS_BRIDGE_PCI
   arch/powerpc/sysdev/fsl_pci.c:601:39: note: each undeclared identifier is reported only once for each function it appears in


vim +601 arch/powerpc/sysdev/fsl_pci.c

   515	
   516	int fsl_add_bridge(struct platform_device *pdev, int is_primary)
   517	{
   518		int len;
   519		struct pci_controller *hose;
   520		struct resource rsrc;
   521		const int *bus_range;
   522		u8 hdr_type, progif;
   523		u32 class_code;
   524		struct device_node *dev;
   525		struct ccsr_pci __iomem *pci;
   526		u16 temp;
   527		u32 svr = mfspr(SPRN_SVR);
   528	
   529		dev = pdev->dev.of_node;
   530	
   531		if (!of_device_is_available(dev)) {
   532			pr_warn("%pOF: disabled\n", dev);
   533			return -ENODEV;
   534		}
   535	
   536		pr_debug("Adding PCI host bridge %pOF\n", dev);
   537	
   538		/* Fetch host bridge registers address */
   539		if (of_address_to_resource(dev, 0, &rsrc)) {
   540			printk(KERN_WARNING "Can't get pci register base!");
   541			return -ENOMEM;
   542		}
   543	
   544		/* Get bus range if any */
   545		bus_range = of_get_property(dev, "bus-range", &len);
   546		if (bus_range == NULL || len < 2 * sizeof(int))
   547			printk(KERN_WARNING "Can't get bus-range for %pOF, assume"
   548				" bus 0\n", dev);
   549	
   550		pci_add_flags(PCI_REASSIGN_ALL_BUS);
   551		hose = pcibios_alloc_controller(dev);
   552		if (!hose)
   553			return -ENOMEM;
   554	
   555		/* set platform device as the parent */
   556		hose->parent = &pdev->dev;
   557		hose->first_busno = bus_range ? bus_range[0] : 0x0;
   558		hose->last_busno = bus_range ? bus_range[1] : 0xff;
   559	
   560		pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
   561			 (u64)rsrc.start, (u64)resource_size(&rsrc));
   562	
   563		pci = hose->private_data = ioremap(rsrc.start, resource_size(&rsrc));
   564		if (!hose->private_data)
   565			goto no_bridge;
   566	
   567		setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
   568				   PPC_INDIRECT_TYPE_BIG_ENDIAN);
   569	
   570		if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
   571			hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
   572	
   573		if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
   574			/* use fsl_indirect_read_config for PCIe */
   575			hose->ops = &fsl_indirect_pcie_ops;
   576			/* For PCIE read HEADER_TYPE to identify controller mode */
   577			early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
   578			if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
   579				goto no_bridge;
   580	
   581		} else {
   582			/* For PCI read PROG to identify controller mode */
   583			early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
   584			if ((progif & 1) &&
   585			    !of_property_read_bool(dev, "fsl,pci-agent-force-enum"))
   586				goto no_bridge;
   587		}
   588	
   589		setup_pci_cmd(hose);
   590	
   591		/* check PCI express link status */
   592		if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
   593			hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
   594				PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
   595			if (fsl_pcie_check_link(hose))
   596				hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
   597			/* Fix Class Code to PCI_CLASS_BRIDGE_PCI_NORMAL for pre-3.0 controller */
   598			if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0) {
   599				early_read_config_dword(hose, 0, 0, PCIE_FSL_CSR_CLASSCODE, &class_code);
   600				class_code &= 0xff;
 > 601				class_code |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
   602				early_write_config_dword(hose, 0, 0, PCIE_FSL_CSR_CLASSCODE, class_code);
   603			}
   604		} else {
   605			/*
   606			 * Set PBFR(PCI Bus Function Register)[10] = 1 to
   607			 * disable the combining of crossing cacheline
   608			 * boundary requests into one burst transaction.
   609			 * PCI-X operation is not affected.
   610			 * Fix erratum PCI 5 on MPC8548
   611			 */
   612	#define PCI_BUS_FUNCTION 0x44
   613	#define PCI_BUS_FUNCTION_MDS 0x400	/* Master disable streaming */
   614			if (((SVR_SOC_VER(svr) == SVR_8543) ||
   615			     (SVR_SOC_VER(svr) == SVR_8545) ||
   616			     (SVR_SOC_VER(svr) == SVR_8547) ||
   617			     (SVR_SOC_VER(svr) == SVR_8548)) &&
   618			    !early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX)) {
   619				early_read_config_word(hose, 0, 0,
   620						PCI_BUS_FUNCTION, &temp);
   621				temp |= PCI_BUS_FUNCTION_MDS;
   622				early_write_config_word(hose, 0, 0,
   623						PCI_BUS_FUNCTION, temp);
   624			}
   625		}
   626	
   627		printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
   628			"Firmware bus number: %d->%d\n",
   629			(unsigned long long)rsrc.start, hose->first_busno,
   630			hose->last_busno);
   631	
   632		pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
   633			hose, hose->cfg_addr, hose->cfg_data);
   634	
   635		/* Interpret the "ranges" property */
   636		/* This also maps the I/O region and sets isa_io/mem_base */
   637		pci_process_bridge_OF_ranges(hose, dev, is_primary);
   638	
   639		/* Setup PEX window registers */
   640		setup_pci_atmu(hose);
   641	
   642		/* Set up controller operations */
   643		setup_swiotlb_ops(hose);
   644	
   645		return 0;
   646	
   647	no_bridge:
   648		iounmap(hose->private_data);
   649		/* unmap cfg_data & cfg_addr separately if not on same page */
   650		if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
   651		    ((unsigned long)hose->cfg_addr & PAGE_MASK))
   652			iounmap(hose->cfg_data);
   653		iounmap(hose->cfg_addr);
   654		pcibios_free_controller(hose);
   655		return -ENODEV;
   656	}
   657	#endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
   658	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
