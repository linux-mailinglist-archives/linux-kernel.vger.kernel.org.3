Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA744FA52A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiDIFfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiDIFfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:35:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C92237FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649482379; x=1681018379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sHhqfpIz/F3p7KwsDX/UimYg8iBufaHk3h/JTf7kGro=;
  b=XlhIDeQsFqGKflggZ76dIQRDO+LWBMkvaHtZKOa8C4Q+GhdF6TwG+0Tp
   q93lwuD7aYgDehRSOM2RWD05Y+m8bjWt5pyUrcOBl77Q6oGLIIcw6Eiki
   tZBkcxeG5+Zy1oAYlH/C+wN0F1ehfZlWHZGjLF08gQjnfY7T2mPVkOJ6j
   ZcEwDlzFFGBGQH+ukKVUBHuO5QeBLkmsbCYPFwXfKRk0QzVxDHGoWwdaG
   zZEd9RfI12ncr3XxRl1443IwBbS3XEitn1NexlKa+zXeOrvkvocpuZirX
   eM9doEg8kDOCLDIIk4CVdHEiw1P4mM44Y37fwKsk+ycEwG1PWUfyl01zh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260607098"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="260607098"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 22:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="852420337"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2022 22:32:57 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd3iS-0000uT-L9;
        Sat, 09 Apr 2022 05:32:56 +0000
Date:   Sat, 9 Apr 2022 13:32:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [sailus-media-tree:master 28/30]
 drivers/media/v4l2-core/v4l2-subdev.c:335:33: error: implicit declaration of
 function 'v4l2_subdev_lock_and_get_active_state'
Message-ID: <202204091346.VjKbcCcw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/sailus/media_tree.git master
head:   bd1d801f302289ddbf86ff6c38fcc91aef8e7609
commit: 3f1a6a471c6a8b5ba772cb82538ad03fa0255e7c [28/30] media: subdev: add locking wrappers to subdev op wrappers
config: sparc-randconfig-p001-20220408 (https://download.01.org/0day-ci/archive/20220409/202204091346.VjKbcCcw-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add sailus-media-tree git://linuxtv.org/sailus/media_tree.git
        git fetch --no-tags sailus-media-tree master
        git checkout 3f1a6a471c6a8b5ba772cb82538ad03fa0255e7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/media/v4l2-core/v4l2-subdev.c: In function 'call_get_fmt_state':
>> drivers/media/v4l2-core/v4l2-subdev.c:335:33: error: implicit declaration of function 'v4l2_subdev_lock_and_get_active_state' [-Werror=implicit-function-declaration]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:335:33: note: in definition of macro 'DEFINE_STATE_WRAPPER'
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-subdev.c:335:31: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                               ^
   drivers/media/v4l2-core/v4l2-subdev.c:342:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     342 | DEFINE_STATE_WRAPPER(get_fmt, struct v4l2_subdev_format);
         | ^~~~~~~~~~~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-subdev.c:338:25: error: implicit declaration of function 'v4l2_subdev_unlock_state' [-Werror=implicit-function-declaration]
     338 |                         v4l2_subdev_unlock_state(state);                   \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c:342:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     342 | DEFINE_STATE_WRAPPER(get_fmt, struct v4l2_subdev_format);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'call_set_fmt_state':
>> drivers/media/v4l2-core/v4l2-subdev.c:335:31: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                               ^
   drivers/media/v4l2-core/v4l2-subdev.c:343:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     343 | DEFINE_STATE_WRAPPER(set_fmt, struct v4l2_subdev_format);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'call_enum_mbus_code_state':
>> drivers/media/v4l2-core/v4l2-subdev.c:335:31: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                               ^
   drivers/media/v4l2-core/v4l2-subdev.c:344:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     344 | DEFINE_STATE_WRAPPER(enum_mbus_code, struct v4l2_subdev_mbus_code_enum);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'call_enum_frame_size_state':
>> drivers/media/v4l2-core/v4l2-subdev.c:335:31: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                               ^
   drivers/media/v4l2-core/v4l2-subdev.c:345:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     345 | DEFINE_STATE_WRAPPER(enum_frame_size, struct v4l2_subdev_frame_size_enum);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'call_enum_frame_interval_state':
>> drivers/media/v4l2-core/v4l2-subdev.c:335:31: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                               ^
   drivers/media/v4l2-core/v4l2-subdev.c:346:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     346 | DEFINE_STATE_WRAPPER(enum_frame_interval, struct v4l2_subdev_frame_interval_enum);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'call_get_selection_state':
>> drivers/media/v4l2-core/v4l2-subdev.c:335:31: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                               ^
   drivers/media/v4l2-core/v4l2-subdev.c:347:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     347 | DEFINE_STATE_WRAPPER(get_selection, struct v4l2_subdev_selection);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'call_set_selection_state':
>> drivers/media/v4l2-core/v4l2-subdev.c:335:31: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |                         state = v4l2_subdev_lock_and_get_active_state(sd); \
         |                               ^
   drivers/media/v4l2-core/v4l2-subdev.c:348:1: note: in expansion of macro 'DEFINE_STATE_WRAPPER'
     348 | DEFINE_STATE_WRAPPER(set_selection, struct v4l2_subdev_selection);
         | ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/v4l2_subdev_lock_and_get_active_state +335 drivers/media/v4l2-core/v4l2-subdev.c

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
 > 338				v4l2_subdev_unlock_state(state);                   \
   339			return ret;                                                \
   340		}
   341	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
