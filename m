Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B40D4C213A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiBXBko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiBXBkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:40:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482171662F5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645666814; x=1677202814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TOq3r4d36+yHjI0glcZliDep/S4dBcUEe7i8DsSVlf4=;
  b=B3vV7SPjZQN/oToHgGG+rHBYC75kJgXFYmt5wUQNjdnchlOnNDT//rsL
   BhYvrCPgaTkap9GvVEcaxNUTxcY1yYekOUGD0VZBqQcXTL+/SHzT/9sq6
   Kvgih0AetBPPsoqALyuv3IlphVaZvnlP0OxXYvgCLmvaDD1lx7idpfJfB
   A5ZR17Ku9cSxyOIYu1eeiGIGTeZ/ymycxTv8lP3S7NxWmJSGSbFuFKYNw
   Ohjt1LjohjiCbSFwSRtHwNGgMrNqcWg1GaGL3lhQ30WjbwbM8YqLRLLqt
   QK/wMC68jCav7WNgJO4CgTA8JGgbD/BBwtsuwA7J+g5A9tHhixhV7o6y6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="338560438"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="338560438"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:17:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="532922454"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 17:17:54 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN2lW-00023f-Aj; Thu, 24 Feb 2022 01:17:54 +0000
Date:   Thu, 24 Feb 2022 09:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2170/2340] arch/x86/pci/bus_numa.c:24:5:
 warning: no previous prototype for 'x86_pci_root_bus_node'
Message-ID: <202202240933.QRPHsCZw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: d1464f1f51594b5388839a7fd0f4701ff84c3092 [2170/2340] headers/deps: pci: Optimize <linux/pci.h> dependencies, remove <linux/topology.h> inclusion
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220224/202202240933.QRPHsCZw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=d1464f1f51594b5388839a7fd0f4701ff84c3092
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout d1464f1f51594b5388839a7fd0f4701ff84c3092
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/pci/bus_numa.c:24:5: warning: no previous prototype for 'x86_pci_root_bus_node' [-Wmissing-prototypes]
      24 | int x86_pci_root_bus_node(int bus)
         |     ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/pci/bus_numa.c:34:6: warning: no previous prototype for 'x86_pci_root_bus_resources' [-Wmissing-prototypes]
      34 | void x86_pci_root_bus_resources(int bus, struct list_head *resources)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/x86_pci_root_bus_node +24 arch/x86/pci/bus_numa.c

67f241f4579651 Yinghai Lu    2009-11-11  23  
afcf21c2beca66 Bjorn Helgaas 2014-01-24 @24  int x86_pci_root_bus_node(int bus)
afcf21c2beca66 Bjorn Helgaas 2014-01-24  25  {
afcf21c2beca66 Bjorn Helgaas 2014-01-24  26  	struct pci_root_info *info = x86_find_pci_root_info(bus);
afcf21c2beca66 Bjorn Helgaas 2014-01-24  27  
afcf21c2beca66 Bjorn Helgaas 2014-01-24  28  	if (!info)
afcf21c2beca66 Bjorn Helgaas 2014-01-24  29  		return NUMA_NO_NODE;
afcf21c2beca66 Bjorn Helgaas 2014-01-24  30  
afcf21c2beca66 Bjorn Helgaas 2014-01-24  31  	return info->node;
afcf21c2beca66 Bjorn Helgaas 2014-01-24  32  }
afcf21c2beca66 Bjorn Helgaas 2014-01-24  33  
d28e5ac2a07e27 Yinghai Lu    2012-04-02 @34  void x86_pci_root_bus_resources(int bus, struct list_head *resources)
d28e5ac2a07e27 Yinghai Lu    2012-04-02  35  {
d28e5ac2a07e27 Yinghai Lu    2012-04-02  36  	struct pci_root_info *info = x86_find_pci_root_info(bus);
d28e5ac2a07e27 Yinghai Lu    2012-04-02  37  	struct pci_root_res *root_res;
14d76b68f2819a Jiang Liu     2015-02-05  38  	struct resource_entry *window;
a10bb128b64fe0 Yinghai Lu    2012-05-17  39  	bool found = false;
d28e5ac2a07e27 Yinghai Lu    2012-04-02  40  
d28e5ac2a07e27 Yinghai Lu    2012-04-02  41  	if (!info)
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  42  		goto default_resources;
67f241f4579651 Yinghai Lu    2009-11-11  43  
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  44  	printk(KERN_DEBUG "PCI: root bus %02x: hardware-probed resources\n",
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  45  	       bus);
67f241f4579651 Yinghai Lu    2009-11-11  46  
a10bb128b64fe0 Yinghai Lu    2012-05-17  47  	/* already added by acpi ? */
14d76b68f2819a Jiang Liu     2015-02-05  48  	resource_list_for_each_entry(window, resources)
a10bb128b64fe0 Yinghai Lu    2012-05-17  49  		if (window->res->flags & IORESOURCE_BUS) {
a10bb128b64fe0 Yinghai Lu    2012-05-17  50  			found = true;
a10bb128b64fe0 Yinghai Lu    2012-05-17  51  			break;
a10bb128b64fe0 Yinghai Lu    2012-05-17  52  		}
a10bb128b64fe0 Yinghai Lu    2012-05-17  53  
a10bb128b64fe0 Yinghai Lu    2012-05-17  54  	if (!found)
a10bb128b64fe0 Yinghai Lu    2012-05-17  55  		pci_add_resource(resources, &info->busn);
a10bb128b64fe0 Yinghai Lu    2012-05-17  56  
727ae8be30b428 Liu Jiang     2015-11-27  57  	list_for_each_entry(root_res, &info->resources, list)
727ae8be30b428 Liu Jiang     2015-11-27  58  		pci_add_resource(resources, &root_res->res);
727ae8be30b428 Liu Jiang     2015-11-27  59  
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  60  	return;
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  61  
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  62  default_resources:
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  63  	/*
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  64  	 * We don't have any host bridge aperture information from the
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  65  	 * "native host bridge drivers," e.g., amd_bus or broadcom_bus,
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  66  	 * so fall back to the defaults historically used by pci_create_bus().
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  67  	 */
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  68  	printk(KERN_DEBUG "PCI: root bus %02x: using default resources\n", bus);
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  69  	pci_add_resource(resources, &ioport_resource);
2cd6975a4ff92a Bjorn Helgaas 2011-10-28  70  	pci_add_resource(resources, &iomem_resource);
67f241f4579651 Yinghai Lu    2009-11-11  71  }
67f241f4579651 Yinghai Lu    2009-11-11  72  

:::::: The code at line 24 was first introduced by commit
:::::: afcf21c2beca6604dbdc24fed1624c2499a85e7d x86/PCI: Add x86_pci_root_bus_node() to look up NUMA node from PCI bus

:::::: TO: Bjorn Helgaas <bhelgaas@google.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
