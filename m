Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1754A4E8497
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 23:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiCZWtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 18:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiCZWtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 18:49:21 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE4B5DA0A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648334861; x=1679870861;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eGIPtlc7gVZP2oHxe79R75bwbRGJLQkAIQuKzMmkJIY=;
  b=ilyK6q+4vOHsFSlzHEolICNNCKnMDVpFebxv8Sf4vj0vIwJpSGkc9vwD
   WJgPLVsTdoCvvLASkWXD96WxE1xJoLlh972iDjorWNht5FAVGsPQm2fvC
   KFDfAxl0HeqQY0FNkwDJ6uOqLIU2ezr+EuhhpUxPEkKoZ1d4B8veHLjkY
   TCI1YdIbfI65cklNCvboGUzxpbRUD5dCr3eblDwzIz0LRUcZhCMQl4Qoi
   lQHIYdhos038YB+W7GIRljx8m/vwxZVAwo2qpTvk3NDHgVttS+a5BCruZ
   3QgKYZnhwepRvV0K5RIT6DtqpOINFCW3mL/ij6AhL15dH4nqca3uSIazt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="319511376"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="319511376"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 15:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="718595825"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2022 15:47:39 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYFC6-0000Te-S2; Sat, 26 Mar 2022 22:47:38 +0000
Date:   Sun, 27 Mar 2022 06:46:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Zhan Liu <zhan.liu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_init.c:127:6:
 warning: no previous prototype for 'dcn201_hw_sequencer_construct'
Message-ID: <202203270623.MEZulKy5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   710f5d627a98e86f821aceb840b8f2f1fcc6cf75
commit: 519607a2f7798decb9c891a4f706aaf780f5a677 drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into DRM_AMD_DC_DCN
date:   6 months ago
config: powerpc64-randconfig-r015-20220325 (https://download.01.org/0day-ci/archive/20220327/202203270623.MEZulKy5-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=519607a2f7798decb9c891a4f706aaf780f5a677
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 519607a2f7798decb9c891a4f706aaf780f5a677
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_init.c:127:6: warning: no previous prototype for 'dcn201_hw_sequencer_construct' [-Wmissing-prototypes]
     127 | void dcn201_hw_sequencer_construct(struct dc *dc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
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


vim +/dcn201_hw_sequencer_construct +127 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_init.c

3f68c01be9a222 Zhan Liu 2021-09-25  126  
3f68c01be9a222 Zhan Liu 2021-09-25 @127  void dcn201_hw_sequencer_construct(struct dc *dc)

:::::: The code at line 127 was first introduced by commit
:::::: 3f68c01be9a2227de1e190317fe34a6fb835a094 drm/amd/display: add cyan_skillfish display support

:::::: TO: Zhan Liu <zhan.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
