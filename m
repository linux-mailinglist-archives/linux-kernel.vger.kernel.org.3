Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108D048C715
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbiALPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:20:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:10406 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354575AbiALPUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642000816; x=1673536816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gqRf8KGBhH2wucFqmBy4iFREi8CJ/l1wEYAi+Qkyw/8=;
  b=Tt9L9Swd2Lf8TbXweydY9SXMgXpKWOjkHCm9oUMHiBzJngvGN6piSjz8
   vKNhOcdw4hgnHHucqJx8DbRlKhlDEUZ691Z6jeJPNGUvXM2kotMpgCl2e
   kvWSfk16TMwOd+c9KPdW7ytmug5O8ZJ1L4dd7kblLJSJmxblNzKKU130u
   h+bRRwPy1TAwbyBoNIt04VnzgYypkvYSMMLTqpFfhwfdme8C47cC0QrYI
   lmTv+lxmav9lBi+ZkednClGEILWMifC0LpoOQ7ALrLEPbRpkF1+U23ZhJ
   uEG4xGytHnB5/+zqNGGYwBNCmNdjt9RX9ZleC66T20/hncWR+rQ01Kl1S
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="241309977"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="241309977"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 07:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="691419011"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2022 07:19:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7fPm-00060O-SY; Wed, 12 Jan 2022 15:19:54 +0000
Date:   Wed, 12 Jan 2022 23:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shawn Tu <shawnx.tu@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [sailus-media-tree:master 15/16] drivers/media/i2c/hi847.c:2700:49:
 error: passing argument 2 of 'v4l2_subdev_get_try_format' from incompatible
 pointer type
Message-ID: <202201122346.jc4ZqZm5-lkp@intel.com>
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
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220112/202201122346.jc4ZqZm5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add sailus-media-tree git://linuxtv.org/sailus/media_tree.git
        git fetch --no-tags sailus-media-tree master
        git checkout 009f8036169f02f87f7fd5e3152f6dcd03986a81
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/i2c/hi847.c: In function 'hi847_set_format':
>> drivers/media/i2c/hi847.c:2700:49: error: passing argument 2 of 'v4l2_subdev_get_try_format' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2700 |                 *v4l2_subdev_get_try_format(sd, cfg, fmt->pad) = fmt->format;
         |                                                 ^~~
         |                                                 |
         |                                                 struct v4l2_subdev_pad_config *
   In file included from include/media/v4l2-device.h:13,
                    from drivers/media/i2c/hi847.c:11:
   include/media/v4l2-subdev.h:982:54: note: expected 'struct v4l2_subdev_state *' but argument is of type 'struct v4l2_subdev_pad_config *'
     982 |                            struct v4l2_subdev_state *state,
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/i2c/hi847.c: In function 'hi847_get_format':
   drivers/media/i2c/hi847.c:2734:71: error: passing argument 2 of 'v4l2_subdev_get_try_format' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2734 |                 fmt->format = *v4l2_subdev_get_try_format(&hi847->sd, cfg,
         |                                                                       ^~~
         |                                                                       |
         |                                                                       struct v4l2_subdev_pad_config *
   In file included from include/media/v4l2-device.h:13,
                    from drivers/media/i2c/hi847.c:11:
   include/media/v4l2-subdev.h:982:54: note: expected 'struct v4l2_subdev_state *' but argument is of type 'struct v4l2_subdev_pad_config *'
     982 |                            struct v4l2_subdev_state *state,
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/i2c/hi847.c: In function 'hi847_open':
>> drivers/media/i2c/hi847.c:2780:66: error: 'struct v4l2_subdev_fh' has no member named 'pad'
    2780 |                                 v4l2_subdev_get_try_format(sd, fh->pad, 0));
         |                                                                  ^~
   drivers/media/i2c/hi847.c: At top level:
>> drivers/media/i2c/hi847.c:2791:20: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_format *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_format *)' [-Werror=incompatible-pointer-types]
    2791 |         .set_fmt = hi847_set_format,
         |                    ^~~~~~~~~~~~~~~~
   drivers/media/i2c/hi847.c:2791:20: note: (near initialization for 'hi847_pad_ops.set_fmt')
   drivers/media/i2c/hi847.c:2792:20: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_format *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_format *)' [-Werror=incompatible-pointer-types]
    2792 |         .get_fmt = hi847_get_format,
         |                    ^~~~~~~~~~~~~~~~
   drivers/media/i2c/hi847.c:2792:20: note: (near initialization for 'hi847_pad_ops.get_fmt')
>> drivers/media/i2c/hi847.c:2793:27: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_mbus_code_enum *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_mbus_code_enum *)' [-Werror=incompatible-pointer-types]
    2793 |         .enum_mbus_code = hi847_enum_mbus_code,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/hi847.c:2793:27: note: (near initialization for 'hi847_pad_ops.enum_mbus_code')
>> drivers/media/i2c/hi847.c:2794:28: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_frame_size_enum *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_frame_size_enum *)' [-Werror=incompatible-pointer-types]
    2794 |         .enum_frame_size = hi847_enum_frame_size,
         |                            ^~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/hi847.c:2794:28: note: (near initialization for 'hi847_pad_ops.enum_frame_size')
   drivers/media/i2c/hi847.c: In function 'hi847_probe':
>> drivers/media/i2c/hi847.c:2954:15: error: implicit declaration of function 'v4l2_async_register_subdev_sensor_common'; did you mean 'v4l2_async_register_subdev_sensor'? [-Werror=implicit-function-declaration]
    2954 |         ret = v4l2_async_register_subdev_sensor_common(&hi847->sd);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               v4l2_async_register_subdev_sensor
   cc1: some warnings being treated as errors


vim +/v4l2_subdev_get_try_format +2700 drivers/media/i2c/hi847.c

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
  2734			fmt->format = *v4l2_subdev_get_try_format(&hi847->sd, cfg,
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
  2792		.get_fmt = hi847_get_format,
> 2793		.enum_mbus_code = hi847_enum_mbus_code,
> 2794		.enum_frame_size = hi847_enum_frame_size,
  2795	};
  2796	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
