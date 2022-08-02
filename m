Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89AB5878CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiHBIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiHBIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:14:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5514BE2D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659428056; x=1690964056;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6Aqwr1pSkYj919JCcg/mAukVWkVQlMP8dECWFe/bnJc=;
  b=m0l02H3YmMbOIz4M+iIX6zoQ8/8pcKASCwO1nyN7zEcFJCuMQw0lhpj6
   v4OWI2vRSqCIpFtlZnOrx62xsgG8ILBdzGapz8pVLHE3FqsfGkXygBAlU
   M+sJ54FBzGj6KUM5GRZ3KVnupI6DY/C1uFNvswErlY3eRg3WuAyjm9gyw
   4LDHVu5YRcrne1IFVG6LmNeGGZC9NKmkMsCRILZ8N6QJ9b15ClMMPbQlT
   3L9TI2y/396jbdEuFxbuVWa8u0hjWjSl5WNpYTCONXhFv016jmbB/kV8X
   YGQWXlEW7/NGbTx9qDlWr82o/csXPS+LURc0j9G7WSP4dY17sQFDNJULY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269120944"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="269120944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="602344000"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 01:14:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIn2Y-000FrX-1I;
        Tue, 02 Aug 2022 08:14:10 +0000
Date:   Tue, 02 Aug 2022 16:13:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c3fdc66620f19493dc0cc6f9ace131463aa0f8ad
Message-ID: <62e8dcae.7GNwDJF6E8rtrHFU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c3fdc66620f19493dc0cc6f9ace131463aa0f8ad  Merge branch into tip/master: 'x86/vmware'

elapsed time: 1033m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220801
i386                 randconfig-a012-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a011-20220801
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
i386                 randconfig-a015-20220801
i386                                defconfig
i386                 randconfig-a014-20220801
i386                 randconfig-a016-20220801
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
arc                              allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
arm                                 defconfig
x86_64               randconfig-a014-20220801
m68k                             allyesconfig
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
x86_64               randconfig-a015-20220801
x86_64               randconfig-a016-20220801
arm64                            allyesconfig
arm                              allyesconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
m68k                          amiga_defconfig
powerpc                     tqm8555_defconfig
sh                          urquell_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-k001-20220801
i386                 randconfig-c001-20220801
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                       m5249evb_defconfig
nios2                            allyesconfig
mips                            ar7_defconfig
arm                            mps2_defconfig
x86_64               randconfig-c001-20220801
arm                  randconfig-c002-20220801
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220801
x86_64               randconfig-a002-20220801
hexagon              randconfig-r045-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a001-20220801
i386                 randconfig-a001-20220801
x86_64               randconfig-a006-20220801
i386                 randconfig-a002-20220801
x86_64               randconfig-a004-20220801
i386                 randconfig-a003-20220801
x86_64               randconfig-a005-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a004-20220801
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      obs600_defconfig
hexagon              randconfig-r045-20220802
s390                 randconfig-r044-20220802
hexagon              randconfig-r041-20220802
riscv                randconfig-r042-20220802

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
