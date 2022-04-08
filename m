Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2623E4F9E35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbiDHUdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDHUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:33:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979EE2E684
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649449874; x=1680985874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i6C1YHz4CoMucEU8uKLQckY9GDlu3SWjU153tDHE6bs=;
  b=PZC2nQr/F8xVDvREJsnWyrWXe8dJlZ18WpSnsE2KBA/5C/R97Zhsx5Sv
   F28Fn5T4PrebIahbgKTvqn80l8uNUthzqelNe4mMMDwutCezAPztSZadO
   x88qPTX0HuJL1ijV1PKOTTt6R5eT4nXHbEByW0yRgKyGiuSGCv/UGMdvU
   9WFA8jTqyCNEQOOZe5FqOuwKs0ibg/P3yT4YW+30vLNo9z9wgwJ27Zrpf
   AYH1bbi26VG3oPkOyysyJ4AjXG3PUWMYP0olNS0M+Taq4sIeweGKM70V2
   +vxifLmewrlYMRvVnz8KssTggLRhUwmzWnMbMdJcXMCvvZLctcFzjuaV+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="348117040"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="348117040"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659615368"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2022 13:31:13 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncvGC-0000c9-Bb;
        Fri, 08 Apr 2022 20:31:12 +0000
Date:   Sat, 9 Apr 2022 04:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [l1k:smsc95xx_5.17 118/201]
 drivers/gpu/drm/i915/display/intel_fbdev.c:109:23: error: initialized field
 overwritten
Message-ID: <202204090433.lPMYm4fL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: 326d4dbb40e05881260d64be29e4cca96443ef1a [118/201] kbuild: Cross-compile binaries to build modules on target
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204090433.lPMYm4fL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/l1k/linux/commit/326d4dbb40e05881260d64be29e4cca96443ef1a
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 326d4dbb40e05881260d64be29e4cca96443ef1a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_fbdev.c:109:23: error: initialized field overwritten [-Werror=override-init]
     109 |         .fb_set_par = intel_fbdev_set_par,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_fbdev.c:109:23: note: (near initialization for 'intelfb_ops.fb_set_par')
   drivers/gpu/drm/i915/display/intel_fbdev.c:113:27: error: initialized field overwritten [-Werror=override-init]
     113 |         .fb_pan_display = intel_fbdev_pan_display,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_fbdev.c:113:27: note: (near initialization for 'intelfb_ops.fb_pan_display')
   drivers/gpu/drm/i915/display/intel_fbdev.c:114:21: error: initialized field overwritten [-Werror=override-init]
     114 |         .fb_blank = intel_fbdev_blank,
         |                     ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_fbdev.c:114:21: note: (near initialization for 'intelfb_ops.fb_blank')
   cc1: all warnings being treated as errors


vim +109 drivers/gpu/drm/i915/display/intel_fbdev.c

d9a946b52350bb drivers/gpu/drm/i915/intel_fbdev.c         Rodrigo Vivi  2015-05-28  105  
b6ff753a0ca0d2 drivers/gpu/drm/i915/display/intel_fbdev.c Jani Nikula   2019-12-03  106  static const struct fb_ops intelfb_ops = {
79e539453b34e3 drivers/gpu/drm/i915/intel_fb.c            Jesse Barnes  2008-11-07  107  	.owner = THIS_MODULE,
a36384dd941b48 drivers/gpu/drm/i915/intel_fbdev.c         Stefan Christ 2016-11-14  108  	DRM_FB_HELPER_DEFAULT_OPS,
e991077ec67e08 drivers/gpu/drm/i915/intel_fbdev.c         Daniel Vetter 2014-06-18 @109  	.fb_set_par = intel_fbdev_set_par,
21cff14847421f drivers/gpu/drm/i915/intel_fbdev.c         Archit Taneja 2015-07-31  110  	.fb_fillrect = drm_fb_helper_cfb_fillrect,
21cff14847421f drivers/gpu/drm/i915/intel_fbdev.c         Archit Taneja 2015-07-31  111  	.fb_copyarea = drm_fb_helper_cfb_copyarea,
21cff14847421f drivers/gpu/drm/i915/intel_fbdev.c         Archit Taneja 2015-07-31  112  	.fb_imageblit = drm_fb_helper_cfb_imageblit,
d9a946b52350bb drivers/gpu/drm/i915/intel_fbdev.c         Rodrigo Vivi  2015-05-28  113  	.fb_pan_display = intel_fbdev_pan_display,
03e515f7f8949c drivers/gpu/drm/i915/intel_fbdev.c         Rodrigo Vivi  2015-03-09  114  	.fb_blank = intel_fbdev_blank,
785b93ef8c3097 drivers/gpu/drm/i915/intel_fb.c            Dave Airlie   2009-08-28  115  };
785b93ef8c3097 drivers/gpu/drm/i915/intel_fb.c            Dave Airlie   2009-08-28  116  

:::::: The code at line 109 was first introduced by commit
:::::: e991077ec67e08bd345fcee4f810e59740359da5 drm/i915: Properly track domain of the fbcon fb

:::::: TO: Daniel Vetter <daniel.vetter@ffwll.ch>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
