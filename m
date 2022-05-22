Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64740530615
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351575AbiEVVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiEVVJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:09:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227C31C13F
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653253776; x=1684789776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Rys72NAgR/L2p9xBhb3I/IYJryzEyPTZnPcT19+hPU=;
  b=YZ7pn1JSStjvT5i6POdMzqzwNiI3iI010bmKum20I1YFJU6LNZfobk1+
   T0sPBp63IJ7kl9tUTPx31EW4DW8kyuOGKiuFzB7ZaLcYgY1U4TPXrdTeH
   y+1dETpdHVw7VTpVGFzd8bH+cfoXuBwyCaTNZL2j/nmQHHGrpKr86UZ2M
   LHoN0cJpjLy5S50szzpUV635Xrt8ye27FFTg9RkBoqu5PrNpwPEgZSa50
   tQMcqh6lt519+mLSe5b5Cdb8Fz2330emJEGr3RPQFAljh+p5ThS8/xkNt
   sGlWbEQ+APLYP6MrRKcHMGhyBwD+XtTbtfsu7CAWo5RIxOg5po5Z0U22/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="359441293"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="359441293"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 14:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="547567093"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 May 2022 14:09:34 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsspS-0000cL-2e;
        Sun, 22 May 2022 21:09:34 +0000
Date:   Mon, 23 May 2022 05:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [madvenka786:orc_v2 17/20] scripts/sorttable.h:96:10: fatal error:
 asm/orc_types.h: No such file or directory
Message-ID: <202205230455.UjhVDL7U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/madvenka786/linux orc_v2
head:   ed9a1d5c036130a53c639eb712485e3d13ab4372
commit: 9da8b45b52cb2268200c44977bc7482d3bea70dc [17/20] arm64: Build the kernel with ORC information
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220523/202205230455.UjhVDL7U-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/madvenka786/linux/commit/9da8b45b52cb2268200c44977bc7482d3bea70dc
        git remote add madvenka786 https://github.com/madvenka786/linux
        git fetch --no-tags madvenka786 orc_v2
        git checkout 9da8b45b52cb2268200c44977bc7482d3bea70dc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/sorttable.c:197:
>> scripts/sorttable.h:96:10: fatal error: asm/orc_types.h: No such file or directory
      96 | #include <asm/orc_types.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.host:95: scripts/sorttable] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1178: scripts] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +96 scripts/sorttable.h

a79f248b9b309e scripts/sortextable.h David Daney 2012-04-19  93  
57fa1899428538 scripts/sorttable.h   Shile Zhang 2019-12-04  94  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
57fa1899428538 scripts/sorttable.h   Shile Zhang 2019-12-04  95  /* ORC unwinder only support X86_64 */
57fa1899428538 scripts/sorttable.h   Shile Zhang 2019-12-04 @96  #include <asm/orc_types.h>
57fa1899428538 scripts/sorttable.h   Shile Zhang 2019-12-04  97  

:::::: The code at line 96 was first introduced by commit
:::::: 57fa1899428538e314a7e0d52a5b617af082389a scripts/sorttable: Implement build-time ORC unwind table sorting

:::::: TO: Shile Zhang <shile.zhang@linux.alibaba.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
