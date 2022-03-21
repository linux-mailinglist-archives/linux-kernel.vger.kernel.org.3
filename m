Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD74E33CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiCUXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiCUW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:58:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58637463017
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647902217; x=1679438217;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0JBihKTrWugKzWMubuHFtCHqpF89FsyT6aX7ZFVtkaI=;
  b=LUCTEueIbkG1giPl33cKti3WIlD7+TDrivtqzLoZRLjtaMwETCphNxct
   H0wckFdnbSO4FSjZ5Fzjjq+bj6BPAFMknBjN5j/Uz+BKEqTPgsdbQwsgh
   Iyrrjua8+mHRXuATfZ/1UlcSrMnBbAKtQyO9HRn7WkOL3RkSP2M1SM0rt
   Li0PVMPm00ZfXWm9LfxdnQT/SPaiHDj/Z/zli1lKj8laxA/71L1Ve6OS+
   MpFzBbjG8RwtXe6kIakwjNm8IvXsBoBoVcUeNsOUeZSa2pfakjRBgeUd5
   3h0WXBw/S1KfIXfbtZJTJCe5O9Tvv3GEuCVQn5e0E+3HlO7iODf31gBiG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="320866608"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="320866608"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 15:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="560073008"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2022 15:36:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWQdy-000IDl-Bo; Mon, 21 Mar 2022 22:36:54 +0000
Date:   Tue, 22 Mar 2022 06:36:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 3387ce4d8a5f2956fab827edf499fe6780e83faa
Message-ID: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 3387ce4d8a5f2956fab827edf499fe6780e83faa  headers/prep: Fix header to build standalone: <linux/psi.h>

elapsed time: 730m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220321
arm                         cm_x300_defconfig
sh                             sh03_defconfig
mips                      maltasmvp_defconfig
sh                        sh7763rdp_defconfig
arm                           h3600_defconfig
arm                       aspeed_g5_defconfig
sh                      rts7751r2d1_defconfig
sh                        edosk7760_defconfig
arc                        nsimosci_defconfig
sh                          rsk7201_defconfig
h8300                     edosk2674_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                         microdev_defconfig
sh                              ul2_defconfig
um                                  defconfig
xtensa                    xip_kc705_defconfig
arc                            hsdk_defconfig
um                               alldefconfig
mips                        vocore2_defconfig
arm                  randconfig-c002-20220321
arm                  randconfig-c002-20220320
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allyesconfig
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
x86_64               randconfig-a013-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a016-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a011-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a015-20220321
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
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                          moxart_defconfig
mips                      bmips_stb_defconfig
powerpc                          allmodconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
powerpc                     mpc512x_defconfig
arm                       cns3420vb_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-a001-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a006-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a002-20220321
riscv                randconfig-r042-20220320
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220321
hexagon              randconfig-r041-20220320

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
