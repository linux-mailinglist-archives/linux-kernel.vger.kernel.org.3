Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284F527800
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiEOOVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEOOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:21:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFC0DF4A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652624471; x=1684160471;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K8nM2p0sXCoQUz2wRHJID/eJ4qWL768CAkvIHkuAGCo=;
  b=nG+TqEGb2L/MEsVazvfMgiZ9qujw6a6lKlOTm7fopv8qfprGpw81mI+9
   AbwA/NBnWMpFXC51l+BvdJ4pZUcvCoRirU7ahjM6ck42ZCd7/KhPwMDDT
   U0dNIEiSju1Q9KhsiV3N6xULsSPRE4wbt+XL5XALn2tVCEdrdmSkbU1jP
   50HVGabUSMnznRVuq1mN1Op3NoQy78gFjeordHJKF8gdhBm1TWe8iTrC+
   8t2L2Mt36HYUB2+vVJcl3p3J16L9aunYbDq4Y9M7xN00SCJemXLUZ1lW3
   Yxf6YZR2nmutAMbOFc/GLp9o1ufyZbDjurvTao7GpoMfY6gL02mBWgtVG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270334429"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="270334429"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 07:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="637898551"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2022 07:21:06 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqF7K-0001h7-0V;
        Sun, 15 May 2022 14:21:06 +0000
Date:   Sun, 15 May 2022 22:20:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 bc469ddf67154a4840267132e87ce0d8b72d4952
Message-ID: <62810c22.OM+YHiAFlHDA4It9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: bc469ddf67154a4840267132e87ce0d8b72d4952  perf/x86/amd: Remove unused variable 'hwc'

elapsed time: 4229m

configs tested: 228
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220512
powerpc                  storcenter_defconfig
arm                         nhk8815_defconfig
arm                           stm32_defconfig
csky                                defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8555_defconfig
powerpc                      arches_defconfig
mips                           ip32_defconfig
arm                          simpad_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
sh                          urquell_defconfig
xtensa                  audio_kc705_defconfig
xtensa                           alldefconfig
m68k                       m5275evb_defconfig
ia64                      gensparse_defconfig
xtensa                    xip_kc705_defconfig
h8300                     edosk2674_defconfig
arm                            hisi_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7712_defconfig
mips                             allyesconfig
mips                         tb0226_defconfig
sh                        sh7763rdp_defconfig
arm                         axm55xx_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc8540_ads_defconfig
mips                           ci20_defconfig
sh                           se7721_defconfig
xtensa                         virt_defconfig
m68k                            q40_defconfig
arm                        keystone_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
sh                   secureedge5410_defconfig
arc                                 defconfig
mips                             allmodconfig
mips                     decstation_defconfig
sh                          sdk7780_defconfig
sh                         ecovec24_defconfig
ia64                            zx1_defconfig
parisc64                            defconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
powerpc                       eiger_defconfig
openrisc                            defconfig
sh                             sh03_defconfig
arc                        vdk_hs38_defconfig
powerpc                       holly_defconfig
mips                            ar7_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                        trizeps4_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
m68k                          sun3x_defconfig
arc                     haps_hs_smp_defconfig
m68k                        mvme16x_defconfig
riscv                               defconfig
sh                        apsh4ad0a_defconfig
sh                   rts7751r2dplus_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
arm                     eseries_pxa_defconfig
sh                 kfr2r09-romimage_defconfig
i386                             alldefconfig
ia64                         bigsur_defconfig
m68k                        mvme147_defconfig
m68k                       m5208evb_defconfig
powerpc                     rainier_defconfig
powerpc                     taishan_defconfig
sparc                       sparc32_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
powerpc                    adder875_defconfig
arm                            qcom_defconfig
powerpc                           allnoconfig
powerpc                 mpc837x_mds_defconfig
xtensa                          iss_defconfig
m68k                          atari_defconfig
parisc                           allyesconfig
xtensa                  cadence_csp_defconfig
arm                        oxnas_v6_defconfig
mips                           gcw0_defconfig
arm                        clps711x_defconfig
powerpc                      pcm030_defconfig
sparc                       sparc64_defconfig
arc                     nsimosci_hs_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                  nommu_kc705_defconfig
mips                 decstation_r4k_defconfig
openrisc                  or1klitex_defconfig
sh                         apsh4a3a_defconfig
sh                                  defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
powerpc                    amigaone_defconfig
sh                          landisk_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
powerpc                         wii_defconfig
um                                  defconfig
arc                        nsimosci_defconfig
sh                           se7750_defconfig
arc                          axs101_defconfig
arm                         s3c6400_defconfig
mips                         mpc30x_defconfig
h8300                       h8s-sim_defconfig
arm                         cm_x300_defconfig
arm                        realview_defconfig
mips                     loongson1b_defconfig
powerpc                  iss476-smp_defconfig
sh                          sdk7786_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
parisc                generic-32bit_defconfig
sh                            hp6xx_defconfig
sh                          r7780mp_defconfig
mips                       bmips_be_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
powerpc                          allyesconfig
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
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
arc                  randconfig-r043-20220513
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
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220512
x86_64                        randconfig-c007
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
i386                          randconfig-c001
arm                  randconfig-c002-20220512
powerpc                     tqm5200_defconfig
powerpc                          allyesconfig
arm                  colibri_pxa300_defconfig
arm                          pcm027_defconfig
arm                         orion5x_defconfig
powerpc                      ppc64e_defconfig
x86_64                           allyesconfig
arm                      pxa255-idp_defconfig
arm                  colibri_pxa270_defconfig
arm                        magician_defconfig
arm                       netwinder_defconfig
riscv                    nommu_virt_defconfig
arm                           spitz_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pseries_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8540_defconfig
riscv                             allnoconfig
arm                       mainstone_defconfig
mips                           mtx1_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                         socfpga_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc8272_ads_defconfig
arm                          collie_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      ppc44x_defconfig
powerpc                   bluestone_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
