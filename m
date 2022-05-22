Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38382530058
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 04:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiEVC4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 22:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiEVC4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 22:56:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB5101E3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653188160; x=1684724160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zF+TvqCLblO6GPibHl4EUmhuY3e8np0hnN4E3lK9rio=;
  b=Mr4yttIP50/hxeBYObTSEi+GJCbR2NBIO1PGx7Sid6OYi5FzJ5AIigNK
   YQskOFNfhfKSmnR+CYEhxppbgv3HUN0bQzIqIE3cw5hsxwloDghRRB25u
   UzoxksAr0DHlntK62QZIYDSbW+RoxSUL4gdx9EZTbqN1FAWDS+HWhkDu0
   iybN2aGY7ey+GyftBryhd1zuhbv6fJcpMtfTXjPozwffSvW+SZ2O+zFnt
   e+IaHKmg0FDwnRTpIHRl0Z+GGhi2D1Lcd6u/N7l5n9Ao2l8BFN40CnZfr
   U3CBRBYc9CNKyqFWZWAZiSHkcMPqkuYjD+z7ryP6dtXmPSuiZ1cIzs6ba
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="273064422"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="273064422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 19:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="716155838"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2022 19:55:59 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsbl8-0006s9-Ms;
        Sun, 22 May 2022 02:55:58 +0000
Date:   Sun, 22 May 2022 10:55:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 c1d2d643378ce89358f65caf9748a6f044086919
Message-ID: <6289a63b.2NyHzexhnZdCj5EA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: c1d2d643378ce89358f65caf9748a6f044086919  objtool: Fix objtool regression on x32 systems

elapsed time: 3149m

configs tested: 255
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc64                           defconfig
arc                                 defconfig
powerpc                     asp8347_defconfig
m68k                            mac_defconfig
ia64                            zx1_defconfig
ia64                      gensparse_defconfig
arm                            pleb_defconfig
sh                            titan_defconfig
sh                            migor_defconfig
arm                      footbridge_defconfig
s390                          debug_defconfig
xtensa                    xip_kc705_defconfig
sh                               j2_defconfig
um                                  defconfig
um                               alldefconfig
arm                        shmobile_defconfig
mips                      maltasmvp_defconfig
powerpc                    sam440ep_defconfig
powerpc                      cm5200_defconfig
arm                        cerfcube_defconfig
mips                         db1xxx_defconfig
sh                          rsk7269_defconfig
powerpc                     pq2fads_defconfig
parisc                           allyesconfig
mips                           ci20_defconfig
s390                             allyesconfig
xtensa                          iss_defconfig
ia64                        generic_defconfig
powerpc                      chrp32_defconfig
mips                  maltasmvp_eva_defconfig
riscv                            allyesconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
h8300                    h8300h-sim_defconfig
arm                        mini2440_defconfig
xtensa                           allyesconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
arm                           tegra_defconfig
ia64                          tiger_defconfig
sh                           se7750_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
h8300                            allyesconfig
arm                          badge4_defconfig
arm                           corgi_defconfig
xtensa                  audio_kc705_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
sh                        sh7763rdp_defconfig
sh                         microdev_defconfig
arm                      jornada720_defconfig
powerpc                     sequoia_defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
sh                           se7206_defconfig
powerpc                        warp_defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
sh                           se7619_defconfig
alpha                               defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
alpha                            allyesconfig
arm                        realview_defconfig
arm                            qcom_defconfig
sh                           se7343_defconfig
nios2                            alldefconfig
arc                        nsimosci_defconfig
powerpc                     stx_gp3_defconfig
sparc64                          alldefconfig
i386                                defconfig
powerpc                      ep88xc_defconfig
h8300                       h8s-sim_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          urquell_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
mips                             allyesconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
powerpc                       eiger_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   motionpro_defconfig
arc                          axs103_defconfig
sh                          sdk7786_defconfig
mips                 decstation_r4k_defconfig
um                             i386_defconfig
s390                       zfcpdump_defconfig
arm                           sama5_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
m68k                             allyesconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                     edosk2674_defconfig
arc                           tb10x_defconfig
m68k                          multi_defconfig
arm                             pxa_defconfig
m68k                        mvme147_defconfig
arm                        keystone_defconfig
openrisc                 simple_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                       holly_defconfig
arc                          axs101_defconfig
powerpc                     rainier_defconfig
powerpc                      mgcoge_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
sh                   secureedge5410_defconfig
m68k                           sun3_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                         3c120_defconfig
sh                        sh7757lcr_defconfig
m68k                          sun3x_defconfig
powerpc                      ppc6xx_defconfig
m68k                          amiga_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
arm                  randconfig-c002-20220522
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220522
s390                 randconfig-r044-20220522
riscv                randconfig-r042-20220522
arc                  randconfig-r043-20220519
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
s390                 randconfig-c005-20220519
arm                  randconfig-c002-20220522
s390                 randconfig-c005-20220522
powerpc              randconfig-c003-20220522
riscv                randconfig-c006-20220522
mips                 randconfig-c004-20220522
powerpc                          g5_defconfig
hexagon                             defconfig
mips                      pic32mzda_defconfig
arm                          ep93xx_defconfig
mips                     loongson2k_defconfig
powerpc                     tqm8560_defconfig
hexagon                          alldefconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
arm                              alldefconfig
arm                          ixp4xx_defconfig
powerpc                      pmac32_defconfig
powerpc                     tqm5200_defconfig
i386                             allyesconfig
powerpc                    socrates_defconfig
powerpc                   microwatt_defconfig
powerpc                      acadia_defconfig
riscv                          rv32_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
arm                         mv78xx0_defconfig
powerpc                    ge_imp3a_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   bluestone_defconfig
powerpc                      katmai_defconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       spear13xx_defconfig
mips                           rs90_defconfig
powerpc                          allmodconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     tqm8540_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
arm                        mvebu_v5_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
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
hexagon              randconfig-r045-20220519
hexagon              randconfig-r041-20220519
hexagon              randconfig-r045-20220522
hexagon              randconfig-r041-20220522
riscv                randconfig-r042-20220519
s390                 randconfig-r044-20220519
hexagon              randconfig-r045-20220521
hexagon              randconfig-r041-20220521
s390                 randconfig-r044-20220521
riscv                randconfig-r042-20220521

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
