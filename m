Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3C50AD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443062AbiDVBdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiDVBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:33:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03649687
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650591033; x=1682127033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oQbcdbZZOUCC2NC/bNLGQRnN+pkXa+YSnk7xuSuLn5c=;
  b=ebg+ZMOUMnZay/vf6rNLy6Dcn6cYPmoMAo/+lUn0BB3IVo36BUMQAo8U
   IjETVfJ+XVLca4UkYVEXTJU9d+L0ahRlngfzvqQNVue8Q48ApEJlFpIjF
   mw9+D4R6UOQ59JCRN+QXia3CWSkJrDiIfQVj9nLt8VmS4q78HOU+3ITBc
   1URoV3eBBX2zS2erBb83vmyFTlNhIj2wCZwtqA/JUbWDcU4JEiv5OKequ
   I0ckvqfOP8/Lcxq7R5H8iBFrllEmkAOCzT4g/DsAKNon5PrAQtVVsVdZQ
   CPaGag/9GcXpRskF18RyAblrYH3+y5ecA8VrsmjMXeTX4f9+TbPaSq3IQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="324982882"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="324982882"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 18:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615184753"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 18:30:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhi7y-00094A-N1;
        Fri, 22 Apr 2022 01:30:30 +0000
Date:   Fri, 22 Apr 2022 09:29:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:117:18:
 warning: variable 'channels' set but not used
Message-ID: <202204220950.PWka9oJf-lkp@intel.com>
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

Hi Fangzhi,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b05a5683eba6e2d40eadd5eeef53c4864149a4fe
commit: 61452908a79ec936660494fb4b9f2a35ee42e6e0 drm/amd/display: Add DP 2.0 Audio Package Generator
date:   8 months ago
config: powerpc64-randconfig-r033-20220420 (https://download.01.org/0day-ci/archive/20220422/202204220950.PWka9oJf-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61452908a79ec936660494fb4b9f2a35ee42e6e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61452908a79ec936660494fb4b9f2a35ee42e6e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c: In function 'apg31_se_audio_setup':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:117:18: warning: variable 'channels' set but not used [-Wunused-but-set-variable]
     117 |         uint32_t channels = 0;
         |                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:116:18: warning: variable 'speakers' set but not used [-Wunused-but-set-variable]
     116 |         uint32_t speakers = 0;
         |                  ^~~~~~~~


vim +/channels +117 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c

   108	
   109	static void apg31_se_audio_setup(
   110		struct apg *apg,
   111		unsigned int az_inst,
   112		struct audio_info *audio_info)
   113	{
   114		struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
   115	
 > 116		uint32_t speakers = 0;
 > 117		uint32_t channels = 0;
   118	
   119		ASSERT(audio_info);
   120		/* This should not happen.it does so we don't get BSOD*/
   121		if (audio_info == NULL)
   122			return;
   123	
   124		speakers = audio_info->flags.info.ALLSPEAKERS;
   125		channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
   126	
   127		/* DisplayPort only allows for one audio stream with stream ID 0 */
   128		REG_UPDATE(APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, 0);
   129	
   130		/* When running in "pair mode", pairs of audio channels have their own enable
   131		 * this is for really old audio drivers */
   132		REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xF);
   133		// REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, channels);
   134	
   135		/* Disable forced mem power off */
   136		REG_UPDATE(APG_MEM_PWR, APG_MEM_PWR_FORCE, 0);
   137	
   138		apg31_enable(apg);
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
