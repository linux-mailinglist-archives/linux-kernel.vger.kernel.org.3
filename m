Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F378F582152
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiG0HlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiG0HlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:41:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C4220193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658907660; x=1690443660;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KPLddpN1iNY999KUGp+HYrhO7p0BswS5UtJ/9mOu0mE=;
  b=j7n6k0EOSeXlWjv13dcHRnWaSNvAraqqTT91PmGn84e2oukCxF/wLbFk
   7ezK0i8RcnCbmdAVXZ5RpE3CpxEvjXzdIRVgCfEb1xjzIcs3OeJsKfkyO
   eTfv0grKS/+KayQgawmcVYY1sAPsQrsoMpPcjDyApQt1xffoXuAnXkJkz
   3UsQfnjB3v8sAevs+pHpjO4zxzaYDJc1Na3BBV25L10caY/QvlwSoLqXg
   aXcbu33PkbKhjIAz6EYv3y7sLpgajKO0J5AI/GLtoXoYu7FEmCwXoMwEP
   Us1WfV8Q9ofhlTN73SLzmm/wrIkjo8D7yULm1hoNlFqxZiqwcVB7RWa+R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="268554149"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="268554149"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="628276882"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2022 00:40:58 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGbf8-0008Tu-0T;
        Wed, 27 Jul 2022 07:40:58 +0000
Date:   Wed, 27 Jul 2022 15:40:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:resolution.2022.07.26a] BUILD SUCCESS
 e5900cd40f657b585872f8e64bced2f4165ed426
Message-ID: <62e0ebfe.xJ7uoGv1t4dVDiP7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git resolution.2022.07.26a
branch HEAD: e5900cd40f657b585872f8e64bced2f4165ed426  Merge remote-tracking branch 'linus/master' into resolution.2022.07.26a

elapsed time: 752m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220724
i386                          randconfig-c001
arc                        nsimosci_defconfig
s390                             allmodconfig
sh                          rsk7264_defconfig
m68k                        m5272c3_defconfig
ia64                      gensparse_defconfig
alpha                            alldefconfig
arc                     nsimosci_hs_defconfig
arm64                               defconfig
arm                        spear6xx_defconfig
sh                               j2_defconfig
powerpc                  iss476-smp_defconfig
mips                       capcella_defconfig
powerpc                         ps3_defconfig
arm                        keystone_defconfig
m68k                       m5275evb_defconfig
arm                        shmobile_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         mpc30x_defconfig
nios2                            allyesconfig
arc                          axs103_defconfig
nios2                               defconfig
powerpc                       eiger_defconfig
sparc64                          alldefconfig
arm                           sama5_defconfig
m68k                         apollo_defconfig
um                                  defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220724
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220724
riscv                randconfig-r042-20220724
arc                  randconfig-r043-20220724
s390                 randconfig-r044-20220726
riscv                randconfig-r042-20220726
arc                  randconfig-r043-20220726
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220726
x86_64                        randconfig-c007
s390                 randconfig-c005-20220726
powerpc              randconfig-c003-20220726
i386                          randconfig-c001
riscv                randconfig-c006-20220726
arm                  randconfig-c002-20220726
mips                   sb1250_swarm_defconfig
mips                      pic32mzda_defconfig
powerpc                  mpc866_ads_defconfig
arm                        multi_v5_defconfig
powerpc                          allmodconfig
mips                  cavium_octeon_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
