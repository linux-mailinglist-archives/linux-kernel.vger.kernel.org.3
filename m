Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555652DD47
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbiESS7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiESS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:59:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED144ABF4C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652986774; x=1684522774;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lZnxfIAUOfdfx+hpNrBKH9JmPhdV5nPhsIAWqr5I3cA=;
  b=GiJ68L4NtftefxvXPiIg9In0iRy5uxu+PEEadQ+nNGj6+8XReNApfGmT
   UzNlfv1MM0U3hw/SJkuyxppij2rHv3DqWPsca7XE988YyxQ9ouk6mIcGS
   qR4Z1oxqewXyGFgoCd3k3HvkAPom2TSJW4MJFKgs74fQFkF66nTONZ+QI
   UaZhWY+S/jbVEznYgXJnJzgr1TlCaKBH7zi90rfYJhWbGmlDkRMyhjds0
   Kwp3BLSMxDYFIfAqFZx6Bs6ZtkooQKXTFRqbteKhY3U5WfTy2kEHTP2wk
   4L6HjvGdwQJfUzMkiVZityqQFMTtyd3iRgqk/Y6ggik39pnmYSjtfkVPL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297640584"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="297640584"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="606634261"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2022 11:59:31 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrlMx-0003rl-7s;
        Thu, 19 May 2022 18:59:31 +0000
Date:   Fri, 20 May 2022 02:58:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [hverkuil-media-tree:for-v5.20a 23/29] ld.lld: error: undefined
 symbol: usb_control_msg
Message-ID: <202205200215.BXfUN9Iw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.20a
head:   e481d316b60f1d57e770f21dc5398d5dcff13ee6
commit: 308124c0301a5258078c2ffddd03cf3fb584d792 [23/29] media: stkwebcam: deprecate driver, move to staging
config: mips-randconfig-r005-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200215.BXfUN9Iw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.20a
        git checkout 308124c0301a5258078c2ffddd03cf3fb584d792
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: usb_control_msg
   >>> referenced by stk-webcam.c:136 (drivers/staging/media/stkwebcam/stk-webcam.c:136)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_write_reg) in archive drivers/built-in.a
   >>> referenced by stk-webcam.c:155 (drivers/staging/media/stkwebcam/stk-webcam.c:155)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_read_reg) in archive drivers/built-in.a
   >>> referenced by stk-webcam.c:136 (drivers/staging/media/stkwebcam/stk-webcam.c:136)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_resume) in archive drivers/built-in.a
   >>> referenced 16 more times
--
>> ld.lld: error: undefined symbol: usb_register_driver
   >>> referenced by stk-webcam.c:1434 (drivers/staging/media/stkwebcam/stk-webcam.c:1434)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_driver_init) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_free_urb
   >>> referenced by stk-webcam.c:488 (drivers/staging/media/stkwebcam/stk-webcam.c:488)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_allocate_buffers) in archive drivers/built-in.a
   >>> referenced by stk-webcam.c:508 (drivers/staging/media/stkwebcam/stk-webcam.c:508)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_clean_iso) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_set_interface
   >>> referenced by stk-webcam.c:185 (drivers/staging/media/stkwebcam/stk-webcam.c:185)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_start_stream) in archive drivers/built-in.a
   >>> referenced by stk-webcam.c:230 (drivers/staging/media/stkwebcam/stk-webcam.c:230)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_stop_stream) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_submit_urb
   >>> referenced by stk-webcam.c:205 (drivers/staging/media/stkwebcam/stk-webcam.c:205)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_start_stream) in archive drivers/built-in.a
   >>> referenced by stk-webcam.c:416 (drivers/staging/media/stkwebcam/stk-webcam.c:416)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_isoc_handler) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_get_dev
   >>> referenced by stk-webcam.c:1317 (drivers/staging/media/stkwebcam/stk-webcam.c:1317)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_get_intf
   >>> referenced by stk-webcam.c:1319 (drivers/staging/media/stkwebcam/stk-webcam.c:1319)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_put_intf
   >>> referenced by stk-webcam.c:1372 (drivers/staging/media/stkwebcam/stk-webcam.c:1372)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_probe) in archive drivers/built-in.a
   >>> referenced by stk-webcam.c:1236 (drivers/staging/media/stkwebcam/stk-webcam.c:1236)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_v4l_dev_release) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_put_dev
   >>> referenced by stk-webcam.c:1373 (drivers/staging/media/stkwebcam/stk-webcam.c:1373)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_camera_probe) in archive drivers/built-in.a
   >>> referenced by stk-webcam.c:1237 (drivers/staging/media/stkwebcam/stk-webcam.c:1237)
   >>> staging/media/stkwebcam/stk-webcam.o:(stk_v4l_dev_release) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_autopm_get_interface
   >>> referenced by stk-webcam.c:628 (drivers/staging/media/stkwebcam/stk-webcam.c:628)
   >>> staging/media/stkwebcam/stk-webcam.o:(v4l_stk_open) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: usb_autopm_put_interface
   >>> referenced by stk-webcam.c:646 (drivers/staging/media/stkwebcam/stk-webcam.c:646)
   >>> staging/media/stkwebcam/stk-webcam.o:(v4l_stk_release) in archive drivers/built-in.a
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
