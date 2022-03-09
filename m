Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7D4D27E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCIENz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCIENu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:13:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31A71AF08
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646799172; x=1678335172;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=a08AIyK3NIUIthi3wtzZgD1FDl766HkzRqnDsmiWnnQ=;
  b=AL2qV1rgt/t94FioRCiiuEQxdMMT+NXYe+BHHyUmveU0NG7YMSnl7+SA
   E4EIMSUXusZI7Sv2Zls/75jVRicNc8j5SmARTEnApI17llVexvaycfs8t
   TYOpDDX132aYXlV6f9uiDI2UwBd/AWe3P9ngECDksgnA7qDkWusejR/Ms
   XrHI1XNbARIoS/EP/oAXwLZa0kSdUnXPpOjP3QCXR4Yk+I9KS0LQt0rQR
   XbQfrnKJrmno2qUBjhla8kGx8393VgnL1HsJ2/+xsdp8XTuEEqaGGO+8q
   Z8wYkdAdxjABfPJO+K3EtwsSjApBZcT6Pl2hhVoBGhPyHYt9CUcsuG1/r
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254821790"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="254821790"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 20:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="711793278"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 20:12:50 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRngv-0002Xz-Vz; Wed, 09 Mar 2022 04:12:49 +0000
Date:   Wed, 09 Mar 2022 12:12:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 5adf349439d29f92467e864f728dfc23180f3ef9
Message-ID: <62282926.ZV4Td9kF9FPYAshK%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 5adf349439d29f92467e864f728dfc23180f3ef9  x86/module: Fix the paravirt vs alternative order

elapsed time: 738m

configs tested: 114
configs skipped: 80

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                       m5208evb_defconfig
arm                       aspeed_g5_defconfig
m68k                        mvme147_defconfig
arm                            zeus_defconfig
powerpc                         wii_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                  storcenter_defconfig
arm                         vf610m4_defconfig
sh                        sh7757lcr_defconfig
sh                ecovec24-romimage_defconfig
alpha                               defconfig
s390                          debug_defconfig
ia64                                defconfig
arm                        shmobile_defconfig
arm                            hisi_defconfig
arm                          pxa3xx_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7721_defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220309
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                  randconfig-r043-20220308
riscv                randconfig-r042-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220308
powerpc              randconfig-c003-20220308
i386                          randconfig-c001
arm                  randconfig-c002-20220308
mips                 randconfig-c004-20220308
mips                        workpad_defconfig
mips                       lemote2f_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
arm                           spitz_defconfig
x86_64                           allyesconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc8272_ads_defconfig
arm                       spear13xx_defconfig
powerpc                      walnut_defconfig
arm                          pcm027_defconfig
arm                          imote2_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
