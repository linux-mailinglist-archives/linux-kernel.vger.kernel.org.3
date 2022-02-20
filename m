Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1F4BD0E2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbiBTTTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:19:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiBTTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:19:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA9522E7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645384730; x=1676920730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dFD0cRwx8DyrLaEwjIg2ODPKjUyCXURcksx6LBeFYE8=;
  b=cVkUjSbpJaGRVctpYtSaBB60VHccStuatTMN26X+QX3h2pu7To++JIMf
   ug8pPjdf34J86OlhX58GDK492HDAs3Q8E2X5xNQ9WFOwQET9cIxA8rCiP
   Z3dRu3aA+o5VQJ3g+NgCGd54co88FFGiHSgBGHDhYp4VG0mHmoy/CMMzh
   11eKaSrXpl2P/jpucoePQ4EM9ZqhwR+2wuCd5zTh72uYJ7FxHLQFReCyt
   XoWauQT53t0niaVjOLpkrBktnV99u2n8pjiwhuV6WoEBDnJUHDL478Zko
   B407/+YOkXmY/Cvg2RqkfDeQrp7vrzQdbN7IuxPPE61nawSA1BXln+B1w
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238808974"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="238808974"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 11:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="775791942"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2022 11:18:48 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLrjL-0000da-Gt; Sun, 20 Feb 2022 19:18:47 +0000
Date:   Mon, 21 Feb 2022 03:18:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:modules-next 6/10]
 arch/riscv/include/asm/set_memory.h:25:25: error: implicit declaration of
 function 'PAGE_ALIGN'; did you mean 'PTR_ALIGN'?
Message-ID: <202202210301.xEFgkf3s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
head:   c55dc78176e6fe97a9e92d24a7ff3015b14ac858
commit: e5973a14d18785b893d383fbd9dc2f98edc16f1b [6/10] module: Move strict rwx support to a separate file
config: riscv-randconfig-r042-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210301.xEFgkf3s-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=e5973a14d18785b893d383fbd9dc2f98edc16f1b
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof modules-next
        git checkout e5973a14d18785b893d383fbd9dc2f98edc16f1b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/set_memory.h:9,
                    from kernel/module/strict_rwx.c:10:
   arch/riscv/include/asm/set_memory.h: In function 'set_kernel_memory':
>> arch/riscv/include/asm/set_memory.h:25:25: error: implicit declaration of function 'PAGE_ALIGN'; did you mean 'PTR_ALIGN'? [-Werror=implicit-function-declaration]
      25 |         int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
         |                         ^~~~~~~~~~
         |                         PTR_ALIGN
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from kernel/module/strict_rwx.c:8:
   kernel/module/strict_rwx.c: In function 'frob_rodata':
>> kernel/module/strict_rwx.c:16:17: error: implicit declaration of function 'PAGE_ALIGNED'; did you mean 'IS_ALIGNED'? [-Werror=implicit-function-declaration]
      16 |         BUG_ON(!PAGE_ALIGNED(layout->base));
         |                 ^~~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   kernel/module/strict_rwx.c:16:9: note: in expansion of macro 'BUG_ON'
      16 |         BUG_ON(!PAGE_ALIGNED(layout->base));
         |         ^~~~~~
   cc1: some warnings being treated as errors


vim +25 arch/riscv/include/asm/set_memory.h

d3ab332a502123 Zong Li         2020-03-10   8  
00cb41d5ad3189 Zong Li         2020-03-10   9  #ifndef __ASSEMBLY__
d3ab332a502123 Zong Li         2020-03-10  10  /*
d3ab332a502123 Zong Li         2020-03-10  11   * Functions to change memory attributes.
d3ab332a502123 Zong Li         2020-03-10  12   */
d3ab332a502123 Zong Li         2020-03-10  13  #ifdef CONFIG_MMU
d3ab332a502123 Zong Li         2020-03-10  14  int set_memory_ro(unsigned long addr, int numpages);
d3ab332a502123 Zong Li         2020-03-10  15  int set_memory_rw(unsigned long addr, int numpages);
d3ab332a502123 Zong Li         2020-03-10  16  int set_memory_x(unsigned long addr, int numpages);
d3ab332a502123 Zong Li         2020-03-10  17  int set_memory_nx(unsigned long addr, int numpages);
19a00869028f4a Atish Patra     2020-11-04  18  int set_memory_rw_nx(unsigned long addr, int numpages);
c10bc260e7c030 Alexandre Ghiti 2021-06-24  19  static __always_inline int set_kernel_memory(char *startp, char *endp,
c10bc260e7c030 Alexandre Ghiti 2021-06-24  20  					     int (*set_memory)(unsigned long start,
c10bc260e7c030 Alexandre Ghiti 2021-06-24  21  							       int num_pages))
c10bc260e7c030 Alexandre Ghiti 2021-06-24  22  {
c10bc260e7c030 Alexandre Ghiti 2021-06-24  23  	unsigned long start = (unsigned long)startp;
c10bc260e7c030 Alexandre Ghiti 2021-06-24  24  	unsigned long end = (unsigned long)endp;
c10bc260e7c030 Alexandre Ghiti 2021-06-24 @25  	int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
c10bc260e7c030 Alexandre Ghiti 2021-06-24  26  
c10bc260e7c030 Alexandre Ghiti 2021-06-24  27  	return set_memory(start, num_pages);
c10bc260e7c030 Alexandre Ghiti 2021-06-24  28  }
d3ab332a502123 Zong Li         2020-03-10  29  #else
d3ab332a502123 Zong Li         2020-03-10  30  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
d3ab332a502123 Zong Li         2020-03-10  31  static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
d3ab332a502123 Zong Li         2020-03-10  32  static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
d3ab332a502123 Zong Li         2020-03-10  33  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
19a00869028f4a Atish Patra     2020-11-04  34  static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
c10bc260e7c030 Alexandre Ghiti 2021-06-24  35  static inline int set_kernel_memory(char *startp, char *endp,
c10bc260e7c030 Alexandre Ghiti 2021-06-24  36  				    int (*set_memory)(unsigned long start,
c10bc260e7c030 Alexandre Ghiti 2021-06-24  37  						      int num_pages))
c10bc260e7c030 Alexandre Ghiti 2021-06-24  38  {
c10bc260e7c030 Alexandre Ghiti 2021-06-24  39  	return 0;
c10bc260e7c030 Alexandre Ghiti 2021-06-24  40  }
d3ab332a502123 Zong Li         2020-03-10  41  #endif
d3ab332a502123 Zong Li         2020-03-10  42  

:::::: The code at line 25 was first introduced by commit
:::::: c10bc260e7c030364b5150aac7ebf048ddfb9502 riscv: Introduce set_kernel_memory helper

:::::: TO: Alexandre Ghiti <alex@ghiti.fr>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
