Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B5474ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhLOAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:01:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:6580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhLOAB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639526517; x=1671062517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fb2cVcz4LwC7zZEOQweYUdwyszIStBC9RhYXkmAbPrA=;
  b=n0QJURbn+PGSpiniOaAw/Mq64yxE5PRb7JutMeyrvVFNqhY9SBbT+mwM
   xGF/eTQwE5AG0iH1YCa7PUDm7nsqnnS7JmLw39R5tj/gKphvCR3XHtT45
   QDmMMPB2n4IXldKshNXtySTa2G/pNslqHP8oAPeMQk5u1IV08khTDbpGT
   e1wkxeBBfwC+dF1fFm0/kJ8wo4eV4CKxxDlnHUwJdN+5A6rXQa6ad58Pt
   BPqPwkxS36PlpxZgAcw0Ep+0aMUtmYEY2cGteeEuIxx7zn/MLueSfQsbF
   RFMEht2bL5LlT5v8OBrZ7eCtfagLi1//WkyLrbdjGzxQ6ya/I7O0kKbVz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237846488"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="237846488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 16:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="661675155"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2021 16:01:35 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxHjj-0000x0-3Q; Wed, 15 Dec 2021 00:01:35 +0000
Date:   Wed, 15 Dec 2021 08:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linuxtv-commits@linuxtv.org
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [git:media_stage/master] media: i2c: Add driver for the Analog
 Devices ADDI9036 ToF front-end
Message-ID: <202112150733.a6LCjbXP-lkp@intel.com>
References: <E1mx7hB-002ppP-O7@www.linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1mx7hB-002ppP-O7@www.linuxtv.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

I love your patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linux/master linus/master v5.16-rc5 next-20211213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mauro-Carvalho-Chehab/media-i2c-Add-driver-for-the-Analog-Devices-ADDI9036-ToF-front-end/20211214-211851
base:   git://linuxtv.org/media_tree.git master
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20211215/202112150733.a6LCjbXP-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ec03b2029965b84eff6a7d1e8fe130330c3e69ed
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mauro-Carvalho-Chehab/media-i2c-Add-driver-for-the-Analog-Devices-ADDI9036-ToF-front-end/20211214-211851
        git checkout ec03b2029965b84eff6a7d1e8fe130330c3e69ed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/i2c/addi9036.c: In function 'addi9036_get_pad_format':
>> drivers/media/i2c/addi9036.c:310:66: error: passing argument 2 of 'v4l2_subdev_get_try_format' from incompatible pointer type [-Werror=incompatible-pointer-types]
     310 |                 return v4l2_subdev_get_try_format(&addi9036->sd, cfg, pad);
         |                                                                  ^~~
         |                                                                  |
         |                                                                  struct v4l2_subdev_pad_config *
   In file included from drivers/media/i2c/addi9036.c:17:
   include/media/v4l2-subdev.h:995:54: note: expected 'struct v4l2_subdev_state *' but argument is of type 'struct v4l2_subdev_pad_config *'
     995 |                            struct v4l2_subdev_state *state,
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/i2c/addi9036.c: In function 'addi9036_get_pad_crop':
>> drivers/media/i2c/addi9036.c:342:64: error: passing argument 2 of 'v4l2_subdev_get_try_crop' from incompatible pointer type [-Werror=incompatible-pointer-types]
     342 |                 return v4l2_subdev_get_try_crop(&addi9036->sd, cfg, pad);
         |                                                                ^~~
         |                                                                |
         |                                                                struct v4l2_subdev_pad_config *
   In file included from drivers/media/i2c/addi9036.c:17:
   include/media/v4l2-subdev.h:1013:52: note: expected 'struct v4l2_subdev_state *' but argument is of type 'struct v4l2_subdev_pad_config *'
    1013 |                          struct v4l2_subdev_state *state,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/media/i2c/addi9036.c: At top level:
>> drivers/media/i2c/addi9036.c:521:35: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *)' [-Werror=incompatible-pointer-types]
     521 |         .init_cfg               = addi9036_entity_init_cfg,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/addi9036.c:521:35: note: (near initialization for 'addi9036_subdev_pad_ops.init_cfg')
>> drivers/media/i2c/addi9036.c:522:35: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_mbus_code_enum *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_mbus_code_enum *)' [-Werror=incompatible-pointer-types]
     522 |         .enum_mbus_code         = addi9036_enum_mbus_code,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/addi9036.c:522:35: note: (near initialization for 'addi9036_subdev_pad_ops.enum_mbus_code')
>> drivers/media/i2c/addi9036.c:523:35: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_frame_size_enum *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_frame_size_enum *)' [-Werror=incompatible-pointer-types]
     523 |         .enum_frame_size        = addi9036_enum_frame_size,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/addi9036.c:523:35: note: (near initialization for 'addi9036_subdev_pad_ops.enum_frame_size')
>> drivers/media/i2c/addi9036.c:524:35: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_format *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_format *)' [-Werror=incompatible-pointer-types]
     524 |         .get_fmt                = addi9036_get_format,
         |                                   ^~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/addi9036.c:524:35: note: (near initialization for 'addi9036_subdev_pad_ops.get_fmt')
   drivers/media/i2c/addi9036.c:525:35: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_format *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_format *)' [-Werror=incompatible-pointer-types]
     525 |         .set_fmt                = addi9036_set_format,
         |                                   ^~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/addi9036.c:525:35: note: (near initialization for 'addi9036_subdev_pad_ops.set_fmt')
>> drivers/media/i2c/addi9036.c:526:35: error: initialization of 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_state *, struct v4l2_subdev_selection *)' from incompatible pointer type 'int (*)(struct v4l2_subdev *, struct v4l2_subdev_pad_config *, struct v4l2_subdev_selection *)' [-Werror=incompatible-pointer-types]
     526 |         .get_selection          = addi9036_get_selection,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/addi9036.c:526:35: note: (near initialization for 'addi9036_subdev_pad_ops.get_selection')
   cc1: some warnings being treated as errors


vim +/v4l2_subdev_get_try_format +310 drivers/media/i2c/addi9036.c

   302	
   303	static struct v4l2_mbus_framefmt *
   304	addi9036_get_pad_format(struct addi9036 *addi9036,
   305				struct v4l2_subdev_pad_config *cfg, unsigned int pad,
   306				enum v4l2_subdev_format_whence which)
   307	{
   308		switch (which) {
   309		case V4L2_SUBDEV_FORMAT_TRY:
 > 310			return v4l2_subdev_get_try_format(&addi9036->sd, cfg, pad);
   311		case V4L2_SUBDEV_FORMAT_ACTIVE:
   312			return &addi9036->fmt;
   313		default:
   314			return ERR_PTR(-EINVAL);
   315		}
   316	}
   317	
   318	static int addi9036_get_format(struct v4l2_subdev *sd,
   319				       struct v4l2_subdev_pad_config *cfg,
   320				       struct v4l2_subdev_format *format)
   321	{
   322		struct addi9036 *addi9036 = to_addi9036(sd);
   323		struct v4l2_mbus_framefmt *pad_format;
   324	
   325		pad_format = addi9036_get_pad_format(addi9036, cfg, format->pad,
   326						     format->which);
   327		if (IS_ERR(pad_format))
   328			return PTR_ERR(pad_format);
   329	
   330		format->format = *pad_format;
   331	
   332		return 0;
   333	}
   334	
   335	static struct v4l2_rect *
   336	addi9036_get_pad_crop(struct addi9036 *addi9036,
   337			      struct v4l2_subdev_pad_config *cfg,
   338			      unsigned int pad, enum v4l2_subdev_format_whence which)
   339	{
   340		switch (which) {
   341		case V4L2_SUBDEV_FORMAT_TRY:
 > 342			return v4l2_subdev_get_try_crop(&addi9036->sd, cfg, pad);
   343		case V4L2_SUBDEV_FORMAT_ACTIVE:
   344			return &addi9036->crop;
   345		default:
   346			return ERR_PTR(-EINVAL);
   347		}
   348	}
   349	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
