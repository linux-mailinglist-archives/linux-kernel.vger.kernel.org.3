Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430864FB0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiDJWzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiDJWzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:55:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2D62C2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649631214; x=1681167214;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2FwjpQ8cfbqZC0gQ4OfrnYHX5nbA+VLZWLak64Z6qk4=;
  b=Zbtm7Db/9QM5B88Mf4btCm+yLt36RIltR4MHM/nG3eqwEG0MGXRhMJWP
   LEIzag2ApLELTvHvxorAxntKSLrt8HfOyewucScBmteD8jLgjD0np7ycp
   GpXUnT2rCVnXVxd2/LjaWeXjfPmfpcWYCNWzjHJTzBxCknSMWs0A4Hyqu
   JKbTaWGdLrAQP76EzV2DHgKDO6K0M30FFdAtQrtcPV1JeWy3Kj5sFKJps
   Z24R3Jmy1udc07BJU/yn8zACXRde1wge8YR29G9R9BYm4mZRk7hk/s49v
   Y87w+/A7Tgjr61NBTaBv3sy5QrJXdhuIlMHSaa4QombvdEDJZRU7T2wcZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322444270"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="322444270"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 15:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="525732302"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2022 15:53:33 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndgR2-0001AF-EJ;
        Sun, 10 Apr 2022 22:53:32 +0000
Date:   Mon, 11 Apr 2022 06:52:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 9c95bc25ad3b1a2240cd1f896569292a57d3ce85
Message-ID: <62535fc1.YaNKXEe1LjxyJgQQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 9c95bc25ad3b1a2240cd1f896569292a57d3ce85  tick/sched: Fix non-kernel-doc comment

elapsed time: 725m

configs tested: 184
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
powerpc              randconfig-c003-20220410
m68k                             allyesconfig
sh                          landisk_defconfig
sh                         ap325rxa_defconfig
parisc                generic-32bit_defconfig
powerpc                 canyonlands_defconfig
sh                        sh7763rdp_defconfig
powerpc                   currituck_defconfig
xtensa                         virt_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc8540_ads_defconfig
nios2                            alldefconfig
sh                           sh2007_defconfig
ia64                         bigsur_defconfig
mips                        vocore2_defconfig
xtensa                  audio_kc705_defconfig
m68k                         apollo_defconfig
powerpc                    adder875_defconfig
arm                           imxrt_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      chrp32_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc834x_mds_defconfig
arc                     nsimosci_hs_defconfig
arm                            zeus_defconfig
alpha                            allyesconfig
s390                                defconfig
powerpc                   motionpro_defconfig
arm                          badge4_defconfig
sh                          r7780mp_defconfig
sh                            migor_defconfig
powerpc                      ppc40x_defconfig
sparc                               defconfig
powerpc                           allnoconfig
powerpc                      tqm8xx_defconfig
mips                             allmodconfig
sparc                       sparc64_defconfig
arm                        oxnas_v6_defconfig
sh                   sh7724_generic_defconfig
arm                           h3600_defconfig
arm                       multi_v4t_defconfig
arm                          pxa910_defconfig
arc                    vdk_hs38_smp_defconfig
mips                         tb0226_defconfig
sh                          sdk7786_defconfig
sparc64                          alldefconfig
powerpc                     tqm8541_defconfig
mips                       capcella_defconfig
nios2                               defconfig
m68k                        mvme16x_defconfig
xtensa                          iss_defconfig
mips                  maltasmvp_eva_defconfig
h8300                            allyesconfig
m68k                       m5275evb_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                    smp_lx200_defconfig
sh                           se7619_defconfig
mips                             allyesconfig
sh                            hp6xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220410
arm                  randconfig-c002-20220411
i386                 randconfig-c001-20220411
x86_64               randconfig-c001-20220411
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
arc                              allyesconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arc                  randconfig-r043-20220410
riscv                               defconfig
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
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220410
arm                  randconfig-c002-20220410
i386                          randconfig-c001
riscv                randconfig-c006-20220410
mips                 randconfig-c004-20220410
powerpc                 mpc8313_rdb_defconfig
powerpc                     kmeter1_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig
mips                     loongson1c_defconfig
mips                        qi_lb60_defconfig
arm                          imote2_defconfig
s390                             alldefconfig
arm                       netwinder_defconfig
arm                      pxa255-idp_defconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
arm                         bcm2835_defconfig
powerpc                        icon_defconfig
mips                         tb0287_defconfig
powerpc                     mpc512x_defconfig
mips                     cu1000-neo_defconfig
arm                       imx_v4_v5_defconfig
arm                          moxart_defconfig
mips                   sb1250_swarm_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
riscv                randconfig-r042-20220410
hexagon              randconfig-r041-20220411
hexagon              randconfig-r041-20220410
hexagon              randconfig-r045-20220411
hexagon              randconfig-r045-20220410
s390                 randconfig-r044-20220410

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
