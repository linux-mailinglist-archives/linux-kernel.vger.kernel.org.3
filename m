Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB156C570
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiGIAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGIAOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:14:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD73D691E7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325656; x=1688861656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iKGZIO2oZCw1cHewO3ZPvKoU8/5a+3Vwi+LdMwm+sh4=;
  b=Ym5qo/t+2QhFXl8SCNLCCIipG2EjgPe0A+7Nw0UHA8tVIZgnHTpO/uQZ
   XQEGwLuRgYSEcIhasg4KqqzJvo0oU4Lk0/6cLjAhv82hOXd8zkpdq5Se2
   Q8d2d9tzSo08CKvWc0yKeMaVBN9daWxdJrQ0R2zaUAPmNtzgk98tI3vyq
   GmedeWKCo9wwAszCjXZKgfEcvaLROgetNwflrVyEVfyDZno6+PVDjJtKa
   CQmejDELUqIxDeL1+B8lmZqJtfCiXA0cHwlHg1j6AcDlUTCCWTwzIyPxl
   rTnJX2fvTJ7maSOwnu/12B1BR8XzKqU18ftQiScob75kY2nC/+gSO17el
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="281942806"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="281942806"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="544382291"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2022 17:14:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9y6u-000O4g-Uc;
        Sat, 09 Jul 2022 00:14:12 +0000
Date:   Sat, 9 Jul 2022 08:13:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@chromium.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 150/161]
 drivers/gpu/drm/msm/dp/dp_drm.c:209:25: warning: excess elements in struct
 initializer
Message-ID: <202207090808.WcWKen2x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   ab88938c957f2e2edc60e19ab6df7830fc1c6914
commit: 17570fbfe787716e607a5496dd44312eab6e733e [150/161] drm/msm/dp: employ bridge mechanism for display enable and disable
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220709/202207090808.WcWKen2x-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/17570fbfe787716e607a5496dd44312eab6e733e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 17570fbfe787716e607a5496dd44312eab6e733e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/msm/ drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/msm/dp/dp_drm.c:16:27: error: field 'bridge' has incomplete type
      16 |         struct drm_bridge bridge;
         |                           ^~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_mode_set':
   drivers/gpu/drm/msm/dp/dp_drm.c:181:55: error: invalid use of undefined type 'struct drm_bridge'
     181 |         msm_dp_display_mode_set(dp_display, drm_bridge->encoder, mode, adjusted_mode);
         |                                                       ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_enable':
   drivers/gpu/drm/msm/dp/dp_drm.c:189:53: error: invalid use of undefined type 'struct drm_bridge'
     189 |         msm_dp_display_enable(dp_display, drm_bridge->encoder);
         |                                                     ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_disable':
   drivers/gpu/drm/msm/dp/dp_drm.c:197:58: error: invalid use of undefined type 'struct drm_bridge'
     197 |         msm_dp_display_pre_disable(dp_display, drm_bridge->encoder);
         |                                                          ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'dp_bridge_post_disable':
   drivers/gpu/drm/msm/dp/dp_drm.c:205:54: error: invalid use of undefined type 'struct drm_bridge'
     205 |         msm_dp_display_disable(dp_display, drm_bridge->encoder);
         |                                                      ^~
   drivers/gpu/drm/msm/dp/dp_drm.c: At top level:
   drivers/gpu/drm/msm/dp/dp_drm.c:208:21: error: variable 'dp_bridge_ops' has initializer but incomplete type
     208 | static const struct drm_bridge_funcs dp_bridge_ops = {
         |                     ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:209:10: error: 'const struct drm_bridge_funcs' has no member named 'enable'
     209 |         .enable       = dp_bridge_enable,
         |          ^~~~~~
>> drivers/gpu/drm/msm/dp/dp_drm.c:209:25: warning: excess elements in struct initializer
     209 |         .enable       = dp_bridge_enable,
         |                         ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:209:25: note: (near initialization for 'dp_bridge_ops')
   drivers/gpu/drm/msm/dp/dp_drm.c:210:10: error: 'const struct drm_bridge_funcs' has no member named 'disable'
     210 |         .disable      = dp_bridge_disable,
         |          ^~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:210:25: warning: excess elements in struct initializer
     210 |         .disable      = dp_bridge_disable,
         |                         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:210:25: note: (near initialization for 'dp_bridge_ops')
   drivers/gpu/drm/msm/dp/dp_drm.c:211:10: error: 'const struct drm_bridge_funcs' has no member named 'post_disable'
     211 |         .post_disable = dp_bridge_post_disable,
         |          ^~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:211:25: warning: excess elements in struct initializer
     211 |         .post_disable = dp_bridge_post_disable,
         |                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:211:25: note: (near initialization for 'dp_bridge_ops')
   drivers/gpu/drm/msm/dp/dp_drm.c:212:10: error: 'const struct drm_bridge_funcs' has no member named 'mode_set'
     212 |         .mode_set     = dp_bridge_mode_set,
         |          ^~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:212:25: warning: excess elements in struct initializer
     212 |         .mode_set     = dp_bridge_mode_set,
         |                         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:212:25: note: (near initialization for 'dp_bridge_ops')
   drivers/gpu/drm/msm/dp/dp_drm.c: In function 'msm_dp_bridge_init':
   drivers/gpu/drm/msm/dp/dp_drm.c:229:15: error: invalid use of undefined type 'struct drm_bridge'
     229 |         bridge->funcs = &dp_bridge_ops;
         |               ^~
   drivers/gpu/drm/msm/dp/dp_drm.c:230:15: error: invalid use of undefined type 'struct drm_bridge'
     230 |         bridge->encoder = encoder;
         |               ^~
   drivers/gpu/drm/msm/dp/dp_drm.c:232:14: error: implicit declaration of function 'drm_bridge_attach'; did you mean 'drm_bridge_detach'? [-Werror=implicit-function-declaration]
     232 |         rc = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
         |              ^~~~~~~~~~~~~~~~~
         |              drm_bridge_detach
   drivers/gpu/drm/msm/dp/dp_drm.c:232:55: error: 'DRM_BRIDGE_ATTACH_NO_CONNECTOR' undeclared (first use in this function)
     232 |         rc = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/dp/dp_drm.c:232:55: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/msm/dp/dp_drm.c: At top level:
   drivers/gpu/drm/msm/dp/dp_drm.c:208:38: error: storage size of 'dp_bridge_ops' isn't known
     208 | static const struct drm_bridge_funcs dp_bridge_ops = {
         |                                      ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +209 drivers/gpu/drm/msm/dp/dp_drm.c

   207	
   208	static const struct drm_bridge_funcs dp_bridge_ops = {
 > 209		.enable       = dp_bridge_enable,
   210		.disable      = dp_bridge_disable,
   211		.post_disable = dp_bridge_post_disable,
   212		.mode_set     = dp_bridge_mode_set,
   213	};
   214	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
