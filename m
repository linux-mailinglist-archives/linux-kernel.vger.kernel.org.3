Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7BA5471C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 06:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350342AbiFKEWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 00:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350357AbiFKEWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 00:22:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175FBE09F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 21:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654921323; x=1686457323;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0Vle8JPBMdV4kPgBCp3h68sMJxDx9W1CTnvq73rzH0g=;
  b=lEZzEvbeICZqw9Ue94rtuTXFnhMY1w4rfK8Pti1gV6kMaZiJLHUcvkM4
   xpDgFa1TMTQVRK4Hxm94kxCvxlru3oL9CJ7+89dpeAmvCvw/WDO0Oe684
   NxnxN7bgddXZDrg64V/e32YQwaZQNyI3ULUwB0xCEKQkJ7mmPnUh25uPc
   YjPXigC6azmF2v+PVjjHmM7eau5kvN2Ym1QssnqzaeXjxAJ43MMgowhgA
   Jl9Zpi0oiAREE70liAmA5aVYmjRSSnajJqZh1veAdxKmxi88y9cNYLacp
   xSPH9FZR9UlO67sp0RLrrRSiVX9odilQuHPeOd3EC+2dZFAnkdygK78Cg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="257654612"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="257654612"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 21:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="828600783"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2022 21:22:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzsdN-000IXD-1E;
        Sat, 11 Jun 2022 04:22:01 +0000
Date:   Sat, 11 Jun 2022 12:21:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/uapi-fam1] BUILD SUCCESS
 58e4d787fd4bf471ec6b4ab9c00188e43df1a883
Message-ID: <62a41846.1o0OrdLnUKwRjpNG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/uapi-fam1
branch HEAD: 58e4d787fd4bf471ec6b4ab9c00188e43df1a883  uapi: vbox: Replace one-element array with flexible-array member

elapsed time: 3598m

configs tested: 131
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
arc                         haps_hs_defconfig
mips                          rb532_defconfig
riscv                               defconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         tb0226_defconfig
m68k                            q40_defconfig
microblaze                      mmu_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc834x_itx_defconfig
sh                           se7750_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
sh                          rsk7201_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
arm                       aspeed_g5_defconfig
powerpc                   currituck_defconfig
parisc64                         alldefconfig
arm                        multi_v7_defconfig
powerpc                       ppc64_defconfig
sh                      rts7751r2d1_defconfig
sh                   secureedge5410_defconfig
powerpc                     tqm8541_defconfig
powerpc                   motionpro_defconfig
arm                          pxa3xx_defconfig
sh                              ul2_defconfig
xtensa                  cadence_csp_defconfig
sh                               alldefconfig
powerpc                      ep88xc_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
um                           x86_64_defconfig
ia64                             alldefconfig
arc                              allyesconfig
sh                            migor_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220608
riscv                randconfig-r042-20220608
s390                 randconfig-r044-20220608
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                   bluestone_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           rs90_defconfig
powerpc                    socrates_defconfig
powerpc                     ppa8548_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                             mxs_defconfig
powerpc                     kmeter1_defconfig
arm                         shannon_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        omega2p_defconfig
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
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220608
hexagon              randconfig-r045-20220608
hexagon              randconfig-r045-20220609
s390                 randconfig-r044-20220609
riscv                randconfig-r042-20220609
hexagon              randconfig-r041-20220609

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
