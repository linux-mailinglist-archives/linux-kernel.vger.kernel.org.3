Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205E4FB31C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbiDKFAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiDKFA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:00:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07420BD5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649653095; x=1681189095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kzMbPIQG0imGmkPPGk1dtXT+WQQ2x3p5kpQQBHSDbpM=;
  b=m2zkpYIDNq8isosyP/lyXthZg/5jmAPhwerwgip4SPVIhdO/Q58c3mA7
   FBrzknhIG2iV7oJ1WzShvAtUmG9SHeeqiFzKufKmayxd3gPOU2SekON0l
   ZMTCSwwVeWr1tG+48up2phswVP+qlC+6nDmH32lGyab4TAsSFxbnbo/r/
   f/bOv9tMjV4Ci7fe9XT85kVtWBFt3gRLHOAAuGQpD3nKc5yKE3E6w9p1v
   /yVU/QiaDyi+jUxILcfZl/pGUNyssu55aKhpl8PyJE1muI4RWvu+0c82/
   ikzSKXHynvWNtx4oei9laIijG27/QSx58+92g6j0tB+y+bqKyVe+TDNNB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="249312511"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="249312511"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 21:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525251509"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Apr 2022 21:58:12 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndm7w-0001YJ-0v;
        Mon, 11 Apr 2022 04:58:12 +0000
Date:   Mon, 11 Apr 2022 12:57:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabe Teeger <gabe.teeger@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hubp.c:57:6:
 warning: no previous prototype for function 'hubp31_program_extended_blank'
Message-ID: <202204111241.iI7F1kt8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
commit: e5fc78252ccd8dfc260f87d83905e9dffff6d975 drm/amd/display: Add support for zstate during extended vblank
date:   2 weeks ago
config: x86_64-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220411/202204111241.iI7F1kt8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc78252ccd8dfc260f87d83905e9dffff6d975
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc78252ccd8dfc260f87d83905e9dffff6d975
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hubp.c:57:6: warning: no previous prototype for function 'hubp31_program_extended_blank' [-Wmissing-prototypes]
   void hubp31_program_extended_blank(struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hubp.c:57:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hubp31_program_extended_blank(struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
   ^
   static 
   1 warning generated.


vim +/hubp31_program_extended_blank +57 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hubp.c

    56	
  > 57	void hubp31_program_extended_blank(struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
    58	{
    59		struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
    60	
    61		REG_SET(BLANK_OFFSET_1, 0, MIN_DST_Y_NEXT_START, min_dst_y_next_start_optimized);
    62	}
    63	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
