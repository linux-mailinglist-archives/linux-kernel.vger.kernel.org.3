Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93C153AABB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356013AbiFAQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349045AbiFAQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:11:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B86A502D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654099869; x=1685635869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=26YWsW3yM1+zsK31KPcT4uJ3P+X/vv2kYM1UOFXZJDY=;
  b=X4Z5+9HVqqfeFe2ZS2nSU7TCgSixzRL15qFEPe6Nz8HTkzSzPhUoVH32
   0oMLieEOVW6TmVZm2awbfBfj6vyZIqjc/Ot81u0udOWkyPRR71w8+IiKx
   Zcy/ovjqzyxuVv6zA3J9efs/xh2NmZdZIU6xaGjce1f4QemxVNtgWhGhL
   pDdzkH4sPwCpQzkOPgbSf9wNVVTi3fi6rLBFPywv8NxhXkg5DzPU6Bgs3
   i30iB5UIgoj9wXRdQqE5DqM3zllYNwNDd+vcuNB1loQ+w10EnUmaYNgZR
   eiwj+k9QVHITNuWSjWWAuiTrmjV5fS6LCs/l1BuP2iCMG0J1kW23mzwXd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="274442855"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="274442855"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="633601679"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2022 09:11:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwQw7-00049g-Pi;
        Wed, 01 Jun 2022 16:11:07 +0000
Date:   Thu, 2 Jun 2022 00:10:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/minimal-regs 5/6]
 arch/x86/include/asm/ftrace.h:47:32: error: initialization of 'struct
 pt_regs *' from 'int' makes pointer from integer without a cast
Message-ID: <202206020032.Mu3eiis7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/minimal-regs
head:   b0741d059a9f19a1aa1191833140f53e41f1775a
commit: c694698df7f633bcbdf8bc0edb94f4a70ed0d092 [5/6] ftrace: pass fregs to arch_ftrace_set_direct_caller()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220602/202206020032.Mu3eiis7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/minimal-regs
        git checkout c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from drivers/gpu/drm/i915/display/intel_display.h:28,
                    from drivers/gpu/drm/i915/display/intel_cdclk.h:11,
                    from <command-line>:
   arch/x86/include/asm/ftrace.h:45:57: error: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
   arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/ftrace.h:47:32: error: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
   In file included from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from drivers/gpu/drm/i915/display/intel_display.h:28,
                    from drivers/gpu/drm/i915/display/intel_cdclk.h:11,
                    from <command-line>:
   include/linux/ftrace.h: At top level:
   include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from drivers/gpu/drm/i915/display/intel_display.h:28,
                    from drivers/gpu/drm/i915/display/intel_cdclk.h:11,
                    from <command-line>:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from include/drm/drm_connector.h:32,
                    from drivers/gpu/drm/i915/i915_drv.h:37,
                    from drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:14:
   arch/x86/include/asm/ftrace.h:45:57: error: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
   arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/ftrace.h:47:32: error: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
   In file included from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from include/drm/drm_connector.h:32,
                    from drivers/gpu/drm/i915/i915_drv.h:37,
                    from drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:14:
   include/linux/ftrace.h: At top level:
   include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from include/drm/drm_connector.h:32,
                    from drivers/gpu/drm/i915/i915_drv.h:37,
                    from drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:14:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:61:6: error: no previous prototype for 'intel_pxp_debugfs_register' [-Werror=missing-prototypes]
      61 | void intel_pxp_debugfs_register(struct intel_pxp *pxp, struct dentry *gt_root)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +47 arch/x86/include/asm/ftrace.h

    37	
    38	/*
    39	 * When a ftrace registered caller is tracing a function that is
    40	 * also set by a register_ftrace_direct() call, it needs to be
    41	 * differentiated in the ftrace_caller trampoline. To do this, we
    42	 * place the direct caller in the ORIG_AX part of pt_regs. This
    43	 * tells the ftrace_caller that there's a direct caller.
    44	 */
    45	static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
    46	{
  > 47		struct pt_regs *regs = ftrace_get_regs(fregs);
    48	
    49		/* Emulate a call */
    50		regs->orig_ax = addr;
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
