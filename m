Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28656D295
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGKBcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiGKBcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:32:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185CC167C8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657503129; x=1689039129;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sB3iQbeUOie1kOd/vhD8O01k5FoLybA9xZ5Z8ht/6v0=;
  b=kHdTeuDRGhKpuFm0G86+pqvJsRo0oG0IEfKVzsqAKzukob4AMoKEkIFZ
   x0HeadcMvEUSmTWHd5mfRroV/Lo2qoGpbQknyrHOmN+Mvm0LwxunPdc/Q
   2oF+6ZF8NUeHOE3IX/vdy7CoazgOVOftBb+0Y3zBAIZoV1GMjiNfpeQJa
   cro2Nvj0pU3jPFhMWCxwToooKALzTczRDRCCUpGrclVc1Nv9qBTk3jNC8
   /XW7xiEKslozra1CpWdo5O4cJf03mfQbV+JwAp0wVaNK+AcgT0QrlXGgJ
   KYbSuUqXNKzV9vQBefQ3YOzcYkjdWYigzOvYU22QrA1pEfjt+fDvpElmO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284578132"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="284578132"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 18:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="921610211"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2022 18:32:07 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAiHO-0000A3-Ls;
        Mon, 11 Jul 2022 01:32:06 +0000
Date:   Mon, 11 Jul 2022 09:31:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 4/50] arch/riscv/lib/string.c:154:7: error:
 redefinition of '__memset'
Message-ID: <202207110842.bZK9H8Xt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   943858df470556d0b7f3b31fcc10931603f0f3cc
commit: bdf1612f166c6ff3822236aa35c1497449fe7d35 [4/50] riscv: optimized memset
config: riscv-randconfig-r033-20220710 (https://download.01.org/0day-ci/archive/20220711/202207110842.bZK9H8Xt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6ce63e267aab79ca87bf63453d34dd3909ab978d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/bdf1612f166c6ff3822236aa35c1497449fe7d35
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout bdf1612f166c6ff3822236aa35c1497449fe7d35
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/lib/string.c:90:57: warning: attribute declaration must precede definition [-Wignored-attributes]
   void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
                                                           ^
   include/linux/compiler_attributes.h:372:56: note: expanded from macro '__weak'
   #define __weak                          __attribute__((__weak__))
                                                          ^
   arch/riscv/lib/string.c:31:7: note: previous definition is here
   void *__memcpy(void *dest, const void *src, size_t count)
         ^
   arch/riscv/lib/string.c:90:7: error: redefinition of '__memcpy'
   void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
         ^
   arch/riscv/include/asm/string.h:21:31: note: expanded from macro 'memcpy'
   #define memcpy(dst, src, len) __memcpy(dst, src, len)
                                 ^
   arch/riscv/lib/string.c:31:7: note: previous definition is here
   void *__memcpy(void *dest, const void *src, size_t count)
         ^
   arch/riscv/lib/string.c:113:58: warning: attribute declaration must precede definition [-Wignored-attributes]
   void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
                                                            ^
   include/linux/compiler_attributes.h:372:56: note: expanded from macro '__weak'
   #define __weak                          __attribute__((__weak__))
                                                          ^
   arch/riscv/lib/string.c:97:7: note: previous definition is here
   void *__memmove(void *dest, const void *src, size_t count)
         ^
   arch/riscv/lib/string.c:113:7: error: redefinition of '__memmove'
   void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
         ^
   arch/riscv/include/asm/string.h:23:32: note: expanded from macro 'memmove'
   #define memmove(dst, src, len) __memmove(dst, src, len)
                                  ^
   arch/riscv/lib/string.c:97:7: note: previous definition is here
   void *__memmove(void *dest, const void *src, size_t count)
         ^
   arch/riscv/lib/string.c:154:44: warning: attribute declaration must precede definition [-Wignored-attributes]
   void *memset(void *s, int c, size_t count) __weak __alias(__memset);
                                              ^
   include/linux/compiler_attributes.h:372:56: note: expanded from macro '__weak'
   #define __weak                          __attribute__((__weak__))
                                                          ^
   arch/riscv/lib/string.c:116:7: note: previous definition is here
   void *__memset(void *s, int c, size_t count)
         ^
>> arch/riscv/lib/string.c:154:7: error: redefinition of '__memset'
   void *memset(void *s, int c, size_t count) __weak __alias(__memset);
         ^
   arch/riscv/include/asm/string.h:22:25: note: expanded from macro 'memset'
   #define memset(s, c, n) __memset(s, c, n)
                           ^
   arch/riscv/lib/string.c:116:7: note: previous definition is here
   void *__memset(void *s, int c, size_t count)
         ^
   3 warnings and 3 errors generated.


vim +/__memset +154 arch/riscv/lib/string.c

   153	
 > 154	void *memset(void *s, int c, size_t count) __weak __alias(__memset);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
