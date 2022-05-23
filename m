Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD522531693
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiEWQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbiEWQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:56:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90A5F74
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653324974; x=1684860974;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=590n7fUgUXkQ6ZlyaOBZwf0M8yMnckXPQyRfIbkaXbQ=;
  b=deEapkaAJP+8yClgvK2NRBFO2G42igNY4LvUmpp8eoJFJdXx0wcR7FdN
   rIpkuybtGfi4xIuySxG2fhY3VgxRcMxLVcnGhvaf/h8RO4IH6TAj5UJf1
   w4ZKKuFGeh0RINHFaWmZ9/LUGo6UONZit1irBWR6wvGV2nBIxiqLlRH30
   AJBASSUZiq6flPIP5zcOg9Xyqi91x4ZMUTVtbh2j5lePD16+Mzz9KiCEo
   xdUD3vU+3U4JiNudRjsMlFFgAf+wENI4g0kkK/NwalRYvx8Yo6mf0zzc/
   wYIdxW18T+dIDBoCKMGkOJT5Fr8JQQnwzp5NnrJ1P5JCcRXJxZmL23ory
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253787220"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="253787220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 09:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="526029735"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 May 2022 09:56:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntBLn-0001I6-1l;
        Mon, 23 May 2022 16:56:11 +0000
Date:   Tue, 24 May 2022 00:55:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 cfbb29a89e8b30b6838385fdf515a9e3535eb0ae
Message-ID: <628bbc84./ZopbAAIQo6yvkg7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: cfbb29a89e8b30b6838385fdf515a9e3535eb0ae  Merge branch into tip/master: 'x86/vdso'

elapsed time: 720m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                         axm55xx_defconfig
mips                     loongson1b_defconfig
mips                            ar7_defconfig
arm                            lart_defconfig
um                                  defconfig
arm                         lubbock_defconfig
m68k                            mac_defconfig
arm                          pxa910_defconfig
openrisc                         alldefconfig
mips                           jazz_defconfig
arm                        mvebu_v7_defconfig
sh                     magicpanelr2_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20220523
x86_64               randconfig-a006-20220523
x86_64               randconfig-a001-20220523
x86_64               randconfig-a004-20220523
x86_64               randconfig-a002-20220523
x86_64               randconfig-a005-20220523
i386                 randconfig-a001-20220523
i386                 randconfig-a006-20220523
i386                 randconfig-a002-20220523
i386                 randconfig-a005-20220523
i386                 randconfig-a003-20220523
i386                 randconfig-a004-20220523
arc                  randconfig-r043-20220523
s390                 randconfig-r044-20220522
riscv                randconfig-r042-20220522
arc                  randconfig-r043-20220522
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     mpc512x_defconfig
powerpc                          allyesconfig
powerpc                      ppc44x_defconfig
powerpc                    ge_imp3a_defconfig
x86_64               randconfig-a013-20220523
x86_64               randconfig-a012-20220523
x86_64               randconfig-a011-20220523
x86_64               randconfig-a014-20220523
x86_64               randconfig-a015-20220523
x86_64               randconfig-a016-20220523
i386                 randconfig-a013-20220523
i386                 randconfig-a012-20220523
i386                 randconfig-a011-20220523
i386                 randconfig-a014-20220523
i386                 randconfig-a015-20220523
i386                 randconfig-a016-20220523
hexagon              randconfig-r045-20220523
hexagon              randconfig-r045-20220522
hexagon              randconfig-r041-20220523
hexagon              randconfig-r041-20220522
riscv                randconfig-r042-20220523
s390                 randconfig-r044-20220523

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
