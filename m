Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4738C4B8077
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiBPGCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:02:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBPGCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:02:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8649412F437
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644991349; x=1676527349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IVPlreFyMESNWqix37VZqoKjgqwMLI/tR34nJqXP0qY=;
  b=PeMSL6h/Piu3vKzNCKtdRmB+pwxFvP+/b/aiuy5xyY9uSoXMzsK+3PWm
   xofn4l6CyjMAShpuYTMDLECCI4M4AJ+Ayb/JUGqQDHXv9dj6ez9EKmRyN
   OdJ1oMqvcdkhLxOybucwtMEpMktioWGPyJk9r0BlMIU63e057yeWwp96H
   UuPjrqeZZz1UbSydzns8RVspfsp1eWMEENXwsvgvhNx8qCcHrNA0NMFrb
   FjCvMBcaHs+egXCWkO32qqu4dNgDRnbC5FNgrlaAIAfsVse8aBIKP9iIq
   319s0UB/CQSg4Arm72F7zGaFMOP/ur8ICVCViceq6KT5K1+8GhlFC/u3h
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="336963601"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="336963601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:02:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="498267307"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 22:02:27 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKDOU-000AUp-OI; Wed, 16 Feb 2022 06:02:26 +0000
Date:   Wed, 16 Feb 2022 14:01:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test 248/382] undefined
 reference to `apple_sart_add_allowed_region'
Message-ID: <202202161307.qyEsGhGi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1-test
head:   5adfbb595194191bad98c47447ddbee7d3b60b8f
commit: 4af74948141263ed097ad48f8845871d16410b08 [248/382] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: parisc-randconfig-r015-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161307.qyEsGhGi-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4af74948141263ed097ad48f8845871d16410b08
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test
        git checkout 4af74948141263ed097ad48f8845871d16410b08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_alloc':
>> (.text+0x6f0): undefined reference to `apple_sart_add_allowed_region'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
>> (.text+0x9d0): undefined reference to `apple_sart_get'
>> hppa-linux-ld: (.text+0xcc0): undefined reference to `devm_apple_rtkit_init'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
>> (.text+0x1248): undefined reference to `apple_rtkit_is_crashed'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
>> (.text+0x1400): undefined reference to `apple_rtkit_is_running'
>> hppa-linux-ld: (.text+0x1410): undefined reference to `apple_rtkit_shutdown'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   (.text+0x1484): undefined reference to `apple_rtkit_is_running'
   hppa-linux-ld: (.text+0x1494): undefined reference to `apple_rtkit_shutdown'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   (.text+0x15c8): undefined reference to `apple_rtkit_is_crashed'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   (.text+0x1738): undefined reference to `apple_rtkit_is_crashed'
>> hppa-linux-ld: (.text+0x175c): undefined reference to `apple_rtkit_is_running'
   hppa-linux-ld: (.text+0x1790): undefined reference to `apple_rtkit_shutdown'
>> hppa-linux-ld: (.text+0x17a8): undefined reference to `apple_rtkit_reinit'
>> hppa-linux-ld: (.text+0x17e0): undefined reference to `apple_rtkit_boot'
   hppa-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_free':
>> (.text+0x1bbc): undefined reference to `apple_sart_remove_allowed_region'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
