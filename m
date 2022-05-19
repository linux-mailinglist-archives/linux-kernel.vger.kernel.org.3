Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C352DECD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbiESUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbiESUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:53:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001C4339D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652993618; x=1684529618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=prFT2V92y88ma5B9DL0iH2Zf38zaOjaulan120HspYQ=;
  b=F8wm4uXJH1kvdEU+VA16Cljqx5xHqo4ZQmpDWsLNcd2g7rl8Exox41Mv
   ieqoxova+xeAEpWIS2CkkWKr4NGCRxyjMHpZO4JA9uyVn6jd1etu1nQDe
   LIL0NDCI8pW2Sd2GzP1LJX1yqhyRPPrY4d1U4v+DYlZsPyKTrLPBWUSiL
   QXCdTMH5rDlS4a4CBe9aDmH9YHPjHKuX60v2Skmg4o+V4DE2cBJkTqtcB
   mlwYbHlGu2hBgsVILlvSGgaYDPpl7zY2Ylvumy/5xyIfBn5TBAzgG5grI
   3PhgM3Puy7ULZSoA84Ieiy1Mca2uyKEdzRmzDNyBCFy5OA9/CZJcKIGlw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272504351"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272504351"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="557110670"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2022 13:53:35 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrn9L-0003wO-8N;
        Thu, 19 May 2022 20:53:35 +0000
Date:   Fri, 20 May 2022 04:52:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [hverkuil-media-tree:for-v5.20a 23/29] ERROR: modpost:
 "usb_submit_urb" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
Message-ID: <202205200435.65DKJk2s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arm64-randconfig-r012-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200435.65DKJk2s-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.20a
        git checkout 308124c0301a5258078c2ffddd03cf3fb584d792
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "usb_submit_urb" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_set_interface" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_free_urb" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_kill_urb" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_alloc_urb" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_autopm_put_interface" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_autopm_get_interface" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_put_dev" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_put_intf" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
>> ERROR: modpost: "usb_get_intf" [drivers/staging/media/stkwebcam/stkwebcam.ko] undefined!
WARNING: modpost: suppressed 4 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
