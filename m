Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE9564398
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 04:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiGCCDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 22:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCCD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 22:03:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EBFA44A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 19:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656813807; x=1688349807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u2TNYrvGCyW7EIUAvv12EOBBUShBBiMJFDjMg52TYZM=;
  b=mCTJ+5l5MWlHtQYZI78yli4Y+wW2u5bjTb9/YFUOXZvw/KzNp8+gO9dF
   cx5ZuME1mRBNLMgx3lanIgO4MY0f1keJsRk5AhqB+n49idwmsYDe2Km3l
   uM7iBzFzl0g2vQe27nldqx/cANACNGyYqBFHqnXptprOJu6/tDFLqcaoN
   FrpSyA5hlUcDMvdUxQ/PROKNZznFvittr7dt0AyTNYvAJWsKcSLAdcMWZ
   FzZTVd2cY07r1N3yHlcV59+AJhEEk1/yqaYoYdJpJdxiyxQXu99lDDgrY
   eTvu1uc5XkwL0qyJjiLFuOLy3f7E3mbgJ+SjBAWfjrp31hcS78/ANBiCj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="346872248"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="346872248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 19:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="618827919"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2022 19:03:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7oxJ-000Fxl-77;
        Sun, 03 Jul 2022 02:03:25 +0000
Date:   Sun, 3 Jul 2022 10:03:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: drivers/gpu/drm/tegra/submit.c:107:28: sparse: sparse: symbol
 'gather_bo_ops' was not declared. Should it be static?
Message-ID: <202207031031.i87PMmio-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69cb6c6556ad89620547318439d6be8bb1629a5a
commit: 13abe0bb15ceac2fb8e8853bd30c278426d95ad0 drm/tegra: Implement job submission part of new UAPI
date:   11 months ago
config: arm-randconfig-s032-20220703 (https://download.01.org/0day-ci/archive/20220703/202207031031.i87PMmio-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=13abe0bb15ceac2fb8e8853bd30c278426d95ad0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 13abe0bb15ceac2fb8e8853bd30c278426d95ad0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ drivers/firmware/arm_scmi/ drivers/gpu/drm/tegra/ drivers/misc/ drivers/video/fbdev/omap/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/tegra/submit.c:107:28: sparse: sparse: symbol 'gather_bo_ops' was not declared. Should it be static?

vim +/gather_bo_ops +107 drivers/gpu/drm/tegra/submit.c

    66	
    67	static struct host1x_bo_mapping *
    68	gather_bo_pin(struct device *dev, struct host1x_bo *bo, enum dma_data_direction direction)
    69	{
    70		struct gather_bo *gather = container_of(bo, struct gather_bo, base);
    71		struct host1x_bo_mapping *map;
    72		int err;
    73	
    74		map = kzalloc(sizeof(*map), GFP_KERNEL);
    75		if (!map)
    76			return ERR_PTR(-ENOMEM);
    77	
    78		kref_init(&map->ref);
    79		map->bo = host1x_bo_get(bo);
    80		map->direction = direction;
    81		map->dev = dev;
    82	
    83		map->sgt = kzalloc(sizeof(*map->sgt), GFP_KERNEL);
    84		if (!map->sgt) {
    85			err = -ENOMEM;
    86			goto free;
    87		}
    88	
    89		err = dma_get_sgtable(gather->dev, map->sgt, gather->gather_data, gather->gather_data_dma,
    90				      gather->gather_data_words * 4);
    91		if (err)
    92			goto free_sgt;
    93	
    94		err = dma_map_sgtable(dev, map->sgt, direction, 0);
    95		if (err)
    96			goto free_sgt;
    97	
    98		map->phys = sg_dma_address(map->sgt->sgl);
    99		map->size = gather->gather_data_words * 4;
   100		map->chunks = err;
   101	
   102		return map;
   103	
   104	free_sgt:
   105		sg_free_table(map->sgt);
   106		kfree(map->sgt);
 > 107	free:
   108		kfree(map);
   109		return ERR_PTR(err);
   110	}
   111	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
