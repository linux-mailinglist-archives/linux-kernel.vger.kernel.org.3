Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB52492D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiARSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:42:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:64761 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239612AbiARSmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642531327; x=1674067327;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O4++ro3cFlQH7fnMdIEb70mM0otQHsdzyHbdjvapuoY=;
  b=cG+vOw0oUnCaAQeL1a1vY2TtlihuXHfGk17dGv0bdlf1zsaV/HszIOTr
   s0YX1zm7ZJkh/BQUZg9mZ2V0gwO8p3uTx0IyCc+KR+nfSpX+ik/4KkNUm
   qOvc6Ksp6ExbA3ZtMr1F0NcJn5NatCUFwpgTqvMDlZkjnOUoQSAQVJRzL
   jXABpqCwTBRhrg198UMtFOKCvMjarjQdVMK4YCmhprbEg1OeCddpnJTeQ
   p2Z+nveqbj7aSQ88PABcH4MOFausSlRj2zRe4VCKy2A6qxpan2T8bbzWv
   43O1FQT6viITNA6IYapIscQgGOR4m7SxRgt1VzvvJb1W1UpE9WxOk8zqT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="331238107"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="331238107"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 10:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="693493247"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2022 10:42:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9tQi-000CqU-7y; Tue, 18 Jan 2022 18:42:04 +0000
Date:   Wed, 19 Jan 2022 02:41:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Fu <wefu@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_mmind_pbmt 42/44]
 arch/riscv/kernel/setup.c:328:8: warning: format '%lx' expects argument of
 type 'long unsigned int', but argument 3 has type 'int'
Message-ID: <202201190246.f3cvUQdo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2_sv48_v3_mmind_pbmt
head:   b28a50c03a72c48d3895320bdd0757e0a8acb881
commit: 330ce3d4a3edd32464ac6deb817c211526c40781 [42/44] riscv: add RISC-V Svpbmt extension supports
config: riscv-randconfig-r042-20220117 (https://download.01.org/0day-ci/archive/20220119/202201190246.f3cvUQdo-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/330ce3d4a3edd32464ac6deb817c211526c40781
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_mmind_pbmt
        git checkout 330ce3d4a3edd32464ac6deb817c211526c40781
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/setup.c: In function 'free_initmem':
   arch/riscv/kernel/setup.c:326:9: error: implicit declaration of function 'ALT_THEAD_PMA' [-Werror=implicit-function-declaration]
     326 |         ALT_THEAD_PMA(prot_val);
         |         ^~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from arch/riscv/kernel/setup.c:12:
>> arch/riscv/kernel/setup.c:328:8: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'int' [-Wformat=]
     328 | printk("%s: _PAGE_IO: 0x%lx\n", __func__, _PAGE_IO);
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   arch/riscv/kernel/setup.c:328:1: note: in expansion of macro 'printk'
     328 | printk("%s: _PAGE_IO: 0x%lx\n", __func__, _PAGE_IO);
         | ^~~~~~
   arch/riscv/kernel/setup.c:328:27: note: format string is defined here
     328 | printk("%s: _PAGE_IO: 0x%lx\n", __func__, _PAGE_IO);
         |                         ~~^
         |                           |
         |                           long unsigned int
         |                         %x
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from arch/riscv/kernel/setup.c:12:
   arch/riscv/kernel/setup.c:329:8: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'int' [-Wformat=]
     329 | printk("%s: _PAGE_NOCACHE: 0x%lx\n", __func__, _PAGE_NOCACHE);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   arch/riscv/kernel/setup.c:329:1: note: in expansion of macro 'printk'
     329 | printk("%s: _PAGE_NOCACHE: 0x%lx\n", __func__, _PAGE_NOCACHE);
         | ^~~~~~
   arch/riscv/kernel/setup.c:329:32: note: format string is defined here
     329 | printk("%s: _PAGE_NOCACHE: 0x%lx\n", __func__, _PAGE_NOCACHE);
         |                              ~~^
         |                                |
         |                                long unsigned int
         |                              %x
   cc1: some warnings being treated as errors


vim +328 arch/riscv/kernel/setup.c

19a00869028f4a Atish Patra    2020-11-04  320  
19a00869028f4a Atish Patra    2020-11-04  321  void free_initmem(void)
19a00869028f4a Atish Patra    2020-11-04  322  {
a8a0c8f014166b Heiko Stuebner 2021-12-17  323  	unsigned long prot_val = pgprot_val(PAGE_KERNEL);
a8a0c8f014166b Heiko Stuebner 2021-12-17  324  
a8a0c8f014166b Heiko Stuebner 2021-12-17  325  printk("%s: _PAGE_KERNEL-orig: 0x%lx\n", __func__, prot_val);
a8a0c8f014166b Heiko Stuebner 2021-12-17  326  	ALT_THEAD_PMA(prot_val);
a8a0c8f014166b Heiko Stuebner 2021-12-17  327  printk("%s: _PAGE_KERNEL: 0x%lx\n", __func__, prot_val);
a8a0c8f014166b Heiko Stuebner 2021-12-17 @328  printk("%s: _PAGE_IO: 0x%lx\n", __func__, _PAGE_IO);

:::::: The code at line 328 was first introduced by commit
:::::: a8a0c8f014166b1e95e223240632fd0baac50ea7 hack in a debug output in freeinitmem

:::::: TO: Heiko Stuebner <heiko@sntech.de>
:::::: CC: Guo Ren <guoren@linux.alibaba.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
