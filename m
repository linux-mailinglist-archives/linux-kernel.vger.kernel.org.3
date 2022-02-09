Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B124AF27A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiBINQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiBINQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:16:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D466EC0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644412609; x=1675948609;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Lc+OeD6iIhjkW26JrnPV674JULuZZct9IJnyh71BMoI=;
  b=HLd9bBV/o9jDguoiBjYw+grRkW7ZizYu3+yMlLw170n2hwhr6WPqrT9F
   AD409KMrl4c/dkl42FcLoryFgV/rh8ukkLqt3iqNqe17U4WxsJUjIHwFz
   SG8pfNt5GTerUSE3wzKiYc5o4hMyQoBWTuBi1relIZikWjg2cPzNwCk+t
   o9sQsVinlvI+aam5HDH1TZpH8Gf8vRqPDmzwI65f5HUGh8//clg4S5Cud
   0K08t3WCoa8ChqzdqOkf1vLmMTzzB/1EqQvUhfcBvtoSaNK3rpLS+GkX2
   +MieojpGibJJ5I7nC0EtvzGNaiVoZ4TPqWN3ZISN7tElQgJsM08Khr+in
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="246784164"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="246784164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:16:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="482324713"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2022 05:16:48 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHmpz-0001qv-7k; Wed, 09 Feb 2022 13:16:47 +0000
Date:   Wed, 09 Feb 2022 21:16:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 f589e15f9255f036c65af24163bb053f745567cc
Message-ID: <6203be98.NOTIBeM97airnEWY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: f589e15f9255f036c65af24163bb053f745567cc  tools/nolibc/stdlib: implement abort()

elapsed time: 935m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                          randconfig-c001
powerpc                   motionpro_defconfig
sh                   sh7724_generic_defconfig
sh                               alldefconfig
arc                          axs103_defconfig
sh                         ap325rxa_defconfig
mips                         bigsur_defconfig
m68k                        m5407c3_defconfig
sh                         apsh4a3a_defconfig
powerpc                   currituck_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm8548_defconfig
sh                          urquell_defconfig
mips                     decstation_defconfig
sh                         microdev_defconfig
arm                            hisi_defconfig
xtensa                  nommu_kc705_defconfig
mips                           jazz_defconfig
s390                             allyesconfig
powerpc                     sequoia_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          sdk7780_defconfig
sh                   rts7751r2dplus_defconfig
arm                        multi_v7_defconfig
sh                             sh03_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
arm                        mvebu_v7_defconfig
x86_64                              defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20220209
ia64                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220209
arc                  randconfig-r043-20220208
arc                  randconfig-r043-20220209
riscv                randconfig-r042-20220209
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                     tqm8540_defconfig
mips                      malta_kvm_defconfig
powerpc                      katmai_defconfig
powerpc                      pmac32_defconfig
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
