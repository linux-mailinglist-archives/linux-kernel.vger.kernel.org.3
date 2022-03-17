Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907304DCF9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiCQUob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCQUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:44:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4073163E17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647549791; x=1679085791;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HvPciZAkV4hSYDrRdNDz9KtkNzvTDaaFCpDcxV7tsFY=;
  b=FdTrKbv1FISBVkRYWeQHT4EsjXJuiY8m1TbkZ9bmn4cVM4Vc5lOUPHrR
   0xDTy0v/+vtH9XkjdySSPAramtECT3oo+YnTnpDr99jd7glsD0cs1A1WG
   9ZFd+Pg6W+F5pYVO3S2+jKgyDR+wciG1kSD6tlryI47Y5VoLpXr3JGxWU
   QtsHAk19l3t29sYFlU3KYWdMtc30qWXWdBZXheqyQr3jrq79PUSfjyMzA
   NNlyK2dmMc/1z00qcWBpPZlbKTXyC5hCN7pBibYRSm4JStc1ryVox1qy+
   Tv7ICW0m9sr5C6pOv6JIp1UYL7edVESS5sVSH/MICNTOXxHW1zqwiK2AU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237593128"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="237593128"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="715188885"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 13:43:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUwxh-000E3z-LM; Thu, 17 Mar 2022 20:43:09 +0000
Date:   Fri, 18 Mar 2022 04:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:merge.2022.03.15a] BUILD SUCCESS
 2747a744e72828bcbcb65a206ced6fe9c34c5d7f
Message-ID: <62339d3d.d6iqbtFYVDIpfx9E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git merge.2022.03.15a
branch HEAD: 2747a744e72828bcbcb65a206ced6fe9c34c5d7f  Merge commit '04d4e665a6090' into HEAD

elapsed time: 749m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
powerpc                     tqm8548_defconfig
sh                          kfr2r09_defconfig
xtensa                              defconfig
parisc                generic-64bit_defconfig
sh                               alldefconfig
powerpc                     tqm8541_defconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
sh                        edosk7705_defconfig
mips                           ip32_defconfig
arm                            xcep_defconfig
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220317
riscv                randconfig-r042-20220317
s390                 randconfig-r044-20220317
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                            mmp2_defconfig
mips                           ip22_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                         tb0287_defconfig
arm                       versatile_defconfig
arm                         orion5x_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220317

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
