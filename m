Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940AB5ABCCE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 06:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiICEVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 00:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiICEUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 00:20:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00C85AB1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 21:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662178848; x=1693714848;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kWmZiNluUmvpy1ua3vJr7FsaopJvmUQevsR2l4xPRlg=;
  b=FTnK1V8kiSK63KtArJ7XzHP+h5Yydgk9gVf5z5qdb/zl6vK4IWOF8HWC
   /7Oev9NuhsSRpQ+Ue5ckMQobFmgUawOWgAez78sJGfvYRRPqSD8vv4SR1
   TW4FVuJtH6MMP0kc3sFJ2Tr1AEsibauHPy9t2gKP3ZRObC8s/7FbDqUXT
   jO0g7cgfSVIKD+UDYHYyfHks8Gsjx5J0WfAZh4zMzoE8i8eQ79v0dK+CB
   lzRCzBAsJjCJaT9E3YzHx6QKqO1qAbxtlA8DvmQ1LDJih4tCYdrmZsOvG
   ecN/d2cpzdWkjEMji05J/Yx1sV/SbDAzgTXEheOWACvoytffSPB9huxDc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="322292787"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="322292787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 21:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="941517088"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2022 21:20:47 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUKeE-00012l-35;
        Sat, 03 Sep 2022 04:20:46 +0000
Date:   Sat, 03 Sep 2022 12:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 fb4aa1d5342688f1688492791cd3301cd64e2a44
Message-ID: <6312d5fb.nnXFrcm8617ZxRcQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: fb4aa1d5342688f1688492791cd3301cd64e2a44  Merge branch into tip/master: 'x86/timers'

elapsed time: 931m

configs tested: 24
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
