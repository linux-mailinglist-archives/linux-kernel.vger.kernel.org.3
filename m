Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8773052FE0D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbiEUQLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245302AbiEUQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:11:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59E78922
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653149507; x=1684685507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8txJi9lrvcqTTRR2yvojtsstIE3rx6cZV+VyhbqqpQ8=;
  b=Io+Zh47HiI1TkMcviwaV5upC3xh0CY+hRhIdkZqXeypvyLe68JiY3vB4
   hbAgu8mm6dVXThQqo2xzJR1aYUGHsMWoaT+78r4ojsyiCd2pb3FA+/W2x
   eo+8Q4Kv/oQsUpJM9BCxrZvdpfCkbZOqzgWPJ7dMrnWKEIFPfcpOTlPzi
   feP+C7jWRag/hDaPSgX7+2J53z8MQZuns03cWuPCHpuBKWK8q5wQVDhQh
   HArrbG2TFbNNwNWhaDBqkTH72G0+m9fU3aWUznxxDmSeQYFyHWViQmpHJ
   ttjzT8alHSDK6Mw2cSJqJdbMUbIscHLubwQb7qntrSWE/G6bgXA1g/pYr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="298190405"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="298190405"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 09:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="628641661"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2022 09:11:44 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsRhf-0006RA-Pb;
        Sat, 21 May 2022 16:11:43 +0000
Date:   Sun, 22 May 2022 00:11:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:61:17:
 error: implicit declaration of function 'enable_kernel_altivec'; did you
 mean 'enable_kernel_vsx'?
Message-ID: <202205220036.y1Y3cc7N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c3f5bec9b40b9437410abb08eccd5cdd1598a3c
commit: 96ee63730fa30614e943ac352ef772be49a712d9 drm/amd/display: Add control mechanism for FPU
date:   10 months ago
config: powerpc64-randconfig-r035-20220519 (https://download.01.org/0day-ci/archive/20220522/202205220036.y1Y3cc7N-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96ee63730fa30614e943ac352ef772be49a712d9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 96ee63730fa30614e943ac352ef772be49a712d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_begin':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:61:17: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_vsx'? [-Werror=implicit-function-declaration]
      61 |                 enable_kernel_altivec();
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 enable_kernel_vsx
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_end':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:89:17: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_vsx'? [-Werror=implicit-function-declaration]
      89 |                 disable_kernel_altivec();
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 disable_kernel_vsx
   cc1: some warnings being treated as errors


vim +61 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c

    35	
    36	/**
    37	 * dc_fpu_begin - Enables FPU protection
    38	 * @function_name: A string containing the function name for debug purposes
    39	 *   (usually __func__)
    40	 *
    41	 * @line: A line number where DC_FP_START was invoked for debug purpose
    42	 *   (usually __LINE__)
    43	 *
    44	 * This function is responsible for managing the use of kernel_fpu_begin() with
    45	 * the advantage of providing an event trace for debugging.
    46	 *
    47	 * Note: Do not call this function directly; always use DC_FP_START().
    48	 */
    49	void dc_fpu_begin(const char *function_name, const int line)
    50	{
    51		TRACE_DCN_FPU(true, function_name, line);
    52	
    53	#if defined(CONFIG_X86)
    54		kernel_fpu_begin();
    55	#elif defined(CONFIG_PPC64)
    56		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
    57			preempt_disable();
    58			enable_kernel_vsx();
    59		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
    60			preempt_disable();
  > 61			enable_kernel_altivec();
    62		} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
    63			preempt_disable();
    64			enable_kernel_fp();
    65		}
    66	#endif
    67	}
    68	
    69	/**
    70	 * dc_fpu_end - Disable FPU protection
    71	 * @function_name: A string containing the function name for debug purposes
    72	 * @line: A-line number where DC_FP_END was invoked for debug purpose
    73	 *
    74	 * This function is responsible for managing the use of kernel_fpu_end() with
    75	 * the advantage of providing an event trace for debugging.
    76	 *
    77	 * Note: Do not call this function directly; always use DC_FP_END().
    78	 */
    79	void dc_fpu_end(const char *function_name, const int line)
    80	{
    81		TRACE_DCN_FPU(false, function_name, line);
    82	#if defined(CONFIG_X86)
    83		kernel_fpu_end();
    84	#elif defined(CONFIG_PPC64)
    85		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
    86			disable_kernel_vsx();
    87			preempt_enable();
    88		} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
  > 89			disable_kernel_altivec();

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
