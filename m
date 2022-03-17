Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5E4DCF41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiCQUZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiCQUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:25:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68427147532
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548648; x=1679084648;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bBqxH2o+6vy4e8xCS1wgRFv9jq8P82W8KTp3gRjbtRc=;
  b=Q2F6hnorONX574Qxc2sz2BVW77/yBqH03BbgjsB5n+ijImdh0XDJ3DQ7
   V4THkQn3Kwst43KPvOhVc56rLfshTiW8bpfVnJ6OadXeDUqvVeHGQ97Rs
   g30Hdmq2NQXk13C5nxH+NwVz0+XHGdR93/pEE8gb4mQo20v5LonttZ09/
   Bk+UavJ0nH2qUMSCtPxgIz+nAK1rVQ2z6C710wtijwX9Tk3dDTHE2nCFa
   ehRRX9rC1RDXiwW/PMLkPsbpTDSjysjfhmDAZZCEv/0A4E8avHbX2mPi9
   0pPIVEQCYMihpRSX3yAqLoXixBGQkn1bonPpTHsSwmVBR4rSbNfCHAMtf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256923411"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="256923411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="691070385"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2022 13:24:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUwfF-000E1F-Oe; Thu, 17 Mar 2022 20:24:05 +0000
Date:   Fri, 18 Mar 2022 04:23:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.15a] BUILD SUCCESS
 cfe8ffdf72f3e8288efd67700e55a90bec9487ee
Message-ID: <623398c3.RZ3k4t0z9EXDLEW8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.15a
branch HEAD: cfe8ffdf72f3e8288efd67700e55a90bec9487ee  srcu: Drop needless initialization of sdp in srcu_gp_start()

elapsed time: 2539m

configs tested: 257
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220314
mips                 randconfig-c004-20220314
powerpc              randconfig-c003-20220313
powerpc                 mpc834x_itx_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
m68k                         apollo_defconfig
sh                        edosk7760_defconfig
powerpc64                           defconfig
mips                  decstation_64_defconfig
powerpc                  storcenter_defconfig
sh                           sh2007_defconfig
sh                         apsh4a3a_defconfig
sh                           se7780_defconfig
alpha                            alldefconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
sh                          landisk_defconfig
powerpc                    amigaone_defconfig
h8300                            alldefconfig
sh                          rsk7201_defconfig
s390                          debug_defconfig
arm                         lubbock_defconfig
powerpc                 canyonlands_defconfig
xtensa                  cadence_csp_defconfig
powerpc                         wii_defconfig
arm                         nhk8815_defconfig
ia64                      gensparse_defconfig
sh                        sh7785lcr_defconfig
arm                        oxnas_v6_defconfig
powerpc                     tqm8541_defconfig
m68k                        mvme16x_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
h8300                            allyesconfig
um                           x86_64_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                           alldefconfig
sh                         ecovec24_defconfig
arm                      jornada720_defconfig
arm                         axm55xx_defconfig
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arm                          pxa910_defconfig
powerpc                     rainier_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
xtensa                           alldefconfig
sh                              ul2_defconfig
sh                ecovec24-romimage_defconfig
sparc                            alldefconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
arm                           sama5_defconfig
m68k                          atari_defconfig
arm                         at91_dt_defconfig
powerpc                      arches_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
m68k                        m5272c3_defconfig
sh                         ap325rxa_defconfig
xtensa                    xip_kc705_defconfig
sh                          sdk7786_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                          iss_defconfig
h8300                       h8s-sim_defconfig
arm64                            alldefconfig
mips                          rb532_defconfig
arc                      axs103_smp_defconfig
m68k                       bvme6000_defconfig
parisc64                            defconfig
arm                           sunxi_defconfig
arm                        trizeps4_defconfig
arm                        multi_v7_defconfig
mips                           jazz_defconfig
arc                              alldefconfig
openrisc                 simple_smp_defconfig
sh                   secureedge5410_defconfig
sh                             shx3_defconfig
arm                        clps711x_defconfig
m68k                       m5208evb_defconfig
riscv                               defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
arm                        realview_defconfig
h8300                               defconfig
arm                         vf610m4_defconfig
parisc                generic-32bit_defconfig
powerpc                      pasemi_defconfig
powerpc                      mgcoge_defconfig
sh                            titan_defconfig
powerpc                     sequoia_defconfig
mips                         tb0226_defconfig
arm                         assabet_defconfig
arm                          badge4_defconfig
sh                          sdk7780_defconfig
arm                           stm32_defconfig
arm                        cerfcube_defconfig
sh                        dreamcast_defconfig
powerpc                     pq2fads_defconfig
sh                        sh7763rdp_defconfig
sh                     sh7710voipgw_defconfig
mips                           ci20_defconfig
m68k                            q40_defconfig
mips                     decstation_defconfig
mips                           xway_defconfig
sh                            migor_defconfig
sh                          r7785rp_defconfig
xtensa                       common_defconfig
powerpc                      makalu_defconfig
powerpc                    adder875_defconfig
arm                           tegra_defconfig
mips                         cobalt_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220314
arc                  randconfig-r043-20220317
riscv                randconfig-r042-20220317
s390                 randconfig-r044-20220317
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
arm                  randconfig-c002-20220317
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
powerpc                     pseries_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_mds_defconfig
mips                      maltaaprp_defconfig
mips                            e55_defconfig
mips                     loongson2k_defconfig
arm                           sama7_defconfig
mips                          ath79_defconfig
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8560_ads_defconfig
hexagon                          alldefconfig
arm                        neponset_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                      pxa255-idp_defconfig
powerpc                     ppa8548_defconfig
powerpc                      pmac32_defconfig
powerpc                     kilauea_defconfig
mips                        omega2p_defconfig
mips                           mtx1_defconfig
mips                        maltaup_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
hexagon              randconfig-r041-20220317
hexagon              randconfig-r045-20220317
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
