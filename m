Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF84B1D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbiBKEHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:07:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiBKEHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:07:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D35F48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644552450; x=1676088450;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HH2FxG1lGM/9Cx5gBxCGKoSQemmGQvgRQveMMhh6pro=;
  b=KM90JAwglkRN4djA477WfdNxcEDuMXaoJOvkgfuH/pLTwKp5LqgUHd6X
   44aAz7ln4VGE7E6SC7hwKrSH8wOWuJ3Kb6hYoQ2w7HQewdtsQEIJNUG2x
   4CowqZ6GZXe49eW5jiCc214nLz/QZFGPCZVoSlU7wGqtYHbpiPIKikf7m
   f34s8C20Kqg+wWj913EjIwV3SpAzwXeR6hatLllyBQyK15ClLLU2Vfq7M
   gEFh2yUVVht0L5EWggEQfhGSeMLr/5v+WxTJdoP+66/lGitvGOWub0/O5
   kcmMLbYul60bK8MH5GEdQ9p2YaHGJYefSQ4r1kZLyfAsUSbkTuVJX4wqQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248487424"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="248487424"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 20:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701956298"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 20:07:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nINDT-00046O-Ir; Fri, 11 Feb 2022 04:07:27 +0000
Date:   Fri, 11 Feb 2022 12:06:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.08a] BUILD SUCCESS
 668c9f52bbc1032a586b49571f387757161e6b73
Message-ID: <6205e0c5.Dk7JXps59BNvzDOt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.08a
branch HEAD: 668c9f52bbc1032a586b49571f387757161e6b73  Revert "mm: Check for SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation"

elapsed time: 722m

configs tested: 172
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
arc                           tb10x_defconfig
mips                       bmips_be_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                         virt_defconfig
powerpc64                           defconfig
powerpc                     sequoia_defconfig
arm                          iop32x_defconfig
h8300                               defconfig
openrisc                            defconfig
mips                 decstation_r4k_defconfig
m68k                          multi_defconfig
sh                           se7722_defconfig
alpha                               defconfig
sh                         ecovec24_defconfig
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
powerpc                     tqm8541_defconfig
arm                           h3600_defconfig
powerpc                       eiger_defconfig
arm                         s3c6400_defconfig
csky                             alldefconfig
powerpc                      ep88xc_defconfig
mips                             allmodconfig
sh                        dreamcast_defconfig
arc                     nsimosci_hs_defconfig
sh                                  defconfig
m68k                        m5407c3_defconfig
sh                   sh7770_generic_defconfig
s390                          debug_defconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
alpha                            allyesconfig
m68k                          hp300_defconfig
powerpc                     tqm8555_defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
arm                           sunxi_defconfig
powerpc                 linkstation_defconfig
sh                         microdev_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v7_defconfig
sh                           se7750_defconfig
m68k                          amiga_defconfig
alpha                            alldefconfig
powerpc                      arches_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20220210
arm                  randconfig-c002-20220209
arm                  randconfig-c002-20220211
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
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
mips                            e55_defconfig
x86_64                           allyesconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
powerpc                     mpc5200_defconfig
powerpc                     akebono_defconfig
powerpc                    ge_imp3a_defconfig
arm                        multi_v5_defconfig
powerpc                      ppc44x_defconfig
mips                       rbtx49xx_defconfig
hexagon                             defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     tqm5200_defconfig
powerpc                       ebony_defconfig
mips                      pic32mzda_defconfig
powerpc                     kilauea_defconfig
arm                           omap1_defconfig
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a005
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
