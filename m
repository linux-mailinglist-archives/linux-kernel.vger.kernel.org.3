Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1C503824
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiDPUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiDPUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:10:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DE22516
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650139698; x=1681675698;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3xWfx4xHNYYJT/0sTPAsuia1zvQaYFMC0rrluaO4bpY=;
  b=gpPPjNhkxGFNd6n1OL8Mn1RMar+uLOinPVz9b4rHS/8u3Z5qitYWGUZb
   YEp2gfYY00V5VIq7Fy9KiED4bohN4o5JD7bXp26bzZzUPGAMc3FQ0rK5o
   Bd6gD4OT/uZbo8pCWknLNrb7kYwX4PvRNPQOBLAE3x9xIy/K1xdvmoorc
   1aoda7N3JLKawMiHezzBqnDrRtUdPjhFIFDClkzZDkrgF7Sf2LVyf8edg
   Ex85VXPf2DVKGmnKW36HqV1ug1qQXRFXA5hFz8DtDTc/YmID298BXZYUM
   Bx0qjzdRVM+HZLCe6ab/okYRGPnqziCRGxCqZG/3gF6kZ4UGkiixaU4Ui
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349786448"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="349786448"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 13:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="528360972"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2022 13:08:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfoiO-0003SX-O9;
        Sat, 16 Apr 2022 20:08:16 +0000
Date:   Sun, 17 Apr 2022 04:07:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 0f91855d69b1fe9bcb868a599039c6b3cba0c0e8
Message-ID: <625b21fd.Qqm71eWHZcohoJhF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 0f91855d69b1fe9bcb868a599039c6b3cba0c0e8  rcutorture: Test polled expedited grace-period primitives

elapsed time: 1452m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220414
powerpc                      ep88xc_defconfig
um                           x86_64_defconfig
h8300                       h8s-sim_defconfig
um                             i386_defconfig
powerpc                     taishan_defconfig
arc                           tb10x_defconfig
m68k                           sun3_defconfig
arm                       imx_v6_v7_defconfig
sh                               j2_defconfig
h8300                    h8300h-sim_defconfig
arc                          axs103_defconfig
sh                   rts7751r2dplus_defconfig
arm                        cerfcube_defconfig
mips                     loongson1b_defconfig
powerpc                         wii_defconfig
powerpc                 linkstation_defconfig
powerpc                       eiger_defconfig
arm                       multi_v4t_defconfig
powerpc                     mpc83xx_defconfig
sh                        sh7757lcr_defconfig
mips                      maltasmvp_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
openrisc                            defconfig
sh                           se7724_defconfig
sh                                  defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
sh                         ecovec24_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7203_defconfig
m68k                          amiga_defconfig
m68k                       m5249evb_defconfig
arm                     eseries_pxa_defconfig
arm                          gemini_defconfig
sh                           se7712_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                   motionpro_defconfig
powerpc                      cm5200_defconfig
arm                            mps2_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          landisk_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7722_defconfig
arm                            pleb_defconfig
x86_64                              defconfig
arc                     haps_hs_smp_defconfig
um                                  defconfig
powerpc                     tqm8555_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220414
arm                  randconfig-c002-20220417
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220414
arc                  randconfig-r043-20220416
riscv                randconfig-r042-20220417
s390                 randconfig-r044-20220417
arc                  randconfig-r043-20220417
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
mips                         tb0287_defconfig
i386                             allyesconfig
arm                            mmp2_defconfig
powerpc                     akebono_defconfig
powerpc                          g5_defconfig
arm                           omap1_defconfig
mips                   sb1250_swarm_defconfig
arm                         bcm2835_defconfig
arm                        neponset_defconfig
powerpc                        icon_defconfig
riscv                          rv32_defconfig
arm                       aspeed_g4_defconfig
powerpc                     tqm5200_defconfig
powerpc                     powernv_defconfig
mips                            e55_defconfig
powerpc                  mpc866_ads_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8560_ads_defconfig
mips                      maltaaprp_defconfig
powerpc                     kilauea_defconfig
arm                       versatile_defconfig
mips                        bcm63xx_defconfig
arm                        vexpress_defconfig
powerpc                          allyesconfig
arm                             mxs_defconfig
arm                  colibri_pxa300_defconfig
arm                       imx_v4_v5_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r041-20220414
riscv                randconfig-r042-20220414
s390                 randconfig-r044-20220414
hexagon              randconfig-r045-20220414
s390                 randconfig-r044-20220416
riscv                randconfig-r042-20220416
hexagon              randconfig-r041-20220415
hexagon              randconfig-r041-20220416
hexagon              randconfig-r045-20220415
hexagon              randconfig-r045-20220416
hexagon              randconfig-r045-20220417
hexagon              randconfig-r041-20220417

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
