Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1943C53C72A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiFCIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiFCIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:53:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5C5F6F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654246395; x=1685782395;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wAckbd7b5AT72R9a2/eXkeom9yl4s1P+Xa6Z4g2IhNE=;
  b=mthJlqggRnxmw9XCSloBTlumYBPxbH++ckrBJZGtJsHmOtoB0/iXWXLE
   S9I4LWMOjy7IIPWIglYrIL9nc7lpDGMRNsBZ4MGvcW6W8M6AGnAQHPZXm
   rClUeAq1SRtDPEy7kQgr0tST/3kfy848d5T3KJEwpUyyOucxCpiazMxke
   2O6mW9ax6h2/x0/H+ZadNfp7O1j+r90WgUj/g7jRXth/5CuzHrx1clW5H
   Jru9TaDV9vwOPgBBmVu3pVccokwgaLK/Sij2myXSFOqdVMkjcEvR0D6Pq
   fESDA2erkgQR3TgjDoywl+9MgQhUF/t+wgKZh+Wv/iC7jmwIM053ON52J
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="258278763"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="258278763"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 01:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="824649762"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2022 01:53:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nx33R-00072f-0d;
        Fri, 03 Jun 2022 08:53:13 +0000
Date:   Fri, 03 Jun 2022 16:53:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dave.2022.06.02a] BUILD REGRESSION
 2efc5c4abe4cc1259378f7c1678a93540559673c
Message-ID: <6299cbf7.qEmZuKv6oQTgxYpC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dave.2022.06.02a
branch HEAD: 2efc5c4abe4cc1259378f7c1678a93540559673c  rcu-tasks: Maintain a count of tasks blocking RCU Tasks Trace grace period

Error/Warning reports:

https://lore.kernel.org/lkml/202206030549.YOUkgBlA-lkp@intel.com
https://lore.kernel.org/lkml/202206030613.IxQYmIW8-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/tasks.h:1239:8: error: variable has incomplete type 'typeof (({
kernel/rcu/tasks.h:1239:9: error: aggregate value used where an integer was expected
kernel/rcu/tasks.h:1245:9: error: aggregate value used where an integer was expected

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-buildonly-randconfig-r002-20220531
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- nios2-randconfig-r005-20220602
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- riscv-allmodconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- riscv-buildonly-randconfig-r003-20220531
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- riscv-buildonly-randconfig-r004-20220531
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- s390-allyesconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- sh-allmodconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- sparc-randconfig-r036-20220531
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
`-- xtensa-allyesconfig
    `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected

clang_recent_errors
`-- arm-buildonly-randconfig-r004-20220531
    `-- kernel-rcu-tasks.h:error:variable-has-incomplete-type-typeof-((

elapsed time: 811m

configs tested: 83
configs skipped: 3

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
ia64                                defconfig
ia64                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220531
riscv                randconfig-r042-20220531
s390                 randconfig-r044-20220531
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
