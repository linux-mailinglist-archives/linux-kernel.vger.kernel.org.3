Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D549B04A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574038AbiAYJbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:31:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:37163 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1573290AbiAYJUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643102417; x=1674638417;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CvoHKh2Sj7FSwQosQoHJRoEf+DpWTkpPjpylZISDp5A=;
  b=XXuqlvmikoXuVLELT4LAOnvy7jf3/+p3EDUtVKzq08h/moFcDnJfnli4
   AM5GOHJPQFvIL6yAe77PMVjdsPmcFf1tDaYm2AdHmHWydjzWXb4yiibtH
   Jk94WFp7p91T5CG4vUhxhBh239QIZnxIm57vhbMPlOEr7p57BpNEIkJrj
   GkSL0TsnTJhHr3vYQP5BwzurAKqQsmCjB8eJ4kq5L4xkX39TgnCI05jDB
   zJLnXkTZFQGjIrTCx5vPwzju1+atbjenb8uQHrJxoNYZzg2J7FD9Z5iE1
   p1B7eW0Qddcv2ytwhVlecMZRwnVD7hJTAqoPjSPQGgNJ39KwbMrwfg7vS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="229836283"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="229836283"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="562976285"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 01:16:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCHwH-000JdN-8e; Tue, 25 Jan 2022 09:16:33 +0000
Date:   Tue, 25 Jan 2022 17:16:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/paravirt] BUILD SUCCESS
 2e1f8e55f9e054b4a49ffc06c7e33b5d4725f05e
Message-ID: <61efbfe9.7zfLb0nKW+J6dWfa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/paravirt
branch HEAD: 2e1f8e55f9e054b4a49ffc06c7e33b5d4725f05e  x86/paravirt: Use %rip-relative addressing in hook calls

elapsed time: 728m

configs tested: 146
configs skipped: 84

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
sh                 kfr2r09-romimage_defconfig
mips                         bigsur_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     rainier_defconfig
mips                      maltasmvp_defconfig
sh                           se7722_defconfig
mips                     decstation_defconfig
sparc                       sparc64_defconfig
powerpc                      ppc6xx_defconfig
mips                            gpr_defconfig
arc                          axs101_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     asp8347_defconfig
riscv                    nommu_k210_defconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
openrisc                            defconfig
csky                                defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
arc                            hsdk_defconfig
arm                       multi_v4t_defconfig
arm                        trizeps4_defconfig
arm                        mvebu_v7_defconfig
arm                           viper_defconfig
sh                   sh7724_generic_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
arm                          simpad_defconfig
sh                          r7780mp_defconfig
mips                  maltasmvp_eva_defconfig
sh                             shx3_defconfig
powerpc                    amigaone_defconfig
arm                            lart_defconfig
arc                         haps_hs_defconfig
mips                        bcm47xx_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
mips                        workpad_defconfig
mips                     loongson2k_defconfig
mips                     cu1000-neo_defconfig
mips                  cavium_octeon_defconfig
mips                        omega2p_defconfig
arm                           sama7_defconfig
powerpc                     kmeter1_defconfig
mips                        bcm63xx_defconfig
powerpc                          g5_defconfig
arm                          imote2_defconfig
powerpc                     tqm5200_defconfig
mips                       lemote2f_defconfig
powerpc                        icon_defconfig
powerpc                     mpc5200_defconfig
powerpc                     tqm8560_defconfig
mips                     cu1830-neo_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
