Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D474E38CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiCVGXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiCVGXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:23:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78844240A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647930123; x=1679466123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BwM9bS8i3YE2T8crylrWYS5OHdqfrv3jTuL6/hmx1xI=;
  b=JHaJVZXWeSmzTpp4oBXuAUAMZ1uQci/+Qp7CF6ZIMbNynJemWifQHNDx
   0XNqITddldUcsMDuq9DYDoTiLmT3Etynds0YHsiw68Gh1wI/3YL2vXaZT
   N53j4aas/JZT09MPpWa+ePCCztcBUbg6t5q9cYkCA8BKSku5LF1Sw2LIQ
   UJ+H12nBqcd0hUh7C8kEZT64gpg33B1QtVQutNf2WPm/EEa9Y9lwEAo9W
   rs6mwADgvQd6c4USAOE7O8wI8jQlfqJeA9FCGniyBbFdxCwhEM5qvFgTl
   X4DfUU0T88vorfTPxK/KR2YTIR4RfDbDDPodQQtAKywhzqX8ZkZExLOXE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257683235"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="257683235"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 23:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="648860449"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 23:22:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWXu4-000IYL-3N; Tue, 22 Mar 2022 06:22:00 +0000
Date:   Tue, 22 Mar 2022 14:21:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Yogesh Lal <quic_ylal@quicinc.com>,
        Elliot Berman <eberman@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 1113/5403] arm-linux-gnueabi-ld:
 drivers/android/android_debug_symbols.o:undefined reference to
 `__per_cpu_start'
Message-ID: <202203221424.skW37V4c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   e4967c187ba0ed7e49621ef0d62906ff6441fbdc
commit: b2df67a932b5cbd6535de9f1a6e63004992ad014 [1113/5403] ANDROID: android: Create debug_symbols driver
config: arm-randconfig-r011-20220322 (https://download.01.org/0day-ci/archive/20220322/202203221424.skW37V4c-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b2df67a932b5cbd6535de9f1a6e63004992ad014
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout b2df67a932b5cbd6535de9f1a6e63004992ad014
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `ttm_bo_vm_fault_reserved':
   ttm_bo_vm.c:(.text+0x4f4): undefined reference to `vmf_insert_pfn_prot'
   arm-linux-gnueabi-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `ttm_bo_vm_dummy_page':
   ttm_bo_vm.c:(.text+0x648): undefined reference to `vmf_insert_pfn_prot'
   arm-linux-gnueabi-ld: drivers/power/supply/rt9455_charger.o: in function `rt9455_probe':
   rt9455_charger.c:(.text+0xbf6): undefined reference to `devm_usb_get_phy'
   arm-linux-gnueabi-ld: drivers/power/supply/bq256xx_charger.o: in function `bq256xx_probe':
   bq256xx_charger.c:(.text+0x11fe): undefined reference to `devm_usb_get_phy'
   arm-linux-gnueabi-ld: bq256xx_charger.c:(.text+0x123c): undefined reference to `devm_usb_get_phy'
>> arm-linux-gnueabi-ld: drivers/android/android_debug_symbols.o:(.rodata+0x14): undefined reference to `__per_cpu_start'
>> arm-linux-gnueabi-ld: drivers/android/android_debug_symbols.o:(.rodata+0x1c): undefined reference to `__per_cpu_end'
>> arm-linux-gnueabi-ld: drivers/android/android_debug_symbols.o:(.rodata+0x6c): undefined reference to `stack_guard_gap'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for USB_PHY
   Depends on USB_SUPPORT
   Selected by
   - GKI_HIDDEN_USB_CONFIGS
   WARNING: unmet direct dependencies detected for NET_PTP_CLASSIFY
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS && HAS_IOMEM && DRM
   WARNING: unmet direct dependencies detected for PAGE_POOL
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
