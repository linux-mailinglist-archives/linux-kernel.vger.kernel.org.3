Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA453B008
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiFAVX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiFAVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:23:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F59FD36A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654118602; x=1685654602;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qqXXJZxA1OPvzuoIIdvgAuGIwUNw9Up57kBV/hKB1aE=;
  b=Ulbxaf2Gqh0hQsBvPtAtDYP2rjKlC6v6BKPvfL6EIF324H5Qfs2azOh2
   nRp5C5CpoUEAvEUEVfl9yM17BBs2KoElSWqo8fznh+8IxpdTXrdsScPjy
   v7ZqlG0Ux+9Xzm4/+UOSJT5lEdFxNwVh/ADioRSIt/lmVGd2iGs5pygw9
   k1Moc/h2qFuE8Era3sz8zMFTxqFTUVqA5dzOjs2xu9z+YJ7ZQxNTbCxXl
   KYnZMZIuCe0/TSCI9b6YBP4OvMeilgwK0LNZxBitEg5050vBgM3grzvej
   lSUx8X8iNGFvOHe2gGhHgFUQTT/s8S8KBXlo7lhdcX0HIgqYutrradXeS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="263371138"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="263371138"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 14:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="552511071"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2022 14:23:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwVoG-0004Pq-74;
        Wed, 01 Jun 2022 21:23:20 +0000
Date:   Thu, 02 Jun 2022 05:22:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f3c3debf7700103a83b222d2a4b5ea0f8035f3a5
Message-ID: <6297d89c.yHPT5HR3CN0d3N9q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f3c3debf7700103a83b222d2a4b5ea0f8035f3a5  Merge branch 'x86/microcode'

elapsed time: 725m

configs tested: 85
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                    adder875_defconfig
ia64                        generic_defconfig
xtensa                    xip_kc705_defconfig
ia64                            zx1_defconfig
ia64                         bigsur_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        dreamcast_defconfig
parisc                generic-64bit_defconfig
sh                          kfr2r09_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
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
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220601
s390                 randconfig-r044-20220601
riscv                randconfig-r042-20220601
hexagon              randconfig-r041-20220601

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
