Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53C507F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359235AbiDTDUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiDTDUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:20:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C112AF2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650424681; x=1681960681;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rfdxw0Hk/HN40rYPoecaHd+ugnHIaANA/T0syfvG8I8=;
  b=El3e6nQ8ZIfLzNo4vIsaoqRuI3ikgOsHjwc70OQO8Som6ECGKZR1g/6E
   Hcw3N24hxSYoIMK4WYNf/IHeRjENGEXQ8btvzqqvZiXvApADFwSYFdhL1
   KqCyABWkcCe+CGQ4uecmIYNFVKKy4W2hdgtX6Ll1d5khahKCMG0DIyB93
   339yNi9QtZP+8GrbVSkNL6WoSUKtcCooZRg4d1PGPwlHq6smtzqormz/8
   dJyiJmsjipfGiYOAIVwyyIkV9EcBqLqBH2OOf4My9SUTgUSofGatc1S1c
   FKO5+2kvH52QYIxajIRV8MWovK9F11YY/Coa54Udgt7GVmC3Qz5J0ZbSd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="264098261"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="264098261"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 20:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="727316428"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2022 20:17:59 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh0qt-0006Vg-6t;
        Wed, 20 Apr 2022 03:17:59 +0000
Date:   Wed, 20 Apr 2022 11:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 51964015565d302fda63ce84ef151e1c9a5939cc
Message-ID: <625f7b33.1E2Xe10hwdSKNw8Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 51964015565d302fda63ce84ef151e1c9a5939cc  x86/mm: Fix spacing within memory encryption features message

elapsed time: 723m

configs tested: 112
configs skipped: 94

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                       eiger_defconfig
nios2                         10m50_defconfig
arm                          pxa910_defconfig
sh                            hp6xx_defconfig
powerpc                 linkstation_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      pcm030_defconfig
ia64                             alldefconfig
powerpc                     redwood_defconfig
sh                           se7343_defconfig
mips                           jazz_defconfig
arc                           tb10x_defconfig
arm                          gemini_defconfig
mips                         cobalt_defconfig
sh                            titan_defconfig
sh                             shx3_defconfig
sh                        sh7757lcr_defconfig
arm                      footbridge_defconfig
sh                        apsh4ad0a_defconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
h8300                       h8s-sim_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220419
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
nios2                               defconfig
arc                              allyesconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20220419
arc                  randconfig-r043-20220419
s390                 randconfig-r044-20220419
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
powerpc              randconfig-c003-20220419
arm                  randconfig-c002-20220419
i386                          randconfig-c001
riscv                randconfig-c006-20220419
mips                 randconfig-c004-20220419
s390                 randconfig-c005-20220419
arm                       netwinder_defconfig
arm                     davinci_all_defconfig
mips                           ip28_defconfig
mips                       lemote2f_defconfig
powerpc                     tqm5200_defconfig
powerpc                     kilauea_defconfig
arm                           spitz_defconfig
powerpc                      ppc64e_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
