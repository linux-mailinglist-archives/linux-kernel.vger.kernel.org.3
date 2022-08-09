Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FFD58D3BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiHIG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiHIG0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:26:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536471FCE8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660026404; x=1691562404;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yE35a2IxSIBfg8nMM4mCZ4kuuWBgoseAqjjHlklfAno=;
  b=aHXplBXL4cHXX67UbBBzI7PK58EfMXyMPZNPDM22EVerqjsU7T2yqlt1
   hoQ1wkAnGn6wHUx2gIgZzF480rvW1aMIdS8qmbiw09xrnsQE5+iCoVZ2X
   C7EDfm3MFRdX7ukR1E51+DeS1aMFWTkA+RNLV/M2mmxcSSPJFgY64FEBR
   V5qt71Z6m0DeypB2kl2+RazTdVlZh2E2lWBnl8juUqZfLbHae9fjhyDEH
   3FVj5AfwWXH4CgxNmj8WUftEI3+jK7jGeeUmVYKWvvahIahJaz9uaQi/x
   FAN7KCAKi/bAUv3OJXUeLs61pzzIjSVB80okl7Q9ej3zHt/9DEUjUdyoy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="377056263"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="377056263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="746932968"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2022 23:26:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLIhO-000Mnj-13;
        Tue, 09 Aug 2022 06:26:42 +0000
Date:   Tue, 09 Aug 2022 14:25:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e6cfcdda8cbe81eaf821c897369a65fec987b404
Message-ID: <62f1fdec.9qJ12Y0S3NSXyVKt%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e6cfcdda8cbe81eaf821c897369a65fec987b404  x86/bugs: Enable STIBP for IBPB mitigated RETBleed

elapsed time: 709m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-a003-20220808
x86_64               randconfig-a001-20220808
x86_64               randconfig-a002-20220808
x86_64               randconfig-a004-20220808
x86_64               randconfig-a005-20220808
x86_64               randconfig-a006-20220808
arc                  randconfig-r043-20220808
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
arm                              allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
arm64                            allyesconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                 randconfig-a001-20220808
i386                 randconfig-a002-20220808
i386                 randconfig-a003-20220808
i386                 randconfig-a004-20220808
i386                 randconfig-a005-20220808
i386                 randconfig-a006-20220808
x86_64                           allyesconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                 randconfig-c001-20220808
sparc64                             defconfig
arm                           u8500_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                    klondike_defconfig
arm                             ezx_defconfig
parisc64                            defconfig
powerpc                 mpc837x_rdb_defconfig
arc                         haps_hs_defconfig
nios2                            alldefconfig
sparc                            allyesconfig
m68k                          multi_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        realview_defconfig
arc                     nsimosci_hs_defconfig
arm                         assabet_defconfig
powerpc                     rainier_defconfig
sh                           se7619_defconfig
arm                            qcom_defconfig
m68k                          hp300_defconfig
csky                                defconfig
ia64                             alldefconfig
m68k                       m5275evb_defconfig
powerpc                        cell_defconfig
arm                         axm55xx_defconfig
powerpc                    sam440ep_defconfig
sparc64                          alldefconfig

clang tested configs:
hexagon              randconfig-r045-20220808
hexagon              randconfig-r041-20220808
riscv                randconfig-r042-20220808
s390                 randconfig-r044-20220808
i386                 randconfig-a011-20220808
i386                 randconfig-a012-20220808
i386                 randconfig-a013-20220808
i386                 randconfig-a014-20220808
i386                 randconfig-a016-20220808
i386                 randconfig-a015-20220808
x86_64               randconfig-a013-20220808
x86_64               randconfig-a012-20220808
x86_64               randconfig-a011-20220808
x86_64               randconfig-a015-20220808
x86_64               randconfig-a014-20220808
x86_64               randconfig-a016-20220808
arm                       mainstone_defconfig
arm                   milbeaut_m10v_defconfig
mips                      bmips_stb_defconfig
x86_64               randconfig-k001-20220808

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
