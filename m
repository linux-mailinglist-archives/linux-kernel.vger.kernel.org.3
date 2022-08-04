Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE9589795
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiHDF4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHDF4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:56:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1E61101
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659592601; x=1691128601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WuiSEBophrQc/ISXHMcTf+eN27iJ0Puc1lcpkCjfnUg=;
  b=BIvVzUJ6r+9onvr0HKHj2Y5xXgkXgxFDc82vasVCRJKNFP2cOH+MF2J4
   L/U63obemGwqUnigikcyUXMfJ0rEeVdtjSUcEYKn+vFMNaUWduCQgYhTK
   nuVpeL7L+TeOmMiRDH2ggW80lIjrShwakQ2mKAYk8ffxa8Ljs1SaIQheD
   MY51XJckL720hSDLFQ5klK7Qzg4ZAAo26ko7FAuj1YHgwVn/3dlI8G0aj
   XcqMEjzjiVHIloUYQ3chf0m9SkwwZHBVmiCmrIqtnZB3ykff/YJyk7OPh
   ewqYeSYzTqmtbdD/p9efFECw6vFeFXDlQtWyNijAtOVKIt/M1493XmYU8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="287408532"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="287408532"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="848839307"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2022 22:56:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJTqZ-000I4h-2y;
        Thu, 04 Aug 2022 05:56:39 +0000
Date:   Thu, 4 Aug 2022 13:56:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:clearfog 8/9] drivers/pci/pcie/portdrv_core.c:330
 pcie_port_device_register() warn: inconsistent indenting
Message-ID: <202208041347.FHCjyytU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm clearfog
head:   6df556f02478218e0aae7757ef1a7025569464d8
commit: 006166c0b29e4fde042ada6c2608ae4b41c1e9dc [8/9] mvebu/clearfog pcie updates
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220804/202208041347.FHCjyytU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/pci/pcie/portdrv_core.c:330 pcie_port_device_register() warn: inconsistent indenting

Old smatch warnings:
drivers/pci/pcie/portdrv_core.c:343 pcie_port_device_register() warn: inconsistent indenting

vim +330 drivers/pci/pcie/portdrv_core.c

   310	
   311	/**
   312	 * pcie_port_device_register - register PCI Express port
   313	 * @dev: PCI Express port to register
   314	 *
   315	 * Allocate the port extension structure and register services associated with
   316	 * the port.
   317	 */
   318	int pcie_port_device_register(struct pci_dev *dev)
   319	{
   320		int status, capabilities, i, nr_service;
   321		int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
   322	
   323		/* Enable PCI Express port device */
   324		status = pci_enable_device(dev);
   325		if (status)
   326			return status;
   327	
   328		/* Get and check PCI Express port services */
   329		capabilities = get_port_device_capability(dev);
 > 330	dev_info(&dev->dev, "PCIe capabilities: 0x%x\n", capabilities);
   331		if (!capabilities)
   332			return 0;
   333	
   334		pci_set_master(dev);
   335		/*
   336		 * Initialize service irqs. Don't use service devices that
   337		 * require interrupts if there is no way to generate them.
   338		 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
   339		 * that can be used in the absence of irqs.  Allow them to determine
   340		 * if that is to be used.
   341		 */
   342		status = pcie_init_service_irqs(dev, irqs, capabilities);
   343	dev_info(&dev->dev, "init_service_irqs: %d\n", status);
   344		if (status) {
   345			capabilities &= PCIE_PORT_SERVICE_HP;
   346			if (!capabilities)
   347				goto error_disable;
   348		}
   349	
   350		/* Allocate child services if any */
   351		status = -ENODEV;
   352		nr_service = 0;
   353		for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
   354			int service = 1 << i;
   355			if (!(capabilities & service))
   356				continue;
   357			if (!pcie_device_init(dev, service, irqs[i]))
   358				nr_service++;
   359		}
   360		if (!nr_service)
   361			goto error_cleanup_irqs;
   362	
   363		return 0;
   364	
   365	error_cleanup_irqs:
   366		pci_free_irq_vectors(dev);
   367	error_disable:
   368		pci_disable_device(dev);
   369		return status;
   370	}
   371	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
