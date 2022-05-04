Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABF51B1CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359379AbiEDWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiEDWbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:31:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABD9DD9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651703262; x=1683239262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xA/ReZLxpV3abEjRxRaBNedXUbcOk+NboegvAbPipMs=;
  b=iZLco2kfOCCpfV0gnDX7aS2278OyxVCTxTaRT2xNriEd7UbSyoPjwJRQ
   TkRRKFVXgO2kpWLV6FCM1L3nBEwnYxLl1VTj7agbvwwqWSBf+Cw+8yoQd
   Yy+JAIkEHJppZ44pEWoWXKkgQTueIcttq3B1uVGGvgPVZTUshoV6dW2WX
   uxpe5zHLKWLKCge/KR/mcqAxSt5xemIVTWHnzrvQbTYC0FAMtZ/mh1ddY
   OzZgAvp8Q6WJJ1Kb7FDCAwyxl6B1gv14wJMrhybHZkTw0i2pdQNEGZ4xc
   gsEzE+3m9gL0NhbTO9OZtoYp+JKIaJGZsrJwrPT2ZZ4yC4+w4Hh0XbK+v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268071158"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="268071158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="599736299"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2022 15:27:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmNT9-000BqV-Sn;
        Wed, 04 May 2022 22:27:39 +0000
Date:   Thu, 5 May 2022 06:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>
Subject: [agd5f:drm-next 429/460]
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous
 prototype for 'gfx_v11_0_rlc_stop'
Message-ID: <202205050625.OzD5MeoT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   d6ffefccf7f04eefddc8e8aa35fb4afe05a42e0c
commit: 3d879e81f0f9ed5d33b5eda0fe5226c884bb8073 [429/460] drm/amdgpu: add init support for GFX11 (v2)
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050625.OzD5MeoT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 3d879e81f0f9ed5d33b5eda0fe5226c884bb8073
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous prototype for 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes]
    1945 | void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
         |      ^~~~~~~~~~~~~~~~~~


vim +/gfx_v11_0_rlc_stop +1945 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c

  1944	
> 1945	void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
  1946	{
  1947		u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
  1948	
  1949		tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
  1950		WREG32_SOC15(GC, 0, regRLC_CNTL, tmp);
  1951	}
  1952	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
