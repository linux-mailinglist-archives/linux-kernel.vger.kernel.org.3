Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9994742FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhLNMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:54:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:29209 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234168AbhLNMyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639486450; x=1671022450;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=e+M8MX7rSXFptrnr63RQRqQp+KUwsfFuzfMPXhXVaU4=;
  b=bg6sQdcYA2TJJRt84zbMv0ygthCqz+yJls0E2vB6OT29TzSQC6Tf8uuL
   Q0g1zRGfHXK7VRc0iWja7TMVHA6/6emhxpa1J+oVUBsUIbQoZ4pPoqrZC
   u/PMfxnkhdWZ1SHGdHf58gKBIxXjNgupBUCjvNjhQgtKmDQhPRKhnGMLt
   GkqsqLDeXYIBq5kYJ7QicXmQmiJGPR6zeScS2RKvVWbqkFVx3wwUKiLPa
   3LZkLK7o3b/YVxWFNNt1QLTJ81wH/glahZDbEpq9GsZfkKV4Nh6BEegDh
   Tc8q/HL0TMv68BgCL3DmLhGaQREuKUTSCc4iPZJTjmesLELJELQw6z2hD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325245758"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="325245758"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 04:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465077552"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 04:54:08 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx7Jo-0000KB-AU; Tue, 14 Dec 2021 12:54:08 +0000
Date:   Tue, 14 Dec 2021 20:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 362fc3cae72088d21e8c6fd3a2e3800f1db65516
Message-ID: <61b893bc./fUq4bHpdXEZRCZN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 362fc3cae72088d21e8c6fd3a2e3800f1db65516  Merge ras/core into tip/master

elapsed time: 983m

configs tested: 102
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-c001-20211213
powerpc                   motionpro_defconfig
mips                           mtx1_defconfig
mips                           xway_defconfig
mips                        omega2p_defconfig
powerpc                      cm5200_defconfig
riscv                               defconfig
arm                        clps711x_defconfig
powerpc                 mpc834x_itx_defconfig
arm                            qcom_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
parisc                              defconfig
sh                           se7712_defconfig
sh                        dreamcast_defconfig
powerpc                     tqm8540_defconfig
arm                  randconfig-c002-20211213
arm                  randconfig-c002-20211214
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211213
x86_64               randconfig-a012-20211213
x86_64               randconfig-a014-20211213
x86_64               randconfig-a013-20211213
x86_64               randconfig-a016-20211213
x86_64               randconfig-a015-20211213
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
x86_64               randconfig-a006-20211214
i386                 randconfig-a013-20211213
i386                 randconfig-a011-20211213
i386                 randconfig-a012-20211213
i386                 randconfig-a016-20211213
i386                 randconfig-a014-20211213
i386                 randconfig-a015-20211213
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
i386                 randconfig-a001-20211213
i386                 randconfig-a002-20211213
i386                 randconfig-a003-20211213
i386                 randconfig-a004-20211213
i386                 randconfig-a005-20211213
i386                 randconfig-a006-20211213
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
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
