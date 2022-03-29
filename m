Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825AD4EAEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiC2NoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbiC2Nn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:43:56 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D375BD06
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648561333; x=1680097333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hpqU7MqHJNI3GQ9qmngKtxRXq3ePkaM7Z6l6zV3fyvA=;
  b=hzxYU/IHcLtxZaroXbGUutT7K0swJJIq3BnS3um157p3rvyWBQmEuAhT
   +NhEx57HfqPfR7w0bQYahBPNWV6RmFJUziN3b3kcBZpBVuAmd4Xa+isBY
   r+OghJ+rT953wA0MrSgVSzK4/hg79LAb296dwyqpXU/qEacdvbgGpB2N9
   Kr9Cqi3tgdCb07NsfCN6H2UtMuuuuIeCLvWj6qhH23pXTyyHmWJebDVAH
   dbl1kHWKtaxckEEqWU80VE1iF8HqAb373nMMbhotVc8gO+8nI3FGpW6io
   HZWz2EZ31ydQxOmE2HJR+GGI6pN6QXltpZ5I/AE4oZ5sxAKf6n+3rKThJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="319949721"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="319949721"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="652975216"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2022 06:42:10 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZC6s-0000GL-10; Tue, 29 Mar 2022 13:42:10 +0000
Date:   Tue, 29 Mar 2022 21:41:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Li <Roman.Li@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenwu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1617:6:
 warning: no previous prototype for function 'is_timing_changed'
Message-ID: <202203292131.ydRfKsCO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
head:   1930a6e739c4b4a654a69164dbe39e554d228915
commit: 17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b drm/amd/display: Add dsc pre-validation in atomic check
date:   6 weeks ago
config: arm64-randconfig-r031-20220327 (https://download.01.org/0day-ci/archive/20220329/202203292131.ydRfKsCO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 17ce8a6907f77b7ac97ddaa071d8a1f6e06ce85b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1617:6: warning: no previous prototype for function 'is_timing_changed' [-Wmissing-prototypes]
   bool is_timing_changed(struct dc_stream_state *cur_stream,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1617:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool is_timing_changed(struct dc_stream_state *cur_stream,
   ^
   static 
   1 warning generated.


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
