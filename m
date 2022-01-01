Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB78E482764
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 12:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiAALFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 06:05:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:2290 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbiAALFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 06:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641035139; x=1672571139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TvkQ7v8u8dl4awdM71zwvB6ZagqGpjzsOsdxxfMsb+g=;
  b=YC4y/n2BL+yooOemssWVJte/CAQ1bEdKqbKC//eelTA0aP5qo2VoZvuv
   lXyD2we3neUNDCmKzGVaGEqrqCw265gFCwj4xePvjRLONyoXKk67Z3mlV
   zl0wozIwyTol/6aVfLVypwAelwsZ3z3b+qegtQXVBaU0wLOlA3lVWG3z+
   nTft9SDabIp7SmI22DkvgpdYShMf6idy7gA7wTR2TODq/yfbPLZf2vKFz
   DA2s0gAEc14EHvaBuegVqECurYldc0k+EDLJBoNJ/D69yRk861QKHRafB
   iKktlVWZ+6bsN41jBxDq/pkzKIxptwcQh9SnrXq+tTRlBOkoaqn3TC/M1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="241840978"
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="241840978"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 03:05:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="687680692"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jan 2022 03:05:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3cCe-000CNj-Vn; Sat, 01 Jan 2022 11:05:36 +0000
Date:   Sat, 1 Jan 2022 19:04:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: drivers/pci/controller/dwc/pcie-hisi.c:61:37: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202201011832.Ed6K2waY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 6e5a1fff9096ecd259dedcbbdc812aa90986a40e PCI: Avoid building empty drivers
date:   10 months ago
config: alpha-randconfig-s032-20211117 (https://download.01.org/0day-ci/archive/20220101/202201011832.Ed6K2waY-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/dma/ drivers/pci/controller/dwc/ sound/soc/mediatek/common/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-hisi.c:61:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *reg_base @@     got void *priv @@
   drivers/pci/controller/dwc/pcie-hisi.c:61:37: sparse:     expected void [noderef] __iomem *reg_base
   drivers/pci/controller/dwc/pcie-hisi.c:61:37: sparse:     got void *priv
>> drivers/pci/controller/dwc/pcie-hisi.c:132:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem *[assigned] reg_base @@
   drivers/pci/controller/dwc/pcie-hisi.c:132:19: sparse:     expected void *priv
   drivers/pci/controller/dwc/pcie-hisi.c:132:19: sparse:     got void [noderef] __iomem *[assigned] reg_base

vim +61 drivers/pci/controller/dwc/pcie-hisi.c

5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   56  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   57  static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   58  				       int where)
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   59  {
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   60  	struct pci_config_window *cfg = bus->sysdata;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  @61  	void __iomem *reg_base = cfg->priv;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   62  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   63  	if (bus->number == cfg->busr.start)
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   64  		return reg_base + where;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   65  	else
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   66  		return pci_ecam_map_bus(bus, devfn, where);
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   67  }
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   68  
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06   69  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06   70  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   71  static int hisi_pcie_init(struct pci_config_window *cfg)
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   72  {
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   73  	struct device *dev = cfg->parent;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   74  	struct acpi_device *adev = to_acpi_device(dev);
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   75  	struct acpi_pci_root *root = acpi_driver_data(adev);
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   76  	struct resource *res;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   77  	void __iomem *reg_base;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   78  	int ret;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   79  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   80  	/*
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   81  	 * Retrieve RC base and size from a HISI0081 device with _UID
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   82  	 * matching our segment.
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   83  	 */
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   84  	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   85  	if (!res)
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   86  		return -ENOMEM;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   87  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   88  	ret = acpi_get_rc_resources(dev, "HISI0081", root->segment, res);
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   89  	if (ret) {
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   90  		dev_err(dev, "can't get rc base address\n");
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   91  		return -ENOMEM;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   92  	}
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   93  
e313a447e73527 drivers/pci/dwc/pcie-hisi.c            Lorenzo Pieralisi 2017-04-19   94  	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   95  	if (!reg_base)
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   96  		return -ENOMEM;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   97  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   98  	cfg->priv = reg_base;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01   99  	return 0;
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  100  }
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  101  
0b104773b4f72c drivers/pci/controller/dwc/pcie-hisi.c Rob Herring       2020-04-09  102  const struct pci_ecam_ops hisi_pcie_ops = {
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  103  	.init         =  hisi_pcie_init,
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  104  	.pci_ops      = {
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  105  		.map_bus    = hisi_pcie_map_bus,
4788316f743539 drivers/pci/host/pcie-hisi.c           Bjorn Helgaas     2017-02-07  106  		.read       = hisi_pcie_rd_conf,
4788316f743539 drivers/pci/host/pcie-hisi.c           Bjorn Helgaas     2017-02-07  107  		.write      = hisi_pcie_wr_conf,
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  108  	}
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  109  };
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  110  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  111  #endif
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  112  
5f00f1a0178cf5 drivers/pci/host/pcie-hisi.c           Dongdong Liu      2016-12-01  113  #ifdef CONFIG_PCI_HISI
500a1d9a43e0a1 drivers/pci/host/pcie-hisi.c           Zhou Wang         2015-10-29  114  
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  115  static int hisi_pcie_platform_init(struct pci_config_window *cfg)
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  116  {
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  117  	struct device *dev = cfg->parent;
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  118  	struct platform_device *pdev = to_platform_device(dev);
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  119  	struct resource *res;
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  120  	void __iomem *reg_base;
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  121  
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  122  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  123  	if (!res) {
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  124  		dev_err(dev, "missing \"reg[1]\"property\n");
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  125  		return -EINVAL;
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  126  	}
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  127  
e313a447e73527 drivers/pci/dwc/pcie-hisi.c            Lorenzo Pieralisi 2017-04-19  128  	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  129  	if (!reg_base)
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  130  		return -ENOMEM;
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  131  
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06 @132  	cfg->priv = reg_base;
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  133  	return 0;
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  134  }
a2ec1996098c7d drivers/pci/host/pcie-hisi.c           Dongdong Liu      2017-02-06  135  

:::::: The code at line 61 was first introduced by commit
:::::: 5f00f1a0178cf52928366a5e1f376a65f1f3f389 PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers

:::::: TO: Dongdong Liu <liudongdong3@huawei.com>
:::::: CC: Bjorn Helgaas <helgaas@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
