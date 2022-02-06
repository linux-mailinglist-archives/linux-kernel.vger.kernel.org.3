Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA8C4AAD68
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 02:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381536AbiBFBtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 20:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381214AbiBFBs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 20:48:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B70C043187
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 17:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644112138; x=1675648138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l7lv/jUnJXVEXg8Gp6rvibwC9ywQ924Ks4bLlQTQmb8=;
  b=nlr4LHf6QVOJgGDwiASb3jQ8MPYp3kRVQvSshx5aQ+jP7ZqkGsVWorRO
   A1vZD6tzswv9wWEPyFR1lGenqs8onYi7uu+nNIEl/nX/lQ4ykBdY74HYu
   vpSMVYrkM5yd6FnJ1vqnT5Nu9J1Yr7rIa/P7M8WmM+f3l5U3MhXdPUbIQ
   g4/6A7oo8aV8FHluR0StEtN55PfVLUiyS2VCgs5rJ/3zq+0Ll8yUdYzmr
   7UFoVvu/sInVw2BJLX3zFnMpuw6P+Rd0HkL+0rrKU0BWp14Tg+QUmOVEQ
   xWzjYhexEHcFtpqQnvvnM7+pxpEUpupkq7nUPXFX059j364Pth/GUyFUZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="235946849"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="235946849"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 17:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="584486248"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2022 17:48:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGWff-000ZjT-UD; Sun, 06 Feb 2022 01:48:55 +0000
Date:   Sun, 6 Feb 2022 09:48:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: powerpc-linux-ld: warning: orphan section `.init.plt' from
 `drivers/platform/chrome/cros_ec_trace.o' being placed in section
 `.init.plt'
Message-ID: <202202060652.lkqKaFAm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
commit: d453ceb6549af8798913de6a20444cb7200fdb69 platform/chrome: sensorhub: Add trace events for sample
date:   6 months ago
config: powerpc-randconfig-c004-20220206 (https://download.01.org/0day-ci/archive/20220206/202202060652.lkqKaFAm-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d453ceb6549af8798913de6a20444cb7200fdb69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d453ceb6549af8798913de6a20444cb7200fdb69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
   drm_fb_helper.c:(.text+0x3b0): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x3f0): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
   drm_fb_helper.c:(.text+0x604): undefined reference to `unregister_framebuffer'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
   drm_fb_helper.c:(.text+0x6a0): undefined reference to `fb_dealloc_cmap'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x6ac): undefined reference to `framebuffer_release'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
   drm_fb_helper.c:(.text+0x7d8): undefined reference to `fb_sys_read'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
   drm_fb_helper.c:(.text+0x1a78): undefined reference to `framebuffer_alloc'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x1a9c): undefined reference to `fb_alloc_cmap'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x1adc): undefined reference to `fb_dealloc_cmap'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x1b1c): undefined reference to `framebuffer_release'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x1cb4): undefined reference to `fb_deferred_io_init'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x1e18): undefined reference to `register_framebuffer'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   drm_fb_helper.c:(.text+0x282c): undefined reference to `fb_set_suspend'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
   drm_fb_helper.c:(.text+0x2ec0): undefined reference to `fb_sys_write'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
   drm_fb_helper.c:(.text+0x2f38): undefined reference to `sys_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
   drm_fb_helper.c:(.text+0x2f90): undefined reference to `sys_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
   drm_fb_helper.c:(.text+0x2fe8): undefined reference to `sys_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
   drm_fb_helper.c:(.text+0x3040): undefined reference to `cfb_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
   drm_fb_helper.c:(.text+0x3098): undefined reference to `cfb_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
   drm_fb_helper.c:(.text+0x30f0): undefined reference to `cfb_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
   drm_fb_helper.c:(.text+0x315c): undefined reference to `cfb_imageblit'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x3170): undefined reference to `sys_imageblit'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
   drm_fb_helper.c:(.text+0x31e0): undefined reference to `cfb_copyarea'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x31f4): undefined reference to `sys_copyarea'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
   drm_fb_helper.c:(.text+0x3264): undefined reference to `cfb_fillrect'
   powerpc-linux-ld: drm_fb_helper.c:(.text+0x3278): undefined reference to `sys_fillrect'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x3314): undefined reference to `fb_deferred_io_cleanup'
   powerpc-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_client_unregister':
   drm_fb_helper.c:(.text+0x3418): undefined reference to `unregister_framebuffer'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
