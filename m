Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D947B48A766
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347183AbiAKFec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:34:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:9079 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbiAKFe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641879268; x=1673415268;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PULBTvr4dMvbgGKY8WS3Aci3+YYOuSOZD8QntClYvMA=;
  b=cXNXTcKK89w6jIX8iZbAGLfB190u7AqQjTZ4vHd83zH1Al4srzD0gG5g
   1sn/jGtyLxb2Bsfx03BeFMjzb617BQNL2WYxhIh/Q+skjog5p4j10v+5c
   ngXrA3+UhSrHpW0AX4z75t1jDid4rJSsNj0Hiwm52uLkM6/ivpadAuCj1
   wAlFHHG87srvL+pTahYWj4dwDxMrNneTh0M76w1qwuMasHb+UqZYzwUPx
   1qwNqlX3mxuSGQVfiTdC1GAK17vabIzQA/CSuKknoYlN3kf4tud6uGpsn
   VoBZzaIKk3/YsSSOFIn6wziaWcN9P2fp9cnXJjy1tFOuroKoNp48rWxhy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306759568"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="306759568"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 21:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="528191403"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2022 21:34:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n79ne-0004Q2-CN; Tue, 11 Jan 2022 05:34:26 +0000
Date:   Tue, 11 Jan 2022 13:33:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 35e13e9da9afbce13c1d36465504ece4e65f24fe
Message-ID: <61dd16b4.x0wjKqWPT2pSd1T4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 35e13e9da9afbce13c1d36465504ece4e65f24fe  Merge branch 'clocksource' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into timers/core

elapsed time: 735m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
