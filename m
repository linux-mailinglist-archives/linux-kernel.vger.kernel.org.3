Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0989D475839
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhLOLzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:55:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:13599 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242224AbhLOLzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639569310; x=1671105310;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Cp5tWnF6uvgnR1uSbFrWcXbtlxFUDHkiAChyrDig5hg=;
  b=A8lq5doO75/ZxBQEX7U2YEjnGcN/M0UlKntkGodrP4PAshs1XNiBRNJ1
   HWi8CnlhJOdsGSdnL2YxRVwXxbZ6hwM+HB5muiC6+xo88OaSGdvxcWEq6
   yG2FkvPmNv6UecoeWwIYwOJOOvLXoL1ullCmdlNqh0RbMoIRchBwMWWeu
   NThEibwEhm/1W4dU5DeIu0DA0NKtfCEuENYeFxp0nbnPl75p/K4cW8pZq
   ol4/EKXvJ1P1VJPrqd1DUAeafQXLSZJ16IQumhsoUuIPWi40rA0XPlugD
   M3qcQpJEHTZbZHNrrOZzDUgDIoRLfgMHlmVPtzwPG4VqmNVOpUk+YNhuq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219893640"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219893640"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="604955976"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Dec 2021 03:54:59 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxSs6-0001iQ-At; Wed, 15 Dec 2021 11:54:58 +0000
Date:   Wed, 15 Dec 2021 19:54:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.12.09b] BUILD SUCCESS WITH WARNING
 0f1825f9df5a83cfeca5f1ecce96633223bf78d2
Message-ID: <61b9d771.ewi+mY6YY2IShqny%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.09b
branch HEAD: 0f1825f9df5a83cfeca5f1ecce96633223bf78d2  fixup! rcu: Create and use a rcu_rdp_cpu_online()

Warning reports:

https://lore.kernel.org/lkml/202112151008.JsE9k2En-lkp@intel.com
https://lore.kernel.org/lkml/202112151339.x3VR9Ztf-lkp@intel.com

Warning in current branch:

kernel/rcu/tree.c:4070:16: warning: variable 'lseq' set but not used [-Wunused-but-set-variable]
kernel/rcu/tree.c:4070:23: warning: variable 'lseq' set but not used [-Wunused-but-set-variable]
kernel/rcu/tree.c:4072:16: warning: variable 'lseq' set but not used [-Wunused-but-set-variable]
kernel/rcu/tree.c:4072:23: warning: variable 'lseq' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- alpha-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arc-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arc-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-colibri_pxa270_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-lpc32xx_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-milbeaut_m10v_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-multi_v5_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-oxnas_v6_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-pcm027_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-qcom_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-randconfig-r022-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-s5pv210_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm-socfpga_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm64-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm64-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm64-buildonly-randconfig-r001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm64-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- arm64-randconfig-c023-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- h8300-randconfig-c004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-alldefconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-debian-10.3
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-debian-10.3-kselftests
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a003-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a005-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a006-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-c001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-r032-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-s001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-s002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- ia64-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- ia64-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- ia64-bigsur_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- ia64-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- ia64-randconfig-r001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- ia64-randconfig-r005-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- ia64-randconfig-r035-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- m68k-randconfig-m031-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- m68k-randconfig-r006-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- microblaze-randconfig-r036-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-bmips_stb_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-ci20_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-malta_kvm_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-maltaup_xpa_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-randconfig-c004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- nds32-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- nds32-randconfig-r034-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- nios2-buildonly-randconfig-r003-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- nios2-randconfig-r032-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- nios2-randconfig-r034-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- openrisc-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- openrisc-buildonly-randconfig-r004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- openrisc-randconfig-c024-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- parisc-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- parisc-buildonly-randconfig-r005-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- parisc-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- parisc-randconfig-c024-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- parisc-randconfig-r014-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc-gamecube_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc-pasemi_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc-randconfig-r003-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc-randconfig-r005-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc64-alldefconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc64-randconfig-m031-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc64-randconfig-r001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- powerpc64-randconfig-r033-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-nommu_k210_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-nommu_k210_sdcard_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-nommu_virt_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-randconfig-c024-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-randconfig-p002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-randconfig-r002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-randconfig-r032-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-randconfig-s031-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-randconfig-s031-20211215
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-rv32_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- s390-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- s390-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- s390-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- s390-randconfig-p002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc-buildonly-randconfig-r001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc-randconfig-r003-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc-randconfig-r006-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc-randconfig-r035-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc64-buildonly-randconfig-r002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc64-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc64-randconfig-m031-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc64-randconfig-r031-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- sparc64-randconfig-r036-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-buildonly-randconfig-r004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-buildonly-randconfig-r005-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-buildonly-randconfig-r006-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-defconfig
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-kexec
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a003-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a005-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a006-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-c002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-c022-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-c023-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-m001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-r002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-r031-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-s021-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-s022-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-rhel-8.3
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-rhel-8.3-func
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
`-- xtensa-xip_kc705_defconfig
    `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used

clang_recent_errors
|-- arm64-randconfig-r016-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- hexagon-randconfig-r041-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a011-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a012-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a014-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a015-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-a016-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-c001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- i386-randconfig-r015-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- mips-randconfig-c004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- riscv-randconfig-r042-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a011-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a012-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a013-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a014-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a015-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
|-- x86_64-randconfig-a016-20211214
|   `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used
`-- x86_64-randconfig-c007-20211214
    `-- kernel-rcu-tree.c:warning:variable-lseq-set-but-not-used

elapsed time: 724m

configs tested: 147
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20211214
i386                 randconfig-c001-20211214
sh                 kfr2r09-romimage_defconfig
xtensa                    xip_kc705_defconfig
powerpc                    klondike_defconfig
arm                      tct_hammer_defconfig
m68k                          amiga_defconfig
arm                          pcm027_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
arm                             mxs_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
arm                           stm32_defconfig
xtensa                       common_defconfig
sh                         ecovec24_defconfig
powerpc                      pasemi_defconfig
powerpc                    gamecube_defconfig
powerpc64                        alldefconfig
s390                                defconfig
powerpc                          allyesconfig
m68k                          sun3x_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
um                             i386_defconfig
powerpc                        fsp2_defconfig
mips                         mpc30x_defconfig
arm                            dove_defconfig
arm                        oxnas_v6_defconfig
arm                         hackkit_defconfig
mips                      malta_kvm_defconfig
arm                      footbridge_defconfig
mips                           ci20_defconfig
sh                          r7780mp_defconfig
csky                             alldefconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      makalu_defconfig
arm                      jornada720_defconfig
i386                             alldefconfig
mips                      bmips_stb_defconfig
mips                           rs90_defconfig
mips                    maltaup_xpa_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
sh                           se7724_defconfig
sparc64                             defconfig
h8300                    h8300h-sim_defconfig
arm                         socfpga_defconfig
powerpc                      bamboo_defconfig
ia64                         bigsur_defconfig
arm                        multi_v5_defconfig
arm                        shmobile_defconfig
arm                        magician_defconfig
sh                      rts7751r2d1_defconfig
sh                                  defconfig
powerpc                    mvme5100_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20211214
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211214
x86_64               randconfig-c007-20211214
riscv                randconfig-c006-20211214
mips                 randconfig-c004-20211214
i386                 randconfig-c001-20211214
s390                 randconfig-c005-20211214
powerpc              randconfig-c003-20211214
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a015-20211214
i386                 randconfig-a012-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
