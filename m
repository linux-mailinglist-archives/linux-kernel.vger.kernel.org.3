Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29C58D067
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbiHHXMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHHXMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:12:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616415A3E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660000357; x=1691536357;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RYyLSmMpXhtwZy1cQJqjAYuvzQ44SPJYA1eymh8Uf/o=;
  b=KiJZqwfX208pOayyhCkd1RNqniHXsR3QPR4ki2K4bhMzuWOv0jDRZxyB
   /9p5R2T+o5ERdDVNFDBri4y1QGNzJ3BxogvePQAolOI28ILSbw0PS43CU
   lY0zbn+GRiL6PSgY/s1bABOAef2J440PCfgMIBl9xv4WW9LGYspyI0vrR
   hk/MhR7dnQRAtEzbopG7UbOvw73q/8sKgXWhQvPODB97LRr3EXR5akVUL
   buKT0HwUz9gzkx1+/DNDhCRCdaNVl4m/wf8V1MKrKtjTIUZ5EO2jb0h4O
   vFxI59PwfP4QCn+4o5pNWXSA2CpzW+db4ojG2mLcglH2nIm9C3ekv69Af
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291498251"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291498251"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 16:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="664177950"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2022 16:12:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLBvG-000MaH-2P;
        Mon, 08 Aug 2022 23:12:34 +0000
Date:   Tue, 09 Aug 2022 07:11:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP/fixes] BUILD SUCCESS
 48dd3559894cbfbd6ad5adb74cb2e60db74981ee
Message-ID: <62f1983d.NEhZQuOZrBmsvpz0%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP/fixes
branch HEAD: 48dd3559894cbfbd6ad5adb74cb2e60db74981ee  hwmon: (lm90) Fix error return value from detect function

elapsed time: 687m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
mips                             allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220807
i386                             allyesconfig
arm                                 defconfig
sh                               allmodconfig
riscv                randconfig-r042-20220807
x86_64                              defconfig
s390                 randconfig-r044-20220807
arc                  randconfig-r043-20220808
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a003-20220808
x86_64               randconfig-a001-20220808
x86_64               randconfig-a002-20220808
ia64                             allmodconfig
x86_64               randconfig-a006-20220808
x86_64               randconfig-a004-20220808
x86_64               randconfig-a005-20220808
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220808
riscv                randconfig-r042-20220808
hexagon              randconfig-r041-20220807
hexagon              randconfig-r041-20220808
s390                 randconfig-r044-20220808
hexagon              randconfig-r045-20220807
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64               randconfig-a014-20220808
x86_64               randconfig-a013-20220808
x86_64               randconfig-a012-20220808
x86_64               randconfig-a011-20220808
x86_64               randconfig-a015-20220808
x86_64               randconfig-a016-20220808
i386                 randconfig-a011-20220808
i386                 randconfig-a013-20220808
i386                 randconfig-a012-20220808
i386                 randconfig-a014-20220808
i386                 randconfig-a016-20220808
i386                 randconfig-a015-20220808

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
