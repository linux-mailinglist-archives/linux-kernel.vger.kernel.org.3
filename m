Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628714881C5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 07:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiAHGHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 01:07:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:23779 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbiAHGHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 01:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641622061; x=1673158061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iFnm1+bUL3YvHnsySUYNgqV5f3qovLQYV6y6T14WesM=;
  b=KHSvbnti3GC5Rn4ptHF1nK+Q/NLBy7yMbxHnPHOJdKMMrEV5FCdVZK9M
   NjD/UEEuHQWpadS62FxBO5+82BuoQLHEKbK95FXwfgVipjM0vsXPvRm0P
   INTPUfMaWZXz1r9Rqqln+r31h8CwT5PDdynwOBAtXBGMpjxmsb267UOGw
   u45ZAt4PfaECibBPjHcfbED49/tpan2z/aG+fV8neIBce/x7krKuNNmta
   72OX9DNzc2UPSHB+NvxYrFN58yzz9DHGuWj7WWna3F5gZsR1p8gljMtG7
   RJVWajetvqCHNZOEgh+TlOyhc5kvHtKDIgx7lCUpnRe0XVBoMvyPDtkdD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="241803599"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="241803599"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 22:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="575325702"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jan 2022 22:07:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n64t8-0000Jo-OW; Sat, 08 Jan 2022 06:07:38 +0000
Date:   Sat, 8 Jan 2022 14:07:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: drivers/media/i2c/ov5648.c:2035:39: warning: taking address of
 packed member 'handler' of class or structure 'ov5648_ctrls' may result in
 an unaligned pointer value
Message-ID: <202201081304.I6PRwgoL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1587f7bfe9a0f97a75d42ac1489aeda551106bc
commit: e43ccb0a045f34838b786e8021dc4838b4af5c38 media: i2c: Add support for the OV5648 image sensor
date:   12 months ago
config: mips-buildonly-randconfig-r002-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081304.I6PRwgoL-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e43ccb0a045f34838b786e8021dc4838b4af5c38
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e43ccb0a045f34838b786e8021dc4838b4af5c38
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/hid/ drivers/media/i2c/ drivers/media/v4l2-core/ fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/ov5648.c:2035:39: warning: taking address of packed member 'handler' of class or structure 'ov5648_ctrls' may result in an unaligned pointer value [-Waddress-of-packed-member]
           struct v4l2_ctrl_handler *handler = &ctrls->handler;
                                                ^~~~~~~~~~~~~~
>> drivers/media/i2c/ov5648.c:2054:29: warning: taking address of packed member 'exposure_auto' of class or structure 'ov5648_ctrls' may result in an unaligned pointer value [-Waddress-of-packed-member]
           v4l2_ctrl_auto_cluster(2, &ctrls->exposure_auto, 1, true);
                                      ^~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/ov5648.c:2064:29: warning: taking address of packed member 'gain_auto' of class or structure 'ov5648_ctrls' may result in an unaligned pointer value [-Waddress-of-packed-member]
           v4l2_ctrl_auto_cluster(2, &ctrls->gain_auto, 0, true);
                                      ^~~~~~~~~~~~~~~~
>> drivers/media/i2c/ov5648.c:2080:29: warning: taking address of packed member 'white_balance_auto' of class or structure 'ov5648_ctrls' may result in an unaligned pointer value [-Waddress-of-packed-member]
           v4l2_ctrl_auto_cluster(3, &ctrls->white_balance_auto, 0, false);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +2035 drivers/media/i2c/ov5648.c

  2031	
  2032	static int ov5648_ctrls_init(struct ov5648_sensor *sensor)
  2033	{
  2034		struct ov5648_ctrls *ctrls = &sensor->ctrls;
> 2035		struct v4l2_ctrl_handler *handler = &ctrls->handler;
  2036		const struct v4l2_ctrl_ops *ops = &ov5648_ctrl_ops;
  2037		int ret;
  2038	
  2039		v4l2_ctrl_handler_init(handler, 32);
  2040	
  2041		/* Use our mutex for ctrl locking. */
  2042		handler->lock = &sensor->mutex;
  2043	
  2044		/* Exposure */
  2045	
  2046		ctrls->exposure_auto = v4l2_ctrl_new_std_menu(handler, ops,
  2047							      V4L2_CID_EXPOSURE_AUTO,
  2048							      V4L2_EXPOSURE_MANUAL, 0,
  2049							      V4L2_EXPOSURE_AUTO);
  2050	
  2051		ctrls->exposure = v4l2_ctrl_new_std(handler, ops, V4L2_CID_EXPOSURE,
  2052						    16, 1048575, 16, 512);
  2053	
> 2054		v4l2_ctrl_auto_cluster(2, &ctrls->exposure_auto, 1, true);
  2055	
  2056		/* Gain */
  2057	
  2058		ctrls->gain_auto =
  2059			v4l2_ctrl_new_std(handler, ops, V4L2_CID_AUTOGAIN, 0, 1, 1, 1);
  2060	
  2061		ctrls->gain = v4l2_ctrl_new_std(handler, ops, V4L2_CID_GAIN, 16, 1023,
  2062						16, 16);
  2063	
> 2064		v4l2_ctrl_auto_cluster(2, &ctrls->gain_auto, 0, true);
  2065	
  2066		/* White Balance */
  2067	
  2068		ctrls->white_balance_auto =
  2069			v4l2_ctrl_new_std(handler, ops, V4L2_CID_AUTO_WHITE_BALANCE, 0,
  2070					  1, 1, 1);
  2071	
  2072		ctrls->red_balance = v4l2_ctrl_new_std(handler, ops,
  2073						       V4L2_CID_RED_BALANCE, 0, 4095,
  2074						       1, 1024);
  2075	
  2076		ctrls->blue_balance = v4l2_ctrl_new_std(handler, ops,
  2077							V4L2_CID_BLUE_BALANCE, 0, 4095,
  2078							1, 1024);
  2079	
> 2080		v4l2_ctrl_auto_cluster(3, &ctrls->white_balance_auto, 0, false);
  2081	
  2082		/* Flip */
  2083	
  2084		v4l2_ctrl_new_std(handler, ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
  2085		v4l2_ctrl_new_std(handler, ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
  2086	
  2087		/* Test Pattern */
  2088	
  2089		v4l2_ctrl_new_std_menu_items(handler, ops, V4L2_CID_TEST_PATTERN,
  2090					     ARRAY_SIZE(ov5648_test_pattern_menu) - 1,
  2091					     0, 0, ov5648_test_pattern_menu);
  2092	
  2093		/* MIPI CSI-2 */
  2094	
  2095		ctrls->link_freq =
  2096			v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ,
  2097					       ARRAY_SIZE(ov5648_link_freq_menu) - 1,
  2098					       0, ov5648_link_freq_menu);
  2099	
  2100		ctrls->pixel_rate =
  2101			v4l2_ctrl_new_std(handler, NULL, V4L2_CID_PIXEL_RATE, 1,
  2102					  INT_MAX, 1, 1);
  2103	
  2104		if (handler->error) {
  2105			ret = handler->error;
  2106			goto error_ctrls;
  2107		}
  2108	
  2109		ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
  2110		ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
  2111	
  2112		ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
  2113		ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
  2114	
  2115		sensor->subdev.ctrl_handler = handler;
  2116	
  2117		return 0;
  2118	
  2119	error_ctrls:
  2120		v4l2_ctrl_handler_free(handler);
  2121	
  2122		return ret;
  2123	}
  2124	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
