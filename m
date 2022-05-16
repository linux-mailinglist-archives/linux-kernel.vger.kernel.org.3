Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CEC527DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiEPGru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiEPGro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:47:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12310DF5D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652683664; x=1684219664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aq1dQIvAptyszsiiVkRGVgV5rN4+rJ10BH2JCRIF7Us=;
  b=flhnt/ilK1+2yWUr/LKWyHTO3Nma9A8fzziMla92tGfqWyKJJqpmgZH8
   7rQ+j9GIjDgnImTTWW35x9MBCbqP4bZGuHJg5ScG16PgaJPS62GqaIUnC
   Ct2xdY+7hB4cpTWnMyfh+7xFjT8zvg40m+8eeYYxs4JH+zM7YqpxCmIXJ
   ZMP8bGIhVc1twJ2sP4fP0CazLFBBJhzETDMbeQvgBdzZmjGzwVOYR5pP6
   4q2frd9P32IkZeg6VIFxxY5Afy+anoDFmBJy/VzddoZ/mhDusz0aMlW4P
   /zx4jGGBO9pVPQegtyvWpJlIl3hpGZfm56DlCsu3kruGND93qzbsORL+x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="250640502"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="250640502"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 23:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="544224072"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2022 23:47:41 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqUW5-0002D7-21;
        Mon, 16 May 2022 06:47:41 +0000
Date:   Mon, 16 May 2022 14:46:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 2/2] vesafb.c:undefined reference to
 `screen_info'
Message-ID: <202205161432.OrBLvbFi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   98526c5bbe3267d447ddd076b685439e3e1396c6
commit: fa0e256450f27a7d85f65c63f05e6897954a1d53 [2/2] fbdev: vesafb: Allow to be built if COMPILE_TEST is enabled
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220516/202205161432.OrBLvbFi-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout fa0e256450f27a7d85f65c63f05e6897954a1d53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/video/fbdev/vesafb.o: in function `vesafb_probe':
>> vesafb.c:(.text+0x4b6): undefined reference to `screen_info'
   m68k-linux-ld: vesafb.c:(.text+0x3c8): undefined reference to `screen_info'
   m68k-linux-ld: vesafb.c:(.text+0x3d2): undefined reference to `screen_info'
   m68k-linux-ld: vesafb.c:(.text+0x3e6): undefined reference to `screen_info'
   m68k-linux-ld: vesafb.c:(.text+0x3f4): undefined reference to `screen_info'
   m68k-linux-ld: drivers/video/fbdev/vesafb.o:vesafb.c:(.text+0x40e): more undefined references to `screen_info' follow
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
