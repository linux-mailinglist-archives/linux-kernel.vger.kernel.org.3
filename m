Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1047053ACDF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiFASeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiFASeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:34:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927012A738
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654108456; x=1685644456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K7U9o3hCQvvE61UN1WrywuQLGgLPbvhCJ9N0oSynSNM=;
  b=ZO4Vb1/p0p8GqdejCdAUCPetkuuIeZLcYuuEMdQL7EqR28kdfW+zLBRn
   m8RWMUDfkBIoae9JTXK9N8FUhbv3ZgRnUpsG4Nhc/0AXh3Qvrl0Hk4hge
   4B0hkcFnGuK+50yYMR/ccfBWRdj+JenaJ8EB7tOtZdn21BubSDqNpK7gE
   BjpTurEHpc51SYkiwbGAEZC0Rs9NLAhTDHbxzu98pyam8bearmdM2p934
   ndTV9VaF415zj/MlfftEWzxIpPU2bA8uZHpXSPTT6aAUaOSmPqkvKTaSF
   mWt0csH18oxML+PYFO1bbB1HXHgyMxI5pnfYBjW/0Sw6iqVmeqv6Car+X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275763299"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="275763299"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 11:34:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="530194317"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2022 11:34:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwTAb-0004IS-Sb;
        Wed, 01 Jun 2022 18:34:13 +0000
Date:   Thu, 2 Jun 2022 02:33:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/minimal-regs 6/6] include/linux/ftrace.h:126:16:
 error: implicit declaration of function 'arch_ftrace_get_regs'; did you mean
 'ftrace_get_regs'?
Message-ID: <202206020253.PecbI4Mb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/minimal-regs
head:   b0741d059a9f19a1aa1191833140f53e41f1775a
commit: b0741d059a9f19a1aa1191833140f53e41f1775a [6/6] WIP: arm64/ftrace: move from REGS to ARGS
config: arm64-randconfig-r031-20220601 (https://download.01.org/0day-ci/archive/20220602/202206020253.PecbI4Mb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=b0741d059a9f19a1aa1191833140f53e41f1775a
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/minimal-regs
        git checkout b0741d059a9f19a1aa1191833140f53e41f1775a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kvm_host.h:32,
                    from arch/arm64/kernel/asm-offsets.c:15:
   include/linux/ftrace.h: In function 'ftrace_get_regs':
>> include/linux/ftrace.h:126:16: error: implicit declaration of function 'arch_ftrace_get_regs'; did you mean 'ftrace_get_regs'? [-Werror=implicit-function-declaration]
     126 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                ftrace_get_regs
>> include/linux/ftrace.h:126:16: warning: returning 'int' from a function with return type 'struct pt_regs *' makes pointer from integer without a cast [-Wint-conversion]
     126 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +126 include/linux/ftrace.h

d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  120) 
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  121) static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  122) {
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  123) 	if (!fregs)
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  124) 		return NULL;
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  125) 
02a474ca266a47 Steven Rostedt (VMware  2020-10-27 @126) 	return arch_ftrace_get_regs(fregs);
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  127) }
d19ad0775dcd64 Steven Rostedt (VMware  2020-10-28  128) 

:::::: The code at line 126 was first introduced by commit
:::::: 02a474ca266a47ea8f4d5a11f4ffa120f83730ad ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default

:::::: TO: Steven Rostedt (VMware) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
