Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC150B35A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445674AbiDVI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiDVI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:59:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2A532CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650617799; x=1682153799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EUKQvAoKoFt5hSbzTVGz9Mveky+GfIeEptM6x0lHNDA=;
  b=RcdWvQx6DrI8g6ST6ucPnPIlUSqF6AhF7jX41BMGT8uIGDITWZ5dZdw/
   uB9FQ6NLA03hLAzd4Sa5UR8DS47XlMriFFDeJimNiQ4OGWh1lympMhFnd
   pznaIqlM8UlUP5vzmdVyUsNM5H7Z1CLHO59asjJ3PT30hGy4bPPBYY2OO
   1aVlTLfGePtr112pF/NOK9DcCGmKaKj+A2r9B5pqN+bEkSXdhgixAiIA2
   6fNsR7DdBgNkB9KhC8vvwTgiikJhJs5+RNsba8rq5sF7WBzMJY1jgsyO5
   aBuNwQgkDuQAPkaEBciAZ52iHRlGxwtSyFzV+HSA2p7zVVzBTCSRDLG/V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325075391"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="325075391"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 01:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="511488183"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2022 01:56:37 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhp5g-0009ww-SB;
        Fri, 22 Apr 2022 08:56:36 +0000
Date:   Fri, 22 Apr 2022 16:56:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Zhan Liu <zhan.liu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:88:14:
 warning: variable 'is_in_uma' set but not used
Message-ID: <202204221604.l3cM1i38-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d569e86915b7f2f9795588591c8d5ea0b66481cb
commit: 519607a2f7798decb9c891a4f706aaf780f5a677 drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into DRM_AMD_DC_DCN
date:   7 months ago
config: powerpc64-randconfig-r033-20220420 (https://download.01.org/0day-ci/archive/20220422/202204221604.l3cM1i38-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=519607a2f7798decb9c891a4f706aaf780f5a677
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 519607a2f7798decb9c891a4f706aaf780f5a677
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function 'gpu_addr_to_uma':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:88:14: warning: variable 'is_in_uma' set but not used [-Wunused-but-set-variable]
      88 |         bool is_in_uma;
         |              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function 'dcn201_pipe_control_lock':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:544:22: warning: variable 'hubp' set but not used [-Wunused-but-set-variable]
     544 |         struct hubp *hubp = NULL;
         |                      ^~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c: In function 'dpp201_get_optimal_number_of_taps':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:185:18: warning: variable 'pixel_width' set but not used [-Wunused-but-set-variable]
     185 |         uint32_t pixel_width;
         |                  ^~~~~~~~~~~


vim +/is_in_uma +88 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c

3f68c01be9a222 Zhan Liu 2021-09-25   84  
3f68c01be9a222 Zhan Liu 2021-09-25   85  static void gpu_addr_to_uma(struct dce_hwseq *hwseq,
3f68c01be9a222 Zhan Liu 2021-09-25   86  		PHYSICAL_ADDRESS_LOC *addr)
3f68c01be9a222 Zhan Liu 2021-09-25   87  {
3f68c01be9a222 Zhan Liu 2021-09-25  @88  	bool is_in_uma;
3f68c01be9a222 Zhan Liu 2021-09-25   89  
3f68c01be9a222 Zhan Liu 2021-09-25   90  	if (hwseq->fb_base.quad_part <= addr->quad_part &&
3f68c01be9a222 Zhan Liu 2021-09-25   91  			addr->quad_part < hwseq->fb_top.quad_part) {
3f68c01be9a222 Zhan Liu 2021-09-25   92  		addr->quad_part -= hwseq->fb_base.quad_part;
3f68c01be9a222 Zhan Liu 2021-09-25   93  		addr->quad_part += hwseq->fb_offset.quad_part;
3f68c01be9a222 Zhan Liu 2021-09-25   94  		is_in_uma = true;
3f68c01be9a222 Zhan Liu 2021-09-25   95  	} else if (hwseq->fb_offset.quad_part <= addr->quad_part &&
3f68c01be9a222 Zhan Liu 2021-09-25   96  			addr->quad_part <= hwseq->uma_top.quad_part) {
3f68c01be9a222 Zhan Liu 2021-09-25   97  		is_in_uma = true;
3f68c01be9a222 Zhan Liu 2021-09-25   98  	} else if (addr->quad_part == 0) {
3f68c01be9a222 Zhan Liu 2021-09-25   99  		is_in_uma = false;
3f68c01be9a222 Zhan Liu 2021-09-25  100  	} else {
3f68c01be9a222 Zhan Liu 2021-09-25  101  		is_in_uma = false;
3f68c01be9a222 Zhan Liu 2021-09-25  102  	}
3f68c01be9a222 Zhan Liu 2021-09-25  103  }
3f68c01be9a222 Zhan Liu 2021-09-25  104  

:::::: The code at line 88 was first introduced by commit
:::::: 3f68c01be9a2227de1e190317fe34a6fb835a094 drm/amd/display: add cyan_skillfish display support

:::::: TO: Zhan Liu <zhan.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
