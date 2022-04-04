Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA594F1C12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381378AbiDDVW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379008AbiDDQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:18:33 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDBB31922
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649088997; x=1680624997;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RhaIORVqgtJXoKDihME/LCeLAa94zMaiZuSGp63+DmE=;
  b=dBgxGgHiiZIm5pgE9yRNpn3J9WSmUK6XkUH92PHzCMbW69Phdfm/dmKp
   v/pb0QJmMlmYf38Oc2+eorMpbHWBvShtQ4lnUYtd236OsLzz+N1pHIaAX
   gaTpO+dlCMbwI5mk0naz1pt+3kLgjjx40OQU0hfv7RhkjNjI66r1i+flV
   AkwenL/1u0412YZp10ZyxETjrY3qOFS8PzoyyoAppQaX8ghrrkYsCq5zc
   vPAUbGNqjdY/jdEdzNg+EspwSffR4jSqrxgFLYr+smIm0fgIk5ydJngtq
   0TR6VHZdzWMpNk3DWFvl+DTSxhw4T7CRmx1ZOrEdN4jDeIAztjTEFT0nV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="321247707"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="321247707"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523637231"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2022 09:16:20 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbPNL-0002Bt-J6;
        Mon, 04 Apr 2022 16:16:19 +0000
Date:   Tue, 05 Apr 2022 00:15:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 4a5e50667c63697dbbf9099419ce4ac8d376b099
Message-ID: <624b19b1.7YYEzQQXRtDXPsR3%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 4a5e50667c63697dbbf9099419ce4ac8d376b099  tools/include/string: Implement `strdup()` and `strndup()`

elapsed time: 993m

configs tested: 198
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220404
i386                          randconfig-c001
arm                      integrator_defconfig
m68k                            q40_defconfig
nios2                         3c120_defconfig
arm                         vf610m4_defconfig
arm64                            alldefconfig
m68k                       m5475evb_defconfig
arm                     eseries_pxa_defconfig
arm                        realview_defconfig
ia64                            zx1_defconfig
arm                          gemini_defconfig
mips                        vocore2_defconfig
powerpc                           allnoconfig
sh                          rsk7269_defconfig
sh                 kfr2r09-romimage_defconfig
parisc64                         alldefconfig
sh                          rsk7264_defconfig
arm                           sama5_defconfig
powerpc                    klondike_defconfig
sh                        edosk7705_defconfig
m68k                          hp300_defconfig
sh                           se7722_defconfig
arm                           h3600_defconfig
h8300                               defconfig
sh                  sh7785lcr_32bit_defconfig
mips                            ar7_defconfig
mips                  maltasmvp_eva_defconfig
arm                          simpad_defconfig
arm                           stm32_defconfig
parisc                           alldefconfig
alpha                               defconfig
arm                        mvebu_v7_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_itx_defconfig
um                             i386_defconfig
sh                             sh03_defconfig
powerpc                     taishan_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
sh                     sh7710voipgw_defconfig
arm                        oxnas_v6_defconfig
mips                           jazz_defconfig
sh                          polaris_defconfig
powerpc                        cell_defconfig
sh                          rsk7203_defconfig
sh                        sh7763rdp_defconfig
arc                              alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                     ep8248e_defconfig
arc                        nsim_700_defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
sh                          r7785rp_defconfig
sh                            migor_defconfig
xtensa                generic_kc705_defconfig
arm                        spear6xx_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
sh                         ecovec24_defconfig
sh                   sh7770_generic_defconfig
arm                         cm_x300_defconfig
m68k                          sun3x_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
mips                         rt305x_defconfig
mips                    maltaup_xpa_defconfig
powerpc                  iss476-smp_defconfig
mips                         db1xxx_defconfig
arm                           viper_defconfig
mips                           ip32_defconfig
powerpc                     tqm8548_defconfig
sh                           se7206_defconfig
m68k                         apollo_defconfig
sh                         ap325rxa_defconfig
m68k                          amiga_defconfig
sh                           se7705_defconfig
sh                   secureedge5410_defconfig
sh                               j2_defconfig
arm                            lart_defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
arm                            qcom_defconfig
x86_64               randconfig-c001-20220404
arm                  randconfig-c002-20220404
arm                  randconfig-c002-20220403
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
powerpc                          allmodconfig
x86_64               randconfig-a015-20220404
x86_64               randconfig-a011-20220404
x86_64               randconfig-a014-20220404
x86_64               randconfig-a016-20220404
x86_64               randconfig-a012-20220404
x86_64               randconfig-a013-20220404
i386                 randconfig-a014-20220404
i386                 randconfig-a013-20220404
i386                 randconfig-a016-20220404
i386                 randconfig-a015-20220404
i386                 randconfig-a011-20220404
i386                 randconfig-a012-20220404
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220404
s390                 randconfig-r044-20220404
riscv                randconfig-r042-20220404
arc                  randconfig-r043-20220403
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
i386                 randconfig-c001-20220404
x86_64               randconfig-c007-20220404
powerpc              randconfig-c003-20220404
riscv                randconfig-c006-20220404
mips                 randconfig-c004-20220404
arm                  randconfig-c002-20220404
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220403
riscv                randconfig-c006-20220403
mips                 randconfig-c004-20220403
arm                  randconfig-c002-20220403
arm                          ep93xx_defconfig
arm                       netwinder_defconfig
mips                      pic32mzda_defconfig
powerpc                      katmai_defconfig
mips                   sb1250_swarm_defconfig
arm                         socfpga_defconfig
arm                           sama7_defconfig
mips                        workpad_defconfig
arm                          pcm027_defconfig
riscv                             allnoconfig
mips                         tb0219_defconfig
powerpc                   bluestone_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
x86_64               randconfig-a006-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a004-20220404
i386                 randconfig-a006-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a001-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a003-20220404
i386                 randconfig-a005-20220404
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20220403
riscv                randconfig-r042-20220403
hexagon              randconfig-r041-20220403
hexagon              randconfig-r045-20220404
hexagon              randconfig-r041-20220404
s390                 randconfig-r044-20220403

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
