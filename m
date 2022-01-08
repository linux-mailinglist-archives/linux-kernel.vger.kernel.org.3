Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1121348859C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiAHTgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:36:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:3054 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231128AbiAHTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641670569; x=1673206569;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bDMUrwGe2jhTC0BBGjpD0yzuAd+3fBGOjVRSbi2p12M=;
  b=aLt8gULwkZ+hBU1iBG7DysqMi9DXu9QU52cOB1uSMd3zWf/JKV9l7RKQ
   k5Gv8Y9jf6+/ZfKj5imKRv9ov5Daw3F5NJ7bX+hm307ETm9qCMmhlfNiG
   VmQ8pYW+7LL5O4XmBGZnQDPj3Q7FSFphgns5JCoHnDiWQooZkmthCT23n
   n+cbwxuR6Z3MGUsa8JBB5rW58f6FqLujRGVlNrnupGFSGMyP+kkRS7uKK
   2wQh+3X0N9CFm+eiwZ2Ws5BKtY9kBKeiQRIoN4jncU62MZoPbAfyUIl9z
   UxxX1Ug35o4dvvWRJQBlN/FdqMYmTMhlhv0UKgQrE2M4BV64UbikUvBZB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="242831744"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="242831744"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 11:36:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="514214730"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 11:36:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6HVX-0000yl-2E; Sat, 08 Jan 2022 19:36:07 +0000
Date:   Sun, 9 Jan 2022 03:35:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liangliang Li <liliangliang@vivo.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 3085/9999] drivers/gpu/drm/exynos/exynos5433_drm_decon.c:380:1: warning: the
 frame size of 1028 bytes is larger than 1024 bytes
Message-ID: <202201090315.ZzC0wcpk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   d5c19346d14b2bdccf8b127cdbcc36696539d6bb
commit: 372b24bad2a8e7994d0360c870f6e981e3f4bb8f [3085/9999] ANDROID: GKI: Add OEM data to mutex/rwsem
config: arm-randconfig-c002-20220106 (https://download.01.org/0day-ci/archive/20220109/202201090315.ZzC0wcpk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/372b24bad2a8e7994d0360c870f6e981e3f4bb8f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 372b24bad2a8e7994d0360c870f6e981e3f4bb8f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/exynos/exynos5433_drm_decon.c: In function 'decon_win_set_pixfmt':
>> drivers/gpu/drm/exynos/exynos5433_drm_decon.c:380:1: warning: the frame size of 1028 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     380 | }
         | ^


vim +380 drivers/gpu/drm/exynos/exynos5433_drm_decon.c

54947290ef6288 Christoph Manszewski 2018-10-25  317  
2eeb2e5e6634db Gustavo Padovan      2015-08-03  318  static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
2eeb2e5e6634db Gustavo Padovan      2015-08-03  319  				 struct drm_framebuffer *fb)
c8466a9166b00e Joonyoung Shim       2015-06-12  320  {
54947290ef6288 Christoph Manszewski 2018-10-25  321  	struct exynos_drm_plane plane = ctx->planes[win];
54947290ef6288 Christoph Manszewski 2018-10-25  322  	struct exynos_drm_plane_state *state =
54947290ef6288 Christoph Manszewski 2018-10-25  323  		to_exynos_plane_state(plane.base.state);
54947290ef6288 Christoph Manszewski 2018-10-25  324  	unsigned int alpha = state->base.alpha;
af130280c61321 Christoph Manszewski 2018-10-25  325  	unsigned int pixel_alpha;
c8466a9166b00e Joonyoung Shim       2015-06-12  326  	unsigned long val;
c8466a9166b00e Joonyoung Shim       2015-06-12  327  
af130280c61321 Christoph Manszewski 2018-10-25  328  	if (fb->format->has_alpha)
af130280c61321 Christoph Manszewski 2018-10-25  329  		pixel_alpha = state->base.pixel_blend_mode;
af130280c61321 Christoph Manszewski 2018-10-25  330  	else
af130280c61321 Christoph Manszewski 2018-10-25  331  		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
af130280c61321 Christoph Manszewski 2018-10-25  332  
c8466a9166b00e Joonyoung Shim       2015-06-12  333  	val = readl(ctx->addr + DECON_WINCONx(win));
7b7aa62c05eac9 Marek Szyprowski     2018-06-07  334  	val &= WINCONx_ENWIN_F;
c8466a9166b00e Joonyoung Shim       2015-06-12  335  
438b74a5497c36 Ville Syrjälä        2016-12-14  336  	switch (fb->format->format) {
c8466a9166b00e Joonyoung Shim       2015-06-12  337  	case DRM_FORMAT_XRGB1555:
c8466a9166b00e Joonyoung Shim       2015-06-12  338  		val |= WINCONx_BPPMODE_16BPP_I1555;
c8466a9166b00e Joonyoung Shim       2015-06-12  339  		val |= WINCONx_HAWSWP_F;
c8466a9166b00e Joonyoung Shim       2015-06-12  340  		val |= WINCONx_BURSTLEN_16WORD;
c8466a9166b00e Joonyoung Shim       2015-06-12  341  		break;
c8466a9166b00e Joonyoung Shim       2015-06-12  342  	case DRM_FORMAT_RGB565:
c8466a9166b00e Joonyoung Shim       2015-06-12  343  		val |= WINCONx_BPPMODE_16BPP_565;
c8466a9166b00e Joonyoung Shim       2015-06-12  344  		val |= WINCONx_HAWSWP_F;
c8466a9166b00e Joonyoung Shim       2015-06-12  345  		val |= WINCONx_BURSTLEN_16WORD;
c8466a9166b00e Joonyoung Shim       2015-06-12  346  		break;
c8466a9166b00e Joonyoung Shim       2015-06-12  347  	case DRM_FORMAT_XRGB8888:
c8466a9166b00e Joonyoung Shim       2015-06-12  348  		val |= WINCONx_BPPMODE_24BPP_888;
c8466a9166b00e Joonyoung Shim       2015-06-12  349  		val |= WINCONx_WSWP_F;
c8466a9166b00e Joonyoung Shim       2015-06-12  350  		val |= WINCONx_BURSTLEN_16WORD;
c8466a9166b00e Joonyoung Shim       2015-06-12  351  		break;
c8466a9166b00e Joonyoung Shim       2015-06-12  352  	case DRM_FORMAT_ARGB8888:
5b7b1b7fa10145 Tobias Jakobi        2017-08-22  353  	default:
c8466a9166b00e Joonyoung Shim       2015-06-12  354  		val |= WINCONx_BPPMODE_32BPP_A8888;
af130280c61321 Christoph Manszewski 2018-10-25  355  		val |= WINCONx_WSWP_F;
c8466a9166b00e Joonyoung Shim       2015-06-12  356  		val |= WINCONx_BURSTLEN_16WORD;
c8466a9166b00e Joonyoung Shim       2015-06-12  357  		break;
c8466a9166b00e Joonyoung Shim       2015-06-12  358  	}
c8466a9166b00e Joonyoung Shim       2015-06-12  359  
6be900563a9e74 Inki Dae             2019-04-15  360  	DRM_DEV_DEBUG_KMS(ctx->dev, "cpp = %u\n", fb->format->cpp[0]);
c8466a9166b00e Joonyoung Shim       2015-06-12  361  
c8466a9166b00e Joonyoung Shim       2015-06-12  362  	/*
c8466a9166b00e Joonyoung Shim       2015-06-12  363  	 * In case of exynos, setting dma-burst to 16Word causes permanent
c8466a9166b00e Joonyoung Shim       2015-06-12  364  	 * tearing for very small buffers, e.g. cursor buffer. Burst Mode
c8466a9166b00e Joonyoung Shim       2015-06-12  365  	 * switching which is based on plane size is not recommended as
c8466a9166b00e Joonyoung Shim       2015-06-12  366  	 * plane size varies a lot towards the end of the screen and rapid
c8466a9166b00e Joonyoung Shim       2015-06-12  367  	 * movement causes unstable DMA which results into iommu crash/tear.
c8466a9166b00e Joonyoung Shim       2015-06-12  368  	 */
c8466a9166b00e Joonyoung Shim       2015-06-12  369  
2eeb2e5e6634db Gustavo Padovan      2015-08-03  370  	if (fb->width < MIN_FB_WIDTH_FOR_16WORD_BURST) {
c8466a9166b00e Joonyoung Shim       2015-06-12  371  		val &= ~WINCONx_BURSTLEN_MASK;
c8466a9166b00e Joonyoung Shim       2015-06-12  372  		val |= WINCONx_BURSTLEN_8WORD;
c8466a9166b00e Joonyoung Shim       2015-06-12  373  	}
af130280c61321 Christoph Manszewski 2018-10-25  374  	decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
c8466a9166b00e Joonyoung Shim       2015-06-12  375  
af130280c61321 Christoph Manszewski 2018-10-25  376  	if (win > 0) {
af130280c61321 Christoph Manszewski 2018-10-25  377  		decon_win_set_bldmod(ctx, win, alpha, pixel_alpha);
af130280c61321 Christoph Manszewski 2018-10-25  378  		decon_win_set_bldeq(ctx, win, alpha, pixel_alpha);
af130280c61321 Christoph Manszewski 2018-10-25  379  	}
c8466a9166b00e Joonyoung Shim       2015-06-12 @380  }
c8466a9166b00e Joonyoung Shim       2015-06-12  381  

:::::: The code at line 380 was first introduced by commit
:::::: c8466a9166b00ecb0c6f768baf70636fe15f63ef drm/exynos: add Exynos5433 decon driver

:::::: TO: Joonyoung Shim <jy0922.shim@samsung.com>
:::::: CC: Inki Dae <inki.dae@samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
