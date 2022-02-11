Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE14B300C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353902AbiBKWFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:05:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbiBKWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:05:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCE3C79
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644617112; x=1676153112;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kcHFZn7YpgoceGHwFEINTdtGIfVM7GyEC2nILtzOtlk=;
  b=mTeLrNB0s00Buox8S5MxkYus5/79U13m4G3JnKUy7zvCS4AjJk/0H/H4
   KjmH0alKo6xzLjsr7OfI4FtR0u8Lim1LJ8t8dSIBiUpXBwCU9LjQf5xoj
   3ddfrfUIr87yx4AZMbFuQ9NX7WC+KiiLUbWPmCmlwPzjosj87t+rF/ijM
   RBbiDCmC3aJ74SCQQ2uzQfFgbMsDAmuCxL/aZ6XCoaYtoGpKUPIpND6dh
   FNOe+54DOAyfwSsXTcVcrKggESYYmJTQH/WfqmmF97jHquBZuSWOQNxaZ
   ldlAMGq1e1Jc8qIQGmqqvyi+CH4Bgej245wh7khazqUXMNrrfH1jrwIAz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="229782999"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="229782999"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 14:05:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483683227"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2022 14:05:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIe2P-0005F7-7p; Fri, 11 Feb 2022 22:05:09 +0000
Date:   Sat, 12 Feb 2022 06:04:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:61:17:
 error: implicit declaration of function 'enable_kernel_altivec'; did you
 mean 'enable_kernel_vsx'?
Message-ID: <202202120657.ZqI8ITCA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1baf68e1383f6ed93eb9cff2866d46562607a43
commit: 96ee63730fa30614e943ac352ef772be49a712d9 drm/amd/display: Add control mechanism for FPU
date:   6 months ago
config: powerpc64-randconfig-r031-20220211 (https://download.01.org/0day-ci/archive/20220212/202202120657.ZqI8ITCA-lkp@intel.com/config)
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
