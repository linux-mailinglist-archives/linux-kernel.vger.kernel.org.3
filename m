Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C651055A880
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiFYJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiFYJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:16:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C2AE53
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656148562; x=1687684562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RNIHWGLPCDLY+ZTXHWQcCfCWWWPpc8kvFHc5lUiP5WE=;
  b=mDraegtY/heweduJ3rsFOTz/+bh2StcS1V1VINdXbZsorgi0dPnRoB9d
   hj0BGSgddu9LmsEYVi5+2tc/s9rPFp7fzf/DTs7esH+Ox/ccV1RQ2Engf
   ZOFNLFMliYiSjOALTkIU6xUBYegZOvAwVcseg3HaUiVkw7+h/dxspZPV0
   1apWnJ0GDrGqWFQIVvea4sUPCaa/mJluw9l+OqVMdak0R73HgExmKebf+
   EWzpXwqAXz+uf+IMwIJ3cJ0aQEKQLNxxO2iFXCXpI1jNpVnlXKH/EL3Pk
   UJ10yEoKdPBnBQOrV0zi2ewiVPLx4KRRvF8LLz0lqqJvcaXc/SRVw2Ybl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281904060"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="281904060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 02:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="716479432"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2022 02:16:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o51tY-0005ad-6Q;
        Sat, 25 Jun 2022 09:16:00 +0000
Date:   Sat, 25 Jun 2022 17:15:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:clearfog 8/9] drivers/pci/pcie/portdrv_core.c:330
 pcie_port_device_register() warn: inconsistent indenting
Message-ID: <202206251737.5U9GIY6w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm clearfog
head:   7fbb8b943f85ac20627571eb927cadfae176a4f7
commit: e86a7c1bfd62bfa0fb3c5319b651c192df44337d [8/9] mvebu/clearfog pcie updates
config: i386-randconfig-m021
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
