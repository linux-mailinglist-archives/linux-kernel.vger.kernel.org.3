Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8F488712
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 01:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiAIAPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 19:15:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:40119 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbiAIAPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 19:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641687316; x=1673223316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2B9S9ng4UKo5tGxjU+t95uwlpvjy3LyV5TmoRYwKjXw=;
  b=DnoZz2A1H0C8Pk64QvjITk7BOzFfT5ZvPf4/f/cDmrqRtGqOr9TBIyiB
   Ud5bQlIDmvNxJThLvqxV8BzFfTXQQcDfrjtSRPn/ZiTJBu1UogExX0zHA
   +kTuXqG1SCixQtJfpkmON/ME7xHTlZHAs2lk8ps1xD1ZZJvAttfFoYqI+
   gqs3Cwmo6bzqNe4o/XXG1D0sKcrE0S+seed3Zkql7N8B4yRf5Ddk/3aN6
   AwgO0HJ9H2jMXss/92Fw4KKQM+ePEd4JxVbLVQIswvtQiGa7rooUwPwLc
   tacWDUzwqQzfNbevl6Vn6q/i0ZxDusg/6Bajf/O+TPAc4zwlGX5L0pQiN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="267366155"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="267366155"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 16:15:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="471682702"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 16:15:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6Lrd-0001CW-QZ; Sun, 09 Jan 2022 00:15:13 +0000
Date:   Sun, 9 Jan 2022 08:14:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:61:17:
 error: implicit declaration of function 'enable_kernel_altivec'; did you
 mean 'enable_kernel_vsx'?
Message-ID: <202201090809.yeYLGlnk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1587f7bfe9a0f97a75d42ac1489aeda551106bc
commit: 96ee63730fa30614e943ac352ef772be49a712d9 drm/amd/display: Add control mechanism for FPU
date:   5 months ago
config: powerpc64-randconfig-s032-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090809.yeYLGlnk-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96ee63730fa30614e943ac352ef772be49a712d9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 96ee63730fa30614e943ac352ef772be49a712d9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
