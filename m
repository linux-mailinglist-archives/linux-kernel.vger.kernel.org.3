Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29A054A0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351574AbiFMVAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351500AbiFMU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:57:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9496BCAC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655152381; x=1686688381;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Hgo8K21MzN+LWBGiA7mxFtkgEbgnEMtdd3J3tPjhRyI=;
  b=BztTTTLEr4+NAB5sVPOb04f2TnsmTZkXwZ1wPeerBV3J5VnPFpUlftyA
   UxNm3MRyfYLQi7Td7viBzFppM0IY9otuyTHDaL7/Nsuqin7fVHxMIHrt0
   MXXiK2WJxP5BHw+YqsfPnS+5KEUWGwjjSn/wnIUdF4jEVNM/AF/V9tPpx
   xNSIOTQtRFGgoxjhkvTBXwjyyLkmZDT7mCa7vYZPa2HHLEnSG+NsrZk5C
   Hz3L1jRnJk9iluCzpagMnoFDuEv/D8r6cPdMnp74jION+HNe1YvQ2onK4
   F3ptHFM8Qoo6p2I+7Via1JWJnxovOCWP0pNzWQJ6xWVqpF5VtZ+UiJD+r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340074743"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="340074743"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 13:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="587988857"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 13:33:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0qk7-000L7N-Di;
        Mon, 13 Jun 2022 20:32:59 +0000
Date:   Tue, 14 Jun 2022 04:32:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 04193d590b390ec7a0592630f46d559ec6564ba1
Message-ID: <62a79ecd.p6HXtZFWe1pAS4Xb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: 04193d590b390ec7a0592630f46d559ec6564ba1  sched: Fix balance_push() vs __sched_setscheduler()

elapsed time: 725m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220613
arm                        trizeps4_defconfig
arm                       aspeed_g5_defconfig
arm                            mps2_defconfig
sh                        edosk7705_defconfig
sh                         apsh4a3a_defconfig
arm                           h3600_defconfig
powerpc                     mpc83xx_defconfig
mips                          rb532_defconfig
powerpc                         ps3_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8555_defconfig
powerpc                      cm5200_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
mips                     loongson1b_defconfig
openrisc                         alldefconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
x86_64               randconfig-k001-20220613
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
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
x86_64               randconfig-a012-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a013-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a015-20220613
x86_64               randconfig-a014-20220613
i386                 randconfig-a012-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
s390                 randconfig-r044-20220613
riscv                randconfig-r042-20220613
arc                  randconfig-r043-20220613
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
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
mips                           mtx1_defconfig
x86_64               randconfig-a003-20220613
x86_64               randconfig-a006-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a006-20220613
i386                 randconfig-a005-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
