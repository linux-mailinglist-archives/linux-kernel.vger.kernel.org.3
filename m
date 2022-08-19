Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397F759A82E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiHSWLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbiHSWLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:11:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D8D7D1B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660947075; x=1692483075;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wkSL4YcRImAsSr0vR7QMBeygezS34rFVcTAH931PSlI=;
  b=cmqtIKfbmciiCeTMwI+5QgC4M7eSzMObHlQBcYaUgqE/2Rm+EKABmNR6
   5hAineaaG235orBC2D8Csmbs9pOQBWrHeE5pErQAZdE3+ybXb9NgGGFJN
   WJy9Rniep571fuY5EZOTqtaqpBdwe0AjXe3miPvnXXdCNz0U52Mf3O7gR
   bQQ7IwRP28xaiMa57MiEwNI/EbVqKxwpiqPq37m0SgHn0geljs2M1V0IL
   C7sHY2j6omdGSvNo0C7yPEJZLvXKFXQt4k58aMpu8gEroAyQ504sLipIG
   h+o4ZD9GyuF5kjZQUTYmxNRLPm3Wgsv8o3SnuabQhpes2Q01imiyosnAm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="276146523"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="276146523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 15:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="641402174"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2022 15:11:13 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPACu-0001rJ-2g;
        Fri, 19 Aug 2022 22:11:12 +0000
Date:   Sat, 20 Aug 2022 06:10:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-hardening-rebased 35/36]
 drivers/virtio/virtio_mmio.c:611:6: error: implicit declaration of function
 'cc_platform_has' is invalid in C99
Message-ID: <202208200658.d5mG6HxB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/virtio/virtio_mmio.c
tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 8aee8422c3b96f5d4dde1f31f8a96409a3e55c48 [35/36] virtio-mmio: Disable in TDX guest
config: hexagon-buildonly-randconfig-r005-20220820 (https://download.01.org/0day-ci/archive/20220820/202208200658.d5mG6HxB-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/8aee8422c3b96f5d4dde1f31f8a96409a3e55c48
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 8aee8422c3b96f5d4dde1f31f8a96409a3e55c48
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/virtio/virtio_mmio.c:611:6: error: implicit declaration of function 'cc_platform_has' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (cc_platform_has(CC_ATTR_GUEST_HARDENED))
               ^
>> drivers/virtio/virtio_mmio.c:611:22: error: use of undeclared identifier 'CC_ATTR_GUEST_HARDENED'
           if (cc_platform_has(CC_ATTR_GUEST_HARDENED))
                               ^
>> drivers/virtio/virtio_mmio.c:611:22: error: use of undeclared identifier 'CC_ATTR_GUEST_HARDENED'
>> drivers/virtio/virtio_mmio.c:611:22: error: use of undeclared identifier 'CC_ATTR_GUEST_HARDENED'
   drivers/virtio/virtio_mmio.c:657:33: warning: shift count >= width of type [-Wshift-count-overflow]
                   rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
                                                 ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/virtio/virtio_mmio.c:666:46: warning: shift count >= width of type [-Wshift-count-overflow]
                   rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                              ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 4 errors generated.


vim +/cc_platform_has +611 drivers/virtio/virtio_mmio.c

   604	
   605	static int virtio_mmio_probe(struct platform_device *pdev)
   606	{
   607		struct virtio_mmio_device *vm_dev;
   608		unsigned long magic;
   609		int rc;
   610	
 > 611		if (cc_platform_has(CC_ATTR_GUEST_HARDENED))
   612			return -ENODEV;
   613	
   614		vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
   615		if (!vm_dev)
   616			return -ENOMEM;
   617	
   618		vm_dev->vdev.dev.parent = &pdev->dev;
   619		vm_dev->vdev.dev.release = virtio_mmio_release_dev;
   620		vm_dev->vdev.config = &virtio_mmio_config_ops;
   621		vm_dev->pdev = pdev;
   622		INIT_LIST_HEAD(&vm_dev->virtqueues);
   623		spin_lock_init(&vm_dev->lock);
   624	
   625		vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
   626		if (IS_ERR(vm_dev->base))
   627			return PTR_ERR(vm_dev->base);
   628	
   629		/* Check magic value */
   630		magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
   631		if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
   632			dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
   633			return -ENODEV;
   634		}
   635	
   636		/* Check device version */
   637		vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
   638		if (vm_dev->version < 1 || vm_dev->version > 2) {
   639			dev_err(&pdev->dev, "Version %ld not supported!\n",
   640					vm_dev->version);
   641			return -ENXIO;
   642		}
   643	
   644		vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
   645		if (vm_dev->vdev.id.device == 0) {
   646			/*
   647			 * virtio-mmio device with an ID 0 is a (dummy) placeholder
   648			 * with no function. End probing now with no error reported.
   649			 */
   650			return -ENODEV;
   651		}
   652		vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
   653	
   654		if (vm_dev->version == 1) {
   655			writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
   656	
   657			rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
   658			/*
   659			 * In the legacy case, ensure our coherently-allocated virtio
   660			 * ring will be at an address expressable as a 32-bit PFN.
   661			 */
   662			if (!rc)
   663				dma_set_coherent_mask(&pdev->dev,
   664						      DMA_BIT_MASK(32 + PAGE_SHIFT));
   665		} else {
   666			rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
   667		}
   668		if (rc)
   669			rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
   670		if (rc)
   671			dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
   672	
   673		platform_set_drvdata(pdev, vm_dev);
   674	
   675		rc = register_virtio_device(&vm_dev->vdev);
   676		if (rc)
   677			put_device(&vm_dev->vdev.dev);
   678	
   679		return rc;
   680	}
   681	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
