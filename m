Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862F25A3503
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 08:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiH0GVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiH0GVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 02:21:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195CDC092
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661581302; x=1693117302;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aXJC/E7x5q+usZCo0oNBegtsCOu6gFfwtcdSpeMxdpI=;
  b=TBXqAJp18TwQZhFEUOiMM6m15l6fRLChk4rOMp0UUyuoeamA6GbhdtW5
   AX0BhMwMj/s0148cokQzAaNa7GjYrDXWTdKIJ+B19/UyPXWzQM5BCU35f
   poNCXFYS2/+XvYt7eMkjeDK3yx6xtecAKhc2U1Iygy0eKoJ7KQVQrZ5Nb
   ZcZE3Ov3yRISzCROg23hWEe2NNG7aoHl5eSRmKfUp4tVnf1QyA5b4lcXv
   DDOou6ZFwe67/5Q1D8dCPlPDME8jrk7AAytZWco5X7oZy1k6Fqj/3TQj3
   ejUzZb4/FAi0D11ew/MRhdg/IVJMeUxctpZYUmRbnF5gG89k3PeZtTok1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="294649227"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="294649227"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 23:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="938991188"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 23:21:40 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRpCN-000147-2w;
        Sat, 27 Aug 2022 06:21:39 +0000
Date:   Sat, 27 Aug 2022 14:21:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:efi-decompressor-v4 4/9]
 drivers/firmware/efi/libstub/intrinsics.c:18:7: error: definition of builtin
 function '__builtin_memcpy'
Message-ID: <202208271446.2z1VzPD0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efi-decompressor-v4
head:   2943178d7555c331c19e9cce9a83e47f9513f3b1
commit: 74f59f87ddbcbacc7232ac6800916260a0632126 [4/9] efi/libstub: use EFI provided memcpy/memset routines
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220827/202208271446.2z1VzPD0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=74f59f87ddbcbacc7232ac6800916260a0632126
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb efi-decompressor-v4
        git checkout 74f59f87ddbcbacc7232ac6800916260a0632126
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/intrinsics.c:18:7: error: definition of builtin function '__builtin_memcpy'
   void *memcpy(void *dst, const void *src, size_t len)
         ^
   arch/x86/include/asm/string_32.h:150:25: note: expanded from macro 'memcpy'
   #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
                           ^
>> drivers/firmware/efi/libstub/intrinsics.c:26:7: error: definition of builtin function '__builtin_memset'
   void *memset(void *dst, int c, size_t len)
         ^
   arch/x86/include/asm/string_32.h:195:29: note: expanded from macro 'memset'
   #define memset(s, c, count) __builtin_memset(s, c, count)
                               ^
   2 errors generated.


vim +/__builtin_memcpy +18 drivers/firmware/efi/libstub/intrinsics.c

    17	
  > 18	void *memcpy(void *dst, const void *src, size_t len)
    19	{
    20		efi_bs_call(copy_mem, dst, src, len);
    21		return dst;
    22	}
    23	
    24	extern void *memmove(void *dst, const void *src, size_t len) __alias(memcpy);
    25	
  > 26	void *memset(void *dst, int c, size_t len)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
