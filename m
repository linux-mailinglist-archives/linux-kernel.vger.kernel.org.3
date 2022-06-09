Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E554538D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbiFIRzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiFIRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:55:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A518025591
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654797346; x=1686333346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bkVhV2DIALzBN3tjhS5SoyZ7ccFtFXAPjGRdtXgjTBM=;
  b=Hu8FICHvGhxMbTla/r2rhh52D9HH971C14Z8/iTdNWBczG9rosHhFzcX
   b5I1ltvsrTqIxfe8qMutxtZjEDS8il/rpsdzIPlO96sdXrQ/D4pVU7zd6
   GMSeIioL3jzcMQa3L81i7XZKB9GCkLEw+qou3aztr0fgtTptQdJpRYphl
   IA39XGbrZ4meOilVTc7ZevNm8lMHIk99Df5EITaBTlpF/cpMtfG8qMrUU
   AYGE18f8kdH4SjvNqM/QwnpilyYfg0tlop4RAa3au95ZxwrrSqzYHjb1r
   22G0KlEREd7v3qqVqlNn9rqlTEy/lNfATcEEZD2AfLqBVA/kQPNKGLN4h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266144273"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="266144273"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585708375"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 10:55:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzMNj-000GEv-GS;
        Thu, 09 Jun 2022 17:55:43 +0000
Date:   Fri, 10 Jun 2022 01:55:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuan Yao <yuan.yao@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 449/453]
 arch/x86/kernel/fpu/xstate.c:719:7: warning: format specifies type 'long'
 but the argument has type 'unsigned int'
Message-ID: <202206100124.87NJ8YRo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   64f3ddf316eab9398414b94e62a01d185e6e94c8
commit: c00f6297349a8d81049eefe338ee079179787e28 [449/453] X86: FPU: Fix unexpected #PF while executing XRSTORS
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220610/202206100124.87NJ8YRo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/c00f6297349a8d81049eefe338ee079179787e28
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout c00f6297349a8d81049eefe338ee079179787e28
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/fpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/fpu/xstate.c:719:7: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
                sizeof(init_fpstate_full), kernel_size);
                ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:133:29: note: expanded from macro 'WARN'
                   __WARN_printf(TAINT_WARN, format);                      \
                                             ^~~~~~
   include/asm-generic/bug.h:105:17: note: expanded from macro '__WARN_printf'
                   __warn_printk(arg);                                     \
                                 ^~~
   1 warning generated.


vim +719 arch/x86/kernel/fpu/xstate.c

   685	
   686	static int __init init_xstate_size(void)
   687	{
   688		/* Recompute the context size for enabled features: */
   689		unsigned int user_size, kernel_size, kernel_default_size;
   690		bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
   691	
   692		/* Uncompacted user space size */
   693		user_size = get_xsave_size_user();
   694	
   695		/*
   696		 * XSAVES kernel size includes supervisor states and
   697		 * uses compacted format when available.
   698		 *
   699		 * XSAVE does not support supervisor states so
   700		 * kernel and user size is identical.
   701		 */
   702		if (compacted)
   703			kernel_size = get_xsaves_size_no_independent();
   704		else
   705			kernel_size = user_size;
   706	
   707		kernel_default_size =
   708			xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
   709	
   710		/* Ensure we have the space to store all default enabled features. */
   711		if (!is_supported_xstate_size(kernel_default_size))
   712			return -EINVAL;
   713	
   714		if (!paranoid_xstate_size_valid(kernel_size))
   715			return -EINVAL;
   716	
   717		WARN(kernel_size > sizeof(init_fpstate_full),
   718		     "Too small init_fpstate size:%ld expected:%d\n",
 > 719		     sizeof(init_fpstate_full), kernel_size);
   720	
   721		fpu_kernel_cfg.max_size = kernel_size;
   722		fpu_user_cfg.max_size = user_size;
   723	
   724		fpu_kernel_cfg.default_size = kernel_default_size;
   725		fpu_user_cfg.default_size =
   726			xstate_calculate_size(fpu_user_cfg.default_features, false);
   727	
   728		return 0;
   729	}
   730	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
