Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4520C4C1B32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbiBWS4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiBWS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:56:14 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DDA3EF00
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645642546; x=1677178546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=55FeCcb1ARGRmEKxVh+6A3zlRphXv2FFw32s6I+V6sk=;
  b=f1Dcae9RiHrpLwJnlo5EO7GVx+j5gyT6Mc0yffI3AwhzxcVzosG6by1p
   k0gI2Mt+y3a+vNNo7YAoLz8OIT9sr+rFXMqu9cTimr0alxmjyzHfr8zh2
   sPNEtDaTWkCnNOlmAZozk5tcAF7+VtraL4lRbI2zGLoDfMDCIfp5HggWM
   DhZabSn5oUQHsLElQ1lUwVwcF21Ishuzr9hR3w5a/LQvsz3dls8RgO1MK
   l7RnOvUbkFhaPOUoMkVPfJX7CDtdDRn4biDfMSQj1l5HQocGU9p+So5YV
   878LvFi+6G+rKAYrXqM/V0dqHHhgfjRscSzNzz7pdwgsovHAPQN0cIY9y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312772099"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="312772099"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="707153545"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2022 10:55:44 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMwnf-0001iF-LT; Wed, 23 Feb 2022 18:55:43 +0000
Date:   Thu, 24 Feb 2022 02:54:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>
Subject: drivers/gpu/drm/i915/display/intel_cursor.c:155:6: error: implicit
 declaration of function 'intel_crtc_is_bigjoiner_slave'
Message-ID: <202202240216.mijx1JlB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220223-215130/Ville-Syrjala/drm-i915-Fix-cursor-coordinates-on-bigjoiner-slave/20220215-142435
head:   57b0973986ab3f838289ef1e4d27e8638c04b72f
commit: 57b0973986ab3f838289ef1e4d27e8638c04b72f drm/i915: Fix cursor coordinates on bigjoiner slave
date:   5 hours ago
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220224/202202240216.mijx1JlB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/57b0973986ab3f838289ef1e4d27e8638c04b72f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220223-215130/Ville-Syrjala/drm-i915-Fix-cursor-coordinates-on-bigjoiner-slave/20220215-142435
        git checkout 57b0973986ab3f838289ef1e4d27e8638c04b72f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_cursor.c:155:6: error: implicit declaration of function 'intel_crtc_is_bigjoiner_slave' [-Werror,-Wimplicit-function-declaration]
           if (intel_crtc_is_bigjoiner_slave(crtc_state))
               ^
   1 error generated.


vim +/intel_crtc_is_bigjoiner_slave +155 drivers/gpu/drm/i915/display/intel_cursor.c

   130	
   131	static int intel_check_cursor(struct intel_crtc_state *crtc_state,
   132				      struct intel_plane_state *plane_state)
   133	{
   134		const struct drm_framebuffer *fb = plane_state->hw.fb;
   135		struct drm_i915_private *i915 = to_i915(plane_state->uapi.plane->dev);
   136		const struct drm_rect src = plane_state->uapi.src;
   137		const struct drm_rect dst = plane_state->uapi.dst;
   138		int ret;
   139	
   140		if (fb && fb->modifier != DRM_FORMAT_MOD_LINEAR) {
   141			drm_dbg_kms(&i915->drm, "cursor cannot be tiled\n");
   142			return -EINVAL;
   143		}
   144	
   145		ret = intel_atomic_plane_check_clipping(plane_state, crtc_state,
   146							DRM_PLANE_HELPER_NO_SCALING,
   147							DRM_PLANE_HELPER_NO_SCALING,
   148							true);
   149		if (ret)
   150			return ret;
   151	
   152		/* Use the unclipped src/dst rectangles, which we program to hw */
   153		plane_state->uapi.src = src;
   154		plane_state->uapi.dst = dst;
 > 155		if (intel_crtc_is_bigjoiner_slave(crtc_state))
   156			drm_rect_translate(&plane_state->uapi.dst,
   157					   -crtc_state->pipe_src_w, 0);
   158	
   159		ret = intel_cursor_check_surface(plane_state);
   160		if (ret)
   161			return ret;
   162	
   163		if (!plane_state->uapi.visible)
   164			return 0;
   165	
   166		ret = intel_plane_check_src_coordinates(plane_state);
   167		if (ret)
   168			return ret;
   169	
   170		return 0;
   171	}
   172	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
