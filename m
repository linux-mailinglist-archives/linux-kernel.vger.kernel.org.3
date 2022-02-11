Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3544B1F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbiBKHWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:22:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiBKHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:22:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75041110B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644564155; x=1676100155;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jcYJIGxQp0jOw4ZVFK7KkNfQ1kjEHbqar2Rctm9LRwU=;
  b=Hbe3/24Xb/Kp6+iFI3vzgNTVqJDHwD7NEsOnWHje0nGum+JU2wMvH2w8
   OxtuSdB+6ovSPCGXPI2QyF0saql6lLgvCJe+hib73Ufo7mPlg/Qlgvmyi
   P6/ObZJCw3NLFPbfMdhC3v+Qm+zbErQFc3tLTxtFiibifkFNrcorb+tIE
   s7vm9+WqTPX97LGHivL6a+PcvQXWWxXMmALEuBwM3k1LLb46E7C8QvT0X
   +iVnELYhKbvV2NANrkdci2W/c+Y8l+af6Mb5eQD62GZubUglEUNZNbWJN
   X8rM2HIdCGST5aMWdOlNyYCFBVuGlXFZ0aHVWGT9K1G1PAI4yZoBvshAw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249887042"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249887042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="679429579"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2022 23:22:34 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIQGH-0004Hp-D2; Fri, 11 Feb 2022 07:22:33 +0000
Date:   Fri, 11 Feb 2022 15:22:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 0ba8896d2fd75c330cb52294b82da2a1538de0ce
Message-ID: <62060eae.6FTO3Ym9tMj9LGAL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 0ba8896d2fd75c330cb52294b82da2a1538de0ce  lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe

elapsed time: 901m

configs tested: 202
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
xtensa                         virt_defconfig
powerpc64                           defconfig
powerpc                     sequoia_defconfig
arm                          iop32x_defconfig
h8300                               defconfig
sh                           se7722_defconfig
alpha                               defconfig
sh                         ecovec24_defconfig
powerpc                     ep8248e_defconfig
arc                            hsdk_defconfig
m68k                         amcore_defconfig
mips                        vocore2_defconfig
arm                         lpc18xx_defconfig
powerpc                       ppc64_defconfig
arm                        mini2440_defconfig
arm                       multi_v4t_defconfig
openrisc                 simple_smp_defconfig
nios2                            alldefconfig
powerpc                      pasemi_defconfig
sh                        sh7785lcr_defconfig
sh                          lboxre2_defconfig
sh                           se7206_defconfig
sh                            hp6xx_defconfig
openrisc                            defconfig
sparc64                          alldefconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
parisc                generic-64bit_defconfig
arm                        shmobile_defconfig
mips                           ip32_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc834x_itx_defconfig
arm                             ezx_defconfig
arm                        cerfcube_defconfig
sh                          urquell_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5249evb_defconfig
arm                          simpad_defconfig
m68k                          multi_defconfig
arm                         s3c6400_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
powerpc                      ep88xc_defconfig
mips                             allmodconfig
ia64                         bigsur_defconfig
sh                        dreamcast_defconfig
arc                     nsimosci_hs_defconfig
arm                     eseries_pxa_defconfig
alpha                            alldefconfig
mips                            gpr_defconfig
h8300                     edosk2674_defconfig
parisc                              defconfig
sh                                  defconfig
m68k                        m5407c3_defconfig
sh                   sh7770_generic_defconfig
arm                             pxa_defconfig
s390                          debug_defconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
alpha                            allyesconfig
m68k                          hp300_defconfig
powerpc                     tqm8555_defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
arm                           sunxi_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
powerpc                      makalu_defconfig
powerpc                 linkstation_defconfig
sh                         microdev_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v7_defconfig
sh                           se7750_defconfig
openrisc                         alldefconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
m68k                       m5275evb_defconfig
powerpc                      arches_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20220211
arm                  randconfig-c002-20220210
arm                  randconfig-c002-20220209
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
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220209
arc                  randconfig-r043-20220208
arc                  randconfig-r043-20220209
riscv                randconfig-r042-20220210
riscv                randconfig-r042-20220209
arc                  randconfig-r043-20220210
s390                 randconfig-r044-20220210
arc                  randconfig-r043-20220211
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
riscv                randconfig-c006-20220209
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220209
i386                          randconfig-c001
mips                 randconfig-c004-20220209
arm                  randconfig-c002-20220209
riscv                randconfig-c006-20220210
powerpc              randconfig-c003-20220210
arm                  randconfig-c002-20220210
mips                 randconfig-c004-20220210
riscv                randconfig-c006-20220211
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
mips                 randconfig-c004-20220211
mips                            e55_defconfig
x86_64                           allyesconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
powerpc                     ksi8560_defconfig
arm                        mvebu_v5_defconfig
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
powerpc                     akebono_defconfig
mips                       rbtx49xx_defconfig
hexagon                             defconfig
powerpc                 mpc836x_mds_defconfig
mips                         tb0219_defconfig
arm                         lpc32xx_defconfig
arm                           omap1_defconfig
powerpc                      ppc44x_defconfig
powerpc                        icon_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220210
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220210
hexagon              randconfig-r041-20220208
hexagon              randconfig-r045-20220211
hexagon              randconfig-r041-20220211
riscv                randconfig-r042-20220211
hexagon              randconfig-r045-20220209
hexagon              randconfig-r041-20220209
riscv                randconfig-r042-20220208
s390                 randconfig-r044-20220211
s390                 randconfig-r044-20220208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
