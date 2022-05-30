Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10D253892D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 01:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiE3X4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 19:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiE3X4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 19:56:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256B13D7F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653955007; x=1685491007;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KXDvnrXgD6ccKFur1BoBKCDKVnyaG3e8fuNQ9D2Qirk=;
  b=MfBmmSrxhbD+aiEIjmsOqRrPOWxUbrtEXfA+U0tNno7VhI8Oo2pgn4+C
   RZCSfIZc0CCntQsAuNX6XNT3raTqq/tZ/nydUGWLtBc0zfXFUDkTGbp1I
   A6/h1vdOCc3ysHVcz+d/haEXwg9ukJGEk6HQDBDsGo67oYScdX/IjImGM
   5kLt33ssAjWtcEwlRfPdRlucipaEp85sVeBgMVzPFdmHQtEsLjdgA7eaP
   CjAfAMHraSRMpxc17++LcyTxiQ9gZugau/RkWJcmNa/A3y7OHwBEXipgB
   MdK/Zt+j4G0wyCQAZz5DXdW1CTbYwltMirRDH54HFpS+8KslVywgmyHGR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="272668817"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="272668817"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 16:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="706318177"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2022 16:56:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvpFd-00026O-B9;
        Mon, 30 May 2022 23:56:45 +0000
Date:   Tue, 31 May 2022 07:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 82f586f923e3ac6062bc7867717a7f8afc09e0ff
Message-ID: <62955995.GlJPT3YQBJrvSXPu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: 82f586f923e3ac6062bc7867717a7f8afc09e0ff  sched/autogroup: Fix sysctl move

elapsed time: 726m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                           u8500_defconfig
arc                            hsdk_defconfig
sh                     magicpanelr2_defconfig
m68k                       m5475evb_defconfig
sh                           se7721_defconfig
sh                         apsh4a3a_defconfig
sh                          kfr2r09_defconfig
sh                            shmin_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
arc                              allyesconfig
nios2                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a002-20220530
i386                 randconfig-a006-20220530
i386                 randconfig-a003-20220530
i386                 randconfig-a004-20220530
i386                 randconfig-a005-20220530
i386                 randconfig-a001-20220530
x86_64               randconfig-a006-20220530
x86_64               randconfig-a005-20220530
x86_64               randconfig-a003-20220530
x86_64               randconfig-a001-20220530
x86_64               randconfig-a002-20220530
x86_64               randconfig-a004-20220530
arc                  randconfig-r043-20220530
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3

clang tested configs:
arm                      tct_hammer_defconfig
x86_64               randconfig-a011-20220530
x86_64               randconfig-a013-20220530
x86_64               randconfig-a012-20220530
x86_64               randconfig-a014-20220530
x86_64               randconfig-a016-20220530
x86_64               randconfig-a015-20220530
i386                 randconfig-a012-20220530
i386                 randconfig-a011-20220530
i386                 randconfig-a014-20220530
i386                 randconfig-a016-20220530
i386                 randconfig-a013-20220530
i386                 randconfig-a015-20220530
hexagon              randconfig-r041-20220530
hexagon              randconfig-r045-20220530
riscv                randconfig-r042-20220530
s390                 randconfig-r044-20220530

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
