Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C806B516D59
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384195AbiEBJbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384178AbiEBJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:31:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1EF1A825
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651483651; x=1683019651;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ymyjtlFY8aDgrK7Ap03FuN6MXygMAWjvP0TpU/yCBhY=;
  b=aFdNijHNQkdhXYB5lemQ8GLRxeZ9XqWewT5ujAnGYQHcc2RyQYo8iBhn
   p45/1WPeKNioJeM5M8tg5VMT41uhnQffEgCfJ1G91QGsw/5UamiCZmw76
   jbqV7AoYEPGK9TJ/wCXSvgD6RStB2I2cKqzwrXKxTjZbNlvS+naKDAahT
   uNneamXWNAI/npEKHx4xsLXQkmn9LHnZxByNjl9uFmyp+pcVbTIGGYeSw
   XoEb3bQ5SI5ejF363gMopi1r9YRGnwS7badnnt6SeR8+2HGhLlYAt40KZ
   AdT2FEEBMNHpgo8luPVb6+5IWM6qiHh83E3iMnHFUX8RvPzX/rh1tSw4x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="249143642"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="249143642"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 02:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="515999524"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 02:27:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlSL3-0009S3-HV;
        Mon, 02 May 2022 09:27:29 +0000
Date:   Mon, 02 May 2022 17:26:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 7a116a2dd32d96869f0f93bac00b900859ba0434
Message-ID: <626fa3e0.Ife61lYMDsuDbrig%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 7a116a2dd32d96869f0f93bac00b900859ba0434  x86/apic: Do apic driver probe for "nosmp" use case

elapsed time: 729m

configs tested: 79
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                       bmips_be_defconfig
arm                         nhk8815_defconfig
csky                                defconfig
arm                        oxnas_v6_defconfig
powerpc                    amigaone_defconfig
microblaze                      mmu_defconfig
sh                          polaris_defconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                          kfr2r09_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8555_defconfig
arc                     nsimosci_hs_defconfig
mips                             allmodconfig
sh                              ul2_defconfig
ia64                        generic_defconfig
sh                          rsk7269_defconfig
powerpc                       maple_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
ia64                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                              debian-10.3
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
arm                         palmz72_defconfig
arm                         socfpga_defconfig
powerpc                   bluestone_defconfig
x86_64                           allyesconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
