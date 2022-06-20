Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C955121A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiFTIDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiFTIDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:03:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103A213
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655712221; x=1687248221;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F/wETvNVQMhAWFfFKnfNsOD0hV6cLaB4LpmI+3xo/+w=;
  b=CWTyz11x2JUqgOXvHXs1NZ8bvRYR8iqWvSqUsG9POYU5DIZulaLJSSu0
   hAp4xAQ08cTJg837bR5wH7V0ibtTwvb9WMmi35zUBZZ6DWPoizzkGQRjC
   y8bN8yqRNFoaQqSGXKttJdQsNYOEmalRSkZfAGL1AJB78fHMyzzX0UE9B
   rqh3lWwsazH3i7Z7HNzEDpMKkGJTxS4XcUaQHUPPuDN58YT4GLCl1hevd
   /WgPpzkoP62wci/ot7MHNzDwxr4U2J1Myr0uUeh6kSv5S0FUGCgQg3HdA
   O1uwl7WIkMllwlKIHaMYDiWzX2VHpdm71zLVLnGjx175RK47xbmK+4Ttd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268552888"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268552888"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 01:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="591063974"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2022 01:03:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3CNl-000SA3-OT;
        Mon, 20 Jun 2022 08:03:37 +0000
Date:   Mon, 20 Jun 2022 16:03:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:torture-test.2022.06.16a] BUILD SUCCESS
 b2445956b1bc7f9fdadcb584f94fc888a208db75
Message-ID: <62b029d2.4JJHHgs4w6Q6tAJq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git torture-test.2022.06.16a
branch HEAD: b2445956b1bc7f9fdadcb584f94fc888a208db75  refscale: Convert test_lock spinlock to raw_spinlock

elapsed time: 2274m

configs tested: 181
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
mips                 randconfig-c004-20220619
i386                          randconfig-c001
arm                         axm55xx_defconfig
powerpc                  storcenter_defconfig
mips                           xway_defconfig
openrisc                  or1klitex_defconfig
sparc                       sparc32_defconfig
ia64                        generic_defconfig
sh                            hp6xx_defconfig
xtensa                generic_kc705_defconfig
arm                         assabet_defconfig
alpha                            alldefconfig
arm                          pxa910_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
mips                           ip32_defconfig
m68k                            mac_defconfig
powerpc                     taishan_defconfig
powerpc                mpc7448_hpc2_defconfig
um                             i386_defconfig
parisc                generic-64bit_defconfig
powerpc                         wii_defconfig
sh                              ul2_defconfig
nios2                            alldefconfig
arm                           sunxi_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
arm                            qcom_defconfig
arm                      jornada720_defconfig
arc                        vdk_hs38_defconfig
powerpc                           allnoconfig
ia64                            zx1_defconfig
m68k                          hp300_defconfig
powerpc                       eiger_defconfig
arm                            pleb_defconfig
mips                     loongson1b_defconfig
sh                           se7721_defconfig
arc                    vdk_hs38_smp_defconfig
arm                     eseries_pxa_defconfig
sh                           se7343_defconfig
powerpc                      arches_defconfig
m68k                       m5275evb_defconfig
m68k                          amiga_defconfig
sh                            migor_defconfig
powerpc                        warp_defconfig
xtensa                  audio_kc705_defconfig
m68k                           sun3_defconfig
powerpc                     asp8347_defconfig
sh                               alldefconfig
openrisc                            defconfig
arc                      axs103_smp_defconfig
mips                  decstation_64_defconfig
m68k                          multi_defconfig
sh                        sh7763rdp_defconfig
m68k                       m5249evb_defconfig
riscv                               defconfig
m68k                             alldefconfig
sh                          urquell_defconfig
sh                            titan_defconfig
mips                          rb532_defconfig
powerpc                     tqm8548_defconfig
sh                           se7724_defconfig
parisc                              defconfig
ia64                                defconfig
parisc64                         alldefconfig
nios2                         10m50_defconfig
sh                           sh2007_defconfig
x86_64                           alldefconfig
powerpc                     ep8248e_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220619
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                              allyesconfig
nios2                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a006
s390                 randconfig-r044-20220619
riscv                randconfig-r042-20220619
arc                  randconfig-r043-20220619
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
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
arm                          pcm027_defconfig
powerpc                    gamecube_defconfig
arm                       mainstone_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                                 defconfig
arm                            mmp2_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     ksi8560_defconfig
arm                        multi_v5_defconfig
arm                      pxa255-idp_defconfig
arm                           sama7_defconfig
powerpc                      ppc64e_defconfig
mips                        bcm63xx_defconfig
arm                           spitz_defconfig
arm                        neponset_defconfig
arm                  colibri_pxa270_defconfig
arm                          moxart_defconfig
arm                        vexpress_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         shannon_defconfig
mips                       rbtx49xx_defconfig
powerpc                     kilauea_defconfig
arm                             mxs_defconfig
mips                          rm200_defconfig
mips                     loongson2k_defconfig
mips                        qi_lb60_defconfig
mips                        omega2p_defconfig
powerpc                          allmodconfig
powerpc                       ebony_defconfig
arm                          pxa168_defconfig
arm                     am200epdkit_defconfig
arm                       spear13xx_defconfig
arm                         socfpga_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220619
hexagon              randconfig-r045-20220619

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
