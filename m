Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46EB5196BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbiEDFPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiEDFPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:15:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A91A385
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 22:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651641105; x=1683177105;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oE11qf1XArmoDWayXpIsHMto/I6WkBT+suFEyyKP9Ik=;
  b=XI14hcO1n5A9ZkATx0gb1xg90UoTE+ELaJTOdeTVFqyMEU5LdmcpYNFB
   3GKhF0IlJodsv45hL7u5n8GuJPW+zTQJaBg+CzMBbqPFoEfm+e+R5OqDJ
   QBGFNCJAlFE2CJDn1Lh86B2LyAueg+iI3OUYveu6uMj/DECfxNo8KCBfM
   eIFX9k/IFHtXBj5Ohns4L05V4/tlj6J6GBipjkBEG6soW6IoijwhFEbsG
   7dPfTLJUKti1oW1mt8R8UH4/v0/YwdDpdYr6OIU3ZgZT1JaoaddEhvPDY
   Iqx1/vyOT9MDV5ovN0Dq1P/iVSIQLxnCOLDk9y5ZFLwEsNLsOB4sS3/wJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="265253053"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="265253053"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 22:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516867093"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 22:11:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm7Ic-000B5b-Ue;
        Wed, 04 May 2022 05:11:42 +0000
Date:   Wed, 04 May 2022 13:11:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 4ccb27d8a0f234aef439d44865d51218ab51eb5a
Message-ID: <62720ae6.tUGchCJaMqcqpdg+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 4ccb27d8a0f234aef439d44865d51218ab51eb5a  rcutorture: Simplify rcu_torture_read_exit_child() loop

elapsed time: 8796m

configs tested: 267
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
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
xtensa                           allyesconfig
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
s390                       zfcpdump_defconfig
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
sh                        sh7763rdp_defconfig
mips                           ci20_defconfig
parisc                              defconfig
sh                         microdev_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     tqm8541_defconfig
riscv                            allmodconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
riscv                            allyesconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          r7780mp_defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
arm                      integrator_defconfig
microblaze                          defconfig
mips                         cobalt_defconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
powerpc                    klondike_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
powerpc                    amigaone_defconfig
microblaze                      mmu_defconfig
sh                          polaris_defconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                        apsh4ad0a_defconfig
m68k                       m5275evb_defconfig
sh                         ap325rxa_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                generic-64bit_defconfig
sh                          lboxre2_defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
m68k                        m5272c3_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
mips                      maltasmvp_defconfig
arc                     nsimosci_hs_defconfig
arm                       omap2plus_defconfig
mips                  decstation_64_defconfig
sh                          kfr2r09_defconfig
alpha                            alldefconfig
mips                      fuloong2e_defconfig
nios2                         3c120_defconfig
m68k                        stmark2_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
sh                   sh7724_generic_defconfig
sh                        sh7785lcr_defconfig
mips                         db1xxx_defconfig
m68k                          multi_defconfig
arm                          exynos_defconfig
powerpc                 mpc834x_mds_defconfig
arc                         haps_hs_defconfig
arm                        cerfcube_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
mips                         rt305x_defconfig
ia64                             alldefconfig
arm                         nhk8815_defconfig
sh                             sh03_defconfig
sh                             espt_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
powerpc                      ppc40x_defconfig
arm                            lart_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
sh                           sh2007_defconfig
arm                     eseries_pxa_defconfig
mips                    maltaup_xpa_defconfig
openrisc                    or1ksim_defconfig
sh                          landisk_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
powerpc                     asp8347_defconfig
mips                       bmips_be_defconfig
sh                           se7206_defconfig
sh                   rts7751r2dplus_defconfig
parisc64                            defconfig
m68k                             allmodconfig
arm                        oxnas_v6_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
arm                        keystone_defconfig
alpha                            allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
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
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
mips                     loongson2k_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
mips                   sb1250_swarm_defconfig
arm64                            allyesconfig
powerpc                     tqm8540_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
mips                  cavium_octeon_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
powerpc                  mpc885_ads_defconfig
arm                       cns3420vb_defconfig
powerpc                        fsp2_defconfig
powerpc                   microwatt_defconfig
mips                       lemote2f_defconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
arm                            dove_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8560_ads_defconfig
riscv                          rv32_defconfig
mips                malta_qemu_32r6_defconfig
arm                                 defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
