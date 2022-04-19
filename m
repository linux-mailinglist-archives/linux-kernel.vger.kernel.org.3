Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D639A506D38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352090AbiDSNNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352135AbiDSNMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:12:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2149463B6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650373797; x=1681909797;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o20O9+6jXcWif5snFhuBg7R9/r5GeqAXVjS4hTtjZp4=;
  b=R+zsFXqY3qg6ESBmUM/SDB8o96QnAaIptG/WazrCQHddMRZDRETlr5Zn
   YLlwPSF8IRDCi4b+NFGFQQhqi5GjFIhHUpMhneLnIw8dIlNV7ib12O5HU
   fRIUIy1I1qjDIThLDHoQUr32U/WM1mxqO6yIexsmOyHCnHcj/sfFZIgb4
   zglNXc6guZ4ZKsTYjDU4Mqkn0e9HnwJS1huj6WuUVGY7naa82v7IYSlS3
   V86VkQNHjahT+dRRkZUJ/WeyKTD1ePBwUsMxgtU+Me+JXrK12Lnzs61W7
   27qFnhUjly1liG3qrGeVHCcimrJke9PdSWijr7KN+pw+YW1A68O2e/wMx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="243692837"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="243692837"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="529302235"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Apr 2022 06:09:55 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngncA-0005om-NS;
        Tue, 19 Apr 2022 13:09:54 +0000
Date:   Tue, 19 Apr 2022 21:09:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD REGRESSION
 d6932dca19b1a7cbccad9d4acede8229e61cf97a
Message-ID: <625eb46d.2vBpDJBHdzzQ5y4B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: d6932dca19b1a7cbccad9d4acede8229e61cf97a  rcu/nocb: Add an option to offload all CPUs on boot

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared (first use in this function); did you mean 'rcu_nocb_setup'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- i386-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- ia64-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- ia64-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- mips-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- mips-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- riscv-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- riscv-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- sparc-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
`-- x86_64-allyesconfig
    `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)

elapsed time: 911m

configs tested: 98
configs skipped: 3

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       bmips_be_defconfig
sh                          urquell_defconfig
arm                  randconfig-c002-20220418
i386                 randconfig-c001-20220418
x86_64               randconfig-c001-20220418
arm                  randconfig-c002-20220417
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20220418
x86_64               randconfig-a004-20220418
x86_64               randconfig-a006-20220418
x86_64               randconfig-a001-20220418
x86_64               randconfig-a002-20220418
x86_64               randconfig-a005-20220418
arc                  randconfig-r043-20220419
s390                 randconfig-r044-20220419
arc                  randconfig-r043-20220418
arc                  randconfig-r043-20220417
riscv                randconfig-r042-20220417
s390                 randconfig-r044-20220417
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                   sb1250_swarm_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a012-20220418
x86_64               randconfig-a013-20220418
x86_64               randconfig-a011-20220418
x86_64               randconfig-a015-20220418
x86_64               randconfig-a016-20220418
x86_64               randconfig-a014-20220418
i386                 randconfig-a011-20220418
i386                 randconfig-a015-20220418
i386                 randconfig-a016-20220418
i386                 randconfig-a012-20220418
i386                 randconfig-a013-20220418
i386                 randconfig-a014-20220418
hexagon              randconfig-r041-20220417
hexagon              randconfig-r041-20220418
hexagon              randconfig-r045-20220417
hexagon              randconfig-r045-20220418
riscv                randconfig-r042-20220418
s390                 randconfig-r044-20220418

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
