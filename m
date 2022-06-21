Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EA553C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355998AbiFUVG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356938AbiFUVFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:05:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE502FFED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655844847; x=1687380847;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rCK33wHiwXXfEe1g+x7+z+TkND+SGqMzDT8MqJchkn8=;
  b=aUGhNHVZQbQASZTLo08Pg0hFhTpteiZB0vGNGlOcWtbr1p/Yi4ihOTg9
   tHTGUZYRRENnICP0TFZl4Hn3t2iDPn/xQECpCUsy/kyNgCoG4j50MNg5p
   KBOMTPwHSm4PoB+XsYlTEvMM8QIrR+AHYAYCfs10vWzevD3/OccPrNcLJ
   opRJNgLjjLYSVoIfZNH+645jybfrUw8/Jr6aC+3mF01E324NlH6r7piiB
   cKgp9xKQD6ZL0qfsy+Vy1wA3CtQQaCznCvWyPrA2u3j9IAxMnbcmNDNCO
   T/SY7cAa6tGy7i7jlvlOkZT53PfjEhyMMHiuAHYcjpdvKLh7/LIMq1V7F
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="279003791"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="279003791"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 13:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="655318118"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2022 13:52:14 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3kr7-0000Q5-Ua;
        Tue, 21 Jun 2022 20:52:13 +0000
Date:   Wed, 22 Jun 2022 04:52:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.17a] BUILD SUCCESS
 c09ca10d879bae4a8df842dbe8d6bd8b87830633
Message-ID: <62b22f7c.dEXaNqXuq3aBWKzX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.17a
branch HEAD: c09ca10d879bae4a8df842dbe8d6bd8b87830633  rcu/nocb: Choose the right rcuog/rcuop kthreads to output

elapsed time: 4630m

configs tested: 213
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
mips                 randconfig-c004-20220619
i386                          randconfig-c001
arm                         axm55xx_defconfig
powerpc                  storcenter_defconfig
mips                           xway_defconfig
openrisc                  or1klitex_defconfig
sh                               j2_defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
mips                       bmips_be_defconfig
m68k                          sun3x_defconfig
m68k                        mvme16x_defconfig
parisc                generic-64bit_defconfig
mips                        vocore2_defconfig
sparc                       sparc64_defconfig
m68k                          multi_defconfig
alpha                            alldefconfig
arc                              alldefconfig
m68k                                defconfig
mips                         rt305x_defconfig
um                             i386_defconfig
arm                         assabet_defconfig
arm                          pxa910_defconfig
arm                            mps2_defconfig
arc                        nsimosci_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     taishan_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
xtensa                       common_defconfig
powerpc                         wii_defconfig
sh                              ul2_defconfig
nios2                            alldefconfig
arm                       imx_v6_v7_defconfig
um                                  defconfig
powerpc                       ppc64_defconfig
xtensa                  audio_kc705_defconfig
arm                        multi_v7_defconfig
sh                           se7705_defconfig
powerpc                       eiger_defconfig
arm                            pleb_defconfig
mips                     loongson1b_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
parisc                              defconfig
arm                     eseries_pxa_defconfig
sh                           se7343_defconfig
mips                           ci20_defconfig
xtensa                  nommu_kc705_defconfig
m68k                       m5275evb_defconfig
m68k                          amiga_defconfig
sh                            migor_defconfig
sh                         apsh4a3a_defconfig
arm                           h3600_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         cm_x300_defconfig
m68k                           virt_defconfig
powerpc                        warp_defconfig
m68k                           sun3_defconfig
powerpc                     asp8347_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                generic_kc705_defconfig
powerpc                       holly_defconfig
mips                  decstation_64_defconfig
sh                        sh7763rdp_defconfig
m68k                             alldefconfig
ia64                            zx1_defconfig
nios2                         10m50_defconfig
parisc                generic-32bit_defconfig
powerpc                   currituck_defconfig
sh                            titan_defconfig
mips                          rb532_defconfig
powerpc                     tqm8548_defconfig
powerpc                           allnoconfig
powerpc                     redwood_defconfig
powerpc                 linkstation_defconfig
mips                            gpr_defconfig
arm                         lubbock_defconfig
m68k                        mvme147_defconfig
sh                          rsk7201_defconfig
sh                           sh2007_defconfig
x86_64                           alldefconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220619
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
nios2                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a004-20220620
x86_64               randconfig-a006-20220620
x86_64               randconfig-a001-20220620
x86_64               randconfig-a005-20220620
x86_64               randconfig-a002-20220620
x86_64               randconfig-a003-20220620
i386                 randconfig-a005-20220620
i386                 randconfig-a001-20220620
i386                 randconfig-a006-20220620
i386                 randconfig-a004-20220620
i386                 randconfig-a003-20220620
i386                 randconfig-a002-20220620
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220619
riscv                randconfig-r042-20220619
s390                 randconfig-r044-20220619
arc                  randconfig-r043-20220620
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz

clang tested configs:
arm                          pcm027_defconfig
powerpc                    gamecube_defconfig
powerpc                     tqm8560_defconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc8272_ads_defconfig
arm                            mmp2_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     ksi8560_defconfig
riscv                          rv32_defconfig
powerpc                     mpc512x_defconfig
arm64                            allyesconfig
powerpc                       ebony_defconfig
arm                        vexpress_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         shannon_defconfig
arm                        multi_v5_defconfig
mips                          malta_defconfig
arm                        magician_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      malta_kvm_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a013-20220620
x86_64               randconfig-a012-20220620
x86_64               randconfig-a016-20220620
x86_64               randconfig-a015-20220620
x86_64               randconfig-a011-20220620
x86_64               randconfig-a014-20220620
i386                 randconfig-a014-20220620
i386                 randconfig-a011-20220620
i386                 randconfig-a012-20220620
i386                 randconfig-a015-20220620
i386                 randconfig-a016-20220620
i386                 randconfig-a013-20220620
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220619
hexagon              randconfig-r041-20220619
hexagon              randconfig-r041-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
