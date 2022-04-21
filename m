Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4C50A7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391150AbiDUSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391151AbiDUSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:05:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118CE4A914
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650564152; x=1682100152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J+3Xvok9xV8uEvqY9CwIS5w9GvNM7edK7Hjcq6V7x1Q=;
  b=QM23PO8rGPoEx92TdcesFvWjxnOO6jkGVcu68xy3yWAEkpC84npuKmhn
   fpQof0JX4EpDAXcakorrggSUYlwnMUPa6qZnbxEyCWDhUAtiOLvlxFTbt
   Y98G+0rrM0EmUPrObz3SGgGWEYclnVPTdjPa/CJP2LVswc1IcbwyhK1/L
   +0kKlHSEGXx/lUhtL5KERGN8EC5gG96BPa+xCPROyQgvcS52IWJt9oWAE
   kD0CWA1U5yMkYjeJs7+HYirdlL7hWh+loP/Xkw9Xze7byWTbmfGQZe5bz
   4AbJXw4RPMZ+YxLtzPEJP+yBeT/y7e31hYvKOv/QiD+7ZMSXg1q1BsHQH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="251754377"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="251754377"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 11:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="658641083"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2022 11:02:30 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhb8P-0008e0-M4;
        Thu, 21 Apr 2022 18:02:29 +0000
Date:   Fri, 22 Apr 2022 02:02:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-hardening 3/13]
 drivers/virtio/virtio_mmio.c:565:13: error: implicit declaration of function
 'cc_platform_has'
Message-ID: <202204220127.lTGaGifK-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git guest-hardening
head:   121e66762efef210f0bbd57d767c22301ff0878e
commit: 3377879e3b9e6535e58030a0d0c9068812664416 [3/13] virtio-mmio: Disable in TDX guest
config: mips-buildonly-randconfig-r003-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220127.lTGaGifK-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/3377879e3b9e6535e58030a0d0c9068812664416
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening
        git checkout 3377879e3b9e6535e58030a0d0c9068812664416
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_mmio.c: In function 'virtio_mmio_probe':
>> drivers/virtio/virtio_mmio.c:565:13: error: implicit declaration of function 'cc_platform_has' [-Werror=implicit-function-declaration]
     565 |         if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
         |             ^~~~~~~~~~~~~~~
>> drivers/virtio/virtio_mmio.c:565:29: error: 'CC_ATTR_GUEST_DEVICE_FILTER' undeclared (first use in this function)
     565 |         if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_mmio.c:565:29: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/cc_platform_has +565 drivers/virtio/virtio_mmio.c

   558	
   559	static int virtio_mmio_probe(struct platform_device *pdev)
   560	{
   561		struct virtio_mmio_device *vm_dev;
   562		unsigned long magic;
   563		int rc;
   564	
 > 565		if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
   566			return -ENODEV;
   567	
   568		vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
   569		if (!vm_dev)
   570			return -ENOMEM;
   571	
   572		vm_dev->vdev.dev.parent = &pdev->dev;
   573		vm_dev->vdev.dev.release = virtio_mmio_release_dev;
   574		vm_dev->vdev.config = &virtio_mmio_config_ops;
   575		vm_dev->pdev = pdev;
   576		INIT_LIST_HEAD(&vm_dev->virtqueues);
   577		spin_lock_init(&vm_dev->lock);
   578	
   579		vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
   580		if (IS_ERR(vm_dev->base))
   581			return PTR_ERR(vm_dev->base);
   582	
   583		/* Check magic value */
   584		magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
   585		if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
   586			dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
   587			return -ENODEV;
   588		}
   589	
   590		/* Check device version */
   591		vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
   592		if (vm_dev->version < 1 || vm_dev->version > 2) {
   593			dev_err(&pdev->dev, "Version %ld not supported!\n",
   594					vm_dev->version);
   595			return -ENXIO;
   596		}
   597	
   598		vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
   599		if (vm_dev->vdev.id.device == 0) {
   600			/*
   601			 * virtio-mmio device with an ID 0 is a (dummy) placeholder
   602			 * with no function. End probing now with no error reported.
   603			 */
   604			return -ENODEV;
   605		}
   606		vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
   607	
   608		if (vm_dev->version == 1) {
   609			writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
   610	
   611			rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
   612			/*
   613			 * In the legacy case, ensure our coherently-allocated virtio
   614			 * ring will be at an address expressable as a 32-bit PFN.
   615			 */
   616			if (!rc)
   617				dma_set_coherent_mask(&pdev->dev,
   618						      DMA_BIT_MASK(32 + PAGE_SHIFT));
   619		} else {
   620			rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
   621		}
   622		if (rc)
   623			rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
   624		if (rc)
   625			dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
   626	
   627		platform_set_drvdata(pdev, vm_dev);
   628	
   629		rc = register_virtio_device(&vm_dev->vdev);
   630		if (rc)
   631			put_device(&vm_dev->vdev.dev);
   632	
   633		return rc;
   634	}
   635	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
