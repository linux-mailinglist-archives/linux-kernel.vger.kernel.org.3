Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8184756AE22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiGGWLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGGWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:11:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FE62714D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657231868; x=1688767868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aXu6A/S0/sr8kYZWnCUQdnyVbvv7DjxxJXo25bHZGtc=;
  b=Wc39Eg73GjO8yo+drR/EZCthckrIK4ozeP5XR+GY6OEP14yJU6AJ83QQ
   BWO62hjZUH5BxnrhTELw4+YjUHRc2D8ngMSREyL5EplSni2ElbtrLRKc8
   AMeqmYkMs02uoNbVmm+ot3rS2axPAHMm+J5EJPPRkYq9bd/7+XvCXWtHs
   9QAvk+PJbTv6gPsX2qGN8EySBe1weBCDIXBkA1H7BX9xx0Hn00x3jW2bD
   N+6uE+/dt8cmOP5VxYrcs/H2hQJ3AUAjLFirzdoVKIeMupBKcAEUFn67R
   kBUsKrSEsa+mLI+2TkuKd2KxLu011OE+bTh783JG1JW7bLp5fVVIxvpAo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281681218"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="281681218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 15:11:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="543977297"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2022 15:11:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9ZiE-000MWd-4B;
        Thu, 07 Jul 2022 22:11:06 +0000
Date:   Fri, 8 Jul 2022 06:10:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-hardening-filter 14/16]
 drivers/virtio/virtio_mmio.c:578:13: error: implicit declaration of function
 'cc_platform_has'
Message-ID: <202207080639.lSQmEaSK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-filter
head:   cadf5ac0e49f45fdd2a3828fa625e01ad5fb55e7
commit: 92e6731960eaf63df4626788d7d302941beaf3dd [14/16] virtio-mmio: Disable in TDX guest
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220708/202207080639.lSQmEaSK-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/92e6731960eaf63df4626788d7d302941beaf3dd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-filter
        git checkout 92e6731960eaf63df4626788d7d302941beaf3dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_mmio.c: In function 'virtio_mmio_probe':
>> drivers/virtio/virtio_mmio.c:578:13: error: implicit declaration of function 'cc_platform_has' [-Werror=implicit-function-declaration]
     578 |         if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
         |             ^~~~~~~~~~~~~~~
>> drivers/virtio/virtio_mmio.c:578:29: error: 'CC_ATTR_GUEST_DEVICE_FILTER' undeclared (first use in this function)
     578 |         if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_mmio.c:578:29: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/cc_platform_has +578 drivers/virtio/virtio_mmio.c

   571	
   572	static int virtio_mmio_probe(struct platform_device *pdev)
   573	{
   574		struct virtio_mmio_device *vm_dev;
   575		unsigned long magic;
   576		int rc;
   577	
 > 578		if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
   579			return -ENODEV;
   580	
   581		vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
   582		if (!vm_dev)
   583			return -ENOMEM;
   584	
   585		vm_dev->vdev.dev.parent = &pdev->dev;
   586		vm_dev->vdev.dev.release = virtio_mmio_release_dev;
   587		vm_dev->vdev.config = &virtio_mmio_config_ops;
   588		vm_dev->pdev = pdev;
   589		INIT_LIST_HEAD(&vm_dev->virtqueues);
   590		spin_lock_init(&vm_dev->lock);
   591	
   592		vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
   593		if (IS_ERR(vm_dev->base))
   594			return PTR_ERR(vm_dev->base);
   595	
   596		/* Check magic value */
   597		magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
   598		if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
   599			dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
   600			return -ENODEV;
   601		}
   602	
   603		/* Check device version */
   604		vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
   605		if (vm_dev->version < 1 || vm_dev->version > 2) {
   606			dev_err(&pdev->dev, "Version %ld not supported!\n",
   607					vm_dev->version);
   608			return -ENXIO;
   609		}
   610	
   611		vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
   612		if (vm_dev->vdev.id.device == 0) {
   613			/*
   614			 * virtio-mmio device with an ID 0 is a (dummy) placeholder
   615			 * with no function. End probing now with no error reported.
   616			 */
   617			return -ENODEV;
   618		}
   619		vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
   620	
   621		if (vm_dev->version == 1) {
   622			writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
   623	
   624			rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
   625			/*
   626			 * In the legacy case, ensure our coherently-allocated virtio
   627			 * ring will be at an address expressable as a 32-bit PFN.
   628			 */
   629			if (!rc)
   630				dma_set_coherent_mask(&pdev->dev,
   631						      DMA_BIT_MASK(32 + PAGE_SHIFT));
   632		} else {
   633			rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
   634		}
   635		if (rc)
   636			rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
   637		if (rc)
   638			dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
   639	
   640		platform_set_drvdata(pdev, vm_dev);
   641	
   642		rc = register_virtio_device(&vm_dev->vdev);
   643		if (rc)
   644			put_device(&vm_dev->vdev.dev);
   645	
   646		return rc;
   647	}
   648	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
