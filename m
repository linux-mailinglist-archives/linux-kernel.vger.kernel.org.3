Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2568463E75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbhK3TN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:13:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:57309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234797AbhK3TN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:13:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299692919"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="299692919"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 11:10:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="540531915"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2021 11:10:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms8Vx-000DgA-7W; Tue, 30 Nov 2021 19:10:05 +0000
Date:   Wed, 1 Dec 2021 03:09:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [drm-misc:for-linux-next 281/286] arm-linux-gnueabi-ld:
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:undefined reference to
 `drm_gem_cma_prime_import_sg_table'
Message-ID: <202112010300.M514poio-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   c99907c723c6f3f6cae63201ddfac610be13f997
commit: 09717af7d13d63df141ae6e71686289989d17efd [281/286] drm: Remove CONFIG_DRM_KMS_CMA_HELPER option
config: arm-aspeed_g5_defconfig (https://download.01.org/0day-ci/archive/20211201/202112010300.M514poio-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout 09717af7d13d63df141ae6e71686289989d17efd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arm-linux-gnueabi-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2a4): undefined reference to `drm_gem_cma_prime_import_sg_table'
>> arm-linux-gnueabi-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2ac): undefined reference to `drm_gem_cma_dumb_create'
   arm-linux-gnueabi-ld: drivers/gpu/drm/aspeed/aspeed_gfx_crtc.o: in function `aspeed_gfx_pipe_update':
>> aspeed_gfx_crtc.c:(.text+0x128): undefined reference to `drm_fb_cma_get_gem_obj'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
