Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB5596648
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiHQAVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbiHQAVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:21:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE29832FF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660695667; x=1692231667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bto+wWr8rVGJdNYoL7NXnmgkSF7ReEMHmQXEtISCcqo=;
  b=k7R55xlDMhzAtOsPHa8SX0lpjnz4THTt327U0yBBISffruDUBHbkXJM3
   QklJcvm2EFUBj6Ly8bMYuneMcEFcwLNWe/vQd+UhQgaRonWJBSolSU0pR
   6yogmX288sPShKZZkotAkzRzrWD+gYOIA9xDDRB4E92L4bYGW9qN3aJFc
   4PCzcYNaaumowGXtQNtOa0XkX9etxqMmZ9OMB8Bo9nps79fVWX3vG/ZOP
   B9Tt3LJYzH6xFjC/YnB/T/Aa9yHRAieTaNwq1mLIWzA8PROlCsbzwjMOO
   uL8Vg1IvE6tnG9+TBjfgmVq1X9YXWhECDeeUwg4vhGbcyboXRJ+p/8/Xw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291114683"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="291114683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 17:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="640241718"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2022 17:21:05 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO6nw-0000Mz-1u;
        Wed, 17 Aug 2022 00:21:04 +0000
Date:   Wed, 17 Aug 2022 08:20:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Escande <thierry.escande@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14 8531/9354] hci_qca.c:undefined
 reference to `clk_set_rate'
Message-ID: <202208170859.QbynVWlL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14
head:   6f750b16c322c9191168a3a97c427c90581d9144
commit: bdcc355ed6e4fc2b4ca55cccebbdfdc195a5dcbf [8531/9354] UPSTREAM: Bluetooth: hci_qca: Add serdev support
config: m68k-randconfig-r003-20220816 (https://download.01.org/0day-ci/archive/20220817/202208170859.QbynVWlL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/bdcc355ed6e4fc2b4ca55cccebbdfdc195a5dcbf
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14
        git checkout bdcc355ed6e4fc2b4ca55cccebbdfdc195a5dcbf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/scsi/ufs/ufshcd.o: In function `ufshcd_init':
   ufshcd.c:(.text+0xa8a0): undefined reference to `clk_set_rate'
   drivers/scsi/ufs/ufshcd.o: In function `ufshcd_scale_clks':
   ufshcd.c:(.text+0x71a): undefined reference to `clk_set_rate'
   ufshcd.c:(.text+0x7e4): undefined reference to `clk_set_rate'
   ufshcd.c:(.text+0x84c): undefined reference to `clk_set_rate'
   drivers/media/i2c/ov5645.o: In function `ov5645_probe':
   ov5645.c:(.text+0xd52): undefined reference to `clk_set_rate'
   drivers/media/i2c/mt9p031.o:mt9p031.c:(.text+0xb5c): more undefined references to `clk_set_rate' follow
   drivers/media/v4l2-core/v4l2-clk.o: In function `v4l2_clk_set_rate':
   v4l2-clk.c:(.text+0x57c): undefined reference to `clk_round_rate'
   v4l2-clk.c:(.text+0x5a4): undefined reference to `clk_set_rate'
   drivers/bluetooth/hci_qca.o: In function `qca_serdev_probe':
>> hci_qca.c:(.text+0xbde): undefined reference to `clk_set_rate'
   drivers/opp/core.o: In function `dev_pm_opp_set_rate':
   core.c:(.text+0xb2c): undefined reference to `clk_round_rate'
   core.c:(.text+0xc92): undefined reference to `clk_set_rate'
   core.c:(.text+0xdb6): undefined reference to `clk_set_rate'
   core.c:(.text+0xe2a): undefined reference to `clk_set_rate'
   core.c:(.text+0xe96): undefined reference to `clk_set_rate'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
