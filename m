Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFFD4851EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiAELfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:35:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:2828 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235686AbiAELfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641382542; x=1672918542;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YuME9SwN2v1dWDsawdrL2avM4l2vAwx7h2ESHBswdkw=;
  b=Y7WfmD7JWczCfKiRjXipHrWs84++Wy8E4boLvNUKxcsSlqRIMBSEX/VM
   +Ck76lf/e1AIDg4u0JBfifw4qcA9pn4HkXOnuft1hxBF51IfkWmN3HP10
   JMT2NWTKTOyGx7gJodsMb8kaxuI4QO0TOTVNaXgDsyspn5UgW+H1Y715v
   85ZYjsQaH1F8o+0Zo9FLhe5s4U68XSbfsGJjrH/bZkFhKEiaCLS9+WB4+
   Q2YHsE7lDqFq/4bmLTTDV8RimasFb0DsMkHUYYbMY8Yv/vYzEsBn2Lb47
   pMbFH8cv3EMWvGxKftG6qGvrQXjhGIT42xLagqpYJjzBL7hjkFUJws1qF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241241733"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241241733"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 03:35:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="472463139"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2022 03:35:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n54Zt-000GYv-BS; Wed, 05 Jan 2022 11:35:37 +0000
Date:   Wed, 05 Jan 2022 19:34:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 4dabd7096bfe076d074338d2890b522883f15122
Message-ID: <61d58257.T8cB4QcZsuP3BCMv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 4dabd7096bfe076d074338d2890b522883f15122  rcu: Mark writes to the rcu_segcblist structure's ->flags field

elapsed time: 879m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220105
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
sh                        edosk7705_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 linkstation_defconfig
arm                           stm32_defconfig
powerpc                        warp_defconfig
arm                          lpd270_defconfig
arm                        shmobile_defconfig
mips                      fuloong2e_defconfig
arm                           u8500_defconfig
h8300                               defconfig
powerpc                           allnoconfig
i386                             alldefconfig
nds32                               defconfig
arm                  randconfig-c002-20220105
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a005-20220105
x86_64               randconfig-a001-20220105
x86_64               randconfig-a004-20220105
x86_64               randconfig-a006-20220105
x86_64               randconfig-a003-20220105
x86_64               randconfig-a002-20220105
i386                 randconfig-a003-20220105
i386                 randconfig-a005-20220105
i386                 randconfig-a004-20220105
i386                 randconfig-a006-20220105
i386                 randconfig-a002-20220105
i386                 randconfig-a001-20220105
arc                  randconfig-r043-20220105
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
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220105
arm                  randconfig-c002-20220105
i386                 randconfig-c001-20220105
riscv                randconfig-c006-20220105
powerpc              randconfig-c003-20220105
x86_64               randconfig-c007-20220105
powerpc                  mpc885_ads_defconfig
arm                        multi_v5_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-a012-20220105
x86_64               randconfig-a015-20220105
x86_64               randconfig-a014-20220105
x86_64               randconfig-a013-20220105
x86_64               randconfig-a011-20220105
x86_64               randconfig-a016-20220105
i386                 randconfig-a012-20220105
i386                 randconfig-a016-20220105
i386                 randconfig-a015-20220105
i386                 randconfig-a014-20220105
i386                 randconfig-a011-20220105
i386                 randconfig-a013-20220105
hexagon              randconfig-r041-20220105
hexagon              randconfig-r045-20220105
riscv                randconfig-r042-20220105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
