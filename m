Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5278150A108
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386588AbiDUNqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347188AbiDUNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:46:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2120F36E37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650548598; x=1682084598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v51gmnQnKce+T95j2M1BTL26N2GdLjz9XKnRt5FsbHk=;
  b=DOw/eLDALIsLz5RhqiV1fwbGvnoa7Ku6E6tDWw7OQnr+SD6w1Lisegd2
   B6frgFFy5XdenRF3Cg1e1PyiZkTxFlnK2W6JzbKNLVg1+f/PIzroKrByr
   WhmVeLIGbtWjIthH94EIRoOxUK0cIENlvW2Aw23sRqLT3bEI1TwfLFlgo
   txZztWMFhZzf9Qt7f4wo0bHtOj+nAscSDRELU2SOgxXElfw3iav/EZ+ib
   XGYi8p507yGMzgVDOtwJQhqbO3hrLYOMccSdv+nkhVQnIGn4MYZ1GC0DV
   nnDJhJHbYeDvECh+EOq9WWpyTApdbKNX3YYZIBlsCHpRkhQI26DNeAyja
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263819427"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263819427"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="614901418"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 06:43:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhX5X-0008RV-OP;
        Thu, 21 Apr 2022 13:43:15 +0000
Date:   Thu, 21 Apr 2022 21:43:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2326/2579] arch/x86/pci/bus_numa.c:24:5:
 warning: no previous prototype for 'x86_pci_root_bus_node'
Message-ID: <202204212112.Aee3HDbH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 4701dddeded9a472bd4d8de9719e12c3b9cdb1f0 [2326/2579] headers/deps: pci: Optimize <linux/pci.h> dependencies, remove <linux/topology.h> inclusion
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204212112.Aee3HDbH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4701dddeded9a472bd4d8de9719e12c3b9cdb1f0
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4701dddeded9a472bd4d8de9719e12c3b9cdb1f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
