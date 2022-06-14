Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7654A831
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350846AbiFNEgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbiFNEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:36:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163052E6BE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655181376; x=1686717376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vISsISBvSfRXzNaWchMWOXQwZ2FNET8hE5Vunm1WHtg=;
  b=gbe58EzfYV7T6ZgVAWjR/ISVQBN7TwOV0/wFJ+QO3T1d4P1tozA4z8Jv
   j++QvY3ApUHTeq1BpkqdZMbdUmG5JryM6BtvjpsjQqgPkTD/4b3efmGG6
   0S+OJyiCkULGPhK2ziFKSnwo+Fwrhz73YL/e4Y3XAdkD/5D7f09VwQXFr
   rXiZ1OdU7ci+BHHhs1nf+JrmHqjBGEBHmhtLtkU1Kl15t01NEyNBRxMyN
   Id/IwMJ6BlSU7bNwDdAKxjR+NHuMlanj7MdIYhwHwO3xB4dISWpnr77cx
   bj7WACy5fOytBUKm5oliUBrDmdFt6TTR9JXIb0xfTLo0ysXrkqIIZBx7p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279542720"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279542720"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910759867"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2022 21:36:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0yHl-000LTs-EA;
        Tue, 14 Jun 2022 04:36:13 +0000
Date:   Tue, 14 Jun 2022 12:35:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:arm64-scs-patching-v3 3/3] ld.lld: error: undefined symbol:
 scs_patch
Message-ID: <202206141211.OYR97qyn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-scs-patching-v3
head:   0da13e3a0d40aa97f6f59e72d5c72fdd3475dc2d
commit: 0da13e3a0d40aa97f6f59e72d5c72fdd3475dc2d [3/3] arm64: implement dynamic shadow call stack for Clang
config: arm64-randconfig-r001-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141211.OYR97qyn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=0da13e3a0d40aa97f6f59e72d5c72fdd3475dc2d
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-scs-patching-v3
        git checkout 0da13e3a0d40aa97f6f59e72d5c72fdd3475dc2d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: scs_patch
   >>> referenced by module.c:537 (arch/arm64/kernel/module.c:537)
   >>> kernel/module.o:(module_finalize) in archive arch/arm64/built-in.a
--
>> ld.lld: error: undefined symbol: dynamic_scs_enabled
   >>> referenced by module.c
   >>> kernel/module.o:(__jump_table+0x28) in archive arch/arm64/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
