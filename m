Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2E4B2C55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352402AbiBKSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:00:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbiBKSAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:00:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C742C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602405; x=1676138405;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tltfk3WqCEh8IVQZiuHolCIBiToTGHULQXM1dAlLFPk=;
  b=X/kpI6T/qR68C12dDZ2TmLuQ4EvXD55p7iS4/FB9N5sL3Ps+BVJ/yl4M
   VP4ZgVhkWDmdODmhcaaXuvOcm8PfxfdrswOFjw2gZCaqcnFhOEoVRnIfP
   q0l01BY5gHK4mk6CjsC+zvCS/LthTsQUgeLLHYhQJt5CHzfIUrBZrLWAK
   P8xNbdE6u6JR3oXdxptFqcy3pL6LGfK9S8Aa3evTTmvki89BmWOh2S47m
   3FWngqxr4kPcxOKjbU8nVdKbFDFKliK1r4LRY1UjoTmy4iItv9R4RGe9f
   GdM6q8sB6v7mBvasDP6BwYc7CYk/KnAuXRqNO60rSrYoSJsb5JSOL4DVj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="229743395"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="229743395"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:00:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="527035737"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2022 10:00:02 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaDB-0004wC-Fn; Fri, 11 Feb 2022 18:00:01 +0000
Date:   Sat, 12 Feb 2022 01:58:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [linux-stable-rc:queue/4.19 5098/9999]
 arch/riscv/include/asm/processor.h:82:9: error: implicit declaration of
 function 'barrier'
Message-ID: <202202120007.oRXqxDqZ-lkp@intel.com>
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

Hi Arvind,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.19
head:   7725add280ae13ca07a21c62a19af15696689710
commit: b207caff4176e3a6ba273243da2db2e595e4aad2 [5098/9999] compiler.h: fix barrier_data() on clang
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220212/202202120007.oRXqxDqZ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b207caff4176e3a6ba273243da2db2e595e4aad2
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.19
        git checkout b207caff4176e3a6ba273243da2db2e595e4aad2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/prefetch.h:15,
                    from drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c:33:
   arch/riscv/include/asm/processor.h: In function 'cpu_relax':
>> arch/riscv/include/asm/processor.h:82:9: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
      82 |         barrier();
         |         ^~~~~~~
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c:37:
   At top level:
   drivers/net/ethernet/mellanox/mlx5/core/en.h:208:19: warning: 'mlx5e_priv_flags' defined but not used [-Wunused-const-variable=]
     208 | static const char mlx5e_priv_flags[][ETH_GSTRING_LEN] = {
         |                   ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/barrier +82 arch/riscv/include/asm/processor.h

7db91e57a0acde1 Palmer Dabbelt 2017-07-10  73  
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  74  
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  75  static inline void cpu_relax(void)
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  76  {
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  77  #ifdef __riscv_muldiv
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  78  	int dummy;
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  79  	/* In lieu of a halt instruction, induce a long-latency stall. */
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  80  	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  81  #endif
7db91e57a0acde1 Palmer Dabbelt 2017-07-10 @82  	barrier();
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  83  }
7db91e57a0acde1 Palmer Dabbelt 2017-07-10  84  

:::::: The code at line 82 was first introduced by commit
:::::: 7db91e57a0acde126a162ababfb1e0ab190130cb RISC-V: Task implementation

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
