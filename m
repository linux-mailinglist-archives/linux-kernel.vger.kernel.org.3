Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8375E544CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiFIMyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbiFIMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:54:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67D133268
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654779276; x=1686315276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EC9/baAFvetCe0MCCc7G/jgHuaCiWwhsYL8R+sTGxk8=;
  b=KEhP7QwMyzEI9ib1YJD/dSLL19AnJXUIhDBfCrakWkAry/fiCOAb1hgk
   OfdIhSzD+dNtfg/QyjUHgDdGzcHHXdR8WoBzoj7WotI5HzUZKATDp8t8X
   9mbmLEii2oM+hLNRSPx/z/u7aH1BinWhf7eUA/r+iXUhceUv4OlqGwox5
   /O5H7NfshwiURiGfU0JWDly089xcUVUnNYUhPWzvYMLyEkE5CDLQsxoT9
   XDZRDLqzq44rIsrR3+Eocl+hnF+rPjzqSfMSzXluSn6oe6SqK0gXD6PjG
   LPVUbdSxUsVQGWM2tYj5HRR2UEs10+HthegQt4LFExqgAlBObuW5fowU2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="274791933"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="274791933"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 05:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="580573004"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2022 05:54:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzHgH-000Fzh-0v;
        Thu, 09 Jun 2022 12:54:33 +0000
Date:   Thu, 9 Jun 2022 20:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuan Yao <yuan.yao@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 449/453]
 arch/x86/kernel/fpu/xstate.c:718:14: warning: format '%ld' expects argument
 of type 'long int', but argument 2 has type 'unsigned int'
Message-ID: <202206092038.sxicJCDm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   64f3ddf316eab9398414b94e62a01d185e6e94c8
commit: c00f6297349a8d81049eefe338ee079179787e28 [449/453] X86: FPU: Fix unexpected #PF while executing XRSTORS
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220609/202206092038.sxicJCDm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c00f6297349a8d81049eefe338ee079179787e28
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout c00f6297349a8d81049eefe338ee079179787e28
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/fpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from arch/x86/kernel/fpu/xstate.c:8:
   arch/x86/kernel/fpu/xstate.c: In function 'init_xstate_size':
>> arch/x86/kernel/fpu/xstate.c:718:14: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'unsigned int' [-Wformat=]
     718 |              "Too small init_fpstate size:%ld expected:%d\n",
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     719 |              sizeof(init_fpstate_full), kernel_size);
         |              ~~~~~~~~~~~~~~~~~~~~~~~~~
         |              |
         |              unsigned int
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/asm-generic/bug.h:175:9: note: in expansion of macro 'no_printk'
     175 |         no_printk(format);                                              \
         |         ^~~~~~~~~
   arch/x86/kernel/fpu/xstate.c:717:9: note: in expansion of macro 'WARN'
     717 |         WARN(kernel_size > sizeof(init_fpstate_full),
         |         ^~~~
   arch/x86/kernel/fpu/xstate.c:718:45: note: format string is defined here
     718 |              "Too small init_fpstate size:%ld expected:%d\n",
         |                                           ~~^
         |                                             |
         |                                             long int
         |                                           %d


vim +718 arch/x86/kernel/fpu/xstate.c

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
 > 718		     "Too small init_fpstate size:%ld expected:%d\n",
   719		     sizeof(init_fpstate_full), kernel_size);
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
