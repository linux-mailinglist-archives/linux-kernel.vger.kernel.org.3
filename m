Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2C57F26C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiGXBEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiGXBE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:04:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B5D17A97
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658624666; x=1690160666;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8s1yfkGEBHoQ4TpMgPchn5YAHgR1ZKI4bVDPjQWyIe0=;
  b=MgCS1ajXJhDWAmPLmIVH66sluiv5dCgoGVnrf09SJ9RMXMoP3ZMlAkij
   ToWBAVwdDCmQzlo8jUztERjUqOvb35TbcUagUK1nBoTxMZ8nzXPWpeDs6
   Khi1DbUhf48bNxaaoO5OzoXqoHj7id2f+nDdfkUs/uOR6cTycaJLZFV+J
   wR12d5jyc/U/ApGRiVuWEWIo8qfuOu3BMe/ZSgeC36NccE6yCr15LjDPH
   Si3wXOZecNg9L6mVLCDhW/m2Ry1mZxexnQuKCklQIg3c3texyaI7Hq7os
   ewmN7yHSbVNU39eFzC5/wbeMTCsZg1Oo2/6sbkHiVimj12TpAyaEsXjsn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267896787"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="267896787"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 18:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="631958053"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2022 18:04:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFQ2a-0003Kl-0b;
        Sun, 24 Jul 2022 01:04:16 +0000
Date:   Sun, 24 Jul 2022 09:03:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>
Subject: [linux-stable-rc:linux-5.15.y 5405/8723] ia64-linux-ld:
 drm_fb_helper.c:undefined reference to `framebuffer_release'
Message-ID: <202207240801.Dyt3JX7i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   a9e2d8e52e1c0d87c0fa4f9d2d38e210aabed515
commit: 81e5b16de862866e7f09a1b00b49f97a9bc23a78 [5405/8723] platform: chrome: Split trace include file
config: ia64-randconfig-r011-20220721 (https://download.01.org/0day-ci/archive/20220724/202207240801.Dyt3JX7i-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=81e5b16de862866e7f09a1b00b49f97a9bc23a78
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 81e5b16de862866e7f09a1b00b49f97a9bc23a78
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
   drm_fb_helper.c:(.text+0x732): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x792): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
   drm_fb_helper.c:(.text+0x8f2): undefined reference to `unregister_framebuffer'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
   drm_fb_helper.c:(.text+0x9c2): undefined reference to `fb_dealloc_cmap'
>> ia64-linux-ld: drm_fb_helper.c:(.text+0x9d2): undefined reference to `framebuffer_release'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
   drm_fb_helper.c:(.text+0xb82): undefined reference to `fb_sys_read'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x29c2): undefined reference to `register_framebuffer'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
   drm_fb_helper.c:(.text+0x2f02): undefined reference to `framebuffer_alloc'
>> ia64-linux-ld: drm_fb_helper.c:(.text+0x2f42): undefined reference to `fb_alloc_cmap'
>> ia64-linux-ld: drm_fb_helper.c:(.text+0x2fe2): undefined reference to `fb_dealloc_cmap'
   ia64-linux-ld: drm_fb_helper.c:(.text+0x3002): undefined reference to `framebuffer_release'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x33e2): undefined reference to `fb_deferred_io_init'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   drm_fb_helper.c:(.text+0x3ba2): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
   drm_fb_helper.c:(.text+0x55a2): undefined reference to `fb_sys_write'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
   drm_fb_helper.c:(.text+0x5642): undefined reference to `sys_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
   drm_fb_helper.c:(.text+0x56e2): undefined reference to `sys_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
   drm_fb_helper.c:(.text+0x5782): undefined reference to `sys_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
   drm_fb_helper.c:(.text+0x5822): undefined reference to `cfb_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
   drm_fb_helper.c:(.text+0x58c2): undefined reference to `cfb_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
   drm_fb_helper.c:(.text+0x5962): undefined reference to `cfb_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
   drm_fb_helper.c:(.text+0x5a32): undefined reference to `cfb_fillrect'
>> ia64-linux-ld: drm_fb_helper.c:(.text+0x5a52): undefined reference to `sys_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
   drm_fb_helper.c:(.text+0x5b12): undefined reference to `cfb_copyarea'
>> ia64-linux-ld: drm_fb_helper.c:(.text+0x5b32): undefined reference to `sys_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
   drm_fb_helper.c:(.text+0x5bf2): undefined reference to `cfb_imageblit'
>> ia64-linux-ld: drm_fb_helper.c:(.text+0x5c12): undefined reference to `sys_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x6232): undefined reference to `fb_deferred_io_cleanup'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_client_unregister':
   drm_fb_helper.c:(.text+0x6402): undefined reference to `unregister_framebuffer'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
