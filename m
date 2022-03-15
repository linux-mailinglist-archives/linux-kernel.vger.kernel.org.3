Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236704DA5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiCOXId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiCOXIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:08:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A845D66E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647385638; x=1678921638;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=97QNbAZCI0YDuGLtJDz/JTelyzLJkHwnXWh/X3GkIGg=;
  b=ZL14o5blYeTAwztxgUYcf1peRNQXuDU+VGKduSlU/kBYSMSSHGOXgDBd
   Il0edGFDJsnjgkpw3fHWLblD8PmB4/QnH1BZTGjuksV1hVnuxFhwyhod0
   C6zRpmUzHySIyBBAZTJPfQeepDVkJfPSzgGO5J8LEYTnbzYVkIatcnN2g
   bJzTUyve9S6NKS7KINcPj+sxl2L76AcaJFBqVAoa/SXsXZi4RyZwgWMSx
   1wsTFh3BqoOlbCaYLLzV5b8CruHIu8c743he/DyGwB+gO93d6kwHYK+DB
   nidmLlpNPEWhSpXlOp7QWEsTZs/upBrqeq+mCMY+zBJzgQl91tLLcwP+f
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256393676"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256393676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 16:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="714364019"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 16:07:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUGG4-000BcN-LK; Tue, 15 Mar 2022 23:07:16 +0000
Date:   Wed, 16 Mar 2022 07:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 a7b2553b5ece1aba4b5994eef150d0a1269b5805
Message-ID: <62311c0a.LGAAkYDx7g+dhIuT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: a7b2553b5ece1aba4b5994eef150d0a1269b5805  sched/headers: Only include <linux/entry-common.h> when CONFIG_GENERIC_ENTRY=y

elapsed time: 728m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                             pxa_defconfig
arc                         haps_hs_defconfig
h8300                    h8300h-sim_defconfig
arm                        realview_defconfig
mips                         mpc30x_defconfig
xtensa                  cadence_csp_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          rsk7269_defconfig
arm                  randconfig-c002-20220314
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220314
x86_64               randconfig-a001-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a005-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a005-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a006-20220314
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                   milbeaut_m10v_defconfig
powerpc                       ebony_defconfig
x86_64               randconfig-a011-20220314
x86_64               randconfig-a014-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220313
hexagon              randconfig-r045-20220313

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
