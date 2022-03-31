Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8694ED9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbiCaMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiCaMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:41:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF1143476
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648730410; x=1680266410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=08PwW8uHvnqETWFQD1YNoNtP3XBNMpQCoMD0PiInW7k=;
  b=b/whvpKEzSXJXthf4lQWgFxjjUYS+IzLGYJU5/XSDJEdz2XaCCDtfOOC
   6JHhA/hHjD1hyuBChHjhD1rNN2OlUjlnr/XyctRvS0/zb11xeHDijS3B/
   fy/BEZOs0DIMb8qJc3P+5A6c2LKlTiCxgzo20PMC7WUFsAPbV9KgafGcS
   dgxefqnKCIKbsqfwvWRPEBYf30knWmxNHSh69DfGcHlKxoz+6Zb7FClax
   DAor7LWE3EsPOfRDDFyCUF1JQh0pge619CHJhPcO53q6Hmnjftvu9mVZK
   wWbjtjXix7ggc47eIokkqq0wSB5YJLBNC9y/cZwMzPCwJt9wk8sjEo6qL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="260007388"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="260007388"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 05:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="606074939"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 31 Mar 2022 05:40:09 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZu5w-0000G6-Ex;
        Thu, 31 Mar 2022 12:40:08 +0000
Date:   Thu, 31 Mar 2022 20:39:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:61:17:
 error: implicit declaration of function 'enable_kernel_altivec'; did you
 mean 'enable_kernel_vsx'?
Message-ID: <202203312020.sqAkcWQT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: 96ee63730fa30614e943ac352ef772be49a712d9 drm/amd/display: Add control mechanism for FPU
date:   8 months ago
config: powerpc64-randconfig-r013-20220329 (https://download.01.org/0day-ci/archive/20220331/202203312020.sqAkcWQT-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96ee63730fa30614e943ac352ef772be49a712d9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 96ee63730fa30614e943ac352ef772be49a712d9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
