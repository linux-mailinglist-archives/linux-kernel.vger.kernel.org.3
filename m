Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50114C1B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiBWTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBWTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:06:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F73DA74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645643168; x=1677179168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yvNjhzpMD+34qMlMF2UIP3PwUYLJOVVBkGgcnZv2yiw=;
  b=njuEOniT2kelJSbqxjeOGDLyiQDb6yfID3Mzu99a0+qzmbmN1Ad96qHf
   8W+86Fd3fLH+qDdmSfGp/DvDWVQ8b1KZch0bkNcuzwWDwdFbhqVxtq8w9
   K9dYnWmrv6JdmwZgM4nr5/9kudhky3dK9+MDzo/vDgcCoDiqPYt+q4PxK
   2qO6c0/0KZIIcRBfvgRa1Mw4YToPD2SgRZfOwWnlr6f08VT4Bfg96ulhC
   N4/WsQVWXfuLCy79Z4k0/U8AIy5BerOCV3Uce7FqMWwMx2ELlc1PQARqT
   nApENPVT5hhdeSzA6c1HwgBP2pp5EAb5AnORCCbPkxehS42ZmAoXrYiLc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315285336"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="315285336"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="591816883"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2022 11:05:44 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMwxM-0001is-1u; Wed, 23 Feb 2022 19:05:44 +0000
Date:   Thu, 24 Feb 2022 03:05:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Lee Shawn C <shawn.c.lee@intel.com>
Subject: drivers/gpu/drm/i915/display/intel_cursor.c:155:6: error: implicit
 declaration of function 'intel_crtc_is_bigjoiner_slave'
Message-ID: <202202240237.lZSlP2iI-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220224/202202240237.lZSlP2iI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/57b0973986ab3f838289ef1e4d27e8638c04b72f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220223-215130/Ville-Syrjala/drm-i915-Fix-cursor-coordinates-on-bigjoiner-slave/20220215-142435
        git checkout 57b0973986ab3f838289ef1e4d27e8638c04b72f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/display/intel_cursor.c: In function 'intel_check_cursor':
>> drivers/gpu/drm/i915/display/intel_cursor.c:155:6: error: implicit declaration of function 'intel_crtc_is_bigjoiner_slave' [-Werror=implicit-function-declaration]
     155 |  if (intel_crtc_is_bigjoiner_slave(crtc_state))
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


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
