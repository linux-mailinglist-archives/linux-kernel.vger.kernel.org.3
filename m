Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC15AF296
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiIFRaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiIFR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:29:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345D681B20
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662484958; x=1694020958;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9N1rFSvtcLUcC7hpfWbXiZaUavz2e3CGIlFU0+3sm5g=;
  b=KESH8VAaePT2+TV5Jy2BKvI1ROXqdThegCBpMVqL31OMXdvRb91YNc/q
   GCY3if8caRuITM87ugYygEqbZQaQ5IxjnNlUN/2ddyvMncv4YaXrI8kF0
   kDsQ6XqCMV0QF0FmaQQXXYaEB7FKoeDoYrQtb50JbOytzZaSSNxmYFgLG
   USDsT4iEA0MFZ0qLuVPkWAvaoQUkrH8PteHw6KX6Vp635ifXEgiGt1W4t
   228dTfl9zHE9BpnaeeD7DJb6+KQoLNw0N3R4aYVLVVgTQu44f08oV7rnW
   wSgCPQkUvD0CBthqqXYXMFTBrp1GaC1TiI+PWEeFXmFIA8CYnTF9xC1fz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297440005"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297440005"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 10:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682477502"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 10:22:35 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVcHT-0005OL-0k;
        Tue, 06 Sep 2022 17:22:35 +0000
Date:   Wed, 7 Sep 2022 01:22:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 1155/6555]
 drivers/gpu/drm/drm_atomic_uapi.c:466: Error: unrecognized opcode `csrs
 sstatus,a3'
Message-ID: <202209070101.FLJZtH6Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: dfdec43d0411076dc70591a0496a0824a8620695 [1155/6555] UPSTREAM: drm: extract drm_atomic_uapi.c
config: riscv-buildonly-randconfig-r003-20220906 (https://download.01.org/0day-ci/archive/20220907/202209070101.FLJZtH6Z-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/dfdec43d0411076dc70591a0496a0824a8620695
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout dfdec43d0411076dc70591a0496a0824a8620695
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash M=drivers/gpu/drm

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_atomic_uapi.c: In function 'complete_signaling':
   drivers/gpu/drm/drm_atomic_uapi.c:1193:26: warning: variable 'crtc' set but not used [-Wunused-but-set-variable]
    1193 |         struct drm_crtc *crtc;
         |                          ^~~~
   drivers/gpu/drm/drm_atomic_uapi.c: Assembler messages:
   drivers/gpu/drm/drm_atomic_uapi.c:1052: Error: unrecognized opcode `csrs sstatus,a4'
   drivers/gpu/drm/drm_atomic_uapi.c:1052: Error: unrecognized opcode `csrc sstatus,a4'
   drivers/gpu/drm/drm_atomic_uapi.c:1230: Error: unrecognized opcode `csrs sstatus,s7'
   drivers/gpu/drm/drm_atomic_uapi.c:1230: Error: unrecognized opcode `csrc sstatus,s7'
>> drivers/gpu/drm/drm_atomic_uapi.c:466: Error: unrecognized opcode `csrs sstatus,a3'
>> drivers/gpu/drm/drm_atomic_uapi.c:466: Error: unrecognized opcode `csrc sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:366: Error: unrecognized opcode `csrs sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:366: Error: unrecognized opcode `csrc sstatus,a3'
>> drivers/gpu/drm/drm_atomic_uapi.c:1297: Error: unrecognized opcode `csrs sstatus,s1'
>> drivers/gpu/drm/drm_atomic_uapi.c:1297: Error: unrecognized opcode `csrc sstatus,s1'
   drivers/gpu/drm/drm_atomic_uapi.c:1314: Error: unrecognized opcode `csrs sstatus,s1'
   drivers/gpu/drm/drm_atomic_uapi.c:1314: Error: unrecognized opcode `csrc sstatus,s1'
   drivers/gpu/drm/drm_atomic_uapi.c:1327: Error: unrecognized opcode `csrs sstatus,s5'
   drivers/gpu/drm/drm_atomic_uapi.c:1327: Error: unrecognized opcode `csrc sstatus,s5'


vim +466 drivers/gpu/drm/drm_atomic_uapi.c

   418	
   419	static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
   420			struct drm_crtc_state *state, struct drm_property *property,
   421			uint64_t val)
   422	{
   423		struct drm_device *dev = crtc->dev;
   424		struct drm_mode_config *config = &dev->mode_config;
   425		bool replaced = false;
   426		int ret;
   427	
   428		if (property == config->prop_active)
   429			state->active = val;
   430		else if (property == config->prop_mode_id) {
   431			struct drm_property_blob *mode =
   432				drm_property_lookup_blob(dev, val);
   433			ret = drm_atomic_set_mode_prop_for_crtc(state, mode);
   434			drm_property_blob_put(mode);
   435			return ret;
   436		} else if (property == config->degamma_lut_property) {
   437			ret = drm_atomic_replace_property_blob_from_id(dev,
   438						&state->degamma_lut,
   439						val,
   440						-1, sizeof(struct drm_color_lut),
   441						&replaced);
   442			state->color_mgmt_changed |= replaced;
   443			return ret;
   444		} else if (property == config->ctm_property) {
   445			ret = drm_atomic_replace_property_blob_from_id(dev,
   446						&state->ctm,
   447						val,
   448						sizeof(struct drm_color_ctm), -1,
   449						&replaced);
   450			state->color_mgmt_changed |= replaced;
   451			return ret;
   452		} else if (property == config->gamma_lut_property) {
   453			ret = drm_atomic_replace_property_blob_from_id(dev,
   454						&state->gamma_lut,
   455						val,
   456						-1, sizeof(struct drm_color_lut),
   457						&replaced);
   458			state->color_mgmt_changed |= replaced;
   459			return ret;
   460		} else if (property == config->prop_out_fence_ptr) {
   461			s32 __user *fence_ptr = u64_to_user_ptr(val);
   462	
   463			if (!fence_ptr)
   464				return 0;
   465	
 > 466			if (put_user(-1, fence_ptr))
   467				return -EFAULT;
   468	
   469			set_out_fence_for_crtc(state->state, crtc, fence_ptr);
   470		} else if (crtc->funcs->atomic_set_property) {
   471			return crtc->funcs->atomic_set_property(crtc, state, property, val);
   472		} else {
   473			DRM_DEBUG_ATOMIC("[CRTC:%d:%s] unknown property [PROP:%d:%s]]\n",
   474					 crtc->base.id, crtc->name,
   475					 property->base.id, property->name);
   476			return -EINVAL;
   477		}
   478	
   479		return 0;
   480	}
   481	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
