Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2E48FFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 00:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiAPX5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 18:57:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:6306 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236448AbiAPX5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 18:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642377439; x=1673913439;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m+eksH4Z3VDFmbqZqXMcQR7273i5vhsghkYH3f7+ImE=;
  b=duU3Zz4LBvBb9lHpj3KKVynffB3Ui48bJXE51bkDrZikaTPQDOSqRRAU
   XWMPvHxkuWDIfI3b/AdaXI4o2WsmB1miuLw/5I5jhoqiMU4xPSGFGgRgG
   YiMHaNDoQ1q3brnt3sluddz9P0BmRgHYOAATUHVNw1HEdIF4hHaFf/lXO
   1ln9oAV7d5nvwzzaebmuz2ubvHwU4PToH6VNmKeszkCZDf6iUblAdYvXc
   7X5wKK8Yqdcokop85qOlWC/lO9BVP8jaqwZGlfywn4h5LMZDOh6yIn0/3
   BTDn+EEzo3yn4HUAlRslwwpToCkGlnIoqnlgTjD44k2ZlzLDKb+LXOcGP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="307864505"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="307864505"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 15:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="474266090"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2022 15:57:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9FOe-000B4A-Uq; Sun, 16 Jan 2022 23:57:16 +0000
Date:   Mon, 17 Jan 2022 07:56:38 +0800
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
Message-ID: <202201170727.bHmScZS3-lkp@intel.com>
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
head:   79e06c4c4950be2abd8ca5d2428a8c915aa62c24
commit: e43ccb0a045f34838b786e8021dc4838b4af5c38 media: i2c: Add support for the OV5648 image sensor
date:   1 year ago
config: mips-randconfig-r002-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170727.bHmScZS3-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/hid/ drivers/iio/adc/ drivers/media/i2c/ drivers/media/v4l2-core/ drivers/usb/gadget/

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
