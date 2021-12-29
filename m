Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B1480E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhL2ANb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:13:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:8740 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhL2ANb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640736810; x=1672272810;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tqVNbkUmJQA7FY7Y+YGwAcBwv0f3wONzL3GosZLGbyM=;
  b=HIXhHjPyClyxRvJxyatjNsyEjd64dq0zlWPkpqnje75gholZ2SfzFS6g
   CiQH010hikPw/c5j08H9+IYxNCphduls++ZU7he8VnL+XVqyrpE3WVgPj
   cOv8pQknZpd8EOAnUDhf/H57iLk5kuKqtSTHH2c8m0mlzKcwLVbl4rqww
   iOqbcIJgT7gOhoWBePMlJzIgKPylkv3t5YZfNyhj64NQoNYw3njCQvLJP
   xkcmocrTkta+SnDMmRX6JUIrB8PGKcwQ9QCsYME+a/KqstiYY81UL3YZQ
   agjQrB+zF8tJWkDevardOJiXaCFQ9hVP7luPVQpz1yasbCvy1pys9ExUs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="238980241"
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="238980241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 16:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="524672438"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2021 16:13:29 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2Mau-00089s-Op; Wed, 29 Dec 2021 00:13:28 +0000
Date:   Wed, 29 Dec 2021 08:13:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 de768416b203ac84e02a757b782a32efb388476f
Message-ID: <61cba815.Her0ebRPVzS617KT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: de768416b203ac84e02a757b782a32efb388476f  x86/mce/inject: Avoid out-of-bounds write when setting flags

possible Warning in current branch (please contact us if interested):

vmlinux.o: warning: objtool: do_machine_check()+0x59a: call to test_bit() leaves .noinstr.text section

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-buildonly-randconfig-r006-20211228
    `-- vmlinux.o:warning:objtool:do_machine_check():call-to-test_bit()-leaves-.noinstr.text-section

elapsed time: 720m

configs tested: 206
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211228
arm64                            alldefconfig
powerpc                        warp_defconfig
powerpc                   currituck_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
mips                         db1xxx_defconfig
arm                             mxs_defconfig
parisc                generic-32bit_defconfig
arm                          simpad_defconfig
arm                         socfpga_defconfig
openrisc                  or1klitex_defconfig
arm                         at91_dt_defconfig
powerpc                      pmac32_defconfig
sh                           se7721_defconfig
powerpc                     mpc5200_defconfig
arc                                 defconfig
m68k                        mvme16x_defconfig
riscv                    nommu_virt_defconfig
mips                         tb0226_defconfig
powerpc                     ep8248e_defconfig
sparc64                             defconfig
powerpc                       holly_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
mips                           gcw0_defconfig
arm                        clps711x_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip32_defconfig
mips                       lemote2f_defconfig
mips                     decstation_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
arm                         cm_x300_defconfig
powerpc                      cm5200_defconfig
arm                          pcm027_defconfig
mips                       rbtx49xx_defconfig
sh                           se7724_defconfig
parisc                generic-64bit_defconfig
arm                          exynos_defconfig
xtensa                       common_defconfig
powerpc                     mpc512x_defconfig
ia64                         bigsur_defconfig
arm                         s3c2410_defconfig
powerpc                     tqm8540_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                      maltaaprp_defconfig
sh                     magicpanelr2_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
arm                             rpc_defconfig
arm                         vf610m4_defconfig
arm                          collie_defconfig
arm                          pxa3xx_defconfig
powerpc                   bluestone_defconfig
mips                      bmips_stb_defconfig
arm                             ezx_defconfig
sh                           se7343_defconfig
arc                          axs101_defconfig
arm                          ep93xx_defconfig
arm                      integrator_defconfig
arm                        trizeps4_defconfig
mips                  cavium_octeon_defconfig
h8300                     edosk2674_defconfig
powerpc                    ge_imp3a_defconfig
ia64                            zx1_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            zeus_defconfig
powerpc                     tqm8541_defconfig
arm                           h3600_defconfig
mips                           jazz_defconfig
openrisc                            defconfig
xtensa                           alldefconfig
m68k                       m5208evb_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                 decstation_r4k_defconfig
arm                        magician_defconfig
sh                           se7619_defconfig
powerpc                     ksi8560_defconfig
um                                  defconfig
sh                         ecovec24_defconfig
sh                        edosk7705_defconfig
powerpc                         ps3_defconfig
powerpc                       maple_defconfig
mips                     loongson2k_defconfig
mips                        maltaup_defconfig
arm                            xcep_defconfig
mips                          ath79_defconfig
i386                             alldefconfig
mips                          rm200_defconfig
arm                           stm32_defconfig
mips                    maltaup_xpa_defconfig
powerpc                  mpc885_ads_defconfig
arm                         lpc18xx_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa910_defconfig
s390                       zfcpdump_defconfig
arm                         lpc32xx_defconfig
arc                        nsimosci_defconfig
arm                              alldefconfig
nds32                            alldefconfig
m68k                        stmark2_defconfig
um                           x86_64_defconfig
powerpc                     powernv_defconfig
mips                      fuloong2e_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
sh                           se7780_defconfig
arm                        shmobile_defconfig
arc                    vdk_hs38_smp_defconfig
csky                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     asp8347_defconfig
powerpc                 canyonlands_defconfig
sh                   sh7770_generic_defconfig
mips                          rb532_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-c002-20211228
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a001-20211228
x86_64               randconfig-a003-20211228
x86_64               randconfig-a002-20211228
x86_64               randconfig-a005-20211228
x86_64               randconfig-a006-20211228
x86_64               randconfig-a004-20211228
i386                 randconfig-a006-20211228
i386                 randconfig-a004-20211228
i386                 randconfig-a002-20211228
i386                 randconfig-a003-20211228
i386                 randconfig-a001-20211228
i386                 randconfig-a005-20211228
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211228
mips                 randconfig-c004-20211228
powerpc              randconfig-c003-20211228
arm                  randconfig-c002-20211228
x86_64               randconfig-c007-20211228
i386                 randconfig-c001-20211228
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
