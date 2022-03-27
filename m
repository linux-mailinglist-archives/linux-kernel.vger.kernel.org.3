Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4984E89F5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiC0ULE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiC0ULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:11:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BEB870
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648411763; x=1679947763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zEWgsueqQKaCJQwm3/OMF+mJ6ERM6ecbMVwHlw/DhGQ=;
  b=OBN9r3YW3q/xmj26vWWoMLk5KjtBKg2/TqG0cpUVNLibs6iFZrl2pk8r
   mGjfiBG0ChhEWHWb0shrOXE6OPzXkygWgCJkM55aVSn9f7V+OLF9Way6M
   EihqwrbaR5b/Qmu32CANARfrKdZ2yHsvUSl4OqRUwH1UPecHkFXiKkWI0
   WnS8Z6LvUUEWRJISDGr9hfDp9ECeOqcT+YV95wwKRHbLFzFLp/GK8/wAp
   q+gFIi55QjchBpL6fPYGIWYC1VvKYNmjP52/NQlSppb5jU1kBU7+OjhjN
   oYYihIbLGANgystEp7jgc7lxU1DrCWu7FA0SRf77wvEZEjYJGk6HEAXOe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="257702510"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="257702510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 13:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="520759978"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2022 13:09:21 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYZCS-0001OR-PL; Sun, 27 Mar 2022 20:09:20 +0000
Date:   Mon, 28 Mar 2022 04:09:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Li <Roman.Li@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenwu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1617:6:
 warning: no previous prototype for 'is_timing_changed'
Message-ID: <202203280415.IGMBaNAP-lkp@intel.com>
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

Hi Roman,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7001052160d172f6de06adeffde24dde9935ece8
commit: 17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b drm/amd/display: Add dsc pre-validation in atomic check
date:   6 weeks ago
config: arc-randconfig-r003-20220327 (https://download.01.org/0day-ci/archive/20220328/202203280415.IGMBaNAP-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1617:6: warning: no previous prototype for 'is_timing_changed' [-Wmissing-prototypes]
    1617 | bool is_timing_changed(struct dc_stream_state *cur_stream,
         |      ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:30:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/is_timing_changed +1617 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c

  1616	
> 1617	bool is_timing_changed(struct dc_stream_state *cur_stream,
  1618			       struct dc_stream_state *new_stream)
  1619	{
  1620		if (cur_stream == NULL)
  1621			return true;
  1622	
  1623		/* If output color space is changed, need to reprogram info frames */
  1624		if (cur_stream->output_color_space != new_stream->output_color_space)
  1625			return true;
  1626	
  1627		return memcmp(
  1628			&cur_stream->timing,
  1629			&new_stream->timing,
  1630			sizeof(struct dc_crtc_timing)) != 0;
  1631	}
  1632	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
