Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B2584B89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiG2GQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiG2GQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:16:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2AD2AF6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659075388; x=1690611388;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XSZk6bvGXGWoh6yAStIVSnzdroxffXE+J0Cq7nDNA38=;
  b=jXfjrU6yhH5BSpEbQUTPA+Yy5wgEQQhfEHprUePEjFMkOPmdpHPu7DWN
   4ugwzV3HDhTki7s9sOZ7CoFsWNniM9U+qQY65rh6yCPo2SUFPA/6BtjvB
   0xRI42ZDdo7PnEMT3Jkjay5wIXv9LIbHOhn0XTki+BEixPJ5sQNrlvvc9
   djv/M84biK4xxDRbAP03Hat05YLroJS0Q0FlSxMMg9iuYMDLD40Rtzk7m
   y8/FVw1WqiExXceQDDMKxoQEXbeTwj4xYZneVBNOSaU6Ine5OjK70A+xu
   4W6pntvf7pntWD5akGKWLk/kCc/SP5K0w52HdoHr6sEJIjus8Z+1xYX5u
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289471083"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289471083"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="576828302"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 23:16:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHJIP-000BBO-2A;
        Fri, 29 Jul 2022 06:16:25 +0000
Date:   Fri, 29 Jul 2022 14:16:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5469982f2cdacdb7d9757479a71633e35e4f1e63
Message-ID: <62e37b24.+7G5EOFU9Z7fr422%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git master
branch HEAD: 5469982f2cdacdb7d9757479a71633e35e4f1e63  Merge x86/urgent into tip/master

elapsed time: 1119m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
powerpc                          allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a004
arm                                 defconfig
arc                  randconfig-r043-20220728
sh                               allmodconfig
x86_64                        randconfig-a013
riscv                randconfig-r042-20220728
x86_64                        randconfig-a002
x86_64                        randconfig-a011
s390                 randconfig-r044-20220728
mips                             allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a006
powerpc                           allnoconfig
i386                          randconfig-a012
x86_64                        randconfig-a015
i386                          randconfig-a016
arm                              allyesconfig
i386                          randconfig-a001
arm64                            allyesconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
i386                          randconfig-a005
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r045-20220728
hexagon              randconfig-r041-20220728
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
arm                         hackkit_defconfig
powerpc                      ppc44x_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig
mips                          rm200_defconfig
arm                  colibri_pxa270_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
