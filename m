Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183CB5963BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiHPUbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHPUbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:31:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C7967C8A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660681863; x=1692217863;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=I7JnDK/RCQESjZRvOfO5uG5qH2chE5spoIiXK9YDFXY=;
  b=jwJb3dLSuVxZntV8zX6exTO2NJtfdTQ928wjHONaOn0ol73672t2SHEl
   I8xPELtUFyYBQtoNFWNyFOTaqhaCfZzMuEXtFWQOpIvozZwlzCm1rriss
   imb1KTpBmCEhrq4k9B4hrjmlfmR2k9O7/T8C+WDgQlPKWqb2XmSPANI+k
   3OcWXOunpkUO5SP3PUnkUpBLBmO5XnCU3lYBrNRqtkrvKNoekIS2q+6bb
   jSrSybrgvwEbmnr92bxEtdsXsJVXUV94adOnbN1fNlP13KJacJMZjOkWC
   QdH9at+iZP/Vqsoql/6r8S2h4rD19gyGP4RL+3dbJYiVEbISpHKp/KnTL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293118436"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293118436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 13:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="733432231"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2022 13:31:01 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO3DI-0000DR-2j;
        Tue, 16 Aug 2022 20:31:00 +0000
Date:   Wed, 17 Aug 2022 04:30:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 5b9f0c4df1c1152403c738373fb063e9ffdac0a1
Message-ID: <62fbfe55.LXyDP67JoO9vWuUP%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 5b9f0c4df1c1152403c738373fb063e9ffdac0a1  x86/entry: Fix entry_INT80_compat for Xen PV guests

elapsed time: 713m

configs tested: 98
configs skipped: 68

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a006-20220815
x86_64               randconfig-a003-20220815
x86_64               randconfig-a005-20220815
x86_64               randconfig-a004-20220815
x86_64               randconfig-a001-20220815
x86_64               randconfig-a002-20220815
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
i386                 randconfig-a004-20220815
i386                 randconfig-a006-20220815
i386                 randconfig-a003-20220815
i386                 randconfig-a002-20220815
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc              randconfig-c003-20220815
i386                 randconfig-c001-20220815
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                         bigsur_defconfig
powerpc                      chrp32_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
m68k                        m5307c3_defconfig
powerpc                     stx_gp3_defconfig
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig
arm                          simpad_defconfig
sh                          r7780mp_defconfig
arm                             ezx_defconfig
openrisc                 simple_smp_defconfig
openrisc                  or1klitex_defconfig
arm                         at91_dt_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                        nsimosci_defconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig

clang tested configs:
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
hexagon              randconfig-r045-20220815
arm                       versatile_defconfig
x86_64               randconfig-a011-20220815
x86_64               randconfig-a016-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a012-20220815
arm                       mainstone_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc832x_rdb_defconfig
i386                 randconfig-a011-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a016-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a013-20220815
hexagon              randconfig-r041-20220815
x86_64               randconfig-k001-20220815
arm                        multi_v5_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc832x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
