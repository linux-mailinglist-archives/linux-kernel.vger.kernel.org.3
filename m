Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03629587E70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiHBOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiHBOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:54:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0FE2CCBB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659452063; x=1690988063;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U6ENi0J3ztDHbIUtKNoPJMx+9XA8CrX1QlExpBImkjc=;
  b=UJ49efeIPS1HPRkuRIwNvvDb/UY2MLWSIiyQmKxIpYiKyM9kx0dSwo2O
   zRUUWfgdt1M5wOl3nisEWOfSLHdZmN9KrE7V8YQbKO1mXQ+/EYyUYj8AV
   eLgROhJvxoQrqjGZN+ygj8f5Q1eKQmzki6QWtH6PWE7yO/8/WWpgJb6uF
   rtx2sos9BFwB0npLAFEK9LVrQvz7Xmcc53iHah+fMxB2rLTndhd/qMq63
   E/RKylikcs0VkeF5zDyOHU9NJndHXRLRvz9nmwZcjaxhIh7Lmoyg3NvYR
   TfYKoBDmknjOsDYtR64RA20CgDKej4BqWQRpWkwJgvOP6RSKbuY6JnKuL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="286986069"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="286986069"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 07:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="578243872"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2022 07:54:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oItHp-000G8L-0n;
        Tue, 02 Aug 2022 14:54:21 +0000
Date:   Tue, 02 Aug 2022 22:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.07.21a] BUILD SUCCESS
 3dcf6043170b475ccf8a3f46bfb47770a8bc3559
Message-ID: <62e93a68.yqnyyuyvlXQSktJv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.07.21a
branch HEAD: 3dcf6043170b475ccf8a3f46bfb47770a8bc3559  fixup! rcu: Add full-sized polling for get_completed*() and poll_state*()

elapsed time: 938m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allyesconfig
i386                                defconfig
s390                 randconfig-r044-20220801
arc                  randconfig-r043-20220801
riscv                randconfig-r042-20220801
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a016-20220801
x86_64               randconfig-a015-20220801
x86_64               randconfig-a014-20220801
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20220802
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-a016-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a012-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a014-20220801
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
i386                 randconfig-c001-20220801
sh                           se7722_defconfig
nios2                            allyesconfig
x86_64               randconfig-k001-20220801
parisc                generic-32bit_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc837x_rdb_defconfig
riscv                    nommu_k210_defconfig
m68k                       m5249evb_defconfig
mips                            ar7_defconfig
arm                            mps2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                           alldefconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
sh                      rts7751r2d1_defconfig
powerpc                        warp_defconfig
powerpc                       ppc64_defconfig
ia64                             alldefconfig
arm                           tegra_defconfig
riscv             nommu_k210_sdcard_defconfig

clang tested configs:
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a004-20220801
hexagon              randconfig-r041-20220802
riscv                randconfig-r042-20220802
hexagon              randconfig-r045-20220802
s390                 randconfig-r044-20220802
powerpc                      obs600_defconfig
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      katmai_defconfig
arm                      tct_hammer_defconfig
arm                         shannon_defconfig
mips                          ath25_defconfig
arm                       spear13xx_defconfig
hexagon                             defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
