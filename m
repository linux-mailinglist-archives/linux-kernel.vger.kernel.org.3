Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18D586257
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiHABmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiHABmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:42:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BF6334
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659318126; x=1690854126;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=f6A94/AbCD2zeg1OTcqBVC3mr6x9cCno7xyjb7ct57o=;
  b=TplBBSP6UCQKQDYJFxo1SLLqORsJv31nfvY7W8hmPIP4MI9cWXZLy7Tl
   3OIvhWHU0iqmSdonFqRFUBG9bPSULTNKsaGXVhRVOsqZV7ZV/UlTjsI70
   m56yZZ2Pd/ijUE0uutCIwb2ne40WWhf7dz7XaQMk0Vhr7GCEtEqq+n6Vx
   nPaHLFnLp4s6g7l0g/z5hDnmLLRjxZELJMx/dHEhSFbTgOZ6yibWxSw/I
   ANY+sbM+0wmc5nmv2wy72s+F5WAqfWmC009Zyt6auAoAy3CJIHgWL1YHQ
   WQjx1y+dQq48VFoKI1c+1jd9f3smTM8pv3WR/n7rhdwDsO9+M3hHNDUFv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="268808645"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="268808645"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 18:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577607411"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 18:42:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIKRY-000Egg-1h;
        Mon, 01 Aug 2022 01:42:04 +0000
Date:   Mon, 01 Aug 2022 09:41:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 44a4ddede9cf44627ea6e30b339caeb39cea46af
Message-ID: <62e72f3f.3m37BTkjZi+FqMpT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 44a4ddede9cf44627ea6e30b339caeb39cea46af  Merge branch into tip/master: 'x86/vmware'

elapsed time: 712m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                  randconfig-r043-20220731
riscv                randconfig-r042-20220731
s390                 randconfig-r044-20220731
x86_64                              defconfig
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                               rhel-8.3
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
arm                                 defconfig
x86_64                        randconfig-a004
arm                              allyesconfig
i386                          randconfig-a003
arc                               allnoconfig
x86_64                        randconfig-a002
alpha                             allnoconfig
riscv                             allnoconfig
i386                          randconfig-a005
x86_64                        randconfig-a006
powerpc                           allnoconfig
csky                              allnoconfig
mips                             allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a014
arc                              allyesconfig
ia64                             allmodconfig
i386                          randconfig-a012
alpha                            allyesconfig
i386                          randconfig-a016
sh                               allmodconfig
m68k                       m5475evb_defconfig
arm                            zeus_defconfig
sh                   sh7724_generic_defconfig
sh                          rsk7203_defconfig
sh                   sh7770_generic_defconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                       bmips_be_defconfig
arm                           h3600_defconfig
powerpc                    amigaone_defconfig
powerpc                      mgcoge_defconfig
mips                      maltasmvp_defconfig
nios2                         10m50_defconfig
mips                        vocore2_defconfig
mips                             allmodconfig
s390                          debug_defconfig
i386                          randconfig-c001
s390                 randconfig-r044-20220801
arc                  randconfig-r043-20220801
riscv                randconfig-r042-20220801
sh                        sh7763rdp_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
parisc                generic-64bit_defconfig
arm                          pxa910_defconfig

clang tested configs:
hexagon              randconfig-r041-20220731
hexagon              randconfig-r045-20220731
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015
arm                            dove_defconfig
powerpc                  mpc885_ads_defconfig
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
