Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922BA4700B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbhLJMgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:36:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:53918 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231374AbhLJMgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639139586; x=1670675586;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3oXIDyN7PsAsKBYQsrfZek/3qJz6YbCUKUifQ17VmXo=;
  b=jBrXaCBfkUtAn4NMnZjcpytyYSOJB7KKwifSNd4S8Yu8326BcQTAPVjF
   aZR86n4W8TXs2seW22YxtF0PgpMLd5WR15oB5eNRFFDE/BZ9wl6FL8nb+
   0YhWWuf5Z1a1DmdwoxUjsrat01LRHYAw+pdtZ+IwbPFJZstriIOb33BQN
   CqUJ/lJiqZAjxQeeKayg7LBDffsTkASdRWHkEiePzxlzmitRbQd7F1HUw
   7Y76JIlMlARygepM1aYUbaJBU/hHx7TNvdcOT3B96uAUOgplWBwlYXZkr
   RsRIfXiHGZrvCrtGPmdgK7ouzFxlTaRa6TGjgWguYb8UtShFnEX+/kcBH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="219026247"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="219026247"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 04:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="680726704"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2021 04:33:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvf5D-0003BY-GA; Fri, 10 Dec 2021 12:33:03 +0000
Date:   Fri, 10 Dec 2021 20:32:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 6f731452e4eefa4e88541faa44ae6e22927ecfef
Message-ID: <61b348ca.kuz4teN+O4F1/faY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 6f731452e4eefa4e88541faa44ae6e22927ecfef  rcu: Add mutex for rcu boost kthread spawning and affinity setting

elapsed time: 724m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211210
h8300                            allyesconfig
arm                     davinci_all_defconfig
arc                        vdk_hs38_defconfig
powerpc                     stx_gp3_defconfig
arm                           sunxi_defconfig
arm                          moxart_defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
m68k                           sun3_defconfig
openrisc                    or1ksim_defconfig
arc                        nsimosci_defconfig
sh                          polaris_defconfig
arm                           corgi_defconfig
arm                         assabet_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      maltaaprp_defconfig
arm                        spear6xx_defconfig
parisc                generic-64bit_defconfig
arm                          pxa168_defconfig
arm                          pxa910_defconfig
arm                         orion5x_defconfig
x86_64                           alldefconfig
ia64                         bigsur_defconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
sh                           se7712_defconfig
arm                             rpc_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      katmai_defconfig
xtensa                         virt_defconfig
powerpc64                           defconfig
arm                             ezx_defconfig
arm                  colibri_pxa270_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7201_defconfig
mips                           ip28_defconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
powerpc                 canyonlands_defconfig
xtensa                              defconfig
powerpc                     ppa8548_defconfig
um                             i386_defconfig
h8300                            alldefconfig
m68k                        stmark2_defconfig
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
riscv                            alldefconfig
powerpc                      bamboo_defconfig
sh                            migor_defconfig
xtensa                  nommu_kc705_defconfig
arm                  randconfig-c002-20211210
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a005-20211210
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211210
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a015-20211210
x86_64               randconfig-a016-20211210
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
