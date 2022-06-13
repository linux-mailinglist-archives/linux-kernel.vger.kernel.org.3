Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A372E54A0B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbiFMVAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351758AbiFMU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:58:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B033012D0A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655152441; x=1686688441;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gvTKX4MT49W3mutIi4G3RbLX2M0ZvCLXzs86p7XGBCk=;
  b=Bm9MnQTW94nkDlTruTRyIddLa7s0xPB/5kDSPRz4a0SfhBUOd/bq94bi
   YLUyFD6wl38uHiXQRdNcouBBkxuXui6MCmO94LulzVmDyA8nH6Y1l8JCE
   RIlkdJY5kv7FZOMmwuzGhNkRZKrXRDOjMQrgj5mfEEEfgOkodTwDZz8st
   2OWcW2j8TKoGEE/EovzSX6MCf59ZK4KMtI6rDXiH7KMRfO1D+tKwRUwlE
   kekJPDd/hgrI1N+yMoVCPpEpzk4wLElVbha0FQ5QOHSEM20FQvpl4da+q
   D4M00m4K629Fru5UnR5/pKccnC32e6o5U73b5Mv0AADFTTWaLxtr7I063
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="275935640"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="275935640"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 13:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="829988576"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 13:34:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0ql5-000L7d-JN;
        Mon, 13 Jun 2022 20:33:59 +0000
Date:   Tue, 14 Jun 2022 04:33:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e32683c6f7d22ba624e0bfc58b02cf3348bdca63
Message-ID: <62a79eff.XN6sBRrGzmtjnu6l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/urgent
branch HEAD: e32683c6f7d22ba624e0bfc58b02cf3348bdca63  x86/mm: Fix RESERVE_BRK() for older binutils

elapsed time: 724m

configs tested: 97
configs skipped: 90

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220613
arm                        trizeps4_defconfig
arm                       aspeed_g5_defconfig
arm                            mps2_defconfig
sh                        edosk7705_defconfig
sh                         apsh4a3a_defconfig
arm                           h3600_defconfig
powerpc                     mpc83xx_defconfig
mips                          rb532_defconfig
powerpc                         ps3_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8555_defconfig
powerpc                      cm5200_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
mips                     loongson1b_defconfig
openrisc                         alldefconfig
x86_64               randconfig-k001-20220613
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
x86_64               randconfig-a015-20220613
x86_64               randconfig-a014-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a012-20220613
x86_64               randconfig-a013-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a012-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
riscv                randconfig-r042-20220613
arc                  randconfig-r043-20220613
s390                 randconfig-r044-20220613
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
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
mips                           mtx1_defconfig
x86_64               randconfig-a002-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a003-20220613
x86_64               randconfig-a004-20220613
x86_64               randconfig-a006-20220613
x86_64               randconfig-a005-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a006-20220613
i386                 randconfig-a005-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
