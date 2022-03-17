Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC374DCF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiCQU00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCQU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:26:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8814926E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548708; x=1679084708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6Yl7vNq9YZB6KB1biDoz+lSKisLZMPeMBtnzJjGgqR4=;
  b=gbftK3aed6i1sd+J5P+ONrml+4bRTxxr+84aBm+87UoQ3MbUIYD8Ueix
   JcKANJ5rlU0fXPG5yRZjU1KFBiUNKUdDFdgg/yVHs7YbZEmzkI3sWVjhv
   3TJv3dvch8fg0HDKngtGKfbtr1x7drtJchIwhrsVwh3bvTXm6CGMcR8KT
   wMUCgSzHbky1x91KZnBsnbQO+W7ndQN+4HaktEoKc2vt0Z/STCXlLBpQK
   mPbd0hdnI6enL1eUZXRcLbNPCFT02OyWURlPIMRwsmwoX4yHV7SvS1zZ8
   /df6I3517Hh8wArr9X1iaHY6BibOxdWCs9PWSrwE0VZf/Xtred6fQ3adg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254531351"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="254531351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="715183308"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 13:25:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUwgD-000E2I-UB; Thu, 17 Mar 2022 20:25:05 +0000
Date:   Fri, 18 Mar 2022 04:24:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 82c20a7b207d88e8c6c24f8a6179d6a03f72bd8a
Message-ID: <623398e9.p2GdoP32A6GlJZES%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 82c20a7b207d88e8c6c24f8a6179d6a03f72bd8a  Merge branch into tip/master: 'x86/cleanups'

elapsed time: 733m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
m68k                          atari_defconfig
mips                           gcw0_defconfig
sh                               alldefconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
powerpc                     asp8347_defconfig
powerpc                      pasemi_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc837x_rdb_defconfig
sparc                       sparc64_defconfig
xtensa                       common_defconfig
sh                        sh7785lcr_defconfig
nios2                         3c120_defconfig
openrisc                            defconfig
xtensa                          iss_defconfig
m68k                            q40_defconfig
sh                            migor_defconfig
mips                     decstation_defconfig
mips                           xway_defconfig
arm                  randconfig-c002-20220317
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
sparc                               defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
riscv                randconfig-r042-20220317
arc                  randconfig-r043-20220317
s390                 randconfig-r044-20220317
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
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                       imx_v4_v5_defconfig
arm                       aspeed_g4_defconfig
powerpc                          g5_defconfig
arm                         lpc32xx_defconfig
powerpc                   microwatt_defconfig
powerpc                     tqm8560_defconfig
arm                          ixp4xx_defconfig
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220317

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
