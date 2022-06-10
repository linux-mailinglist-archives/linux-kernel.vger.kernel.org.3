Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BAE546FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347347AbiFJXFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiFJXE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:04:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12093525A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654902296; x=1686438296;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6G7K9PLHT3WpnM85njUgGyQ7zZIAHOlnaQHj0mDwvx0=;
  b=KBvnGIKxLnUlYNidJ3+ZsjYfNpbZvzxVN68IpoiYcG3S8ddz4c2IYe6H
   BfnHARM1pQ5RPYw2cEKAijasbOGFdFFas3lP1mEQERfF6HECTHeS1qzyY
   lgYlHuxRXf8CpREtRAhAGqjuCQBIF6f/0sOAEjpbT9OVfujMskEGvcoDN
   RukkRSDOY5FSLTYLCHjXgV9YzX5eHeCIk6qOq34nWsKeeWwJKZc4JQiWV
   1z0fWoDrDQdYfi0v+kv1x1vEOcwvcAdjeffCW+VjTs0O8oyeFG1Uk6g8u
   4ofe79gdc1Y17/MItsL7IWSRfqg2A3VjA+onkS9Mgp487nf78f76VN1Gs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="276554506"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="276554506"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="586437690"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2022 16:04:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzngU-000ILh-S4;
        Fri, 10 Jun 2022 23:04:54 +0000
Date:   Sat, 11 Jun 2022 07:04:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sakkinen <jarkko@profian.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jarkko-tpmdd:kprobes 3/3] arch/arm/kernel/module_alloc.c:24:7:
 warning: no previous prototype for function 'module_alloc'
Message-ID: <202206110716.TCuKUFdZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git kprobes
head:   8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
commit: 8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3 [3/3] kprobes: Enable tracing for mololithic kernel images
config: arm-mxs_defconfig (https://download.01.org/0day-ci/archive/20220611/202206110716.TCuKUFdZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 70d35fe1257e429266b83025997b400e9f79110e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd kprobes
        git checkout 8a45ec8f64f51131c2e98dcb9ee56edf0ca0a0b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/kernel/module_alloc.c:24:7: warning: no previous prototype for function 'module_alloc' [-Wmissing-prototypes]
   void *module_alloc(unsigned long size)
         ^
   arch/arm/kernel/module_alloc.c:24:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *module_alloc(unsigned long size)
   ^
   static 
   1 warning generated.


vim +/module_alloc +24 arch/arm/kernel/module_alloc.c

    22	
    23	#ifdef CONFIG_MMU
  > 24	void *module_alloc(unsigned long size)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
