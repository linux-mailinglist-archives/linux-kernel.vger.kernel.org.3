Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6888A53E706
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiFFPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbiFFPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:40:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BDE34BAD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654530023; x=1686066023;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L61haQy24dlnKi4VDgjYlFt0spfUGeEqGGwv62tAWYQ=;
  b=WTD9EQPK4PGgY2eGWesh0y5xsC6javArVimLKW5dIcU6o4aN5paFeR4B
   q/IXTcC4G7pRbCNjiMRobf/FInkHMbFUM0N8W8Bfp3J24iGkjuxAH8ulh
   sYg2R+I+jhOYr3zoNiPt2QJC3u6Durwf8GVwRIYHNGEhzwciNKt8qKhpN
   fWuzqgOidylpUe6COFWhTNmiDwF3MNh+reHD0PN9NIv4Vugltu+GY4E9L
   VZ/x51qtwFA61yTzaX4pb/orGjsDyb+vYLiQHfb3g1DHDRyuxmStf1gBg
   3IGTo4X1m+9pfD245WEPLI3fwhXngRX+1iSCsVpSzEcLJ2a0ALJF9twDh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="363008500"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="363008500"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 08:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="682298131"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2022 08:40:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyEq4-000Cqn-Ss;
        Mon, 06 Jun 2022 15:40:20 +0000
Date:   Mon, 6 Jun 2022 23:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arun R Murthy <arun.r.murthy@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/gpu/drm/i915/display/intel_display.c:7532:3: error:
 unannotated fall-through between switch labels
Message-ID: <202206062357.xOj8gI5t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220601-122646/Arun-R-Murthy/drm-i915-Support-Async-Flip-on-Linear-buffers/20220426-200801
head:   cc1daa161e85e6157fff3455b5aa0b2712730b3e
commit: cc1daa161e85e6157fff3455b5aa0b2712730b3e drm/i915: Support Async Flip on Linear buffers
date:   5 days ago
config: i386-randconfig-c001-20220606 (https://download.01.org/0day-ci/archive/20220606/202206062357.xOj8gI5t-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cc1daa161e85e6157fff3455b5aa0b2712730b3e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220601-122646/Arun-R-Murthy/drm-i915-Support-Async-Flip-on-Linear-buffers/20220426-200801
        git checkout cc1daa161e85e6157fff3455b5aa0b2712730b3e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_display.c:7532:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
                   case I915_FORMAT_MOD_X_TILED:
                   ^
   drivers/gpu/drm/i915/display/intel_display.c:7532:3: note: insert 'break;' to avoid fall-through
                   case I915_FORMAT_MOD_X_TILED:
                   ^
                   break; 
   1 error generated.


vim +7532 drivers/gpu/drm/i915/display/intel_display.c

b0b2bed2a1305c8 Ville Syrj�l�         2022-02-14  7458  
b0b2bed2a1305c8 Ville Syrj�l�         2022-02-14  7459  static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct intel_crtc *crtc)
30ff93af9e19dbe Karthik B S           2020-09-21  7460  {
30ff93af9e19dbe Karthik B S           2020-09-21  7461  	struct drm_i915_private *i915 = to_i915(state->base.dev);
30ff93af9e19dbe Karthik B S           2020-09-21  7462  	const struct intel_crtc_state *old_crtc_state, *new_crtc_state;
30ff93af9e19dbe Karthik B S           2020-09-21  7463  	const struct intel_plane_state *new_plane_state, *old_plane_state;
30ff93af9e19dbe Karthik B S           2020-09-21  7464  	struct intel_plane *plane;
30ff93af9e19dbe Karthik B S           2020-09-21  7465  	int i;
30ff93af9e19dbe Karthik B S           2020-09-21  7466  
0826edb6a5e5b32 Jos� Roberto de Souza 2021-10-29  7467  	old_crtc_state = intel_atomic_get_old_crtc_state(state, crtc);
0826edb6a5e5b32 Jos� Roberto de Souza 2021-10-29  7468  	new_crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
0826edb6a5e5b32 Jos� Roberto de Souza 2021-10-29  7469  
b0b2bed2a1305c8 Ville Syrj�l�         2022-02-14  7470  	if (!new_crtc_state->uapi.async_flip)
b0b2bed2a1305c8 Ville Syrj�l�         2022-02-14  7471  		return 0;
b0b2bed2a1305c8 Ville Syrj�l�         2022-02-14  7472  
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7473  	if (!new_crtc_state->hw.active) {
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7474  		drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7475  			    "[CRTC:%d:%s] not active\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7476  			    crtc->base.base.id, crtc->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7477  		return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7478  	}
30ff93af9e19dbe Karthik B S           2020-09-21  7479  
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7480  	if (intel_crtc_needs_modeset(new_crtc_state)) {
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7481  		drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7482  			    "[CRTC:%d:%s] modeset required\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7483  			    crtc->base.base.id, crtc->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7484  		return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7485  	}
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7486  
30ff93af9e19dbe Karthik B S           2020-09-21  7487  	if (old_crtc_state->active_planes != new_crtc_state->active_planes) {
30ff93af9e19dbe Karthik B S           2020-09-21  7488  		drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7489  			    "[CRTC:%d:%s] Active planes cannot be in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7490  			    crtc->base.base.id, crtc->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7491  		return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7492  	}
30ff93af9e19dbe Karthik B S           2020-09-21  7493  
30ff93af9e19dbe Karthik B S           2020-09-21  7494  	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
30ff93af9e19dbe Karthik B S           2020-09-21  7495  					     new_plane_state, i) {
0826edb6a5e5b32 Jos� Roberto de Souza 2021-10-29  7496  		if (plane->pipe != crtc->pipe)
0826edb6a5e5b32 Jos� Roberto de Souza 2021-10-29  7497  			continue;
0826edb6a5e5b32 Jos� Roberto de Souza 2021-10-29  7498  
30ff93af9e19dbe Karthik B S           2020-09-21  7499  		/*
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7500  		 * Only async flip capable planes should be in the state
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7501  		 * if we're really about to ask the hardware to perform
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7502  		 * an async flip. We should never get this far otherwise.
30ff93af9e19dbe Karthik B S           2020-09-21  7503  		 */
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7504  		if (drm_WARN_ON(&i915->drm,
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7505  				new_crtc_state->do_async_flip && !plane->async_flip))
30ff93af9e19dbe Karthik B S           2020-09-21  7506  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7507  
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7508  		/*
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7509  		 * Only check async flip capable planes other planes
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7510  		 * may be involved in the initial commit due to
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7511  		 * the wm0/ddb optimization.
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7512  		 *
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7513  		 * TODO maybe should track which planes actually
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7514  		 * were requested to do the async flip...
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7515  		 */
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7516  		if (!plane->async_flip)
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7517  			continue;
2e08437160d1e8f Ville Syrj�l�         2022-02-14  7518  
30ff93af9e19dbe Karthik B S           2020-09-21  7519  		/*
30ff93af9e19dbe Karthik B S           2020-09-21  7520  		 * FIXME: This check is kept generic for all platforms.
244dba4cb596379 Lucas De Marchi       2021-07-28  7521  		 * Need to verify this for all gen9 platforms to enable
30ff93af9e19dbe Karthik B S           2020-09-21  7522  		 * this selectively if required.
30ff93af9e19dbe Karthik B S           2020-09-21  7523  		 */
30ff93af9e19dbe Karthik B S           2020-09-21  7524  		switch (new_plane_state->hw.fb->modifier) {
cc1daa161e85e61 Arun R Murthy         2022-06-01  7525  		case DRM_FORMAT_MOD_LINEAR:
cc1daa161e85e61 Arun R Murthy         2022-06-01  7526  			if (DISPLAY_VER(i915) < 12) {
cc1daa161e85e61 Arun R Murthy         2022-06-01  7527  				drm_dbg_kms(&i915->drm,
cc1daa161e85e61 Arun R Murthy         2022-06-01  7528  					"[PLANE:%d:%s] Modifier does not support async flips\n",
cc1daa161e85e61 Arun R Murthy         2022-06-01  7529  					plane->base.base.id, plane->base.name);
cc1daa161e85e61 Arun R Murthy         2022-06-01  7530  				return -EINVAL;
cc1daa161e85e61 Arun R Murthy         2022-06-01  7531  			}
30ff93af9e19dbe Karthik B S           2020-09-21 @7532  		case I915_FORMAT_MOD_X_TILED:
30ff93af9e19dbe Karthik B S           2020-09-21  7533  		case I915_FORMAT_MOD_Y_TILED:
30ff93af9e19dbe Karthik B S           2020-09-21  7534  		case I915_FORMAT_MOD_Yf_TILED:
072ce4164f973bc Stanislav Lisovskiy   2022-01-18  7535  		case I915_FORMAT_MOD_4_TILED:
30ff93af9e19dbe Karthik B S           2020-09-21  7536  			break;
30ff93af9e19dbe Karthik B S           2020-09-21  7537  		default:
30ff93af9e19dbe Karthik B S           2020-09-21  7538  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7539  				    "[PLANE:%d:%s] Modifier does not support async flips\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7540  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7541  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7542  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7543  
aaec72ee90bcccf Ville Syrj�l�         2021-10-18  7544  		if (new_plane_state->hw.fb->format->num_planes > 1) {
aaec72ee90bcccf Ville Syrj�l�         2021-10-18  7545  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7546  				    "[PLANE:%d:%s] Planar formats do not support async flips\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7547  				    plane->base.base.id, plane->base.name);
aaec72ee90bcccf Ville Syrj�l�         2021-10-18  7548  			return -EINVAL;
aaec72ee90bcccf Ville Syrj�l�         2021-10-18  7549  		}
aaec72ee90bcccf Ville Syrj�l�         2021-10-18  7550  
be6c1dd5ac074de Imre Deak             2021-10-27  7551  		if (old_plane_state->view.color_plane[0].mapping_stride !=
be6c1dd5ac074de Imre Deak             2021-10-27  7552  		    new_plane_state->view.color_plane[0].mapping_stride) {
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7553  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7554  				    "[PLANE:%d:%s] Stride cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7555  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7556  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7557  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7558  
30ff93af9e19dbe Karthik B S           2020-09-21  7559  		if (old_plane_state->hw.fb->modifier !=
30ff93af9e19dbe Karthik B S           2020-09-21  7560  		    new_plane_state->hw.fb->modifier) {
30ff93af9e19dbe Karthik B S           2020-09-21  7561  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7562  				    "[PLANE:%d:%s] Modifier cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7563  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7564  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7565  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7566  
30ff93af9e19dbe Karthik B S           2020-09-21  7567  		if (old_plane_state->hw.fb->format !=
30ff93af9e19dbe Karthik B S           2020-09-21  7568  		    new_plane_state->hw.fb->format) {
30ff93af9e19dbe Karthik B S           2020-09-21  7569  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7570  				    "[PLANE:%d:%s] Pixel format cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7571  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7572  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7573  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7574  
30ff93af9e19dbe Karthik B S           2020-09-21  7575  		if (old_plane_state->hw.rotation !=
30ff93af9e19dbe Karthik B S           2020-09-21  7576  		    new_plane_state->hw.rotation) {
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7577  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7578  				    "[PLANE:%d:%s] Rotation cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7579  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7580  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7581  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7582  
30ff93af9e19dbe Karthik B S           2020-09-21  7583  		if (!drm_rect_equals(&old_plane_state->uapi.src, &new_plane_state->uapi.src) ||
30ff93af9e19dbe Karthik B S           2020-09-21  7584  		    !drm_rect_equals(&old_plane_state->uapi.dst, &new_plane_state->uapi.dst)) {
30ff93af9e19dbe Karthik B S           2020-09-21  7585  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7586  				    "[PLANE:%d:%s] Size/co-ordinates cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7587  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7588  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7589  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7590  
30ff93af9e19dbe Karthik B S           2020-09-21  7591  		if (old_plane_state->hw.alpha != new_plane_state->hw.alpha) {
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7592  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7593  				    "[PLANES:%d:%s] Alpha value cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7594  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7595  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7596  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7597  
30ff93af9e19dbe Karthik B S           2020-09-21  7598  		if (old_plane_state->hw.pixel_blend_mode !=
30ff93af9e19dbe Karthik B S           2020-09-21  7599  		    new_plane_state->hw.pixel_blend_mode) {
30ff93af9e19dbe Karthik B S           2020-09-21  7600  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7601  				    "[PLANE:%d:%s] Pixel blend mode cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7602  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7603  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7604  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7605  
30ff93af9e19dbe Karthik B S           2020-09-21  7606  		if (old_plane_state->hw.color_encoding != new_plane_state->hw.color_encoding) {
30ff93af9e19dbe Karthik B S           2020-09-21  7607  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7608  				    "[PLANE:%d:%s] Color encoding cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7609  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7610  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7611  		}
30ff93af9e19dbe Karthik B S           2020-09-21  7612  
30ff93af9e19dbe Karthik B S           2020-09-21  7613  		if (old_plane_state->hw.color_range != new_plane_state->hw.color_range) {
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7614  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7615  				    "[PLANE:%d:%s] Color range cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7616  				    plane->base.base.id, plane->base.name);
30ff93af9e19dbe Karthik B S           2020-09-21  7617  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7618  		}
ef6ba31dd384058 Anshuman Gupta        2021-09-24  7619  
ef6ba31dd384058 Anshuman Gupta        2021-09-24  7620  		/* plane decryption is allow to change only in synchronous flips */
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7621  		if (old_plane_state->decrypt != new_plane_state->decrypt) {
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7622  			drm_dbg_kms(&i915->drm,
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7623  				    "[PLANE:%d:%s] Decryption cannot be changed in async flip\n",
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7624  				    plane->base.base.id, plane->base.name);
ef6ba31dd384058 Anshuman Gupta        2021-09-24  7625  			return -EINVAL;
30ff93af9e19dbe Karthik B S           2020-09-21  7626  		}
6b4e414ce8dab70 Ville Syrj�l�         2022-02-14  7627  	}
30ff93af9e19dbe Karthik B S           2020-09-21  7628  
30ff93af9e19dbe Karthik B S           2020-09-21  7629  	return 0;
30ff93af9e19dbe Karthik B S           2020-09-21  7630  }
30ff93af9e19dbe Karthik B S           2020-09-21  7631  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
