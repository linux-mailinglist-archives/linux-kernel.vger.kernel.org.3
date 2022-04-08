Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BBD4F9E11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiDHUMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiDHUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:12:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FA1CFFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649448608; x=1680984608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DLdq08U6vX3/sQbDi4WGA6YNm/K/4filTRbr6eccn0g=;
  b=JPJUT7oB3qZK1xY+JdphDDLF5iSlRGKDa5acKGm9p0ftfteWcRQ3TyZ3
   85wvaqOn4Gtc0ap7AZ+z7OylebuEQkRxAGJqSGOkpo2AkOCJdvH5tp9op
   Ee6ZKlSzRBCHPGeDgMj3XCZoXaBN8LWBlgM2BDk/AKSDcT+Ys3aEK3lzV
   6Gga+OuY1wd15wVNhWtIq5pL5zK5TJj0o1F0S/LxD/yyiX1PvkYANegiB
   1MqfGv0l74sOoFLvWEdudC0EfvW4uXUcI9BUWva5btlmZQZzErlLOSfwe
   2WKdWd7WGg/hecxuHF4rr/hTSeasr76hY+ryFXouJ6boBRWJ8Hfd/r1kF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="241614846"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="241614846"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="852196851"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2022 13:10:06 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncuvl-0000bQ-C8;
        Fri, 08 Apr 2022 20:10:05 +0000
Date:   Sat, 9 Apr 2022 04:09:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [sailus-media-tree:master 28/30]
 drivers/media/v4l2-core/v4l2-subdev.c:342:1: error: implicit declaration of
 function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99
Message-ID: <202204090350.ZbhpomcE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/sailus/media_tree.git master
head:   bd1d801f302289ddbf86ff6c38fcc91aef8e7609
commit: 3f1a6a471c6a8b5ba772cb82538ad03fa0255e7c [28/30] media: subdev: add locking wrappers to subdev op wrappers
config: arm-randconfig-r022-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090350.ZbhpomcE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add sailus-media-tree git://linuxtv.org/sailus/media_tree.git
        git fetch --no-tags sailus-media-tree master
        git checkout 3f1a6a471c6a8b5ba772cb82538ad03fa0255e7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/media/v4l2-core/v4l2-subdev.c:342:1: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEFINE_STATE_WRAPPER(get_fmt, struct v4l2_subdev_format);
   ^
   drivers/media/v4l2-core/v4l2-subdev.c:335:12: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                   ^
>> drivers/media/v4l2-core/v4l2-subdev.c:342:1: warning: incompatible integer to pointer conversion assigning to 'struct v4l2_subdev_state *' from 'int' [-Wint-conversion]
   DEFINE_STATE_WRAPPER(get_fmt, struct v4l2_subdev_format);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:10: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-subdev.c:342:1: error: implicit declaration of function 'v4l2_subdev_unlock_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/media/v4l2-core/v4l2-subdev.c:338:4: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           v4l2_subdev_unlock_state(state);                   \
                           ^
   drivers/media/v4l2-core/v4l2-subdev.c:343:1: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEFINE_STATE_WRAPPER(set_fmt, struct v4l2_subdev_format);
   ^
   drivers/media/v4l2-core/v4l2-subdev.c:335:12: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                   ^
   drivers/media/v4l2-core/v4l2-subdev.c:343:1: warning: incompatible integer to pointer conversion assigning to 'struct v4l2_subdev_state *' from 'int' [-Wint-conversion]
   DEFINE_STATE_WRAPPER(set_fmt, struct v4l2_subdev_format);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:10: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:343:1: error: implicit declaration of function 'v4l2_subdev_unlock_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/media/v4l2-core/v4l2-subdev.c:338:4: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           v4l2_subdev_unlock_state(state);                   \
                           ^
   drivers/media/v4l2-core/v4l2-subdev.c:344:1: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEFINE_STATE_WRAPPER(enum_mbus_code, struct v4l2_subdev_mbus_code_enum);
   ^
   drivers/media/v4l2-core/v4l2-subdev.c:335:12: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                   ^
   drivers/media/v4l2-core/v4l2-subdev.c:344:1: warning: incompatible integer to pointer conversion assigning to 'struct v4l2_subdev_state *' from 'int' [-Wint-conversion]
   DEFINE_STATE_WRAPPER(enum_mbus_code, struct v4l2_subdev_mbus_code_enum);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:10: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:344:1: error: implicit declaration of function 'v4l2_subdev_unlock_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/media/v4l2-core/v4l2-subdev.c:338:4: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           v4l2_subdev_unlock_state(state);                   \
                           ^
   drivers/media/v4l2-core/v4l2-subdev.c:345:1: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEFINE_STATE_WRAPPER(enum_frame_size, struct v4l2_subdev_frame_size_enum);
   ^
   drivers/media/v4l2-core/v4l2-subdev.c:335:12: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                   ^
   drivers/media/v4l2-core/v4l2-subdev.c:345:1: warning: incompatible integer to pointer conversion assigning to 'struct v4l2_subdev_state *' from 'int' [-Wint-conversion]
   DEFINE_STATE_WRAPPER(enum_frame_size, struct v4l2_subdev_frame_size_enum);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:10: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:345:1: error: implicit declaration of function 'v4l2_subdev_unlock_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/media/v4l2-core/v4l2-subdev.c:338:4: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           v4l2_subdev_unlock_state(state);                   \
                           ^
   drivers/media/v4l2-core/v4l2-subdev.c:346:1: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEFINE_STATE_WRAPPER(enum_frame_interval, struct v4l2_subdev_frame_interval_enum);
   ^
   drivers/media/v4l2-core/v4l2-subdev.c:335:12: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                   ^
   drivers/media/v4l2-core/v4l2-subdev.c:346:1: warning: incompatible integer to pointer conversion assigning to 'struct v4l2_subdev_state *' from 'int' [-Wint-conversion]
   DEFINE_STATE_WRAPPER(enum_frame_interval, struct v4l2_subdev_frame_interval_enum);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:10: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:346:1: error: implicit declaration of function 'v4l2_subdev_unlock_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/media/v4l2-core/v4l2-subdev.c:338:4: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           v4l2_subdev_unlock_state(state);                   \
                           ^
   drivers/media/v4l2-core/v4l2-subdev.c:347:1: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEFINE_STATE_WRAPPER(get_selection, struct v4l2_subdev_selection);
   ^
   drivers/media/v4l2-core/v4l2-subdev.c:335:12: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                   ^
   drivers/media/v4l2-core/v4l2-subdev.c:347:1: warning: incompatible integer to pointer conversion assigning to 'struct v4l2_subdev_state *' from 'int' [-Wint-conversion]
   DEFINE_STATE_WRAPPER(get_selection, struct v4l2_subdev_selection);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:10: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:347:1: error: implicit declaration of function 'v4l2_subdev_unlock_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/media/v4l2-core/v4l2-subdev.c:338:4: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           v4l2_subdev_unlock_state(state);                   \
                           ^
   drivers/media/v4l2-core/v4l2-subdev.c:348:1: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEFINE_STATE_WRAPPER(set_selection, struct v4l2_subdev_selection);
   ^
   drivers/media/v4l2-core/v4l2-subdev.c:335:12: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                   ^
   drivers/media/v4l2-core/v4l2-subdev.c:348:1: warning: incompatible integer to pointer conversion assigning to 'struct v4l2_subdev_state *' from 'int' [-Wint-conversion]
   DEFINE_STATE_WRAPPER(set_selection, struct v4l2_subdev_selection);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:10: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           state = v4l2_subdev_lock_and_get_active_state(sd); \
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:348:1: error: implicit declaration of function 'v4l2_subdev_unlock_state' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/media/v4l2-core/v4l2-subdev.c:338:4: note: expanded from macro 'DEFINE_STATE_WRAPPER'
                           v4l2_subdev_unlock_state(state);                   \
                           ^
   7 warnings and 14 errors generated.


vim +/v4l2_subdev_lock_and_get_active_state +342 drivers/media/v4l2-core/v4l2-subdev.c

   321	
   322	/*
   323	 * Create state-management wrapper for pad ops dealing with subdev state. The
   324	 * wrapper handles the case where the caller does not provide the called
   325	 * subdev's state. This should be removed when all the callers are fixed.
   326	 */
   327	#define DEFINE_STATE_WRAPPER(f, arg_type)                                  \
   328		static int call_##f##_state(struct v4l2_subdev *sd,                \
   329					    struct v4l2_subdev_state *_state,      \
   330					    arg_type *format)                      \
   331		{                                                                  \
   332			struct v4l2_subdev_state *state = _state;                  \
   333			int ret;                                                   \
   334			if (!_state)                                               \
 > 335				state = v4l2_subdev_lock_and_get_active_state(sd); \
   336			ret = call_##f(sd, state, format);                         \
   337			if (!_state && state)                                      \
   338				v4l2_subdev_unlock_state(state);                   \
   339			return ret;                                                \
   340		}
   341	
 > 342	DEFINE_STATE_WRAPPER(get_fmt, struct v4l2_subdev_format);
   343	DEFINE_STATE_WRAPPER(set_fmt, struct v4l2_subdev_format);
   344	DEFINE_STATE_WRAPPER(enum_mbus_code, struct v4l2_subdev_mbus_code_enum);
   345	DEFINE_STATE_WRAPPER(enum_frame_size, struct v4l2_subdev_frame_size_enum);
   346	DEFINE_STATE_WRAPPER(enum_frame_interval, struct v4l2_subdev_frame_interval_enum);
   347	DEFINE_STATE_WRAPPER(get_selection, struct v4l2_subdev_selection);
   348	DEFINE_STATE_WRAPPER(set_selection, struct v4l2_subdev_selection);
   349	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
