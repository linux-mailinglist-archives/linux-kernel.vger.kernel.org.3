Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81754BC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358388AbiFNUsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344430AbiFNUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:47:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D423BC7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655239672; x=1686775672;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DQrjeq8ZA4p+GkmHtWKVOu0kb3id5BLlfgX5VBVUSxo=;
  b=g3WX0BxN6L3Dvduoq4jrFf9imJwRIYTCLnmBBhY8tV5XIvxMyV+hn7vo
   4/tu1ywZu3cgWZRZKe8s6svn8RMhHbq9KEyOnTWNq/grk6Hzhbi/iUgjG
   JWu1Z3nmFRVTlJWEM/Gox+B4A4jJAj4abRfTbeE+kC9vTHQNWmYZQx+CM
   WA45c4WkzskjCWHEsXWxT6621QUZoVPPT7wsC7ngVh1qxHskDFQw+Bib/
   Kgh1O3t92dYvJ3C6+Vfjp6Wd6rzGsAugh5leXz7X9jgmzijZzl3sC7bmJ
   I6CoM+hXfkc5lErf1O0Yag7HwxQ7dB8To2T9/mdkYXgBFSy0RYWSEI8eR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278784491"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278784491"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 13:47:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652254208"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2022 13:47:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1DS2-000MIF-8S;
        Tue, 14 Jun 2022 20:47:50 +0000
Date:   Wed, 15 Jun 2022 04:46:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 d97c2338871bee6c4255c5a38f95849c063f8f1f
Message-ID: <62a8f3bd.1LLIgqtkwRZzabQ7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: d97c2338871bee6c4255c5a38f95849c063f8f1f  rcu-tasks: Be more patient for RCU Tasks boot-time testing

elapsed time: 1152m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220613
sh                         apsh4a3a_defconfig
arm                           h3600_defconfig
powerpc                     mpc83xx_defconfig
mips                          rb532_defconfig
sh                          r7780mp_defconfig
arm                             ezx_defconfig
powerpc                   motionpro_defconfig
csky                             alldefconfig
arm                         axm55xx_defconfig
sh                         microdev_defconfig
arm                      jornada720_defconfig
powerpc                      chrp32_defconfig
arm                          exynos_defconfig
alpha                            alldefconfig
powerpc                    klondike_defconfig
ia64                                defconfig
x86_64               randconfig-k001-20220613
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64               randconfig-a015-20220613
x86_64               randconfig-a014-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a012-20220613
x86_64               randconfig-a013-20220613
i386                 randconfig-a012-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
riscv                randconfig-r042-20220613
arc                  randconfig-r043-20220613
s390                 randconfig-r044-20220613
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                      malta_kvm_defconfig
mips                           mtx1_defconfig
x86_64               randconfig-a003-20220613
x86_64               randconfig-a006-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a005-20220613
i386                 randconfig-a006-20220613
i386                 randconfig-a001-20220613
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220613
hexagon              randconfig-r045-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
