Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642FC47DF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbhLWH2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:28:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:25053 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346809AbhLWH2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640244486; x=1671780486;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U4AlNwfLEdwlGj4njPtHRLgTF4wB8x0SzdZTQICQc8w=;
  b=I6ZVK5Q8XJkj/mmHbchFJbeVJ+b6wNfpRwGsxKgzq0QPIKScarEP5HtU
   QAo9Ay0WW3G9R8+lBLSZYS7Xzba87UeToGglBCulyV2gPT4kOOI+DlLR+
   jdn6rHT6gWPFjWG6soXeu3JopdWilKEv+omPzG49C0IQh8delJxIeS4lL
   ogrzo3iOzFXSrWByk0JqYJPP/qekutqvbqe1ncp4c9PfykA0+lcGocLcu
   JSWlhazGhL+Ss8gbChgkavaFYR7ihSTRYccmkqiQEhTH6s4ftiUxPiFHi
   CgDzoqjHvNQFjDAnV8N0cH0E3SbcMoAAal5rDkfCWexCuqHl8wPgEfesV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227619249"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="227619249"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 23:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="466915865"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 23:27:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0IVe-0001WS-SN; Thu, 23 Dec 2021 07:27:30 +0000
Date:   Thu, 23 Dec 2021 15:26:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 4d5cff69fbddbbefef2903faa48263cc5d3ca382
Message-ID: <61c424aa.ijoREzqPI+Ip5T93%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 4d5cff69fbddbbefef2903faa48263cc5d3ca382  x86/mtrr: Remove the mtrr_bp_init() stub

elapsed time: 742m

configs tested: 160
configs skipped: 100

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
i386                 randconfig-c001-20211223
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                       sparc64_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
powerpc                      ppc44x_defconfig
arm                       mainstone_defconfig
powerpc                     ep8248e_defconfig
sh                         microdev_defconfig
arm                         s5pv210_defconfig
mips                        vocore2_defconfig
sh                     magicpanelr2_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      pcm030_defconfig
arc                     nsimosci_hs_defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
mips                     cu1000-neo_defconfig
mips                            e55_defconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
powerpc                     kilauea_defconfig
sh                          sdk7786_defconfig
arm                          pxa168_defconfig
powerpc                      makalu_defconfig
arm                        trizeps4_defconfig
arm                            zeus_defconfig
m68k                       m5475evb_defconfig
xtensa                    smp_lx200_defconfig
arm                        vexpress_defconfig
powerpc                          allmodconfig
sh                           se7705_defconfig
powerpc                  mpc866_ads_defconfig
mips                           ip27_defconfig
sh                          sdk7780_defconfig
powerpc                     mpc83xx_defconfig
arm                     davinci_all_defconfig
powerpc                      walnut_defconfig
sh                        sh7763rdp_defconfig
powerpc                  storcenter_defconfig
arm                        shmobile_defconfig
mips                       capcella_defconfig
mips                          rb532_defconfig
powerpc                        icon_defconfig
sh                          rsk7269_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sama5_defconfig
powerpc                      ppc40x_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
arm                  randconfig-c002-20211223
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a002-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a005-20211222
i386                 randconfig-a001-20211222
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
