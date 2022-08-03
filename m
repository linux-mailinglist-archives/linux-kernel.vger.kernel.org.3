Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECEC5888A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiHCITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiHCITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:19:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0445E60D0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659514740; x=1691050740;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AxTT9CLPbIJFu1VLIYTyPklDwuwKIe3EdKtfLuw7R1E=;
  b=CnkHCQJyKCBW1g4Hxx414Y+5efNrwxdzsNmbQjpWq+N+e2gGIm9kQwPz
   O06nK2Uhp0pHrag4bmPEouXnobr82O4oUQ/rBZ9M11F8WVhLZKaRE7vYo
   1xA5r5BV51GKJEDgg/NHSqx6NxH54tk3A/7dT5HVfoLJ9NpxlZcsqjIv3
   qOtw5E7Nc6Ed3p8G9EoQIZsmgdRpq5o9TAJbHpZtWUvF5tNfOSZoIRXUs
   IZbdPTYTdqBQO4IBscpENhMuBqMOqbn1PosCw48vxPVaVhxRrX1dqQqWd
   Txo3t1qvA0QwysWmP+mNRgZRAEIt2CdmpXlJm44uXfUeMZi2beUdAovjf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287177104"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="287177104"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 01:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="578555883"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 01:18:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ9ai-000H2Z-1v;
        Wed, 03 Aug 2022 08:18:56 +0000
Date:   Wed, 03 Aug 2022 16:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 41101f1279fc264ae055400f752016bbca367012
Message-ID: <62ea2f5c.ZmVipJOPJeplKZ5V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 41101f1279fc264ae055400f752016bbca367012  Merge branch into tip/master: 'perf/urgent'

elapsed time: 720m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a011-20220801
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
i386                 randconfig-a012-20220801
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20220801
arc                  randconfig-r043-20220801
x86_64               randconfig-a012-20220801
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
arm                              allyesconfig
x86_64               randconfig-a013-20220801
arc                              allyesconfig
x86_64               randconfig-a016-20220801
s390                 randconfig-r044-20220801
x86_64               randconfig-a014-20220801
i386                 randconfig-a013-20220801
alpha                            allyesconfig
i386                 randconfig-a014-20220801
m68k                             allyesconfig
x86_64               randconfig-a015-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a016-20220801
i386                 randconfig-a015-20220801
ia64                             allmodconfig

clang tested configs:
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a006-20220801
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a006-20220801

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
