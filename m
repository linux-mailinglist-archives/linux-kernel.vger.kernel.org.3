Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57759637E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiHPUFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHPUFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:05:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B47B788
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660680302; x=1692216302;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=64cxPXUR1/1yhLA0ois3zXOO/EezC1ZG8tFBRR3t74A=;
  b=Ps0tUYxNzu1H7NAtYUthZVpYxQluLFFvKRAvTpEXZvaIuKhjW37syKOa
   EYupzIDHf+7/GAP7nDftF3vqxgZgroPu68qyPLrmVcx6Ky+Mxqfyg/0P7
   HTeygDWTyDA3JzqUxe1IwasHl8pMZekbL8gz1VwAOc7b13JngHcRG0NKl
   N4JHLqfWlzC1dT0cMvng/uJEN2Rm0z55FD5z0kAcwyJ6n001rZUdJs4EO
   wX/wNcc/NOyg7jVu1z7bNsEWJQ8Dd0EuwbbV/XQqAQWlUKKhd8dAOYtOL
   w0rRqqsB9kIUTnxVe+T/zltiIFf0M3blQr2QZdsm+mCK6p6wNqq2/Pp1v
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="279279069"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="279279069"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 13:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667275844"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 13:05:01 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO2o8-0000CW-1Q;
        Tue, 16 Aug 2022 20:05:00 +0000
Date:   Wed, 17 Aug 2022 04:04:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 764fc2a82fed0a4f0ce7444c34a3683bad06e403
Message-ID: <62fbf85d.AYGkK8knj6m9KOAw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 764fc2a82fed0a4f0ce7444c34a3683bad06e403  x86/microcode: Document the whole late loading problem

elapsed time: 716m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220815
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a003-20220815
m68k                             allyesconfig
i386                 randconfig-a004-20220815
i386                 randconfig-a002-20220815
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
arm                                 defconfig
m68k                             allmodconfig
i386                 randconfig-a006-20220815
arc                              allyesconfig
i386                                defconfig
arm64                            allyesconfig
x86_64                              defconfig
arm                              allyesconfig
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a001-20220815
x86_64               randconfig-a003-20220815
mips                             allyesconfig
x86_64               randconfig-a002-20220815
x86_64                               rhel-8.3
x86_64               randconfig-a004-20220815
x86_64               randconfig-a006-20220815
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a005-20220815
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
ia64                             allmodconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc8540_ads_defconfig
i386                 randconfig-c001-20220815
powerpc              randconfig-c003-20220815
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
mips                         bigsur_defconfig
powerpc                      chrp32_defconfig
arm                           h3600_defconfig
arm                      integrator_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                     stx_gp3_defconfig
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig
arm                          simpad_defconfig
sh                          r7780mp_defconfig
arm                             ezx_defconfig
openrisc                 simple_smp_defconfig
openrisc                  or1klitex_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                        nsimosci_defconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig

clang tested configs:
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220815
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a012-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a016-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a013-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a016-20220815
arm                       versatile_defconfig
arm                       mainstone_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc832x_rdb_defconfig
x86_64               randconfig-k001-20220815
arm                        multi_v5_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc832x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
