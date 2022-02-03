Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB7D4A7E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbiBCDAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:00:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:15031 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349126AbiBCDAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643857241; x=1675393241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K6pFS2Y4Shc8KlI4WDGp7AKRzgAWz4XIGXqn0rGrHRE=;
  b=QVhk6d6AO/LsNJEr7lwXd8cIl1VNAq0sl8mes6Xu3u8r8JWPGnAAJtII
   jLjloD44/uRW5P1ub1kFV/LYTKNx3BTIcq1tB7bdj7g9of5IaqpKzi1bd
   0zsmSJVxLr4sgFHV852sykHs+UlOf14AaXDNo0Q6JU9k+8JGq7eeHFILw
   aX55HWxjhHlnkhs1Z5LcMfgxyJGdOkDrGuzGSIWIIKvE1UplIaGvxu6uP
   PkYAXCbMOqUr/GVHl446FFeR1pk8VKBZLl3Iem49P1i/75dONQcWp1DPw
   cTP+H+WgS2kNmTMKkgiZhx7UtsXJZjjyyFTmJ1cE6DxMHuMda+jHk8HgL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311371662"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="311371662"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="583657812"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2022 19:00:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFSMQ-000VTo-Up; Thu, 03 Feb 2022 03:00:38 +0000
Date:   Thu, 3 Feb 2022 11:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fprobe_link 4/10]
 include/linux/compiler_types.h:143:41: error: 'struct pt_regs' has no member
 named 'ip'
Message-ID: <202202031016.tJSG2jo5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fprobe_link
head:   f35f5b111d32e11c2201dcbfa5e3c8c0560a0a43
commit: 920d37911d3fcf2459de4d3f361bae269d37de1c [4/10] bpf: Add bpf_get_func_ip kprobe helper for fprobe link
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220203/202202031016.tJSG2jo5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=920d37911d3fcf2459de4d3f361bae269d37de1c
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fprobe_link
        git checkout 920d37911d3fcf2459de4d3f361bae269d37de1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bpf_verifier.h:9,
                    from kernel/bpf/verifier.c:13:
   kernel/bpf/verifier.c: In function 'do_misc_fixups':
>> include/linux/compiler_types.h:143:41: error: 'struct pt_regs' has no member named 'ip'
     143 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/filter.h:253:26: note: in definition of macro 'BPF_LDX_MEM'
     253 |                 .off   = OFF,                                   \
         |                          ^~~
   include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:13649:51: note: in expansion of macro 'offsetof'
   13649 |                                                   offsetof(struct pt_regs, ip));
         |                                                   ^~~~~~~~


vim +143 include/linux/compiler_types.h

71391bdd2e9aab1 Xiaozhou Liu 2018-12-14  142  
71391bdd2e9aab1 Xiaozhou Liu 2018-12-14 @143  #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
71391bdd2e9aab1 Xiaozhou Liu 2018-12-14  144  

:::::: The code at line 143 was first introduced by commit
:::::: 71391bdd2e9aab188f86bf1ecd9b232531ec7eea include/linux/compiler_types.h: don't pollute userspace with macro definitions

:::::: TO: Xiaozhou Liu <liuxiaozhou@bytedance.com>
:::::: CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
