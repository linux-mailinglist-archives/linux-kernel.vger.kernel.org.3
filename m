Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EAC4BDC36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359092AbiBUN3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:29:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359091AbiBUN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:29:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A228D205D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645450158; x=1676986158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c6T+jLGA6cDeCl9WqQkP8WA+dhrDUpfxgSkAHH0bsvQ=;
  b=lXt7A2EKWOTTBopm6dt1X0ybFNdqNwZva6Zrvlan1xrYAvXyMqRnwNds
   xZjrzwNgXV3NDPYESPkN/LYWKZ3cYJ3UEQaQYkMGnOkorfIXbakuExqZf
   GlPnnvODaJ6mQ+Gb2S1J2pTgEqxmuvnioMbAsA7RR6ph2GUzPLzPgyczN
   jhIl89DkpIzzG6HabtRPqsMn4Fne41sgEZAmTYbvLFuHFuh5ZGejTJ5oi
   TpggKZyzNLIdFBGuAjjoYPOvgz8dDmjv2hHqB04+luwB9g6nq3/bMm1Rk
   YbVe872B74CCeu2Nrxu0hXqp5ghxadYK+s6DlKaM3b0aSWfWq+q/Y9h/t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="249087296"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="249087296"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="505075359"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2022 05:29:16 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM8kd-0001eK-ND; Mon, 21 Feb 2022 13:29:15 +0000
Date:   Mon, 21 Feb 2022 21:28:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 434/552]
 drivers/nvme/host/apple.c:272: undefined reference to
 `apple_sart_remove_allowed_region'
Message-ID: <202202212127.pkVd6xaZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 493f6321556155242b30f79a6aa6afa58d5ff28d [434/552] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: microblaze-randconfig-p001-20220220 (https://download.01.org/0day-ci/archive/20220221/202202212127.pkVd6xaZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/493f6321556155242b30f79a6aa6afa58d5ff28d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout 493f6321556155242b30f79a6aa6afa58d5ff28d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_destroy':
>> drivers/nvme/host/apple.c:272: undefined reference to `apple_sart_remove_allowed_region'
   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_setup':
>> drivers/nvme/host/apple.c:255: undefined reference to `apple_sart_add_allowed_region'
   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
>> drivers/nvme/host/apple.c:1341: undefined reference to `apple_sart_get'
>> microblaze-linux-ld: drivers/nvme/host/apple.c:1393: undefined reference to `devm_apple_rtkit_init'
   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
>> drivers/nvme/host/apple.c:800: undefined reference to `apple_rtkit_is_crashed'
   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
>> drivers/nvme/host/apple.c:1436: undefined reference to `apple_rtkit_is_running'
>> microblaze-linux-ld: drivers/nvme/host/apple.c:1437: undefined reference to `apple_rtkit_shutdown'
   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   drivers/nvme/host/apple.c:1425: undefined reference to `apple_rtkit_is_running'
   microblaze-linux-ld: drivers/nvme/host/apple.c:1426: undefined reference to `apple_rtkit_shutdown'
   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   drivers/nvme/host/apple.c:984: undefined reference to `apple_rtkit_is_crashed'
>> microblaze-linux-ld: drivers/nvme/host/apple.c:995: undefined reference to `apple_rtkit_is_running'
   microblaze-linux-ld: drivers/nvme/host/apple.c:997: undefined reference to `apple_rtkit_shutdown'
>> microblaze-linux-ld: drivers/nvme/host/apple.c:1009: undefined reference to `apple_rtkit_reinit'
>> microblaze-linux-ld: drivers/nvme/host/apple.c:1020: undefined reference to `apple_rtkit_boot'
   microblaze-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   drivers/nvme/host/apple.c:899: undefined reference to `apple_rtkit_is_crashed'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NFSD_V2_ACL
   Depends on NETWORK_FILESYSTEMS && NFSD
   Selected by
   - NFSD_V3_ACL && NETWORK_FILESYSTEMS


vim +272 drivers/nvme/host/apple.c

   241	
   242	static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
   243					     dma_addr_t iova, size_t size)
   244	{
   245		struct apple_nvme *anv = cookie;
   246		int ret;
   247	
   248		if (iova)
   249			return -EINVAL;
   250	
   251		bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
   252		if (!bfr->buffer)
   253			return -ENOMEM;
   254	
 > 255		ret = apple_sart_add_allowed_region(anv->sart, iova, size);
   256		if (ret) {
   257			dma_free_coherent(anv->dev, size, bfr->buffer, iova);
   258			bfr->buffer = NULL;
   259			return -ENOMEM;
   260		}
   261	
   262		bfr->size = size;
   263		bfr->iova = iova;
   264	
   265		return 0;
   266	}
   267	
   268	static void apple_nvme_sart_dma_destroy(void *cookie, struct apple_rtkit_shmem *bfr)
   269	{
   270		struct apple_nvme *anv = cookie;
   271	
 > 272		apple_sart_remove_allowed_region(anv->sart, bfr->iova, bfr->size);
   273		dma_free_coherent(anv->dev, bfr->size, bfr->buffer, bfr->iova);
   274	}
   275	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
