Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1956855097F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiFSJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFSJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:27:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916849FEA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655630874; x=1687166874;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9Dr2ehPqL2ccjUPS48zqtWrMeuho8whAGez4/2iaxs4=;
  b=feMgz5NyGkvTbn6FF21X5r5qgVVgYKI8rdh7msdfCCmAnClXrkWNNGUY
   y7rNtG8VmKqTdZjy2wtqJ7zPYAMTFLG/E/BA5jYpDiIupivcqNgwVwf9P
   p1CxYv1x4GkcFbAkuWV39ELAXDR65Lag/T953VtW5OCxpiPIzJxdgUJ8h
   ZBtF0ReMucdWL2mPUy1jEfChaiCn+maT1Hfw/vs66yL9yiOrLAPxPMGr8
   FKjw0Oz96zt2P5ev7+Qq9Lr/ej+92mMX4fa2RyWtb03OdQbEtFhJij2CY
   T5G1b3j120F5xfJZPjzO9ko4oy4pou+R1rPNiZD4/Ud6hYk97mzSC0F2G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305148431"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305148431"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 02:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642669281"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2022 02:27:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2rDk-000R4b-D4;
        Sun, 19 Jun 2022 09:27:52 +0000
Date:   Sun, 19 Jun 2022 17:27:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:nocb-test.2022.06.16a] BUILD SUCCESS
 91927caa81e8438976a4e2fd1cc3d598f07599c7
Message-ID: <62aeebee.s6va5l/AwWYcexZC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git nocb-test.2022.06.16a
branch HEAD: 91927caa81e8438976a4e2fd1cc3d598f07599c7  rcu/nocb: Avoid polling when my_rdp->nocb_head_rdp list is empty

elapsed time: 2347m

configs tested: 200
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
s390                       zfcpdump_defconfig
sh                           se7751_defconfig
sh                            migor_defconfig
mips                            gpr_defconfig
arm                         axm55xx_defconfig
powerpc                  storcenter_defconfig
mips                           xway_defconfig
openrisc                  or1klitex_defconfig
powerpc                    adder875_defconfig
sh                           se7724_defconfig
x86_64                              defconfig
powerpc                         ps3_defconfig
sh                          r7780mp_defconfig
sh                           sh2007_defconfig
arm                         assabet_defconfig
alpha                            alldefconfig
arm                          pxa910_defconfig
arm                            mps2_defconfig
mips                             allyesconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
m68k                          amiga_defconfig
arm                         at91_dt_defconfig
arc                           tb10x_defconfig
arm                        cerfcube_defconfig
powerpc                        cell_defconfig
sh                          sdk7780_defconfig
mips                    maltaup_xpa_defconfig
parisc                generic-64bit_defconfig
sh                            titan_defconfig
mips                           ip32_defconfig
xtensa                              defconfig
um                             i386_defconfig
powerpc                         wii_defconfig
sh                              ul2_defconfig
nios2                            alldefconfig
xtensa                         virt_defconfig
powerpc                     pq2fads_defconfig
m68k                            mac_defconfig
arm                           sunxi_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
arm                            qcom_defconfig
arm                      jornada720_defconfig
m68k                        mvme147_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                       maple_defconfig
m68k                          hp300_defconfig
powerpc                       eiger_defconfig
arm                            pleb_defconfig
mips                     loongson1b_defconfig
arc                        vdk_hs38_defconfig
powerpc                      ep88xc_defconfig
parisc64                         alldefconfig
mips                     decstation_defconfig
arm                        trizeps4_defconfig
powerpc                  iss476-smp_defconfig
xtensa                  cadence_csp_defconfig
arm                     eseries_pxa_defconfig
powerpc                      arches_defconfig
xtensa                  audio_kc705_defconfig
arm                            zeus_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
powerpc                       holly_defconfig
powerpc                     tqm8541_defconfig
m68k                          multi_defconfig
powerpc                        warp_defconfig
m68k                           sun3_defconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
sh                               alldefconfig
openrisc                            defconfig
arc                      axs103_smp_defconfig
m68k                         amcore_defconfig
mips                      maltasmvp_defconfig
riscv                               defconfig
mips                  decstation_64_defconfig
xtensa                generic_kc705_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
csky                             alldefconfig
sh                        sh7763rdp_defconfig
m68k                       m5249evb_defconfig
m68k                             alldefconfig
ia64                            zx1_defconfig
m68k                       m5208evb_defconfig
powerpc                           allnoconfig
parisc                              defconfig
ia64                                defconfig
sh                            shmin_defconfig
m68k                          atari_defconfig
nios2                            allyesconfig
nios2                         10m50_defconfig
x86_64                           alldefconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220617
arm                  randconfig-c002-20220619
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
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
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                randconfig-r042-20220619
arc                  randconfig-r043-20220619
s390                 randconfig-r044-20220619
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                          pcm027_defconfig
powerpc                    gamecube_defconfig
arm                       spear13xx_defconfig
powerpc                     tqm8560_defconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc8272_ads_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
mips                      maltaaprp_defconfig
arm                                 defconfig
powerpc                       ebony_defconfig
arm                             mxs_defconfig
arm                        multi_v5_defconfig
arm                      pxa255-idp_defconfig
mips                        bcm63xx_defconfig
arm                           spitz_defconfig
arm                        neponset_defconfig
s390                             alldefconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                         s3c2410_defconfig
arm                            mmp2_defconfig
powerpc                     mpc512x_defconfig
mips                        omega2p_defconfig
powerpc                          allmodconfig
arm                          pxa168_defconfig
arm                     am200epdkit_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc8313_rdb_defconfig
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
hexagon              randconfig-r041-20220617
hexagon              randconfig-r045-20220617

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
