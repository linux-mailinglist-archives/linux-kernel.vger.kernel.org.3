Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322F54E80A2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiCZLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiCZLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:47:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B650466;
        Sat, 26 Mar 2022 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648295177; x=1679831177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QZz30kRk2KYFgwCCmkTEJe3s7wNZUQDJ9cvHRPojmY0=;
  b=PTq2cvEtK0Mpj4er9XfUIHJgFc8QRO7PqCkV4pXb4XnXIsm23lx1nbMP
   tkZGPUXpaAx36W/rDu9eIY7UeezXEWCpGRLACi17XXThjEM62eOq/T4lk
   5pdK/130vcBCrqnloIhSIs9jgsSgR3tx40pg1XTxiMS6Fa/8DhlzInkQI
   FYFAIGaXTTBCB67UMG4qRwG4c39VVMSoej4nfnAgUD/KQUAoRdN86eBS1
   xW73hmGBfXA/jjQlBVWawvKmZbFxJ1RFgJJ2eX2hBWT669DCrrFMPrtCN
   JOtYoE6vNhUl2pSCc6jI2q3pQ7vTSyKcm6iB11tO8tqTdwjJpITTAnnRb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="239376247"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="239376247"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 04:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="718492219"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2022 04:46:14 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY4s1-000NKn-Vl; Sat, 26 Mar 2022 11:46:13 +0000
Date:   Sat, 26 Mar 2022 19:45:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        linux-doc@vger.kernel.org
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_optc.c:95:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203261919.vs4G6G1g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   9 months ago
config: powerpc64-randconfig-r015-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261919.vs4G6G1g-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fe44c080a53ac0ccbe88053a2e40f9acca33091
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8fe44c080a53ac0ccbe88053a2e40f9acca33091
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_optc.c:95: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Enable CRTC


vim +95 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_optc.c

110d3968fe9508 Nicholas Kazlauskas 2021-05-19   93  
110d3968fe9508 Nicholas Kazlauskas 2021-05-19   94  /**
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  @95   * Enable CRTC
110d3968fe9508 Nicholas Kazlauskas 2021-05-19   96   * Enable CRTC - call ASIC Control Object to enable Timing generator.
110d3968fe9508 Nicholas Kazlauskas 2021-05-19   97   */
110d3968fe9508 Nicholas Kazlauskas 2021-05-19   98  static bool optc31_enable_crtc(struct timing_generator *optc)
110d3968fe9508 Nicholas Kazlauskas 2021-05-19   99  {
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  100  	struct optc *optc1 = DCN10TG_FROM_TG(optc);
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  101  
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  102  	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  103  	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  104  			OPTC_SEG0_SRC_SEL, optc->inst);
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  105  
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  106  	/* VTG enable first is for HW workaround */
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  107  	REG_UPDATE(CONTROL,
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  108  			VTG0_ENABLE, 1);
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  109  
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  110  	REG_SEQ_START();
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  111  
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  112  	/* Enable CRTC */
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  113  	REG_UPDATE_2(OTG_CONTROL,
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  114  			OTG_DISABLE_POINT_CNTL, 2,
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  115  			OTG_MASTER_EN, 1);
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  116  
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  117  	REG_SEQ_SUBMIT();
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  118  	REG_SEQ_WAIT_DONE();
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  119  
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  120  	return true;
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  121  }
110d3968fe9508 Nicholas Kazlauskas 2021-05-19  122  

:::::: The code at line 95 was first introduced by commit
:::::: 110d3968fe9508142cb76b530d141209efa169a8 drm/amd/display: Add DCN3.1 OPTC

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
