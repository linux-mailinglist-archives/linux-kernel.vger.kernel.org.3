Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4A49108C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbiAQTFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:05:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:50715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233286AbiAQTFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642446347; x=1673982347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sRMk2gWpOK/4IUMHyxonrVJ6i0vyNFHcpoY/g5RvRBE=;
  b=GHTo9L9LCyZkG2lUy8gblv2qukgNe7oBWqpB2YGXFGazJ9pE9LSHEhjB
   CdaOxz6ZijXzZf+t+vqz8UFeASsZehN041ewjfsfcDtgynzJZEVBhBA5E
   5EBPe+/IktzleumIoabHIXoVcso5bMIxJ4kNEimQAQdMwG1vYUbOE+RkT
   aTz6CxbxynAZfy3T8314X/gpau8NMnPZUC216nrrzjJZsGsxrqGW63bWB
   fdHk9LzAZqcnjhpyf11u8zaHu7EttemXVw9CA0AgJ5dGhp38GAj3dyLZQ
   pUhggCf5CjpAk/mKOulGo/IdzHfJmC5LzKB1jogBl++bZTQGdpGcyEbDj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="224659900"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224659900"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 11:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="517504440"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2022 11:05:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9XK4-000BnQ-St; Mon, 17 Jan 2022 19:05:44 +0000
Date:   Tue, 18 Jan 2022 03:05:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 3/5] analogix_dp_core.c:undefined reference
 to `drm_dp_dpcd_read'
Message-ID: <202201180232.qDi3QkrX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   032a125904995985334766911de9e26ee2bbd646
commit: adb9d5a2cc77e8aefe98fe4c11656c5b7025c248 [3/5] drm/dp: Move DisplayPort helpers into separate helper module
config: arm-exynos_defconfig (https://download.01.org/0day-ci/archive/20220118/202201180232.qDi3QkrX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout adb9d5a2cc77e8aefe98fe4c11656c5b7025c248
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-edp.o: in function `panel_edp_probe':
   panel-edp.c:(.text+0xf2c): undefined reference to `drm_panel_dp_aux_backlight'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_set_enhanced_mode':
>> analogix_dp_core.c:(.text+0x1e4): undefined reference to `drm_dp_dpcd_read'
>> arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x20c): undefined reference to `drm_dp_dpcd_read'
>> arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x284): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x2b0): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x2e4): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_bind':
>> analogix_dp_core.c:(.text+0x624): undefined reference to `drm_dp_aux_register'
>> arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x6a0): undefined reference to `drm_dp_aux_unregister'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_stop_crc':
>> analogix_dp_core.c:(.text+0x6c8): undefined reference to `drm_dp_stop_crc'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_start_crc':
>> analogix_dp_core.c:(.text+0x7c4): undefined reference to `drm_dp_start_crc'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_link_start':
>> analogix_dp_core.c:(.text+0x868): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x928): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x95c): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_reduce_link_rate':
   analogix_dp_core.c:(.text+0xa94): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_process_clock_recovery':
   analogix_dp_core.c:(.text+0xb08): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0xb24): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0xb9c): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0xbf0): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_unbind':
>> analogix_dp_core.c:(.text+0x13b8): undefined reference to `drm_dp_aux_unregister'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_process_equalizer_training':
   analogix_dp_core.c:(.text+0x1420): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1484): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x14a0): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1538): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x160c): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1664): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_full_link_train':
   analogix_dp_core.c:(.text+0x1738): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1754): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_commit':
   analogix_dp_core.c:(.text+0x1968): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1a9c): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1ae0): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1b54): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1b94): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1bc4): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1bf0): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x1c1c): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_bridge_atomic_enable':
   analogix_dp_core.c:(.text+0x1ffc): undefined reference to `drm_dp_dpcd_write'
   arm-linux-gnueabi-ld: analogix_dp_core.c:(.text+0x2068): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_bridge_atomic_post_disable':
   analogix_dp_core.c:(.text+0x25a0): undefined reference to `drm_dp_dpcd_read'
   arm-linux-gnueabi-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_reg.o: in function `analogix_dp_send_psr_spd':
>> analogix_dp_reg.c:(.text+0x1658): undefined reference to `drm_dp_dpcd_read'
>> arm-linux-gnueabi-ld: analogix_dp_reg.c:(.text+0x16e0): undefined reference to `drm_dp_dpcd_read'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
