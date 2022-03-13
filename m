Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A104D7219
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiCMBaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiCMBay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:30:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E0F58805
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 17:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647134987; x=1678670987;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=by6Fs2eVYKUDLivyWMac/XDDaRZRukPoHT0r4UXiCKk=;
  b=Ett/YZ2EybSBOJ+8kE4hu5h+F+4GzLajnA8P6ShXMh3kLWUe34M1xLp7
   AEeS4es4t+QRYLVdLH4FKDGVvzFs0FVLPA1OZTxu6y2U536TEie3ytXh4
   psjlLHXaGGIMnHGw9i3B1JC5JuV92zxXTp+e9tWAgWwQ8AEEH36SvVnDa
   DuSiDUXwUgJBo79DKVqtWYC/ssKGA/+aJTWjsikdIeuBJAWvbcsvyewJw
   pTuSfKkO0frSH1Z3IzgMenNAI3xNhsqm10Znr6Ja4dXeWzXsBbdXLrG8e
   L1EZRFzc/mg4NlQ9pIY3La5Qdy6ZrbupJp/SPxNLgd1HZphatOgSypJDx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="255783397"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="255783397"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 17:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="713299438"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2022 17:29:46 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTD3J-0008Sd-Au; Sun, 13 Mar 2022 01:29:45 +0000
Date:   Sun, 13 Mar 2022 09:28:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 f8afc9d88e65d189653f363eacc1f3131216ef7c
Message-ID: <622d48d0.Q7E1GroUQQ+ufW8Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: f8afc9d88e65d189653f363eacc1f3131216ef7c  x86/ibt: Fix CC_HAS_IBT check for clang

elapsed time: 722m

configs tested: 151
configs skipped: 41

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
sh                 kfr2r09-romimage_defconfig
m68k                       m5249evb_defconfig
arm                        keystone_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
mips                         bigsur_defconfig
powerpc                    amigaone_defconfig
xtensa                    smp_lx200_defconfig
alpha                            alldefconfig
ia64                      gensparse_defconfig
arm                       imx_v6_v7_defconfig
mips                           xway_defconfig
arc                     nsimosci_hs_defconfig
m68k                         apollo_defconfig
powerpc                  iss476-smp_defconfig
parisc64                         alldefconfig
powerpc                     tqm8548_defconfig
m68k                        m5307c3_defconfig
sh                          lboxre2_defconfig
m68k                          hp300_defconfig
nios2                            alldefconfig
sh                          rsk7269_defconfig
arm                      integrator_defconfig
powerpc                 mpc837x_rdb_defconfig
sparc                            allyesconfig
arm                  randconfig-c002-20220310
arm                  randconfig-c002-20220312
arm                  randconfig-c002-20220313
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220310
arc                  randconfig-r043-20220312
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220313
arm                  randconfig-c002-20220313
powerpc              randconfig-c003-20220313
s390                 randconfig-c005-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220310
x86_64                        randconfig-c007
mips                 randconfig-c004-20220312
riscv                randconfig-c006-20220312
s390                 randconfig-c005-20220310
s390                 randconfig-c005-20220312
arm                  randconfig-c002-20220312
powerpc              randconfig-c003-20220310
i386                          randconfig-c001
riscv                randconfig-c006-20220310
powerpc              randconfig-c003-20220312
arm                  randconfig-c002-20220310
mips                        qi_lb60_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig
mips                          rm200_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
mips                       lemote2f_defconfig
powerpc                      ppc64e_defconfig
mips                        bcm63xx_defconfig
arm                          ep93xx_defconfig
powerpc                       ebony_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313
riscv                randconfig-r042-20220310
s390                 randconfig-r044-20220312
hexagon              randconfig-r045-20220312
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220312
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310
hexagon              randconfig-r041-20220312

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
