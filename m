Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E8516F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385013AbiEBMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiEBMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:22:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6015FFD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651493967; x=1683029967;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eckX1rid7yQi+nvXInn+qxAPnYGJfbdMfE4OdXlAdk0=;
  b=SYtP3hJLPeFMn7hooVHLUM/llQ53GxXBQLhf+fQ7gcbsRofzuEW0g75r
   42kmpGdBfeOUe5NNdn3qK1TwL3vJSvb5B4LURMicux5mIXcNS2ZrUpiCi
   YqT07WAl4TdEFrwvnfdlWTTBLwhjzeRCx8DixqJidWBhNmBXiRGRvJdE1
   pLUHukb6aQ6FQAhWH/GVrbB8LbbN2ypD08fKlumrPqiu70hBLCUdoWJgS
   zSL4PDcXQab569FttAug+/Hm8kZ16jVftyD15EBDTm9xcDWDXRG/is2j0
   EpyeDkJfJeS+Iqx2wi4Pzrcoro/8DIBQ58m0ZUoENIjlqIuyaXO46rink
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="254644936"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="254644936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 05:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="535823749"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 May 2022 05:19:13 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlV1E-0009Xn-Sv;
        Mon, 02 May 2022 12:19:12 +0000
Date:   Mon, 02 May 2022 20:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/splitlock] BUILD SUCCESS
 ef79970d7ccdc4e8855aa6079fc2f4797a6807fb
Message-ID: <626fcc18.Vwi6emE0lAYssMPj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/splitlock
branch HEAD: ef79970d7ccdc4e8855aa6079fc2f4797a6807fb  x86/split-lock: Remove unused TIF_SLD bit

elapsed time: 7065m

configs tested: 288
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220428
i386                          randconfig-c001
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
powerpc                     ep8248e_defconfig
s390                                defconfig
mips                         tb0226_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
arc                            hsdk_defconfig
mips                          rb532_defconfig
mips                        vocore2_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
arm                      jornada720_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          r7780mp_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
sh                             sh03_defconfig
arm                       imx_v6_v7_defconfig
ia64                      gensparse_defconfig
m68k                            mac_defconfig
ia64                         bigsur_defconfig
m68k                          sun3x_defconfig
arm                         nhk8815_defconfig
powerpc                     tqm8541_defconfig
powerpc                       holly_defconfig
mips                            gpr_defconfig
xtensa                           allyesconfig
arm                            lart_defconfig
powerpc                         ps3_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                               defconfig
mips                    maltaup_xpa_defconfig
sh                        apsh4ad0a_defconfig
mips                           gcw0_defconfig
arm                             ezx_defconfig
arm                       omap2plus_defconfig
m68k                           sun3_defconfig
m68k                        m5272c3_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
mips                      maltasmvp_defconfig
arc                     nsimosci_hs_defconfig
m68k                       m5249evb_defconfig
xtensa                           alldefconfig
arm                          gemini_defconfig
sh                          landisk_defconfig
arm                         lpc18xx_defconfig
arc                         haps_hs_defconfig
xtensa                  cadence_csp_defconfig
arm                         assabet_defconfig
parisc                              defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
arm                            qcom_defconfig
mips                         db1xxx_defconfig
m68k                          multi_defconfig
arm                          exynos_defconfig
sh                   sh7724_generic_defconfig
mips                     loongson1b_defconfig
m68k                        m5307c3_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
arm                          lpd270_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
arm                          simpad_defconfig
nios2                            allyesconfig
arm                        cerfcube_defconfig
arm                      integrator_defconfig
um                               alldefconfig
sh                          rsk7201_defconfig
arm                        oxnas_v6_defconfig
powerpc                         wii_defconfig
arm64                            alldefconfig
arm                           corgi_defconfig
arm                        multi_v7_defconfig
sh                ecovec24-romimage_defconfig
microblaze                          defconfig
powerpc                     pq2fads_defconfig
arm                           sunxi_defconfig
sh                           se7751_defconfig
ia64                             alldefconfig
sh                          lboxre2_defconfig
mips                       capcella_defconfig
powerpc                 mpc837x_rdb_defconfig
sparc64                          alldefconfig
sh                           se7750_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                       aspeed_g5_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    amigaone_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                   currituck_defconfig
powerpc                      cm5200_defconfig
arm                     eseries_pxa_defconfig
arm                           imxrt_defconfig
openrisc                    or1ksim_defconfig
i386                             alldefconfig
m68k                        mvme16x_defconfig
i386                                defconfig
mips                           jazz_defconfig
powerpc                      makalu_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
sh                   rts7751r2dplus_defconfig
parisc64                            defconfig
arm                        keystone_defconfig
powerpc                  storcenter_defconfig
x86_64                           alldefconfig
sh                          kfr2r09_defconfig
powerpc                    sam440ep_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220427
arm                  randconfig-c002-20220429
arm                  randconfig-c002-20220501
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220427
riscv                randconfig-r042-20220427
arc                  randconfig-r043-20220428
arc                  randconfig-r043-20220429
s390                 randconfig-r044-20220429
riscv                randconfig-r042-20220429
s390                 randconfig-r044-20220427
riscv                               defconfig
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
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                        mvebu_v5_defconfig
mips                      malta_kvm_defconfig
arm64                            allyesconfig
powerpc                     tqm8540_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
powerpc                     tqm5200_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         s3c2410_defconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          moxart_defconfig
mips                           mtx1_defconfig
powerpc                      obs600_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    socrates_defconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
mips                       rbtx49xx_defconfig
powerpc                          allmodconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
powerpc                 linkstation_defconfig
powerpc                     skiroot_defconfig
powerpc                        fsp2_defconfig
mips                      bmips_stb_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      pmac32_defconfig
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
hexagon              randconfig-r041-20220427
hexagon              randconfig-r045-20220427
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428
s390                 randconfig-r044-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
