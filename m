Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D488654AACC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353369AbiFNHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353274AbiFNHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:40:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA13C73D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655192432; x=1686728432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P0aJnBIFFspWwqVkB0taLrA9jZrADKzMbVhB6A62rCw=;
  b=ZVSUI920k9fYepzBYMXkvF3A83xKc+2K2yC9jSFsYe5OngnvcGbLal+Q
   ify7lvyO9fbIMidz5uHOoiOwESftvGnuE5yWtYMwVhg3iSFm5scE0jUm0
   vF6gcmwOF2u2JYgrJoPA846SKORIefKyTTvlUUmLTomFfJvGEOKwXHMuG
   anVsOWfzGA+qxVt3vkJWR4ZYfO1ZUjBMRxiLSCOSSHVXhrbCva9SgiQU2
   +f/rufINOJ6aQuGLsUMEoTh2gfpu5QkQjycMyyt+06Q9gGgiqeAc9At6n
   ond/A39mlrDlYdgwiZ+ePQyAic3ZcsOl01ysHJps7Sjf1kAMueP8NBTPw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261572327"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261572327"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640198976"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2022 00:40:19 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o119v-000Lcf-5p;
        Tue, 14 Jun 2022 07:40:19 +0000
Date:   Tue, 14 Jun 2022 15:40:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-unaccepted-memory 2/17]
 arch/x86/coco/tdx/tdx.c:167:30: warning: format '%d' expects argument of
 type 'int', but argument 2 has type 'u64' {aka 'long long unsigned int'}
Message-ID: <202206141529.wEmcF0KX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-unaccepted-memory
head:   7a902d05477ac272558ba731d903c6b0c9d72903
commit: b79b8d6d1f803ccb288402963fe31b887438e5fc [2/17] x86/tdx: Clarify RIP adjustments in #VE handler
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220614/202206141529.wEmcF0KX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/b79b8d6d1f803ccb288402963fe31b887438e5fc
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-unaccepted-memory
        git checkout b79b8d6d1f803ccb288402963fe31b887438e5fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask.h:14,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from include/linux/cpufeature.h:13,
                    from arch/x86/coco/tdx/tdx.c:7:
   arch/x86/coco/tdx/tdx.c: In function 've_instr_len':
>> arch/x86/coco/tdx/tdx.c:167:30: warning: format '%d' expects argument of type 'int', but argument 2 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     167 |                 WARN_ONCE(1, "Unexpected #VE-type: %d\n", ve->exit_reason);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~~~~
         |                                                             |
         |                                                             u64 {aka long long unsigned int}
   include/asm-generic/bug.h:105:31: note: in definition of macro '__WARN_printf'
     105 |                 __warn_printk(arg);                                     \
         |                               ^~~
   include/linux/once_lite.h:19:25: note: in expansion of macro 'WARN'
      19 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/asm-generic/bug.h:151:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
     151 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
         |         ^~~~~~~~~~~~~~~
   arch/x86/coco/tdx/tdx.c:167:17: note: in expansion of macro 'WARN_ONCE'
     167 |                 WARN_ONCE(1, "Unexpected #VE-type: %d\n", ve->exit_reason);
         |                 ^~~~~~~~~
   arch/x86/coco/tdx/tdx.c:167:53: note: format string is defined here
     167 |                 WARN_ONCE(1, "Unexpected #VE-type: %d\n", ve->exit_reason);
         |                                                    ~^
         |                                                     |
         |                                                     int
         |                                                    %lld


vim +167 arch/x86/coco/tdx/tdx.c

   126	
   127	/*
   128	 * TDX module spec states that #VE may be injected by the Intel TDX module in
   129	 * several cases:
   130	 *
   131	 *  - Emulation of the architectural #VE injection on EPT violation;
   132	 *
   133	 *  - As a result of guest TD execution of a disallowed instruction,
   134	 *    a disallowed MSR access, or CPUID virtualization;
   135	 *
   136	 *  - A notification to the guest TD about anomalous behavior;
   137	 *
   138	 * The last one is opt-in and is not used by the kernel.
   139	 *
   140	 * Intel Software Developer's Manual describes cases when instruction length
   141	 * field can be used in section "Information for VM Exits Due to Instruction
   142	 * Execution".
   143	 *
   144	 * For TDX, it ultimately means GET_VEINFO provides reliable instruction length
   145	 * information if #VE occurred due to instruction execution, but not for EPT
   146	 * violations.
   147	 */
   148	static int ve_instr_len(struct ve_info *ve)
   149	{
   150		switch (ve->exit_reason) {
   151		case EXIT_REASON_HLT:
   152		case EXIT_REASON_MSR_READ:
   153		case EXIT_REASON_MSR_WRITE:
   154		case EXIT_REASON_CPUID:
   155		case EXIT_REASON_IO_INSTRUCTION:
   156			/* It is safe to use ve->instr_len for #VE due instructions */
   157			return ve->instr_len;
   158		case EXIT_REASON_EPT_VIOLATION:
   159			/*
   160			 * For EPT violations, ve->insn_len is not defined. For those,
   161			 * the kernel must decode instructions manually and should not
   162			 * be using this function.
   163			 */
   164			WARN_ONCE(1, "ve->instr_len is not defined for EPT violations");
   165			return 0;
   166		default:
 > 167			WARN_ONCE(1, "Unexpected #VE-type: %d\n", ve->exit_reason);
   168			return ve->instr_len;
   169		}
   170	}
   171	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
