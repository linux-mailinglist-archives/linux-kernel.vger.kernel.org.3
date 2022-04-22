Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1DA50C50D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiDVXhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiDVXg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:36:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D7D3ACD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650669745; x=1682205745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4otL8TRrBO+M5G+dHbVsu0cGBD0FUjenUHO3LNY0VpM=;
  b=VG1N4Hc8tVSdvNYv5h3yVrb+VwEwk6P7YHfyoYXI7Lu8pLqcDixo/QNy
   mbzbPgZZtK9aRf4TUQlNmG+g3YMMCbQ4+AxuKwp9qhLcYXFD99GUV96bx
   T7Rl0MVntCernLi59ae/g/ioWz9hsK6Yo/szLPvYN4DPp0urru2Y6idbm
   sLPxm0YD/cXAm4TVMzHk8fmpjGg8PGhncwE7zVwQapF5q4K3+0G0oGsyS
   y1reBnlbXqzmR5h4sczEZijEM10TrPyHvhqmFGPJsxLIkLhyx2nbXuYHI
   0vUt8MZzF7nl3UZXspfX/McQ9Yoe5zIyoBef30KZogZuz4Ye1/KHDobcD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264301799"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264301799"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="728733995"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2022 16:22:23 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni2bW-000Aeg-Vo;
        Fri, 22 Apr 2022 23:22:22 +0000
Date:   Sat, 23 Apr 2022 07:22:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-hardening 3/13] drivers/virtio/virtio_mmio.c:565:6:
 error: implicit declaration of function 'cc_platform_has'
Message-ID: <202204230726.SODHP9ez-lkp@intel.com>
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220423/202204230726.SODHP9ez-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel/tdx/commit/3377879e3b9e6535e58030a0d0c9068812664416
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening
        git checkout 3377879e3b9e6535e58030a0d0c9068812664416
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/virtio/virtio_mmio.c:565:6: error: implicit declaration of function 'cc_platform_has' [-Werror,-Wimplicit-function-declaration]
           if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
               ^
>> drivers/virtio/virtio_mmio.c:565:22: error: use of undeclared identifier 'CC_ATTR_GUEST_DEVICE_FILTER'
           if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
                               ^
   drivers/virtio/virtio_mmio.c:611:33: warning: shift count >= width of type [-Wshift-count-overflow]
                   rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
                                                 ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/virtio/virtio_mmio.c:620:46: warning: shift count >= width of type [-Wshift-count-overflow]
                   rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                              ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 2 errors generated.


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
