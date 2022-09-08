Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8DF5B2925
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiIHWUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIHWUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:20:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC0BFABB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662675634; x=1694211634;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c93NufDL72Tf/EtS96+8pnIvZdqM3OOFZG+Z32RcIXI=;
  b=BocN+lRofsea2qEFVBeehpCAycrsIFjQqNXzGDHcyreWVfEVvCde1ED8
   t0LbvBMnes0MrwSYqqlhjZrL5lIb8+hUCwF3YuRkdQLb8c4KPE2Nw539v
   4xW7OfdPX7lbrBjZcj3Pi7Ia91k1WvOh1vHRfajxsjNp09u3IbLfOFOer
   U7lATEELtjP7H9yfPcg32PfnqCAN83ob6sqvALF96pBm0Ug4Y0sP6lxkh
   WgNOqhrGd5SLPKo8FoTiLrw/Djfk3aMs99zWfjay25njk4l6IC18pPWf6
   Mger2l5i2LdpO7guD9A91PcfKtTFkrRnCTRyHwwna+tLGvp2jKJ3SfwkD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323539413"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="323539413"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592372684"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2022 15:20:32 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWPst-0000N5-33;
        Thu, 08 Sep 2022 22:20:31 +0000
Date:   Fri, 9 Sep 2022 06:19:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 3/42] arch/riscv/lib/string.c:154:7: error:
 redefinition of '__memset'
Message-ID: <202209090619.qDykZACq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   044c1f5e968de7d30940431fbb90da599074ea1c
commit: 8999d2c8c7f28aa49f4658496266487b2e676aae [3/42] riscv: optimized memset
config: riscv-randconfig-r021-20220907 (https://download.01.org/0day-ci/archive/20220909/202209090619.qDykZACq-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/8999d2c8c7f28aa49f4658496266487b2e676aae
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 8999d2c8c7f28aa49f4658496266487b2e676aae
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
