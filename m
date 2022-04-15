Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C205023E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiDOFdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiDOFdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:33:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1D9BB9A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650000648; x=1681536648;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uCHRMsxHF68JkYa1yHxrB+DiPaz40XRfbZFKLlB4rkQ=;
  b=Rz3C3lwZufDz4rkEj+eY9+nkgewOWOv/JgB1Mx+uTPucNGifFmEshEic
   GD8MBgzcf/NvZgl7AktNJeebPwJfYc5Bi6NtwZhl43WlUlDLRYTQxE+ln
   JrUFpWrA9Appz3YKdU0CusXAM2gQHgOYN+m5Cm/OoVOKi9OfVhPxNZGKB
   gOYHTw1QQymgX+AgmOXqCJq816RdQrcIMpEA6rAiD8nMACENsTMZS6dnL
   bqSvK7yW/KDoJZNy99nwKmif4POcRmiqLzb4Q6d/YpHvAdJYLJdr/ebXD
   IWuKB4f4syFlCehLBmpNALjrq4NtaQygm1ojtgCasxEur6paSSvhqloxy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="244983013"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="244983013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 22:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="612684615"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2022 22:30:46 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfEXd-0001ZN-Ru;
        Fri, 15 Apr 2022 05:30:45 +0000
Date:   Fri, 15 Apr 2022 13:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Dominik Behr <dbehr@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: [jsarha:backport/cros-v4.14-intel-audio 5196/9999]
 include/drm/drm_print.h:217:2: error: this statement may fall through
Message-ID: <202204151349.1jkLAiYB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haneen,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux backport/cros-v4.14-intel-audio
head:   ed5b3159902598be61b23ef22a235d9b1eaa9ad8
commit: 27e31e8e0e7a44982813ec603246138eee221bd4 [5196/9999] BACKPORT: drm: Move debug macros out of drmP.h
config: i386-randconfig-a011-20220411 (https://download.01.org/0day-ci/archive/20220415/202204151349.1jkLAiYB-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/27e31e8e0e7a44982813ec603246138eee221bd4
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha backport/cros-v4.14-intel-audio
        git checkout 27e31e8e0e7a44982813ec603246138eee221bd4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/drm/drm_mm.h:49:0,
                    from include/drm/drmP.h:73,
                    from drivers/gpu/drm/i915/i915_drv.h:47,
                    from drivers/gpu/drm/i915/intel_drv.h:33,
                    from drivers/gpu/drm/i915/intel_cdclk.c:24:
   drivers/gpu/drm/i915/intel_cdclk.c: In function 'pnv_get_cdclk':
>> include/drm/drm_print.h:217:2: error: this statement may fall through [-Werror=implicit-fallthrough=]
     drm_printk(KERN_ERR, DRM_UT_NONE, fmt, ##__VA_ARGS__)
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/intel_cdclk.c:318:3: note: in expansion of macro 'DRM_ERROR'
      DRM_ERROR("Unknown pnv display core clock 0x%04x\n", gcfgc);
      ^~~~~~~~~
   drivers/gpu/drm/i915/intel_cdclk.c:319:2: note: here
     case GC_DISPLAY_CLOCK_133_MHZ_PNV:
     ^~~~
   cc1: all warnings being treated as errors


vim +217 include/drm/drm_print.h

   186	
   187	#define _DRM_PRINTK(once, level, fmt, ...)				\
   188		do {								\
   189			printk##once(KERN_##level "[" DRM_NAME "] " fmt,	\
   190				     ##__VA_ARGS__);				\
   191		} while (0)
   192	
   193	#define DRM_INFO(fmt, ...)						\
   194		_DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
   195	#define DRM_NOTE(fmt, ...)						\
   196		_DRM_PRINTK(, NOTICE, fmt, ##__VA_ARGS__)
   197	#define DRM_WARN(fmt, ...)						\
   198		_DRM_PRINTK(, WARNING, fmt, ##__VA_ARGS__)
   199	
   200	#define DRM_INFO_ONCE(fmt, ...)						\
   201		_DRM_PRINTK(_once, INFO, fmt, ##__VA_ARGS__)
   202	#define DRM_NOTE_ONCE(fmt, ...)						\
   203		_DRM_PRINTK(_once, NOTICE, fmt, ##__VA_ARGS__)
   204	#define DRM_WARN_ONCE(fmt, ...)						\
   205		_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
   206	
   207	/**
   208	 * Error output.
   209	 *
   210	 * \param fmt printf() like format string.
   211	 * \param arg arguments
   212	 */
   213	#define DRM_DEV_ERROR(dev, fmt, ...)					\
   214		drm_dev_printk(dev, KERN_ERR, DRM_UT_NONE, __func__, " *ERROR*",\
   215			       fmt, ##__VA_ARGS__)
   216	#define DRM_ERROR(fmt, ...)						\
 > 217		drm_printk(KERN_ERR, DRM_UT_NONE, fmt,	##__VA_ARGS__)
   218	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
