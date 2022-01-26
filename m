Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6349C2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiAZEgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:36:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:58566 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbiAZEgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643171795; x=1674707795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kdRWxu7l9PU46pBEGCerCwT1O2nX8+p1ye0RRZLkGwI=;
  b=dcvgdt5j+XU0VhlCeD9JK/XeuzNCrOl6WPS23dnMXWZi7WIlJ6KiM2G0
   8htlp4f8R7Z6Zx/F/RcodqAaJydT6WE/qn2fw3sERjKK2w6FWm3c2zS3L
   FZRu0n5hvSlwo4T4ycXUPNe28yrLkmEcvlDpfN12ecRefp0gMXMRHaux7
   kpy44S6AxjgwhC8R++7/XFoiGsYVrj2NidBinb6iQagyup1dw/9CN63vf
   KLpZV0CxPitmUc24ACMKb5+lH+xKMMQLP1/SxPj1Xqac31Fj27RhkxEMZ
   7s7c20RiaxYDHqLgmEGReZrqzUCy0zxw9r03peyXj5dB+R6aygFmFqmkN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227152803"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="227152803"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 20:36:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="628187941"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2022 20:36:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCa2q-000Kmq-N2; Wed, 26 Jan 2022 04:36:32 +0000
Date:   Wed, 26 Jan 2022 12:36:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenjing Liu <wenjing.liu@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>
Subject: [agd5f:drm-next 135/190]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:805:6:
 warning: no previous prototype for 'dm_helpers_enable_periodic_detection'
Message-ID: <202201261234.rQipESIN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   63e583c8843f305a3e334a96d5de00435f4d38a2
commit: d9eb8fea6862e63421f7b9c93e32bef348488c41 [135/190] drm/amd/display: Drop DCN for DP2.x logic
config: sparc64-buildonly-randconfig-r002-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261234.rQipESIN-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout d9eb8fea6862e63421f7b9c93e32bef348488c41
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:805:6: warning: no previous prototype for 'dm_helpers_enable_periodic_detection' [-Wmissing-prototypes]
     805 | void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dm_helpers_enable_periodic_detection +805 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c

ac02dc34258569 Eric Yang 2021-08-25  804  
ac02dc34258569 Eric Yang 2021-08-25 @805  void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)

:::::: The code at line 805 was first introduced by commit
:::::: ac02dc34258569b793b78483154ca336f103946f drm/amd/display: Add periodic detection when zstate is enabled

:::::: TO: Eric Yang <Eric.Yang2@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
