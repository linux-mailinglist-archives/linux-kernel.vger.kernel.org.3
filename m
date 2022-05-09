Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3751FD32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiEIMtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiEIMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:49:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136762631F6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652100313; x=1683636313;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=e4RlNm/0a9Z8nMbaptMN1lxeDtZ2M80v0RQlq3njVEY=;
  b=WTha+XMclqmF/4jMpXqd2X0fJdEj2kbFSGEvLnbKPivEGlf5GSQxbt8l
   MCTwowaXHqTXV0P6/c1ksQm3Fk3JmJTEhp2zE+oCxJg4KHInaI5FMw7wQ
   3wIPFia2l3viOyDWPum0NvKpgEczJvZw72ldIuvcflXAK8FrImXzomh9r
   LQACeo/lxRHSex0NXGZ2K1S3zbf3p7hdb4HmluBQMdhbqriPpRP/bN0NI
   qtdrNtGLzEq+UMOGFMbvaPVtqiFJ8R02UedZMYFWciBtuJGDlf0xXIgmK
   +o3riwwgI2AIJPkd17lrADkXpIZ775Cn2XKHxLugbl3er6Eim08bhx5k0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="248938008"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="248938008"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 05:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="570141861"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 May 2022 05:45:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no2lC-000GVm-PF;
        Mon, 09 May 2022 12:45:10 +0000
Date:   Mon, 09 May 2022 20:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 ab65f49253ff706723ecbf87af74e9383b5e4582
Message-ID: <62790cb2.3hbMb7Jy6bC8vw9A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/sev
branch HEAD: ab65f49253ff706723ecbf87af74e9383b5e4582  x86/sev: Fix address space sparse warning

elapsed time: 9895m

configs tested: 283
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         tb0226_defconfig
powerpc                         ps3_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
ia64                             alldefconfig
arm                          exynos_defconfig
h8300                    h8300h-sim_defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
arm                        clps711x_defconfig
sh                           se7705_defconfig
mips                       bmips_be_defconfig
powerpc                     taishan_defconfig
m68k                           sun3_defconfig
powerpc                      pcm030_defconfig
parisc                           allyesconfig
s390                       zfcpdump_defconfig
arm                         lpc18xx_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
arm                        mini2440_defconfig
sh                   sh7724_generic_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
sh                           se7619_defconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
arm                       multi_v4t_defconfig
mips                  maltasmvp_eva_defconfig
m68k                          hp300_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
arm                           viper_defconfig
h8300                            allyesconfig
powerpc                     rainier_defconfig
powerpc                mpc7448_hpc2_defconfig
parisc                generic-64bit_defconfig
sh                          lboxre2_defconfig
m68k                       m5249evb_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
sh                               allmodconfig
arm                         lubbock_defconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
powerpc                      pasemi_defconfig
mips                           ci20_defconfig
mips                         bigsur_defconfig
sh                   rts7751r2dplus_defconfig
sh                            shmin_defconfig
alpha                            alldefconfig
arc                     nsimosci_hs_defconfig
arc                           tb10x_defconfig
ia64                        generic_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
arm                            zeus_defconfig
csky                                defconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
sh                          kfr2r09_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     redwood_defconfig
arm                        realview_defconfig
arc                         haps_hs_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
sh                          sdk7786_defconfig
mips                     decstation_defconfig
powerpc                 mpc8540_ads_defconfig
s390                             allyesconfig
arm                         s3c6400_defconfig
arm                         cm_x300_defconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
powerpc                       eiger_defconfig
mips                        bcm47xx_defconfig
arm                        cerfcube_defconfig
m68k                          multi_defconfig
mips                        vocore2_defconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
i386                                defconfig
arc                        vdk_hs38_defconfig
powerpc                      bamboo_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7785lcr_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
arm                       omap2plus_defconfig
sh                           se7750_defconfig
powerpc                      arches_defconfig
powerpc                     tqm8555_defconfig
sh                           se7721_defconfig
arm                       aspeed_g5_defconfig
m68k                       m5475evb_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220508
arm                  randconfig-c002-20220501
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a006-20220502
x86_64               randconfig-a002-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a004-20220502
x86_64               randconfig-a005-20220502
x86_64               randconfig-a003-20220502
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220502
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
s390                 randconfig-c005-20220506
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
s390                 randconfig-c005-20220501
powerpc              randconfig-c003-20220507
riscv                randconfig-c006-20220507
mips                 randconfig-c004-20220507
arm                  randconfig-c002-20220507
arm                         lpc32xx_defconfig
mips                     cu1830-neo_defconfig
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
arm                          collie_defconfig
mips                          malta_defconfig
powerpc                      pmac32_defconfig
powerpc                    socrates_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
arm                          moxart_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     pseries_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
hexagon                             defconfig
arm                            mmp2_defconfig
arm                     davinci_all_defconfig
arm                            dove_defconfig
arm                          ixp4xx_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
powerpc                     powernv_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a015-20220502
x86_64               randconfig-a016-20220502
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                 randconfig-a011-20220502
i386                 randconfig-a013-20220502
i386                 randconfig-a016-20220502
i386                 randconfig-a015-20220502
i386                 randconfig-a014-20220502
i386                 randconfig-a012-20220502
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501
s390                 randconfig-r044-20220502

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
