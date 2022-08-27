Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357825A3757
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiH0LSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiH0LSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:18:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E725C7B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661599127; x=1693135127;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o5PDN8PE5mWe9H2K5ioOi/PHS2bbo3ogtkR3N6LFNEA=;
  b=CuEA2RR3teOgq/ab32KV10NAij2pOMtopoW7mF/O3pJ5u4i5cqb8ZSNj
   IrdYCzlWc8vYTU6FgqM5Uu+SNRbXAJkVYSYaZLvFrxb1kJ49gp3BsIon9
   fryLQgXanzSNgR65gJKrpiEtDmfik+9XOtnsm3NoppgnsA7aTEbiys8nF
   vI7l1LC1LH3g99Wj/eDQRpqYbWQ9SIYYjB8nVckW7QqQeAgXSG6B0garD
   YYfTEAi3i9MwMH6cYMjeT1cWefd3mt2L75sjr2m3GAMem1JCDTTFv0rn5
   Su4d/G3r7jBKj0yKwXrUo1pzG7c+DeEa8JeTOPWKEw/C8ybvUtKnvDh9J
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="356370255"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="356370255"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 04:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="939037463"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2022 04:18:45 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRtpt-00007j-0N;
        Sat, 27 Aug 2022 11:18:45 +0000
Date:   Sat, 27 Aug 2022 19:18:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 97a2c50e702a410ab273adcf7463f757b9ada970
Message-ID: <6309fd82.i8pL+F9Zcbt7UUpZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 97a2c50e702a410ab273adcf7463f757b9ada970  rcutorture: Verify NUM_ACTIVE_RCU_POLL_OLDSTATE

elapsed time: 1315m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
alpha                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
loongarch                         allnoconfig
s390                                defconfig
loongarch                           defconfig
arc                                 defconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                           allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220827
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a011
x86_64                        randconfig-a013
s390                       zfcpdump_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           sama5_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
powerpc                           allnoconfig
i386                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
ia64                             allmodconfig
m68k                             allmodconfig
s390                 randconfig-r044-20220826
arc                  randconfig-r043-20220823
riscv                randconfig-r042-20220826
arc                  randconfig-r043-20220826
arc                  randconfig-r043-20220825

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220827
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220827
riscv                randconfig-r042-20220827
x86_64                        randconfig-a016
s390                 randconfig-r044-20220827
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
arm                                 defconfig
arm                         bcm2835_defconfig
hexagon              randconfig-r041-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220825
s390                 randconfig-r044-20220823
hexagon              randconfig-r045-20220826
hexagon              randconfig-r041-20220826
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
riscv                randconfig-r042-20220823
hexagon              randconfig-r045-20220823

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
