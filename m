Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDB46FCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhLJIfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:35:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:22403 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhLJIfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639125138; x=1670661138;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zxGv0ssu4fdX+yDg85HmhKqZmiSlGRmSAr8fwZyz1lg=;
  b=UC6RYOB0nvexqnaNV2MMl/EqrWcI9aX1QaYdw75vLUOOrxLcts3sJMTI
   1tzRbi8Q7q4CSKhbK5E8aqh6V7jzscoS2N9dWxn7k9yjwa3ujPNj+EaMe
   b4+Pi2v4FhsqQAJ6zXeKURobnJLviUjvJq2+iY4z9nqrMiJ28UVe1DLe9
   MwCbsn4NuAEFjyElqdoZvV6AMjxWYv2Xbw1pnW5Gq8DRBExnWs72azzx7
   /2bjWL+a4gIFP+MBt4SVBvz4yDwj9W0GxLm0pJ2ibJb76ZeQhcziCZPgF
   YS7AP9yb9oYMuhg5o59UoXIEPkW//rgyxrsEeRefUM9A8fh1obrdHcmIU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324567325"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="324567325"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 00:32:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="503847508"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 00:31:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvbJu-0002yB-Hb; Fri, 10 Dec 2021 08:31:58 +0000
Date:   Fri, 10 Dec 2021 16:31:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 9da622944c940e55caabd823dce0ce85df24b769
Message-ID: <61b31044.s4CHfzRZnFBFN6Nv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 9da622944c940e55caabd823dce0ce85df24b769  Merge branch into tip/master: 'core/entry'

elapsed time: 750m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211210
mips                 randconfig-c004-20211210
powerpc                      chrp32_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           u8500_defconfig
xtensa                  cadence_csp_defconfig
sh                          polaris_defconfig
arm                           corgi_defconfig
arm                         assabet_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
m68k                        m5307c3_defconfig
arm                             mxs_defconfig
sh                        apsh4ad0a_defconfig
alpha                            allyesconfig
x86_64                           alldefconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
ia64                         bigsur_defconfig
sh                           se7712_defconfig
arm                             rpc_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    socrates_defconfig
nds32                             allnoconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
powerpc                     rainier_defconfig
arm                            dove_defconfig
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
arm                             pxa_defconfig
m68k                        m5407c3_defconfig
powerpc                        warp_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                           tegra_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     davinci_all_defconfig
powerpc                     taishan_defconfig
sh                             shx3_defconfig
um                           x86_64_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
openrisc                 simple_smp_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-c002-20211210
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
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
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
