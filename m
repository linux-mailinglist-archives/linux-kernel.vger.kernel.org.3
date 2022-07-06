Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2D568105
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiGFIVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGFIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:21:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE18237D2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095695; x=1688631695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PJhhnXComKx1M4ShaOEW3g+zg2Tl+r3qnW72BNEdkHw=;
  b=Y0s4nFcyUSiKwu1reklQd6BllokYgWd7TqdZSOjPtbiLdqyypUoVdBml
   ifOUTVWiD6CyaYawYFsuGhEJE8aOPuo/rK7alD4X8gcNaVG8PssGbnrWm
   uZrwH4DjRjRl67Fq4TKfxnIXM3RA1urNZ4rd3R71FPG1Y2oTgBAkQ0HEM
   pgsKDMQ9wj0qoiHqZfQsEa2EWj7bt957c0qPurJjEIEevHVHsqpGEaygj
   o1prNh/wNe8NjHY/WNx3lMS5pSbPKtEcyN4MIh/eRkcEuaOgRjBbbI4i1
   foWW1VJZpOkxUCNno24up5u1IuCz/6sdFbEkGO18ERl+HOlLArshX5aG5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282432786"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="282432786"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567967360"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:21:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o90Hs-000KFx-Gy;
        Wed, 06 Jul 2022 08:21:32 +0000
Date:   Wed, 6 Jul 2022 16:20:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 353/388]
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2720:6: warning: no
 previous prototype for 'dc_reset_state'
Message-ID: <202207061638.WngLaW9T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   fc25fd602b1e101a45650475a8d2f00d7bb8e971
commit: 97ca308925a50aa80711ccfaf814fa3898374862 [353/388] drm/amd/display: Add minimal pipe split transition state
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207061638.WngLaW9T-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 97ca308925a50aa80711ccfaf814fa3898374862
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2720:6: warning: no previous prototype for 'dc_reset_state' [-Wmissing-prototypes]
    2720 | void dc_reset_state(struct dc *dc, struct dc_state *context)
         |      ^~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:33:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dc_reset_state +2720 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c

  2719	
> 2720	void dc_reset_state(struct dc *dc, struct dc_state *context)
  2721	{
  2722		dc_resource_state_destruct(context);
  2723	
  2724		/* clear the structure, but don't reset the reference count */
  2725		memset(context, 0, offsetof(struct dc_state, refcount));
  2726	
  2727		init_state(dc, context);
  2728	}
  2729	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
