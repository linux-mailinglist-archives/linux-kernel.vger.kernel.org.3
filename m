Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53B149334C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiASDGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:06:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:5460 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238949AbiASDGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642561572; x=1674097572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=suGQKurNhAumEguqauMFlkJHUXMnmfTXDMhJlCMvqIs=;
  b=Se8TXDkexUzK5JQx5rbGIdkfOjyUvZg8/zkbN5TS/yoKN63+OVAgybWj
   DSNyBrBkSKaYhAKOoqCZnfbEKpXOoWQSSQs4wibRY2D/DH96uPpcPAQX5
   aedA455fkzzncMiv+GlG/KWdAGJHhEFPYWZjN2rYCuvv69+3bU8aMmI6N
   zhpNEfRNN1cvAP72BC8hcJGfcq325djmuyAIpocmq+xONyE5i/v6+kbnf
   6ZdOTDqeFPilgRTXTVGaVN0Gv2HMb40wLUxRo8Ri+fX+Fn6jSSCRVZpKR
   XzeW91nFkEb+A7MIT6cOr+pmwYMweHnWQwsl93P68RqbweeHz2B4ZrkmH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305701329"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="305701329"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 19:06:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="622363327"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2022 19:06:12 -0800
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 19:06:11 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 11:06:09 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.2308.020;
 Wed, 19 Jan 2022 11:06:09 +0800
From:   "Tu, ShawnX" <shawnx.tu@intel.com>
To:     lkp <lkp@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [sailus-media-tree:master 15/16]
 drivers/media/i2c/hi847.c:2700:35: error: incompatible pointer types passing
 'struct v4l2_subdev_pad_config *' to parameter of type 'struct
 v4l2_subdev_state *'
Thread-Topic: [sailus-media-tree:master 15/16]
 drivers/media/i2c/hi847.c:2700:35: error: incompatible pointer types passing
 'struct v4l2_subdev_pad_config *' to parameter of type 'struct
 v4l2_subdev_state *'
Thread-Index: AQHYCScEi8gK1wAzgEOqyXUEOnWdEqxpqpfw
Date:   Wed, 19 Jan 2022 03:06:09 +0000
Message-ID: <3e680a691f9543fabf4b2cdc5de2bf6d@intel.com>
References: <202201141739.Q7kFIE7g-lkp@intel.com>
In-Reply-To: <202201141739.Q7kFIE7g-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
x-originating-ip: [10.108.32.68]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

It has uploaded fixed V2 patch to the server.
* [PATCH v2] media: hi847: Add support for Hi-847 sensor
https://github.com/0day-ci/linux/commits/Shawnx-Tu/media-hi847-Add-support-=
for-Hi-847-sensor/20220113-120102

But I still see the lkp build error message and use previous V1 patch to bu=
ild.
Could you help to check? If needs to fix the driver, I'll upload new one.

>> drivers/media/i2c/hi847.c:2954:8: error: implicit declaration of=20
>> function 'v4l2_async_register_subdev_sensor_common'=20
>> [-Werror,-Wimplicit-function-declaration]
           ret =3D v4l2_async_register_subdev_sensor_common(&hi847->sd);
                 ^

Thanks,
Shawn
-----Original Message-----
From: lkp <lkp@intel.com>=20
Sent: Friday, January 14, 2022 5:14 PM
To: Tu, ShawnX <shawnx.tu@intel.com>
Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; linux-kernel@vger.kernel=
.org; Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [sailus-media-tree:master 15/16] drivers/media/i2c/hi847.c:2700:35=
: error: incompatible pointer types passing 'struct v4l2_subdev_pad_config =
*' to parameter of type 'struct v4l2_subdev_state *'

tree:   git://linuxtv.org/sailus/media_tree.git master
head:   232068c0bf39d2e34585450343c1439a89aad66b
commit: 009f8036169f02f87f7fd5e3152f6dcd03986a81 [15/16] media: hi847: Add =
support for Hi-847 sensor
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220114=
/202201141739.Q7kFIE7g-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2=
913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add sailus-media-tree git://linuxtv.org/sailus/media_tre=
e.git
        git fetch --no-tags sailus-media-tree master
        git checkout 009f8036169f02f87f7fd5e3152f6dcd03986a81
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/i2c/hi847.c:2700:35: error: incompatible pointer types=20
>> passing 'struct v4l2_subdev_pad_config *' to parameter of type=20
>> 'struct v4l2_subdev_state *' [-Werror,-Wincompatible-pointer-types]
                   *v4l2_subdev_get_try_format(sd, cfg, fmt->pad) =3D fmt->=
format;
                                                   ^~~
   include/media/v4l2-subdev.h:982:33: note: passing argument to parameter =
'state' here
                              struct v4l2_subdev_state *state,
                                                        ^
   drivers/media/i2c/hi847.c:2734:57: error: incompatible pointer types pas=
sing 'struct v4l2_subdev_pad_config *' to parameter of type 'struct v4l2_su=
bdev_state *' [-Werror,-Wincompatible-pointer-types]
                   fmt->format =3D *v4l2_subdev_get_try_format(&hi847->sd, =
cfg,
                                                                         ^~=
~
   include/media/v4l2-subdev.h:982:33: note: passing argument to parameter =
'state' here
                              struct v4l2_subdev_state *state,
                                                        ^
>> drivers/media/i2c/hi847.c:2780:40: error: no member named 'pad' in 'stru=
ct v4l2_subdev_fh'
                                   v4l2_subdev_get_try_format(sd, fh->pad, =
0));
                                                                  ~~  ^
>> drivers/media/i2c/hi847.c:2791:13: error: incompatible function=20
>> pointer types initializing 'int (*)(struct v4l2_subdev *, struct=20
>> v4l2_subdev_state *, struct v4l2_subdev_format *)' with an expression=20
>> of type 'int (struct v4l2_subdev *, struct v4l2_subdev_pad_config *,=20
>> struct v4l2_subdev_format *)'=20
>> [-Werror,-Wincompatible-function-pointer-types]
           .set_fmt =3D hi847_set_format,
                      ^~~~~~~~~~~~~~~~
   drivers/media/i2c/hi847.c:2792:13: error: incompatible function pointer =
types initializing 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state =
*, struct v4l2_subdev_format *)' with an expression of type 'int (struct v4=
l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_format *)'=
 [-Werror,-Wincompatible-function-pointer-types]
           .get_fmt =3D hi847_get_format,
                      ^~~~~~~~~~~~~~~~
>> drivers/media/i2c/hi847.c:2793:20: error: incompatible function=20
>> pointer types initializing 'int (*)(struct v4l2_subdev *, struct=20
>> v4l2_subdev_state *, struct v4l2_subdev_mbus_code_enum *)' with an=20
>> expression of type 'int (struct v4l2_subdev *, struct=20
>> v4l2_subdev_pad_config *, struct v4l2_subdev_mbus_code_enum *)'=20
>> [-Werror,-Wincompatible-function-pointer-types]
           .enum_mbus_code =3D hi847_enum_mbus_code,
                             ^~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/hi847.c:2794:21: error: incompatible function=20
>> pointer types initializing 'int (*)(struct v4l2_subdev *, struct=20
>> v4l2_subdev_state *, struct v4l2_subdev_frame_size_enum *)' with an=20
>> expression of type 'int (struct v4l2_subdev *, struct=20
>> v4l2_subdev_pad_config *, struct v4l2_subdev_frame_size_enum *)'=20
>> [-Werror,-Wincompatible-function-pointer-types]
           .enum_frame_size =3D hi847_enum_frame_size,
                              ^~~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/hi847.c:2954:8: error: implicit declaration of=20
>> function 'v4l2_async_register_subdev_sensor_common'=20
>> [-Werror,-Wimplicit-function-declaration]
           ret =3D v4l2_async_register_subdev_sensor_common(&hi847->sd);
                 ^
   drivers/media/i2c/hi847.c:2954:8: note: did you mean 'v4l2_async_registe=
r_subdev_sensor'?
   include/media/v4l2-async.h:305:1: note: 'v4l2_async_register_subdev_sens=
or' declared here
   v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd);
   ^
   8 errors generated.


vim +2700 drivers/media/i2c/hi847.c

  2683=09
  2684	static int hi847_set_format(struct v4l2_subdev *sd,
  2685				    struct v4l2_subdev_pad_config *cfg,
  2686				    struct v4l2_subdev_format *fmt)
  2687	{
  2688		struct hi847 *hi847 =3D to_hi847(sd);
  2689		const struct hi847_mode *mode;
  2690		s32 vblank_def, h_blank;
  2691=09
  2692		mode =3D v4l2_find_nearest_size(supported_modes,
  2693					      ARRAY_SIZE(supported_modes), width,
  2694					      height, fmt->format.width,
  2695					      fmt->format.height);
  2696=09
  2697		mutex_lock(&hi847->mutex);
  2698		hi847_assign_pad_format(mode, &fmt->format);
  2699		if (fmt->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) {
> 2700			*v4l2_subdev_get_try_format(sd, cfg, fmt->pad) =3D fmt->format;
  2701		} else {
  2702			hi847->cur_mode =3D mode;
  2703			__v4l2_ctrl_s_ctrl(hi847->link_freq, mode->link_freq_index);
  2704			__v4l2_ctrl_s_ctrl_int64(hi847->pixel_rate,
  2705						 to_pixel_rate(mode->link_freq_index));
  2706=09
  2707			/* Update limits and set FPS to default */
  2708			vblank_def =3D mode->fll_def - mode->height;
  2709			__v4l2_ctrl_modify_range(hi847->vblank,
  2710						 mode->fll_min - mode->height,
  2711						 HI847_FLL_MAX - mode->height, 1,
  2712						 vblank_def);
  2713			__v4l2_ctrl_s_ctrl(hi847->vblank, vblank_def);
  2714=09
  2715			h_blank =3D hi847->cur_mode->llp - hi847->cur_mode->width;
  2716=09
  2717			__v4l2_ctrl_modify_range(hi847->hblank, h_blank, h_blank, 1,
  2718						 h_blank);
  2719		}
  2720=09
  2721		mutex_unlock(&hi847->mutex);
  2722=09
  2723		return 0;
  2724	}
  2725=09
  2726	static int hi847_get_format(struct v4l2_subdev *sd,
  2727				    struct v4l2_subdev_pad_config *cfg,
  2728				    struct v4l2_subdev_format *fmt)
  2729	{
  2730		struct hi847 *hi847 =3D to_hi847(sd);
  2731=09
  2732		mutex_lock(&hi847->mutex);
  2733		if (fmt->which =3D=3D V4L2_SUBDEV_FORMAT_TRY)
> 2734			fmt->format =3D *v4l2_subdev_get_try_format(&hi847->sd, cfg,
  2735								  fmt->pad);
  2736		else
  2737			hi847_assign_pad_format(hi847->cur_mode, &fmt->format);
  2738=09
  2739		mutex_unlock(&hi847->mutex);
  2740=09
  2741		return 0;
  2742	}
  2743=09
  2744	static int hi847_enum_mbus_code(struct v4l2_subdev *sd,
  2745					struct v4l2_subdev_pad_config *cfg,
  2746					struct v4l2_subdev_mbus_code_enum *code)
  2747	{
  2748		if (code->index > 0)
  2749			return -EINVAL;
  2750=09
  2751		code->code =3D MEDIA_BUS_FMT_SGRBG10_1X10;
  2752=09
  2753		return 0;
  2754	}
  2755=09
  2756	static int hi847_enum_frame_size(struct v4l2_subdev *sd,
  2757					 struct v4l2_subdev_pad_config *cfg,
  2758					 struct v4l2_subdev_frame_size_enum *fse)
  2759	{
  2760		if (fse->index >=3D ARRAY_SIZE(supported_modes))
  2761			return -EINVAL;
  2762=09
  2763		if (fse->code !=3D MEDIA_BUS_FMT_SGRBG10_1X10)
  2764			return -EINVAL;
  2765=09
  2766		fse->min_width =3D supported_modes[fse->index].width;
  2767		fse->max_width =3D fse->min_width;
  2768		fse->min_height =3D supported_modes[fse->index].height;
  2769		fse->max_height =3D fse->min_height;
  2770=09
  2771		return 0;
  2772	}
  2773=09
  2774	static int hi847_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh =
*fh)
  2775	{
  2776		struct hi847 *hi847 =3D to_hi847(sd);
  2777=09
  2778		mutex_lock(&hi847->mutex);
  2779		hi847_assign_pad_format(&supported_modes[0],
> 2780					v4l2_subdev_get_try_format(sd, fh->pad, 0));
  2781		mutex_unlock(&hi847->mutex);
  2782=09
  2783		return 0;
  2784	}
  2785=09
  2786	static const struct v4l2_subdev_video_ops hi847_video_ops =3D {
  2787		.s_stream =3D hi847_set_stream,
  2788	};
  2789=09
  2790	static const struct v4l2_subdev_pad_ops hi847_pad_ops =3D {
> 2791		.set_fmt =3D hi847_set_format,
> 2792		.get_fmt =3D hi847_get_format,
> 2793		.enum_mbus_code =3D hi847_enum_mbus_code,
> 2794		.enum_frame_size =3D hi847_enum_frame_size,
  2795	};
  2796=09

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperk=
itty/list/kbuild-all@lists.01.org
