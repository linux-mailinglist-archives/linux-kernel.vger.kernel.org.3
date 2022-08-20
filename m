Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3FD59AD62
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiHTK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiHTK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:59:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D648E95
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660993171; x=1692529171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6bvnfTT4/t+5ClYUhDOG/MQcIDUXZ10fpoddRgksaJw=;
  b=i0UYoP9mkklpLYNgkV4T6BPtHZSIjTPd7dJwjarMHfHq2wHEj8LYqP15
   tr1XUHTqoYJ4FtWruTBvAxIACVcaH3iaoJeXVZYDJjSk5sRBvG/VhDJXT
   s7sU1H4QYYmTJVdDkemQp0/ImvLzc0TptFKKMNWpiaqHznKBLLIRm82oj
   FfbYVuo4KIk1hq5TUPTSTvXu7IOGh2uqicUUmJkjF69NMLBYREJQkc/Sn
   xywc2oijykIoM4J569S2BJJDbdVYOXcXfCD0EcaIRn9qGu8gW19KB2fB2
   ho/qA2A4sBx18CUF52nlmXF4HwQMbGgmLCuZHBXA03z7iDYyjOdI6d/dq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="293954172"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="293954172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 03:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="584947572"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2022 03:59:29 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPMCO-0002XD-37;
        Sat, 20 Aug 2022 10:59:28 +0000
Date:   Sat, 20 Aug 2022 18:58:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 10/14] drivers/iommu/iommufd/device.c:59:
 warning: expecting prototype for iommufd_bind_device(). Prototype was for
 iommufd_device_bind() instead
Message-ID: <202208201856.H1yTyIFO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   6624f48e554fe6a880b261074a1c9580dc9b5384
commit: e6ea33b10e22b67a040cb8bbe1068528adab762a [10/14] iommufd: Add kAPI toward external drivers for physical devices
config: s390-randconfig-r035-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201856.H1yTyIFO-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/jgunthorpe/linux/commit/e6ea33b10e22b67a040cb8bbe1068528adab762a
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout e6ea33b10e22b67a040cb8bbe1068528adab762a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/iommufd/device.c:59: warning: Function parameter or member 'dev' not described in 'iommufd_device_bind'
>> drivers/iommu/iommufd/device.c:59: warning: expecting prototype for iommufd_bind_device(). Prototype was for iommufd_device_bind() instead


vim +59 drivers/iommu/iommufd/device.c

    40	
    41	/**
    42	 * iommufd_bind_device - Bind a physical device to an iommu fd
    43	 * @ictx: iommufd file descriptor
    44	 * @pdev: Pointer to a physical PCI device struct
    45	 * @id: Output ID number to return to userspace for this device
    46	 *
    47	 * A successful bind establishes an ownership over the device and returns
    48	 * struct iommufd_device pointer, otherwise returns error pointer.
    49	 *
    50	 * A driver using this API must set driver_managed_dma and must not touch
    51	 * the device until this routine succeeds and establishes ownership.
    52	 *
    53	 * Binding a PCI device places the entire RID under iommufd control.
    54	 *
    55	 * The caller must undo this with iommufd_unbind_device()
    56	 */
    57	struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
    58						   struct device *dev, u32 *id)
  > 59	{
    60		struct iommufd_device *idev;
    61		struct iommu_group *group;
    62		int rc;
    63	
    64	       /*
    65	        * iommufd always sets IOMMU_CACHE because we offer no way for userspace
    66	        * to restore cache coherency.
    67	        */
    68		if (!iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY))
    69			return ERR_PTR(-EINVAL);
    70	
    71		group = iommu_group_get(dev);
    72		if (!group)
    73			return ERR_PTR(-ENODEV);
    74	
    75		/*
    76		 * FIXME: Use a device-centric iommu api, this won't work with
    77		 * multi-device groups
    78		 */
    79		rc = iommu_group_claim_dma_owner(group, ictx);
    80		if (rc)
    81			goto out_group_put;
    82	
    83		idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
    84		if (IS_ERR(idev)) {
    85			rc = PTR_ERR(idev);
    86			goto out_release_owner;
    87		}
    88		idev->ictx = ictx;
    89		iommufd_ctx_get(ictx);
    90		idev->dev = dev;
    91		/* The calling driver is a user until iommufd_device_unbind() */
    92		refcount_inc(&idev->obj.users);
    93		/* group refcount moves into iommufd_device */
    94		idev->group = group;
    95	
    96		/*
    97		 * If the caller fails after this success it must call
    98		 * iommufd_unbind_device() which is safe since we hold this refcount.
    99		 * This also means the device is a leaf in the graph and no other object
   100		 * can take a reference on it.
   101		 */
   102		iommufd_object_finalize(ictx, &idev->obj);
   103		*id = idev->obj.id;
   104		return idev;
   105	
   106	out_release_owner:
   107		iommu_group_release_dma_owner(group);
   108	out_group_put:
   109		iommu_group_put(group);
   110		return ERR_PTR(rc);
   111	}
   112	EXPORT_SYMBOL_GPL(iommufd_device_bind);
   113	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
