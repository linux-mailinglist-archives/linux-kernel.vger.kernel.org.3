Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53CA5301D8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 10:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiEVI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiEVI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 04:27:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94836E2B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653208038; x=1684744038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LteJ72TWNsYKXEonDajzghmVGbT4VlhAsqMZEfLzdiQ=;
  b=mSqDS/ouUC8r5w5+JVrC9mquypBhlsDdkwp/fWzA6LxZIO6p1RbFwilO
   ccjXjvvuaKlH9gY/LKgbOKmxDzoQoKpRZyvRfXSJfPF3+8YQ8M1ja39ZP
   7q/JV0hsNfv3Q5XCu1go8JlTmsAH0owL9JLu+O308zTypFn9wDzfHbmup
   +6pViLT+a8o0G9aPOhvkG9WpjqneZSwgTSXJrhfjyNPaAHXryXm2Ln0UY
   DQIEL4QENDsQ9O/DmP97hYMbiGS8DSOWEQnYCY0rvRZr/0uapZv0HYsCq
   Y4gB2k0EesekpwJ5rHT82wBg7U94hPj0nRXJl6mra5TdymEd2G0TCcToA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="272675679"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="272675679"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 01:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="819283116"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 May 2022 01:27:16 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsgvj-0000DH-Ff;
        Sun, 22 May 2022 08:27:15 +0000
Date:   Sun, 22 May 2022 16:26:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [ebiggers:crypto-pending 8/9]
 arch/arm64/crypto/polyval-ce-glue.c:187:1: error: redefinition of
 '__inittest'
Message-ID: <202205221607.4vYxE0vQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crypto-pending
head:   22ca50a7cbeef1cde1ea3d99686ad3575bd7d4ed
commit: bfa275a9bb4e16067b9056e8019bd478da798bc9 [8/9] crypto: arm64/polyval: Add PMULL accelerated implementation of POLYVAL
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220522/202205221607.4vYxE0vQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b369762beb70dfef22c7e793aed79b94d7dc0757)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=bfa275a9bb4e16067b9056e8019bd478da798bc9
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers crypto-pending
        git checkout bfa275a9bb4e16067b9056e8019bd478da798bc9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/crypto/polyval-ce-glue.c:187:1: error: redefinition of '__inittest'
   module_init(polyval_ce_mod_init);
   ^
   include/linux/module.h:131:42: note: expanded from macro 'module_init'
           static inline initcall_t __maybe_unused __inittest(void)                \
                                                   ^
   arch/arm64/crypto/polyval-ce-glue.c:185:1: note: previous definition is here
   module_cpu_feature_match(PMULL, polyval_ce_mod_init)
   ^
   include/linux/cpufeature.h:54:10: note: expanded from macro 'module_cpu_feature_match'
   }                                                               \
                                                                   ^
   include/linux/module.h:131:42: note: expanded from macro '\
   module_init'
           static inline initcall_t __maybe_unused __inittest(void)                \
                                                   ^
>> arch/arm64/crypto/polyval-ce-glue.c:187:1: error: redefinition of 'init_module'
   module_init(polyval_ce_mod_init);
   ^
   include/linux/module.h:133:6: note: expanded from macro 'module_init'
           int init_module(void) __copy(initfn)                    \
               ^
   arch/arm64/crypto/polyval-ce-glue.c:185:1: note: previous definition is here
   module_cpu_feature_match(PMULL, polyval_ce_mod_init)
   ^
   include/linux/cpufeature.h:54:10: note: expanded from macro 'module_cpu_feature_match'
   }                                                               \
                                                                   ^
   include/linux/module.h:133:6: note: expanded from macro '\
   module_init'
           int init_module(void) __copy(initfn)                    \
               ^
   2 errors generated.


vim +/__inittest +187 arch/arm64/crypto/polyval-ce-glue.c

   186	
 > 187	module_init(polyval_ce_mod_init);
   188	module_exit(polyval_ce_mod_exit);
   189	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
