Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD555A29B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiFXU11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiFXU1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:27:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725881C77
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656102445; x=1687638445;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZCjO29ldwOYYPeZd6G+voqUBGRJoYUy4dDB65CyT2QI=;
  b=UidlwpYXUDwhugSBLZ5QGyLOnM8J4YGJ+OXMjaebotPVKH974t/v73/L
   9thTZtdDo9+v0NyRM0hZ61qsCzgoeTp8xvVEM9R7puRXwf3bpybisAleJ
   LPwNiVyDECODqd5sipXm3rbkNcf66oLGEdm1fAEB9Is38n70vrMB/yEBg
   aOjkFQv6V8AGf+2U0mBB47kIlppsqam6QL0h2FMiULyOMmvGAFjc+n4cu
   HyIgdiJVb2yn/wGKU1VBIV8BuQOk3lWJlxaJUsU1o2HU2uKMLd6cqWHrT
   3x/03QRUKz5oqJiJZFvBJLJmLZYvS7x0sm0rKZc5QdM1kAC0XDNERFm32
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="279848746"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="279848746"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="656789069"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jun 2022 13:27:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4ptj-0004gB-7c;
        Fri, 24 Jun 2022 20:27:23 +0000
Date:   Sat, 25 Jun 2022 04:27:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2ecab2ee56ba146b8f962fba74e9f12797ca7b7a
Message-ID: <62b61e19.hp/XF0RxSm5w6xrv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 2ecab2ee56ba146b8f962fba74e9f12797ca7b7a  Merge branch into tip/master: 'x86/vmware'

elapsed time: 724m

configs tested: 81
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
um                           x86_64_defconfig
m68k                          multi_defconfig
sh                                  defconfig
openrisc                  or1klitex_defconfig
xtensa                           alldefconfig
mips                  decstation_64_defconfig
sh                   sh7770_generic_defconfig
arm                           imxrt_defconfig
sparc                       sparc64_defconfig
sh                   rts7751r2dplus_defconfig
sh                             sh03_defconfig
s390                                defconfig
sh                          sdk7786_defconfig
sh                             shx3_defconfig
arm                           h3600_defconfig
arm                       aspeed_g5_defconfig
parisc64                            defconfig
powerpc                 mpc834x_mds_defconfig
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
ia64                             allmodconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220624
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     kmeter1_defconfig
powerpc                     kilauea_defconfig
x86_64                           allyesconfig
arm                   milbeaut_m10v_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220624
s390                 randconfig-r044-20220624
hexagon              randconfig-r045-20220624
riscv                randconfig-r042-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
