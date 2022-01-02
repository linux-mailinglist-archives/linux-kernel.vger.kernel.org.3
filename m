Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE72482901
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 05:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiABDn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 22:43:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:4414 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbiABDnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 22:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641095005; x=1672631005;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GvZlLGxaEPa5TYpFDfoUMUOSZoqb2rKB2Q/eMO5mu9o=;
  b=Wq+9CyqBb+WKbL2cNcV9Ite8FJWYcZOS28TQd+pGDFlssWC25ZQT+EQL
   gQFXZLpDNJQT7u49adlXQTpMpS5lamCV4HPwehhrnLOc51b883QQpJVeB
   oYHoTuAFNEBDjnm2hUO7mf+uz1yIWcHYShP3ZHqeVaenwqOzaq5UERWh3
   Cy+XMVZbAzgFx2V5OTyWXANZAcfn2pxhI28Y5ZPLiVMjjEyB+tZp7AY2t
   ij37ZoPUqaNqobbrbJ1BPKlBsrWbQYHgnm27ZQYq8Wlg+qv2cAh/Bm5oo
   uJGYsc3JIko83Jk7MPhH2n/0Ul1fTQhZY87MwI7YpHZSfXBc6usp1h7Xm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="242147903"
X-IronPort-AV: E=Sophos;i="5.88,255,1635231600"; 
   d="scan'208";a="242147903"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 19:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,255,1635231600"; 
   d="scan'208";a="469373230"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jan 2022 19:43:23 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3rmE-000D2a-Aw; Sun, 02 Jan 2022 03:43:22 +0000
Date:   Sun, 2 Jan 2022 11:42:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from
 `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
Message-ID: <202201021124.W3iual1n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   278218f6778bc7d6f8b67199446c56cec7ebb841
commit: a1867f85e06edacd82956d3422caa2b9074f4321 mfd: Add Renesas Synchronization Management Unit (SMU) support
date:   6 months ago
config: powerpc-randconfig-c024-20211012 (https://download.01.org/0day-ci/archive/20220102/202201021124.W3iual1n-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1867f85e06edacd82956d3422caa2b9074f4321
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1867f85e06edacd82956d3422caa2b9074f4321
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/mfd/rsmu_core.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
   (.text+0x424): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x4b0): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
   (.text+0x818): undefined reference to `unregister_framebuffer'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
   (.text+0x9b8): undefined reference to `fb_dealloc_cmap'
   powerpc-linux-ld: (.text+0x9d8): undefined reference to `framebuffer_release'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
   (.text+0xbe8): undefined reference to `fb_sys_read'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
   (.text+0x34f8): undefined reference to `framebuffer_alloc'
   powerpc-linux-ld: (.text+0x3554): undefined reference to `fb_alloc_cmap'
   powerpc-linux-ld: (.text+0x3618): undefined reference to `fb_dealloc_cmap'
   powerpc-linux-ld: (.text+0x3674): undefined reference to `framebuffer_release'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x37b0): undefined reference to `register_framebuffer'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   (.text+0x4518): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x58f8): undefined reference to `fb_deferred_io_init'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
   (.text+0x644c): undefined reference to `fb_sys_write'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
   (.text+0x6534): undefined reference to `sys_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
   (.text+0x65b4): undefined reference to `sys_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
   (.text+0x6634): undefined reference to `sys_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
   (.text+0x66b4): undefined reference to `cfb_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
   (.text+0x6734): undefined reference to `cfb_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
   (.text+0x67b4): undefined reference to `cfb_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
   drm_fb_helper.c:(.text+0x6c30): undefined reference to `cfb_imageblit'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x6c58): undefined reference to `sys_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
   drm_fb_helper.c:(.text+0x6d30): undefined reference to `cfb_copyarea'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x6d58): undefined reference to `sys_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
   drm_fb_helper.c:(.text+0x6e30): undefined reference to `cfb_fillrect'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x6e58): undefined reference to `sys_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x734c): undefined reference to `fb_deferred_io_cleanup'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
