Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241B54F8F69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiDHHVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDHHUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:20:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578721FC62
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649402308; x=1680938308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1iiz65dkewXFVU2JVgR+NgxlENZAlIxCKHCCdhdsNGI=;
  b=MaO7jxSlL7ZMwNtaVqNSaSFDchqPxuv5pD1KxYhrgjSg0HPtWoF64kDc
   AsB+rPuFm0mpgBKQ4E/TOEy4mvvk15MwIal0FoINAmrkAmEgWH899OYdd
   SBZojPsn8VTXubSKjk1mTnrEkO4lftcKy6jc5H3C1N4P8sRHN7lGrBpVy
   qR/JAWsO0cB4DhJJFY+TotLbu+e9CMC4BUxkP1oSGPbcwDCcRIN/M+LKu
   o2WdFNLPdGC+vN+kEWjjF2o6ySirX7NuKZ7hvg0IjP0UlvAURYwFDdyKP
   bvRuHMHdzYy9EHeaYxQlImcyGikZJLZWBtVXdCouM41aGiUHIs5vYqqdc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="286521195"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="286521195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="653155830"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2022 00:18:25 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncisy-00069w-Ht;
        Fri, 08 Apr 2022 07:18:24 +0000
Date:   Fri, 8 Apr 2022 15:17:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabe Teeger <gabe.teeger@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [agd5f:drm-next 16/132]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hubp.c:57:6: warning:
 no previous prototype for 'hubp31_program_extended_blank'
Message-ID: <202204081535.oinzrfCs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   49aa98ca30cd186ab33fc5802066e2024d3bfa39
commit: e5fc78252ccd8dfc260f87d83905e9dffff6d975 [16/132] drm/amd/display: Add support for zstate during extended vblank
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220408/202204081535.oinzrfCs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout e5fc78252ccd8dfc260f87d83905e9dffff6d975
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hubp.c:57:6: warning: no previous prototype for 'hubp31_program_extended_blank' [-Wmissing-prototypes]
      57 | void hubp31_program_extended_blank(struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
