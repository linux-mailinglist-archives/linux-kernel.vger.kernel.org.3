Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412FB50CDEC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiDWWZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDWWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:25:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3D178595
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 15:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650752562; x=1682288562;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zMdk6iWzkyTLRUXdH9dO6D6JnfUoMkjdmflzUIYl5jc=;
  b=mDRwvUljR8gc2IgCAon2vTWZ8AJUKjqwxxx8tHcXTPMU5orWSZVhuB9H
   9BBaTAi4E0iBsZPiI4DLaKsaBeYZNWOd0UvDlHG9+0KCymtOiSMahwCsf
   Hib786EP+fyAvNFkxLOd2qd3CFP3QqOljFe5JFekbZxk+dMoUTAASaSK4
   MdZKAdYWCT76DOpsdQ2ThTJrj/FdjebBu09QZgO1iLlURwWOPtYYx2RY6
   vBEeqxqazQOjDKIq0XwtzlIKbpr3C78BsqXgBLQMYzZHiG99FJSR+vSPd
   zRinNATYFjoRkWE/ZkWJqTe5aFYVJDFa/CmOA2Z6y4B9ksIztoBLhpDg8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="252302937"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="252302937"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 15:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="627484592"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2022 15:22:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niO9I-0000aJ-0Y;
        Sat, 23 Apr 2022 22:22:40 +0000
Date:   Sun, 24 Apr 2022 06:21:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 4abff6d48dbcea8200c7ea35ba70c242d128ebf3
Message-ID: <62647bf8.EakSbgl+YDP5DGcj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: 4abff6d48dbcea8200c7ea35ba70c242d128ebf3  objtool: Fix code relocs vs weak symbols

elapsed time: 2134m

configs tested: 130
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sparc                               defconfig
arm                       aspeed_g5_defconfig
sh                          rsk7201_defconfig
m68k                         apollo_defconfig
ia64                             allyesconfig
nios2                         10m50_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
um                                  defconfig
arm                          simpad_defconfig
powerpc                      pcm030_defconfig
powerpc                   currituck_defconfig
arm                        shmobile_defconfig
powerpc                       holly_defconfig
mips                        bcm47xx_defconfig
sparc64                             defconfig
um                               alldefconfig
ia64                        generic_defconfig
arm                           viper_defconfig
m68k                             allyesconfig
ia64                         bigsur_defconfig
sh                        apsh4ad0a_defconfig
arm                           sama5_defconfig
mips                 decstation_r4k_defconfig
powerpc                     redwood_defconfig
arm                         cm_x300_defconfig
sh                           se7705_defconfig
arm                          iop32x_defconfig
arm                         assabet_defconfig
m68k                       m5475evb_defconfig
powerpc                 canyonlands_defconfig
arm                        trizeps4_defconfig
sh                           se7751_defconfig
arc                          axs103_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220422
mips                 randconfig-c004-20220422
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220422
powerpc              randconfig-c003-20220422
powerpc                      acadia_defconfig
mips                           ip27_defconfig
riscv                            alldefconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     ksi8560_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc836x_mds_defconfig
mips                          ath25_defconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
mips                     cu1830-neo_defconfig
riscv                    nommu_virt_defconfig
mips                       rbtx49xx_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220422
s390                 randconfig-r044-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
