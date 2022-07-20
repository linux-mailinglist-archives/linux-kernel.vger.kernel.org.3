Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE957B339
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiGTIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiGTItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:49:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E7166ACB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658306961; x=1689842961;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uIH1pWVWOe5VxfNgXESkyLnBEOvNDU9wIlNkt1K0Vdo=;
  b=mdYSszlFrf6fVA5oa0clvJq3Kzp0KvjOZX93dO/sp85CAm/+c7ST8sV5
   59383k6NSujo4kR8DAJWtmbkAv2sJfPi6nwqW49XTTgpHkBpUTh+Byf8p
   8eRkJW/musZbOCQ9P30xYQhZg4IjcS/3RcpYJF0vdrmIgeyUbp9TkhUUT
   FFCu1MSieqzd+Wg3PpoTeJCZWIZooxOU4mKwW1u3By0i5KPSFbZoEaXYk
   og5i9jVI5NorHZOSsVHTTrYX6oYubr9aEfMIOJgAnzArC/OlAPvqFsygu
   oSh/zkxbty71Fn9rJaM1uRBtd9csI2WGfiUB/dsuZgg2vuig1x3tSSwZs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269747240"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="269747240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 01:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="625577174"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2022 01:49:19 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE5OR-0000It-Bp;
        Wed, 20 Jul 2022 08:49:19 +0000
Date:   Wed, 20 Jul 2022 16:48:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 9f01129382774d98ec21526f13da26a0630ee3d8
Message-ID: <62d7c167.Cb1ri5iRX3LSzn8x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 9f01129382774d98ec21526f13da26a0630ee3d8  intel_idle: Add a new flag to initialize the AMX state

elapsed time: 904m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc                      ep88xc_defconfig
arm                      footbridge_defconfig
x86_64                              defconfig
sh                        sh7757lcr_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a013-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
