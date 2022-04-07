Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE3D4F6EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiDGAFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDGAF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:05:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C81C7C0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649289810; x=1680825810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hu/qduD1GZxLWWXHqubllafoqMw931EVunCvJKzuasg=;
  b=oF5QpweP4bYHZdwSzMGZo3r4ZEQde7V9vu6YB4S24KipsVXJ7NgaR8zE
   bzeYhWsmzSS3M0ubzn76fws3e52n7LeFc0FUFEJ6VGwgpU6tx/FSKOhly
   aot36XatZmUGGIDMbcESiEMdYiq0Ulxqoa78s2aiPsLtf7kgZkYt/omkc
   vzuZQUvy24BdyO68ZaYFgoApweVMxYohrj5v2na4mQRsEA8Eq/7zFQvFE
   L9SkBnj0Lkh7+OTu526v09i3M+RScQYKkcg7nS0Dt8fJXIgnYeXWMFb5U
   xKz7kNk7PAaLB3dFOtPlABJNB/Wvww/EBlDSE/8LDScDiQcWVFImw4b0Y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="258779275"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="258779275"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 17:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="549778978"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Apr 2022 17:03:22 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncFcP-0004sE-Et;
        Thu, 07 Apr 2022 00:03:21 +0000
Date:   Thu, 7 Apr 2022 08:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 2/55] arch/riscv/lib/string.c:89:7: error:
 expected identifier or '('
Message-ID: <202204070737.6a0DKGta-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   7ff84520cb688edd6028a4ac3de3ed684eb22794
commit: b058f14336c3f0efc9156b44d9b4f8357e5c7a56 [2/55] riscv: optimized memcpy
config: riscv-randconfig-r003-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070737.6a0DKGta-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/b058f14336c3f0efc9156b44d9b4f8357e5c7a56
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout b058f14336c3f0efc9156b44d9b4f8357e5c7a56
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/lib/string.c:89:7: error: expected identifier or '('
   void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
         ^
   include/linux/fortify-string.h:369:26: note: expanded from macro 'memcpy'
   #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
                            ^
   include/linux/fortify-string.h:358:42: note: expanded from macro '__fortify_memcpy_chk'
                                p_size_field, q_size_field, op) ({         \
                                                                 ^
>> arch/riscv/lib/string.c:89:7: error: expected ')'
   include/linux/fortify-string.h:369:26: note: expanded from macro 'memcpy'
   #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
                            ^
   include/linux/fortify-string.h:358:42: note: expanded from macro '__fortify_memcpy_chk'
                                p_size_field, q_size_field, op) ({         \
                                                                 ^
   arch/riscv/lib/string.c:89:7: note: to match this '('
   include/linux/fortify-string.h:369:26: note: expanded from macro 'memcpy'
   #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
                            ^
   include/linux/fortify-string.h:358:41: note: expanded from macro '__fortify_memcpy_chk'
                                p_size_field, q_size_field, op) ({         \
                                                                ^
   2 errors generated.


vim +89 arch/riscv/lib/string.c

    88	
  > 89	void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
