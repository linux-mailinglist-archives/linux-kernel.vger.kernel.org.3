Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB546FB06
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhLJHEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:04:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:34801 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhLJHEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639119660; x=1670655660;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Tr5EOaWvlUf27ucVpIIS7uK+94W2W9Ype3JMpQUHQ6w=;
  b=K/70QGEIyV3mfFRFMEWpbftiZ0rTg/PCDeHUsFm/NMmxk/WtmJpd6bum
   W/8wWwcWBYVO2FNu8MbI0bS0ogYR9d8R5QpvcUGYlB059enNVIFMo+gNI
   63AgXFJMmjP0sjrqGxINSKPcxea/YEO/Ujpyna/uiGzV+/OB1Mey/mQgp
   IOEMfOxRfBIesez+/nvey3CMQkepjJMmKzE1wIiBrzTqO03w3ZpELyBXz
   aZNbB+FpGZZxWVOrVEHsIovtqRATThAdgQENcUCCILI7pnwr1yjdXmDXg
   5IdWMwDIVK00aadLy/q3IW/RPM8SZ7gfdHvanRTKcL71JcD2o++GeLuth
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="237026328"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="237026328"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="463567863"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 23:00:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvZto-0002tN-HS; Fri, 10 Dec 2021 07:00:56 +0000
Date:   Fri, 10 Dec 2021 15:00:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 50468e4313355b161cac8a5155a45832995b7f25
Message-ID: <61b2fb07.RE9DZAJH0BQOYAXI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 50468e4313355b161cac8a5155a45832995b7f25  x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node

elapsed time: 881m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211210
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
m68k                        m5307c3_defconfig
arm                             mxs_defconfig
sh                        apsh4ad0a_defconfig
alpha                            allyesconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     kilauea_defconfig
powerpc                      makalu_defconfig
sh                          lboxre2_defconfig
sh                           se7712_defconfig
arm                             rpc_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    socrates_defconfig
nds32                             allnoconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
powerpc                     rainier_defconfig
arm                            dove_defconfig
nds32                               defconfig
m68k                         apollo_defconfig
arm                     am200epdkit_defconfig
mips                         mpc30x_defconfig
powerpc                 canyonlands_defconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
xtensa                              defconfig
powerpc                     ppa8548_defconfig
arm                             pxa_defconfig
m68k                        m5407c3_defconfig
powerpc                        warp_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                           tegra_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     davinci_all_defconfig
powerpc                     taishan_defconfig
sh                             shx3_defconfig
powerpc                      chrp32_defconfig
um                           x86_64_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
openrisc                 simple_smp_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-c002-20211210
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211210
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a016-20211210
x86_64               randconfig-a015-20211210
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
