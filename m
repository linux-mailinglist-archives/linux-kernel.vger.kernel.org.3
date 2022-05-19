Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0852DDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbiESTVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiESTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:20:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDBB12ACE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652988051; x=1684524051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VG0I81Vi4zkACRITn2gr1QcUsNlLRmFAQtBwtwtd3ZI=;
  b=lmZOEHRYycKGLigM5GiTuTgD6v+UrNOZ+QK+i65zZ1jcQFBd6+fhOxZ4
   QMxH7rp5lnCEm7FaXQMEl1LV+eu5tjVUjpAtlifyL6HjooeC3wrV9hpP+
   HcvjY9r74yQmNOnPTVxx7xb+HNDWgZEIyU+1q+fIhAh1TNY0VWUQsK2t1
   kOdN4C24LWYQLnoRsSsApVwIMokMHfP3I0KdJ6f5er3CbeB7vqYk2F7zO
   c3l/8JgFg4NLFXdJYpmpLhiY86cmuL8eR2z25xariAJQJcQsSbTSDsVjZ
   J9PGwy17492LsMur7GotmGb9TZYz/JKDPV8hz/6NjKTx1RBZdf9iby0TO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272306184"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272306184"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 12:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="661870162"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2022 12:20:33 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrlhH-0003sz-QO;
        Thu, 19 May 2022 19:20:31 +0000
Date:   Fri, 20 May 2022 03:19:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [hverkuil-media-tree:for-v5.20a 23/29] stk-webcam.c:undefined
 reference to `usb_free_urb'
Message-ID: <202205200316.4zqbkVU1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.20a
head:   e481d316b60f1d57e770f21dc5398d5dcff13ee6
commit: 308124c0301a5258078c2ffddd03cf3fb584d792 [23/29] media: stkwebcam: deprecate driver, move to staging
config: m68k-randconfig-c004-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200316.4zqbkVU1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.20a
        git checkout 308124c0301a5258078c2ffddd03cf3fb584d792
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/macintosh/via-cuda.o: in function `cuda_set_rtc_time':
   via-cuda.c:(.text+0xae2): undefined reference to `rtc_tm_to_time64'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_clean_iso':
>> stk-webcam.c:(.text+0x648): undefined reference to `usb_free_urb'
>> m68k-linux-ld: stk-webcam.c:(.text+0x64e): undefined reference to `usb_kill_urb'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_prepare_iso':
>> stk-webcam.c:(.text+0x111e): undefined reference to `usb_kill_urb'
>> m68k-linux-ld: stk-webcam.c:(.text+0x12a0): undefined reference to `usb_free_urb'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_start_stream':
>> stk-webcam.c:(.text+0x1ad2): undefined reference to `usb_submit_urb'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_v4l_dev_release':
>> stk-webcam.c:(.text+0x1f2): undefined reference to `usb_put_intf'
>> m68k-linux-ld: stk-webcam.c:(.text+0x1fc): undefined reference to `usb_put_dev'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_camera_probe':
>> stk-webcam.c:(.text+0xc04): undefined reference to `usb_get_dev'
>> m68k-linux-ld: stk-webcam.c:(.text+0xc14): undefined reference to `usb_get_intf'
>> m68k-linux-ld: stk-webcam.c:(.text+0xd84): undefined reference to `usb_put_intf'
   m68k-linux-ld: stk-webcam.c:(.text+0xd8e): undefined reference to `usb_put_dev'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_isoc_handler':
   stk-webcam.c:(.text+0x1096): undefined reference to `usb_submit_urb'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_prepare_iso':
>> stk-webcam.c:(.text+0x1124): undefined reference to `usb_alloc_urb'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_initialise':
>> stk-webcam.c:(.text+0x1420): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `v4l_stk_open':
   stk-webcam.c:(.text+0x1500): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_vidioc_reqbufs':
   stk-webcam.c:(.text+0x15ba): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_vidioc_s_fmt_vid_cap':
   stk-webcam.c:(.text+0x1862): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_camera_write_reg':
   stk-webcam.c:(.text+0x18c4): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o:stk-webcam.c:(.text+0x1912): more undefined references to `usb_control_msg' follow
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_start_stream':
>> stk-webcam.c:(.text+0x1972): undefined reference to `usb_set_interface'
>> m68k-linux-ld: stk-webcam.c:(.text+0x19ee): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_stop_stream.isra.0':
   stk-webcam.c:(.text+0x1f58): undefined reference to `usb_control_msg'
   m68k-linux-ld: stk-webcam.c:(.text+0x1f6c): undefined reference to `usb_kill_urb'
>> m68k-linux-ld: stk-webcam.c:(.text+0x1f9c): undefined reference to `usb_set_interface'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `v4l_stk_release':
   stk-webcam.c:(.text+0x204c): undefined reference to `usb_control_msg'
   m68k-linux-ld: drivers/staging/media/stkwebcam/stk-webcam.o: in function `stk_camera_driver_init':
>> stk-webcam.c:(.init.text+0x14): undefined reference to `usb_register_driver'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
