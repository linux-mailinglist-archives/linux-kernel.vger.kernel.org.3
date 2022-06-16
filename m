Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47B54EA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378168AbiFPTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiFPTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:34:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F985715B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655408055; x=1686944055;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g8JN9o2azBOeoFzFmUP6z+SaTbSfQgezcqAfmpF2rL0=;
  b=MSlby5LF4AvZGgcA6BGORiC2Tc4CVL2cB7tNrO7gqMrlu6HZXd16y+KR
   SY5NqdPAo/gIpZ+lm4VJccITxKIhjucirLNRjXigg643EBnQDs9J39u38
   G1ccNka/Z6P/2kk0NiamuWbuOtOsMRaYYGqJP33PRxgD3LP9pRsbWEzdv
   ip6jL9Dcs5XZMvanow26gCIeM+7FIcaFgubcCQh9Pwa3mSi1ZhisiIcCo
   OK7ba4p1DTpkF8n94Z199DCFXU/kvOLRyvLqIL2tFfE2Swn0Lusk314Y6
   zgcTQbO+JCr/zQdYLyEiF7ErcJcHz7kIpP2lcLxCVRhKSeCIWJpufD552
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280049021"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280049021"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 12:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="687961309"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2022 12:34:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1vFs-000Ohx-Bw;
        Thu, 16 Jun 2022 19:34:12 +0000
Date:   Fri, 17 Jun 2022 03:33:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:pmladek.2022.06.15a] BUILD SUCCESS WITH WARNING
 0ba7324b44282870af740a5a121add62c7f5f730
Message-ID: <62ab8587.j8Ju7IuzIFZk71FR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git pmladek.2022.06.15a
branch HEAD: 0ba7324b44282870af740a5a121add62c7f5f730  printk: Wait for the global console lock when the system is going down

Warning reports:

https://lore.kernel.org/lkml/202206160411.v3iL3YC0-lkp@intel.com
https://lore.kernel.org/llvm/202206160421.Gnl3tpxc-lkp@intel.com

Warning: (recently discovered and may have been fixed)

vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-r003-20220516
    |-- vmlinux.o:warning:objtool:__ct_user_enter:call-to-__kasan_check_read()-leaves-.noinstr.text-section
    `-- vmlinux.o:warning:objtool:__ct_user_exit:call-to-__kasan_check_read()-leaves-.noinstr.text-section

clang_recent_errors
`-- x86_64-randconfig-a005-20220613
    |-- vmlinux.o:warning:objtool:ct_kernel_enter:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:ct_kernel_enter_state:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:ct_kernel_exit:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    `-- vmlinux.o:warning:objtool:ct_kernel_exit_state:call-to-ftrace_likely_update()-leaves-.noinstr.text-section

elapsed time: 1477m

configs tested: 51
configs skipped: 3

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
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
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
