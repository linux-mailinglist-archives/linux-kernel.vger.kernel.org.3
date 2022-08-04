Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7758A2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiHDVxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:53:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C799E99
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659650018; x=1691186018;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6T0NBZXCpqtaao1kys1WExwQYMUr16QwE0w4vUF/ICo=;
  b=d8crhBNY55R/mDBeBSrDogRUC7ZgSOksljX+y7iPKrt20qEOSOOLsQa+
   3Aq0D6LUOnESLlu9q9BOUVku7Qe8NBeRK1u4jTCrdZG4Vd/6stbR+yNj7
   P68QMM3YFxooqFVrdRy3T1EwbBXFi7/UbEM26FM/XjdHL8rdN+LOyT04M
   +NY0xuPJGkjBV0BpHkWQQrEsDwwTRslrNcHzB/wKDvLzn3Gc1tjt154qW
   5j1wuMmLG5HLTmUKmAb/ZcYQ17Gi5xhBCybLIy1IrUmQi9gWjZvfBkOcS
   OqO/dounKkmrKCQr+pjOTx4jE6SAphBFAmA5qSx4U/wa+G7N638fdo436
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354051605"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354051605"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="930985992"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2022 14:53:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJime-000Isx-0D;
        Thu, 04 Aug 2022 21:53:36 +0000
Date:   Fri, 05 Aug 2022 05:53:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 751d4cbc43879229dbc124afefe240b70fd29a85
Message-ID: <62ec3fd1.zA1ZCcDxCH9PJTVr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 751d4cbc43879229dbc124afefe240b70fd29a85  sched/core: Do not requeue task on CPU excluded from cpus_mask

elapsed time: 697m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                                defconfig
um                             i386_defconfig
i386                             allyesconfig
um                           x86_64_defconfig
sh                               allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220804
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
x86_64                        randconfig-a006
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig
arm                                 defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
mips                             allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220804
riscv                randconfig-r042-20220804
hexagon              randconfig-r041-20220804
x86_64                        randconfig-a012
s390                 randconfig-r044-20220804
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
