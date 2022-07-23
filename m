Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6571F57EC3D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 08:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGWGGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 02:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGWGGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 02:06:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3513F98
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658556368; x=1690092368;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0U04/hlhxSMkFEfSnteCgKSBOKLy0iO+QpRplCLAmUg=;
  b=Y0w7F7iKtpuzYdYo/yJX66ZYuLQ5mK8dTWZNSDDz+oCm8V5e6Sas4Up6
   OIGJveZlB7oRBYdqPHPRFx0mE7+XUz1gm2zBz8NjeAsDx5sppN97jrTu7
   HWrlqY/MwuPIpJi8YrgUeuwPytgfL8wRXAFBCWc1wCbcNj9MdInW67UPM
   c+64bxVztzxBY4Y+aCYhKU/qP3pnwhfF4zpZ063Teok2ggsiTK/JLkjom
   zI5KBenVp4j3aarLRJxRbP2PC+J9Sb5ttUxAS3cnruL7LBWORlOQzSKWr
   V8diEQUZIVZHHmpeY5Cj2+PJcHl+4oUySHUuZWLp+BCinjbSB3EzYBg0m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267222188"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="267222188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 23:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="574413752"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2022 23:06:06 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF8H7-0002JR-1E;
        Sat, 23 Jul 2022 06:06:05 +0000
Date:   Sat, 23 Jul 2022 14:05:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 57262d2c56b8c67c5d29a2e81b740a8d26174dc3
Message-ID: <62db8fc6.25C2K02cAHkaxp3Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 57262d2c56b8c67c5d29a2e81b740a8d26174dc3  selftests/nolibc: Avoid generated files being committed

elapsed time: 1720m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                 mpc834x_itx_defconfig
m68k                          atari_defconfig
m68k                                defconfig
sh                          r7785rp_defconfig
sparc                       sparc64_defconfig
sh                             sh03_defconfig
powerpc                     sequoia_defconfig
xtensa                           alldefconfig
csky                                defconfig
arm                          gemini_defconfig
powerpc                       ppc64_defconfig
ia64                             allmodconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220721
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                       mainstone_defconfig
mips                        bcm63xx_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     akebono_defconfig
powerpc                 mpc8272_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
s390                 randconfig-r044-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
