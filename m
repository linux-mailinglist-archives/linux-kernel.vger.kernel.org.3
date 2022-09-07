Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888345B0EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIGVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:15:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589DE2E9D6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662585332; x=1694121332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZZJqsZJrCYlDyHph8xdCoe+iknngZkT0G9cnPOAiBY=;
  b=kQt0XOfsDr7fOpeVDW2dqEKsk29g4YyIaty90jD6uVGyBm2F46yxKfqT
   9dTOKRUbonGXf42X1wwebQ8dUQn9IlQuLRLeZdEra60LCQ3Wx6ifurbAm
   nTKZcew4MRJtJ5AyV/kaKSfs5lEb/N7Jq2pXvtjQ7OLXTxRQE6rUeX4D4
   ZwkbGcny/T9q45mjRaOxrjUh9VY0t9K6ubJfp2R97CKSFsYL093v8lF/6
   0N0YPqxfOCLIkf+sfEcTrjD0bR//KWeT0CL0XKPbKNmqccPI64e6cQ8vF
   z7YOH1cZZEWxqrEe2Q6zJ/C+kvsRbvOm+Bqf30DGTlTWUMi0WIOjGpoIy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276735932"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="276735932"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="740439955"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Sep 2022 14:15:30 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW2OP-0006xv-2H;
        Wed, 07 Sep 2022 21:15:29 +0000
Date:   Thu, 8 Sep 2022 05:15:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [pinchartl-media:streams/v6.0/v11 27/49]
 drivers/media/v4l2-core/v4l2-subdev.c:156:8: error: call to undeclared
 function 'v4l2_subdev_state_get_stream_format'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202209080505.7TfHX43B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git streams/v6.0/v11
head:   c8cf58f00bee6d4f43462b3e3f83ef516c594d61
commit: 46db369d5850a9ac814a5ac236a4d39e390ca217 [27/49] media: subdev: add stream based configuration
config: arm-randconfig-r002-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080505.7TfHX43B-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media streams/v6.0/v11
        git checkout 46db369d5850a9ac814a5ac236a4d39e390ca217
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/v4l2-core/v4l2-subdev.c:156:8: error: call to undeclared function 'v4l2_subdev_state_get_stream_format'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (!v4l2_subdev_state_get_stream_format(state, pad, stream))
                        ^
   1 error generated.


vim +/v4l2_subdev_state_get_stream_format +156 drivers/media/v4l2-core/v4l2-subdev.c

   150	
   151	static int check_state(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
   152			       u32 which, u32 pad, u32 stream)
   153	{
   154	#if defined(CONFIG_MEDIA_CONTROLLER)
   155		if (sd->flags & V4L2_SUBDEV_FL_MULTIPLEXED) {
 > 156			if (!v4l2_subdev_state_get_stream_format(state, pad, stream))
   157				return -EINVAL;
   158			return 0;
   159		}
   160	#endif
   161	
   162		if (which == V4L2_SUBDEV_FORMAT_TRY && (!state || !state->pads))
   163			return -EINVAL;
   164	
   165		return 0;
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
