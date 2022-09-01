Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6525AA2AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiIAWOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiIAWOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:14:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9ECDF9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662070443; x=1693606443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LpPyp6BfRy58FmkvY7Nxfga8i6Jk/8JmjLUbUJvocEY=;
  b=Dv5rc/MSORC4eHKpckzV68AyYh6VkHteLkuNkHN1r8KfYpk/rDFuCyrK
   pHgXOIJ2ymBdvDrUJDLjozQdBxxGbBW2nftwZR2DrrVv/43jXSMb4wnW0
   zmBkrA7ChKZeXAByMtM+2tO9EXpY90KPsza7FfOShNHZUgTYs11sTkAtl
   CoxcmZy3vFHhGPtQc5Q4SJltlB/kdJ0s6P8l0oqDUK7GZr2MwWStmYN+K
   dWws1ZX79o7NHFG172AJyQo5LcpsuvfuvUmFIdRy48W2/qIWJCVw1zUAh
   8aWvN87tVjUl96IjRgk6UYkdZH1G64VuuRQW6j2xm8089vAkywI6Cm+AP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275585425"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="275585425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 15:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="941038277"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2022 15:14:01 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTsRl-0000pz-0h;
        Thu, 01 Sep 2022 22:14:01 +0000
Date:   Fri, 2 Sep 2022 06:13:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [char-misc:char-misc-testing 20/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
 'PCI_IRQ_ALL_TYPES' undeclared
Message-ID: <202209020641.mPiacQEP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
head:   51ea3f9e9017b47c15b37a200d8e81e36a169b70
commit: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d [20/24] misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220902/202209020641.mPiacQEP-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=3f359bf61b6f65be474fbcdf557cd412f19d0f1d
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch --no-tags char-misc char-misc-testing
        git checkout 3f359bf61b6f65be474fbcdf557cd412f19d0f1d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/misc/mchp_pci1xxxx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c: In function 'gp_aux_bus_probe':
>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error: 'PCI_IRQ_ALL_TYPES' undeclared (first use in this function)
      87 |         retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
         |                                                    ^~~~~~~~~~~~~~~~~
   drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: note: each undeclared identifier is reported only once for each function it appears in
   drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c: At top level:
>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:162:1: warning: data definition has no type or storage class
     162 | module_pci_driver(pci1xxxx_gp_driver);
         | ^~~~~~~~~~~~~~~~~
>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:162:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:162:1: warning: parameter names (without types) in function declaration
   drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:155:26: warning: 'pci1xxxx_gp_driver' defined but not used [-Wunused-variable]
     155 | static struct pci_driver pci1xxxx_gp_driver = {
         |                          ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/PCI_IRQ_ALL_TYPES +87 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c

    31	
    32	static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id)
    33	{
    34		struct aux_bus_device *aux_bus;
    35		int retval;
    36	
    37		retval = pcim_enable_device(pdev);
    38		if (retval)
    39			return retval;
    40	
    41		aux_bus = kzalloc(sizeof(*aux_bus), GFP_KERNEL);
    42		if (!aux_bus)
    43			return -ENOMEM;
    44	
    45		aux_bus->aux_device_wrapper[0] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[0]),
    46							 GFP_KERNEL);
    47		if (!aux_bus->aux_device_wrapper[0])
    48			return -ENOMEM;
    49	
    50		retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
    51		if (retval < 0)
    52			goto err_ida_alloc_0;
    53	
    54		aux_bus->aux_device_wrapper[0]->aux_dev.name = aux_dev_otp_e2p_name;
    55		aux_bus->aux_device_wrapper[0]->aux_dev.dev.parent = &pdev->dev;
    56		aux_bus->aux_device_wrapper[0]->aux_dev.dev.release = gp_auxiliary_device_release;
    57		aux_bus->aux_device_wrapper[0]->aux_dev.id = retval;
    58	
    59		aux_bus->aux_device_wrapper[0]->gp_aux_data.region_start = pci_resource_start(pdev, 0);
    60		aux_bus->aux_device_wrapper[0]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
    61	
    62		retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[0]->aux_dev);
    63		if (retval < 0)
    64			goto err_aux_dev_init_0;
    65	
    66		retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[0]->aux_dev);
    67		if (retval)
    68			goto err_aux_dev_add_0;
    69	
    70		aux_bus->aux_device_wrapper[1] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[1]),
    71							 GFP_KERNEL);
    72		if (!aux_bus->aux_device_wrapper[1])
    73			return -ENOMEM;
    74	
    75		retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
    76		if (retval < 0)
    77			goto err_ida_alloc_1;
    78	
    79		aux_bus->aux_device_wrapper[1]->aux_dev.name = aux_dev_gpio_name;
    80		aux_bus->aux_device_wrapper[1]->aux_dev.dev.parent = &pdev->dev;
    81		aux_bus->aux_device_wrapper[1]->aux_dev.dev.release = gp_auxiliary_device_release;
    82		aux_bus->aux_device_wrapper[1]->aux_dev.id = retval;
    83	
    84		aux_bus->aux_device_wrapper[1]->gp_aux_data.region_start = pci_resource_start(pdev, 0);
    85		aux_bus->aux_device_wrapper[1]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
    86	
  > 87		retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
    88	
    89		if (retval < 0)
    90			return retval;
    91	
    92		pdev->irq = pci_irq_vector(pdev, 0);
    93		if (pdev->irq < 0)
    94			return retval;
    95	
    96		aux_bus->aux_device_wrapper[1]->gp_aux_data.irq_num = pdev->irq;
    97	
    98		retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[1]->aux_dev);
    99		if (retval < 0)
   100			goto err_aux_dev_init_1;
   101	
   102		retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[1]->aux_dev);
   103		if (retval)
   104			goto err_aux_dev_add_1;
   105	
   106		pci_set_drvdata(pdev, aux_bus);
   107		pci_set_master(pdev);
   108	
   109		return 0;
   110	
   111	err_aux_dev_add_1:
   112		auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
   113	
   114	err_aux_dev_init_1:
   115		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
   116	
   117	err_ida_alloc_1:
   118		kfree(aux_bus->aux_device_wrapper[1]);
   119	
   120	err_aux_dev_add_0:
   121		auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
   122	
   123	err_aux_dev_init_0:
   124		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[0]->aux_dev.id);
   125	
   126	err_ida_alloc_0:
   127		kfree(aux_bus->aux_device_wrapper[0]);
   128	
   129		return retval;
   130	}
   131	
   132	static void gp_aux_bus_remove(struct pci_dev *pdev)
   133	{
   134		struct aux_bus_device *aux_bus = pci_get_drvdata(pdev);
   135	
   136		auxiliary_device_delete(&aux_bus->aux_device_wrapper[0]->aux_dev);
   137		auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
   138		auxiliary_device_delete(&aux_bus->aux_device_wrapper[1]->aux_dev);
   139		auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
   140		kfree(aux_bus);
   141		pci_disable_device(pdev);
   142	}
   143	
   144	static const struct pci_device_id pci1xxxx_tbl[] = {
   145		{ PCI_DEVICE(0x1055, 0xA005) },
   146		{ PCI_DEVICE(0x1055, 0xA015) },
   147		{ PCI_DEVICE(0x1055, 0xA025) },
   148		{ PCI_DEVICE(0x1055, 0xA035) },
   149		{ PCI_DEVICE(0x1055, 0xA045) },
   150		{ PCI_DEVICE(0x1055, 0xA055) },
   151		{0,}
   152	};
   153	MODULE_DEVICE_TABLE(pci, pci1xxxx_tbl);
   154	
   155	static struct pci_driver pci1xxxx_gp_driver = {
   156		.name = "PCI1xxxxGP",
   157		.id_table = pci1xxxx_tbl,
   158		.probe = gp_aux_bus_probe,
   159		.remove = gp_aux_bus_remove,
   160	};
   161	
 > 162	module_pci_driver(pci1xxxx_gp_driver);
   163	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
