Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B464E81B8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiCZPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCZPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:01:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC11ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648306821; x=1679842821;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y8kIx4My/06TL0nQFY6hwQHcnmCTvA4S9aA9GzqM9+E=;
  b=fXJRBIUW8qCUXMUaQu1p6bhQM6DCCBoEw7DDrb7FpphKuCP3+HyI73Fg
   WPMlEK/LX1OL/r9HwhfnScJ9vQYExx06rnLE8uno874eIrQhZd4cyXpJQ
   02Kk3Uteh47P2UWIsAhuShgDSWQZHV0ehz5lyo4OFckmbAIQUTubWcowh
   Jh9nsI1BgeQ6qAhCDbFkY3nKaeJXLKm+qvfZh5Awzk7MmF5VLMuzMOPsu
   ZUdz4lwuVFCF7kNTGrGD4bKS8I1T1ZDk3Qzo98C2tyFafKEtq82NJYLlW
   vrT+zM2MxanE2dDA4PCUyde6MJLGoEd5akd2MDTjBl1kQ44keYZRcJZs8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="240942590"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="240942590"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 08:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="520506890"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 08:00:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY7tq-00006Q-8B; Sat, 26 Mar 2022 15:00:18 +0000
Date:   Sat, 26 Mar 2022 22:59:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_apg.c:117:18:
 warning: variable 'channels' set but not used
Message-ID: <202203262252.GRTBgzPR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: 61452908a79ec936660494fb4b9f2a35ee42e6e0 drm/amd/display: Add DP 2.0 Audio Package Generator
date:   7 months ago
config: powerpc64-randconfig-r015-20220325 (https://download.01.org/0day-ci/archive/20220326/202203262252.GRTBgzPR-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61452908a79ec936660494fb4b9f2a35ee42e6e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61452908a79ec936660494fb4b9f2a35ee42e6e0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

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
