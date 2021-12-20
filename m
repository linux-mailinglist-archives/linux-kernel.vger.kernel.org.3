Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9B47A7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhLTKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:54:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:39521 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhLTKyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639997646; x=1671533646;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4sNheOiOGp/+IXIraAHwfAxSRiGC2eIdgFPlHk9Na4E=;
  b=inuMW7zlmRVOqQdj7gkFH5Ddsn1vMgt2JP+Wo+DXpCUcM0cR/uVNl6rD
   ABTSRV593MCuz6aBDGHbN9uFc1OIKacExIEbENF0xcllS6bfu8KHsOGKU
   Rr94V6DtbH6ZAr+pI9mWnjmPeH/EU6pFIP0Gzh63Q2zNSNLCo73H8V9WQ
   mpLfVGfXQeZgVdsmDGKY0lOhkhXm5/pbqnY08jaAoIYLajEcrUmwnjR5j
   Dp6A/sTvFf8wICmsuz0TI4qNm3+2jQ/FMKTLKzx+8j2zdTl9BKmzBcZH/
   GTWtYyMhIMD4vF2EGBCSPjHRM/ob94O3Fso6SOlLEzimEwAEeM18n+r3R
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="237681035"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="237681035"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 02:54:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="606679789"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2021 02:54:04 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzGIt-0007hD-GF; Mon, 20 Dec 2021 10:54:03 +0000
Date:   Mon, 20 Dec 2021 18:53:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 57690554abe135fee81d6ac33cc94d75a7e224bb
Message-ID: <61c060a5.rvrbzGsCiMME9J9u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 57690554abe135fee81d6ac33cc94d75a7e224bb  x86/pkey: Fix undefined behaviour with PKRU_WD_BIT

elapsed time: 725m

configs tested: 77
configs skipped: 72

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                 mpc834x_itx_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    adder875_defconfig
m68k                       m5249evb_defconfig
powerpc                     sequoia_defconfig
arm                           viper_defconfig
m68k                          hp300_defconfig
powerpc                    amigaone_defconfig
csky                                defconfig
s390                       zfcpdump_defconfig
sh                          landisk_defconfig
openrisc                  or1klitex_defconfig
sh                        sh7763rdp_defconfig
arm                       versatile_defconfig
powerpc                      ppc44x_defconfig
m68k                        m5307c3_defconfig
sh                         apsh4a3a_defconfig
arm                       cns3420vb_defconfig
powerpc                         wii_defconfig
powerpc                 canyonlands_defconfig
mips                           ci20_defconfig
nios2                         10m50_defconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20211220
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
