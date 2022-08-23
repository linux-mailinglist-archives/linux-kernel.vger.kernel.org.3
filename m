Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8A559EDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiHWVAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHWVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:00:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F4786C8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661288411; x=1692824411;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1kDaPDpjqfaqAC/Cxd3FbM87PretknuOEghd5qsQD50=;
  b=oEiNXa0Y9hRRn/C0Z8VvB3trAkAAULQ2lk8ShxEq6Lleppth/WztfiTc
   7awhimUMEAHV2kqWCw0zEYXJk1H/8WL0jc4NqgHM8jEPdXbRNZTBy+kdw
   itL+LhaR0Pkx+p01EtfX2IXoPzz8HzI0AqqK6tZ511vLOk8+N+Xziipu2
   ae6cBptVKGIi6cllNBdYAMqsdkqj0jqt0R+ZSc9oB+pNhMMS5XDIa1b7T
   Zjum7V+ankCN7sKwJGWZyBHHxXDYMv6qqfzzzEnS/OliyCgqoL60NcCt7
   ES/Sd3Az4imn4k1FzMWovaYGh/1OyyVdGoOiBxhN+lHP0OiuRffgnqrgU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291357416"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="291357416"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="677769634"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2022 14:00:04 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQb0F-0000Xl-1l;
        Tue, 23 Aug 2022 21:00:03 +0000
Date:   Wed, 24 Aug 2022 04:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: drivers/gpu/host1x/context.c:65:23: error: too many arguments to
 function 'of_dma_configure_id'
Message-ID: <202208240444.uTBVAbiI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   072e51356cd5a4a1c12c1020bc054c99b98333df
commit: 8aa5bcb61612060429223d1fbb7a1c30a579fc1f gpu: host1x: Add context device management code
date:   7 weeks ago
config: arm-randconfig-r012-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240444.uTBVAbiI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8aa5bcb61612060429223d1fbb7a1c30a579fc1f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8aa5bcb61612060429223d1fbb7a1c30a579fc1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/host1x/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/host1x/context.c: In function 'host1x_memory_context_list_init':
>> drivers/gpu/host1x/context.c:65:23: error: too many arguments to function 'of_dma_configure_id'
      65 |                 err = of_dma_configure_id(&ctx->dev, node, true, &i);
         |                       ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/of_platform.h:12,
                    from drivers/gpu/host1x/context.c:9:
   include/linux/of_device.h:103:19: note: declared here
     103 | static inline int of_dma_configure_id(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~


vim +/of_dma_configure_id +65 drivers/gpu/host1x/context.c

    15	
    16	int host1x_memory_context_list_init(struct host1x *host1x)
    17	{
    18		struct host1x_memory_context_list *cdl = &host1x->context_list;
    19		struct device_node *node = host1x->dev->of_node;
    20		struct host1x_memory_context *ctx;
    21		unsigned int i;
    22		int err;
    23	
    24		cdl->devs = NULL;
    25		cdl->len = 0;
    26		mutex_init(&cdl->lock);
    27	
    28		err = of_property_count_u32_elems(node, "iommu-map");
    29		if (err < 0)
    30			return 0;
    31	
    32		cdl->devs = kcalloc(err, sizeof(*cdl->devs), GFP_KERNEL);
    33		if (!cdl->devs)
    34			return -ENOMEM;
    35		cdl->len = err / 4;
    36	
    37		for (i = 0; i < cdl->len; i++) {
    38			struct iommu_fwspec *fwspec;
    39	
    40			ctx = &cdl->devs[i];
    41	
    42			ctx->host = host1x;
    43	
    44			device_initialize(&ctx->dev);
    45	
    46			/*
    47			 * Due to an issue with T194 NVENC, only 38 bits can be used.
    48			 * Anyway, 256GiB of IOVA ought to be enough for anyone.
    49			 */
    50			ctx->dma_mask = DMA_BIT_MASK(38);
    51			ctx->dev.dma_mask = &ctx->dma_mask;
    52			ctx->dev.coherent_dma_mask = ctx->dma_mask;
    53			dev_set_name(&ctx->dev, "host1x-ctx.%d", i);
    54			ctx->dev.bus = &host1x_context_device_bus_type;
    55			ctx->dev.parent = host1x->dev;
    56	
    57			dma_set_max_seg_size(&ctx->dev, UINT_MAX);
    58	
    59			err = device_add(&ctx->dev);
    60			if (err) {
    61				dev_err(host1x->dev, "could not add context device %d: %d\n", i, err);
    62				goto del_devices;
    63			}
    64	
  > 65			err = of_dma_configure_id(&ctx->dev, node, true, &i);
    66			if (err) {
    67				dev_err(host1x->dev, "IOMMU configuration failed for context device %d: %d\n",
    68					i, err);
    69				device_del(&ctx->dev);
    70				goto del_devices;
    71			}
    72	
    73			fwspec = dev_iommu_fwspec_get(&ctx->dev);
    74			if (!fwspec || !device_iommu_mapped(&ctx->dev)) {
    75				dev_err(host1x->dev, "Context device %d has no IOMMU!\n", i);
    76				device_del(&ctx->dev);
    77				goto del_devices;
    78			}
    79	
    80			ctx->stream_id = fwspec->ids[0] & 0xffff;
    81		}
    82	
    83		return 0;
    84	
    85	del_devices:
    86		while (i--)
    87			device_del(&cdl->devs[i].dev);
    88	
    89		kfree(cdl->devs);
    90		cdl->len = 0;
    91	
    92		return err;
    93	}
    94	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
