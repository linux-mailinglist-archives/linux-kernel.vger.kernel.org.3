Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482D7524F62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354999AbiELOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354984AbiELOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:04:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3722025B06B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652364269; x=1683900269;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=28GBTzbqAHkG8x0kb03T62upVHHfK7VX0kw01qI/hWo=;
  b=Mib6EBfv+Sp1FC5bPqmiADGT36XKupoBu2ZYUtEg5dmoSO7L9uutjNps
   3AbpZOQpkvUuZF+wcL6IGAmZ5EihNxWr93IYy6y1emiUIRhUwEz2kTPmw
   u0cXGQ2rzMgjc9rvOj3YvWUzMg/Egjj+aj0goxUHEbDjTSovoJc2PkJRo
   OXVK1cd/WmP0xUaNHXjB1G26qO74gxid5NIM/MHzZ+tlD9fy+YWvK9Iqm
   37om4hqAgTDr5+4IjVi4BFp3ZK6XrpRWUR3K8S61NkS8MlHlNJS1o1qGO
   77DP6LikDvtTCUF71bPKL5I1EftkFCUuiJ1TJwFKJGE78gAqTULEAqrTF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="252059999"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="252059999"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="636857618"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2022 07:04:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np9QY-000KXY-Hy;
        Thu, 12 May 2022 14:04:26 +0000
Date:   Thu, 12 May 2022 22:03:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 734387ec2f9d77b00276042b1fa7c95f48ee879d
Message-ID: <627d13ae.sVJITC1WervrtmKe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 734387ec2f9d77b00276042b1fa7c95f48ee879d  sched/deadline: Remove superfluous rq clock update in push_dl_task()

elapsed time: 1078m

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
i386                 randconfig-c001-20220509
i386                          randconfig-c001
arm                         lpc18xx_defconfig
sh                          rsk7269_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
arc                          axs101_defconfig
h8300                       h8s-sim_defconfig
xtensa                generic_kc705_defconfig
xtensa                         virt_defconfig
um                                  defconfig
m68k                       m5249evb_defconfig
sh                          urquell_defconfig
ia64                         bigsur_defconfig
arm                            pleb_defconfig
xtensa                          iss_defconfig
arm                        mini2440_defconfig
arm                        multi_v7_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7201_defconfig
arm                         at91_dt_defconfig
arc                        nsim_700_defconfig
powerpc                 linkstation_defconfig
powerpc                       eiger_defconfig
arm                          iop32x_defconfig
arm                         cm_x300_defconfig
arm                           h3600_defconfig
um                               alldefconfig
xtensa                  cadence_csp_defconfig
sh                          r7785rp_defconfig
sh                                  defconfig
powerpc                  storcenter_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
ia64                        generic_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7721_defconfig
m68k                             allmodconfig
sh                           sh2007_defconfig
i386                                defconfig
powerpc                     sequoia_defconfig
sh                          polaris_defconfig
sh                            hp6xx_defconfig
sparc                            alldefconfig
arc                         haps_hs_defconfig
m68k                          multi_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
mips                  maltasmvp_eva_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
arm                          exynos_defconfig
s390                       zfcpdump_defconfig
arc                          axs103_defconfig
m68k                       m5208evb_defconfig
powerpc                      pcm030_defconfig
mips                       capcella_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     taishan_defconfig
mips                            ar7_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
arm                          simpad_defconfig
xtensa                       common_defconfig
powerpc                 mpc837x_mds_defconfig
h8300                            allyesconfig
sh                          kfr2r09_defconfig
sh                            migor_defconfig
powerpc                     tqm8555_defconfig
parisc                generic-32bit_defconfig
alpha                            allyesconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
ia64                                defconfig
m68k                             alldefconfig
openrisc                            defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
riscv                               defconfig
xtensa                           alldefconfig
powerpc                   currituck_defconfig
sh                     sh7710voipgw_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      ep88xc_defconfig
powerpc                         ps3_defconfig
arm                             rpc_defconfig
arm                        spear6xx_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      cm5200_defconfig
sh                           se7724_defconfig
sh                          rsk7203_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
powerpc                 mpc834x_itx_defconfig
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a014-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-c007-20220509
s390                 randconfig-c005-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
mips                 randconfig-c004-20220509
arm                  randconfig-c002-20220509
s390                 randconfig-c005-20220512
powerpc              randconfig-c003-20220512
x86_64                        randconfig-c007
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
i386                          randconfig-c001
arm                  randconfig-c002-20220512
powerpc                      acadia_defconfig
mips                       rbtx49xx_defconfig
mips                        maltaup_defconfig
mips                      maltaaprp_defconfig
mips                        omega2p_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  colibri_pxa300_defconfig
arm                       versatile_defconfig
powerpc                     ppa8548_defconfig
arm                         shannon_defconfig
powerpc                    mvme5100_defconfig
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
