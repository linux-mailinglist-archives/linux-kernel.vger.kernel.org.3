Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4258D068
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiHHXNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHHXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:13:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1775115A3F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660000417; x=1691536417;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iH4FhxAKE2sXD2t/hGvnZkdZMrd2QCDKQSefnfWw7/M=;
  b=asCrhGWLrb+/RFopS1FILLckb+rORqwLSJi01lixalyXFhavn3eaCVq/
   Uiv8KLUXzNZELf9NOBYo94mu+RFHN5l59xn8snS/gdA+IEGApxPicUpFf
   mOv95SUDLnZa6ag0vpnXR7HwzULOCYk8kQv/FFnM8STqVYXLr7b4QSJYj
   Nzvu+35V2sLQdmzsazFp6ObYnUkzIZL41RDCUP1sk4uswKPIwfdoKu0K/
   doAsVRhV+Zcnw++Mc7MAjvgTFgw7DXoWR0EK/HOJfkSCgCw5W15hporaS
   wXm+X9icKl//RbXOgkaYCzwiQ3E1kL7dKMFek6qQPrpuTsNof47N/5KrZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291949491"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291949491"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 16:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="633098928"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2022 16:13:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLBwE-000MaL-2T;
        Mon, 08 Aug 2022 23:13:34 +0000
Date:   Tue, 09 Aug 2022 07:12:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0dc2dd2cb4add7cd6075249c4067b4a7f5af8e7f
Message-ID: <62f1986b.JADZ6do+fB89Wp9d%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0dc2dd2cb4add7cd6075249c4067b4a7f5af8e7f  Merge branch into tip/master: 'WIP/fixes'

elapsed time: 716m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allyesconfig
i386                 randconfig-a001-20220808
i386                 randconfig-a002-20220808
i386                 randconfig-a003-20220808
i386                 randconfig-a005-20220808
i386                 randconfig-a004-20220808
i386                 randconfig-a006-20220808
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
m68k                             allmodconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220807
arm                              allyesconfig
powerpc                           allnoconfig
arm64                            allyesconfig
i386                          randconfig-a014
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
riscv                randconfig-r042-20220807
mips                             allyesconfig
s390                 randconfig-r044-20220807
alpha                            allyesconfig
arc                  randconfig-r043-20220808
m68k                             allyesconfig
x86_64                           allyesconfig
x86_64               randconfig-a003-20220808
x86_64               randconfig-a004-20220808
x86_64               randconfig-a001-20220808
x86_64               randconfig-a002-20220808
x86_64               randconfig-a005-20220808
x86_64               randconfig-a006-20220808
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-c001-20220808
arm                             ezx_defconfig
parisc64                            defconfig
powerpc                 mpc837x_rdb_defconfig
arc                         haps_hs_defconfig
nios2                            alldefconfig
sh                ecovec24-romimage_defconfig
mips                      loongson3_defconfig
loongarch                        alldefconfig
sh                           sh2007_defconfig

clang tested configs:
x86_64               randconfig-a013-20220808
x86_64               randconfig-a015-20220808
x86_64               randconfig-a012-20220808
x86_64               randconfig-a011-20220808
i386                          randconfig-a013
i386                          randconfig-a011
x86_64               randconfig-a014-20220808
x86_64               randconfig-a016-20220808
hexagon              randconfig-r045-20220808
i386                          randconfig-a015
riscv                randconfig-r042-20220808
hexagon              randconfig-r041-20220807
hexagon              randconfig-r041-20220808
s390                 randconfig-r044-20220808
i386                 randconfig-a016-20220808
i386                 randconfig-a013-20220808
i386                 randconfig-a015-20220808
i386                 randconfig-a012-20220808
i386                 randconfig-a011-20220808
i386                 randconfig-a014-20220808

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
