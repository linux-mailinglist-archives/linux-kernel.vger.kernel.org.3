Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72444F44DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352995AbiDEUPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356164AbiDEKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:23:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00800BA332
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649153236; x=1680689236;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=b0DuVQISzMfQ1sFhGZdaekf0nUHMMfZDKdnN+10n/QI=;
  b=nyB0M+aJ3ZdZ6JPkYtMgDWPH+TU1djPoYa9cJIzUAc8hoX0MOkahXuJC
   Zyf5nOFfELJMiSiSTNJWmAMYprzMOQbHZqrBab0hAd+GIOUzpd2/zLZvO
   8jDItr9hNtyVHCq8K2O8PtP2wPn1xU0GoByHHI2dadVk/7wpSf0Kd2k9Y
   XoC2mKztDqPReQ4sWzuCPymtdYn8oFkwKsgTHBtf1HaVFsorsS1/rAKza
   gHsV8LL33zL12KR2kFK/O6usTDmYwncMLd9G8bkFShz+Cn206vIugk5YK
   WglVRhmBBvI3Io1ZiBQVwmdYtmYlAb48vqY3oyXkalN9Bk1HnmtBohvrP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260701852"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260701852"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569817014"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2022 03:06:57 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbg5R-00031W-8i;
        Tue, 05 Apr 2022 10:06:57 +0000
Date:   Tue, 05 Apr 2022 18:06:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 944fad4583bc8a6d7dd80fbe39db50141da95793
Message-ID: <624c14a6.fBp+hKjyxFQj1pAh%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 944fad4583bc8a6d7dd80fbe39db50141da95793  x86/fault: Cast an argument to the proper address space in prefetch()

elapsed time: 880m

configs tested: 107
configs skipped: 98

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-c001
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                         at91_dt_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
arm                       imx_v6_v7_defconfig
arc                        vdk_hs38_defconfig
sh                           se7751_defconfig
m68k                       m5475evb_defconfig
sh                          sdk7786_defconfig
powerpc                        cell_defconfig
powerpc                      chrp32_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc837x_mds_defconfig
arc                           tb10x_defconfig
mips                       capcella_defconfig
mips                     loongson1b_defconfig
arm                          pxa910_defconfig
openrisc                  or1klitex_defconfig
mips                           jazz_defconfig
sh                ecovec24-romimage_defconfig
sh                     magicpanelr2_defconfig
sh                        edosk7760_defconfig
powerpc                     stx_gp3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220405
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
sparc                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220405
riscv                randconfig-c006-20220405
mips                 randconfig-c004-20220405
arm                  randconfig-c002-20220405
arm                  colibri_pxa300_defconfig
mips                     loongson1c_defconfig
arm                        neponset_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
