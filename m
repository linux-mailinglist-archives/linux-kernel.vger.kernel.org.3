Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD448E72E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiANJNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:13:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:43289 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbiANJNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642151618; x=1673687618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GQ9R/5pgFRevyS47qqCQqrNRQf3Af/vF6OA7EqGRVn4=;
  b=DlBLFju9vOwoo11uKFjFgh0E2LXZa7mS6cf5GbhkoPChVe7GePgLzvvL
   t+/YNzAUkTYt10KqWebhg/ViFT8Mgj1G3axb5tbf4R+O3fM3TYnTohQ2U
   zwOdLMG9fXOeD/z3Y8f6qHd74Kii2uLBasi7cBargDlICj6A+WIN43MqZ
   +anwfEhMScZ62qH5Md3MW2OAuO8ZSaeD8UJetod1wW39zobiwPhAJhhS5
   TMnzEhNiM/++K98dQisxsVvxoB9+yHmF4Poa3CbZKUFAZDZJgN9G/QY8x
   AmM6mrb8TBOZ3BPvwRPpA8l5OiLArZV47tID0iS2XMiJf6PeZ4PYbsVIP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231561814"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="231561814"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 01:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="475714140"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2022 01:13:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8IeN-0008Lt-P0; Fri, 14 Jan 2022 09:13:35 +0000
Date:   Fri, 14 Jan 2022 17:13:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shawn Tu <shawnx.tu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [sailus-media-tree:master 15/16] drivers/media/i2c/hi847.c:2700:35:
 error: incompatible pointer types passing 'struct v4l2_subdev_pad_config *'
 to parameter of type 'struct v4l2_subdev_state *'
Message-ID: <202201141739.Q7kFIE7g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/sailus/media_tree.git master
head:   232068c0bf39d2e34585450343c1439a89aad66b
commit: 009f8036169f02f87f7fd5e3152f6dcd03986a81 [15/16] media: hi847: Add support for Hi-847 sensor
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201141739.Q7kFIE7g-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add sailus-media-tree git://linuxtv.org/sailus/media_tree.git
        git fetch --no-tags sailus-media-tree master
        git checkout 009f8036169f02f87f7fd5e3152f6dcd03986a81
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/i2c/hi847.c:2700:35: error: incompatible pointer types passing 'struct v4l2_subdev_pad_config *' to parameter of type 'struct v4l2_subdev_state *' [-Werror,-Wincompatible-pointer-types]
                   *v4l2_subdev_get_try_format(sd, cfg, fmt->pad) = fmt->format;
                                                   ^~~
   include/media/v4l2-subdev.h:982:33: note: passing argument to parameter 'state' here
                              struct v4l2_subdev_state *state,
                                                        ^
   drivers/media/i2c/hi847.c:2734:57: error: incompatible pointer types passing 'struct v4l2_subdev_pad_config *' to parameter of type 'struct v4l2_subdev_state *' [-Werror,-Wincompatible-pointer-types]
                   fmt->format = *v4l2_subdev_get_try_format(&hi847->sd, cfg,
                                                                         ^~~
   include/media/v4l2-subdev.h:982:33: note: passing argument to parameter 'state' here
                              struct v4l2_subdev_state *state,
                                                        ^
>> drivers/media/i2c/hi847.c:2780:40: error: no member named 'pad' in 'struct v4l2_subdev_fh'
                                   v4l2_subdev_get_try_format(sd, fh->pad, 0));
                                                                  ~~  ^
>> drivers/media/i2c/hi847.c:2791:13: error: incompatible function pointer types initializing 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_format *)' with an expression of type 'int (struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_format *)' [-Werror,-Wincompatible-function-pointer-types]
           .set_fmt = hi847_set_format,
                      ^~~~~~~~~~~~~~~~
   drivers/media/i2c/hi847.c:2792:13: error: incompatible function pointer types initializing 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_format *)' with an expression of type 'int (struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_format *)' [-Werror,-Wincompatible-function-pointer-types]
           .get_fmt = hi847_get_format,
                      ^~~~~~~~~~~~~~~~
>> drivers/media/i2c/hi847.c:2793:20: error: incompatible function pointer types initializing 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_mbus_code_enum *)' with an expression of type 'int (struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_mbus_code_enum *)' [-Werror,-Wincompatible-function-pointer-types]
           .enum_mbus_code = hi847_enum_mbus_code,
                             ^~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/hi847.c:2794:21: error: incompatible function pointer types initializing 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_frame_size_enum *)' with an expression of type 'int (struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_frame_size_enum *)' [-Werror,-Wincompatible-function-pointer-types]
           .enum_frame_size = hi847_enum_frame_size,
                              ^~~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/hi847.c:2954:8: error: implicit declaration of function 'v4l2_async_register_subdev_sensor_common' [-Werror,-Wimplicit-function-declaration]
           ret = v4l2_async_register_subdev_sensor_common(&hi847->sd);
                 ^
   drivers/media/i2c/hi847.c:2954:8: note: did you mean 'v4l2_async_register_subdev_sensor'?
   include/media/v4l2-async.h:305:1: note: 'v4l2_async_register_subdev_sensor' declared here
   v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd);
   ^
   8 errors generated.


vim +2700 drivers/media/i2c/hi847.c

  2683	
  2684	static int hi847_set_format(struct v4l2_subdev *sd,
  2685				    struct v4l2_subdev_pad_config *cfg,
  2686				    struct v4l2_subdev_format *fmt)
  2687	{
  2688		struct hi847 *hi847 = to_hi847(sd);
  2689		const struct hi847_mode *mode;
  2690		s32 vblank_def, h_blank;
  2691	
  2692		mode = v4l2_find_nearest_size(supported_modes,
  2693					      ARRAY_SIZE(supported_modes), width,
  2694					      height, fmt->format.width,
  2695					      fmt->format.height);
  2696	
  2697		mutex_lock(&hi847->mutex);
  2698		hi847_assign_pad_format(mode, &fmt->format);
  2699		if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
> 2700			*v4l2_subdev_get_try_format(sd, cfg, fmt->pad) = fmt->format;
  2701		} else {
  2702			hi847->cur_mode = mode;
  2703			__v4l2_ctrl_s_ctrl(hi847->link_freq, mode->link_freq_index);
  2704			__v4l2_ctrl_s_ctrl_int64(hi847->pixel_rate,
  2705						 to_pixel_rate(mode->link_freq_index));
  2706	
  2707			/* Update limits and set FPS to default */
  2708			vblank_def = mode->fll_def - mode->height;
  2709			__v4l2_ctrl_modify_range(hi847->vblank,
  2710						 mode->fll_min - mode->height,
  2711						 HI847_FLL_MAX - mode->height, 1,
  2712						 vblank_def);
  2713			__v4l2_ctrl_s_ctrl(hi847->vblank, vblank_def);
  2714	
  2715			h_blank = hi847->cur_mode->llp - hi847->cur_mode->width;
  2716	
  2717			__v4l2_ctrl_modify_range(hi847->hblank, h_blank, h_blank, 1,
  2718						 h_blank);
  2719		}
  2720	
  2721		mutex_unlock(&hi847->mutex);
  2722	
  2723		return 0;
  2724	}
  2725	
  2726	static int hi847_get_format(struct v4l2_subdev *sd,
  2727				    struct v4l2_subdev_pad_config *cfg,
  2728				    struct v4l2_subdev_format *fmt)
  2729	{
  2730		struct hi847 *hi847 = to_hi847(sd);
  2731	
  2732		mutex_lock(&hi847->mutex);
  2733		if (fmt->which == V4L2_SUBDEV_FORMAT_TRY)
> 2734			fmt->format = *v4l2_subdev_get_try_format(&hi847->sd, cfg,
  2735								  fmt->pad);
  2736		else
  2737			hi847_assign_pad_format(hi847->cur_mode, &fmt->format);
  2738	
  2739		mutex_unlock(&hi847->mutex);
  2740	
  2741		return 0;
  2742	}
  2743	
  2744	static int hi847_enum_mbus_code(struct v4l2_subdev *sd,
  2745					struct v4l2_subdev_pad_config *cfg,
  2746					struct v4l2_subdev_mbus_code_enum *code)
  2747	{
  2748		if (code->index > 0)
  2749			return -EINVAL;
  2750	
  2751		code->code = MEDIA_BUS_FMT_SGRBG10_1X10;
  2752	
  2753		return 0;
  2754	}
  2755	
  2756	static int hi847_enum_frame_size(struct v4l2_subdev *sd,
  2757					 struct v4l2_subdev_pad_config *cfg,
  2758					 struct v4l2_subdev_frame_size_enum *fse)
  2759	{
  2760		if (fse->index >= ARRAY_SIZE(supported_modes))
  2761			return -EINVAL;
  2762	
  2763		if (fse->code != MEDIA_BUS_FMT_SGRBG10_1X10)
  2764			return -EINVAL;
  2765	
  2766		fse->min_width = supported_modes[fse->index].width;
  2767		fse->max_width = fse->min_width;
  2768		fse->min_height = supported_modes[fse->index].height;
  2769		fse->max_height = fse->min_height;
  2770	
  2771		return 0;
  2772	}
  2773	
  2774	static int hi847_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
  2775	{
  2776		struct hi847 *hi847 = to_hi847(sd);
  2777	
  2778		mutex_lock(&hi847->mutex);
  2779		hi847_assign_pad_format(&supported_modes[0],
> 2780					v4l2_subdev_get_try_format(sd, fh->pad, 0));
  2781		mutex_unlock(&hi847->mutex);
  2782	
  2783		return 0;
  2784	}
  2785	
  2786	static const struct v4l2_subdev_video_ops hi847_video_ops = {
  2787		.s_stream = hi847_set_stream,
  2788	};
  2789	
  2790	static const struct v4l2_subdev_pad_ops hi847_pad_ops = {
> 2791		.set_fmt = hi847_set_format,
> 2792		.get_fmt = hi847_get_format,
> 2793		.enum_mbus_code = hi847_enum_mbus_code,
> 2794		.enum_frame_size = hi847_enum_frame_size,
  2795	};
  2796	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
