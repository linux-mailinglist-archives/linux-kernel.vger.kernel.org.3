Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538484E33E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiCUXK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCUXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF935DA43
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647903425; x=1679439425;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ASzCyi624QF/09QSYp+je5al7Z9rJWt4vVrkPEb+xFE=;
  b=CRJexEmBH+BXXiup3P70FHVq1CcMEEat1nEweNebl9i2SmgZzlEXd5FO
   tMfgqQDNdzeGQ4LEeWUQcuR0b4jouge7UmagylS6AjW5vSxI6rXQuA/PS
   6AKO/YJuOH9k8j0AxVGFFWxl79+tJOAcrbEa2DGmkGWt6krUuxsGL7M9u
   c0KRVGd+rbhVxO1C8Px5iIwKLq1dmVdche+mW25rTfrpvr0N2f3womYlo
   dxrBbsLgDyOa5Xv1s5xRXJO800L56wXqqnjMrY3b3cwigW7Jto1NQgiRC
   yvcXVcdygZBFxqApq3fw8kApgDHkQpRBBBRKK2zzKtZwRE3xMgpAiZTKR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="255226792"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="255226792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 15:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="518616320"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 15:36:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWQdy-000IDp-Cw; Mon, 21 Mar 2022 22:36:54 +0000
Date:   Tue, 22 Mar 2022 06:36:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c5ce7fd2592464ff5da46d8b9b7581411eab0a80
Message-ID: <6238fdf4.EknTgDDTgJ1lbJ0K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c5ce7fd2592464ff5da46d8b9b7581411eab0a80  Merge branch into tip/master: 'core/core'

elapsed time: 730m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220321
arm                          lpd270_defconfig
sh                         ecovec24_defconfig
sh                             sh03_defconfig
ia64                        generic_defconfig
sh                          urquell_defconfig
xtensa                           alldefconfig
arm                          exynos_defconfig
m68k                        mvme16x_defconfig
powerpc                       holly_defconfig
m68k                        m5272c3_defconfig
powerpc                      pasemi_defconfig
arm                  randconfig-c002-20220321
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
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
sparc                               defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a013-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a016-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a015-20220321
i386                 randconfig-a011-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a016-20220321
arc                  randconfig-r043-20220320
riscv                randconfig-r042-20220321
s390                 randconfig-r044-20220321
arc                  randconfig-r043-20220321
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
hexagon                             defconfig
powerpc                      acadia_defconfig
mips                     loongson1c_defconfig
arm                       netwinder_defconfig
mips                         tb0287_defconfig
arm                      tct_hammer_defconfig
x86_64               randconfig-a002-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a001-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a002-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a006-20220321
hexagon              randconfig-r041-20220321
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220320
s390                 randconfig-r044-20220320
riscv                randconfig-r042-20220320

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
