Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCF4EA70B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiC2FWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiC2FWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:22:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052E9199E3E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648531259; x=1680067259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TINLsHuDin6UBvvL9KGMyuxZ8onKVbUsFmaoevT5osY=;
  b=aTH7vrGdxjm8hYx9AV4Gf3yGKcedFMYSjYqJGkhnnYSRXqEn3YzfV+KM
   1GaNSzX43wI19GPPVo0+4tlGtqbe+qBUCnFeFi3dN2shEJRezALk/BO+K
   Bc5zxLCPEBhWIW9945nPOv/ofMBNE+BPA7EwLRMhr2icC4rBkjmsiSUA8
   KD+h4Qw+b9NGKYRP0ZJA19nrWFg0ldRuqDEI9u3FB+/A8PUk6Oc/ZR1Pk
   QZIi5a5vnQ5Q72mS7fv55O5gx0cAVUMaHMYd0FXCZzLtD/5rv0ijQzHXo
   uwrO8ysDgceuHdguQky/LdBYNxJqgPCaoT9zh72D7lSew3fuyAqa4zIMS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="241318114"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="241318114"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="502764394"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 22:20:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ4Hn-0002gn-K4; Tue, 29 Mar 2022 05:20:55 +0000
Date:   Tue, 29 Mar 2022 13:20:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:arm64/linux/devel/kmalloc-minalign 11/11]
 arch/arm64/include/asm/cache.h:51:44: error: missing binary operator before
 token "("
Message-ID: <202203291356.qd9QDdwo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/devel/kmalloc-minalign
head:   96a378f120e08f205dad5abcc348f0628d2db801
commit: 96a378f120e08f205dad5abcc348f0628d2db801 [11/11] arm64: Allow arch_kmalloc_minalign() of 8 if CLIDR_EL1.LoC == 0
config: arm64-buildonly-randconfig-r006-20220328 (https://download.01.org/0day-ci/archive/20220329/202203291356.qd9QDdwo-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/96a378f120e08f205dad5abcc348f0628d2db801
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/devel/kmalloc-minalign
        git checkout 96a378f120e08f205dad5abcc348f0628d2db801
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/cache.h:6,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from mm/slab.c:90:
>> arch/arm64/include/asm/cache.h:51:33: warning: "__alignof__" is not defined, evaluates to 0 [-Wundef]
      51 | #define ARCH_KMALLOC_MINALIGN   __alignof__(unsigned long long)
         |                                 ^~~~~~~~~~~
   include/linux/slab.h:214:26: note: in expansion of macro 'ARCH_KMALLOC_MINALIGN'
     214 | #define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
         |                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h:305:33: note: in expansion of macro 'KMALLOC_MIN_SIZE'
     305 | #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
         |                                 ^~~~~~~~~~~~~~~~
   mm/slab.c:163:36: note: in expansion of macro 'SLAB_OBJ_MIN_SIZE'
     163 |                                 <= SLAB_OBJ_MIN_SIZE) ? 1 : 0)
         |                                    ^~~~~~~~~~~~~~~~~
   mm/slab.c:165:5: note: in expansion of macro 'FREELIST_BYTE_INDEX'
     165 | #if FREELIST_BYTE_INDEX
         |     ^~~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/cache.h:51:44: error: missing binary operator before token "("
      51 | #define ARCH_KMALLOC_MINALIGN   __alignof__(unsigned long long)
         |                                            ^
   include/linux/slab.h:214:26: note: in expansion of macro 'ARCH_KMALLOC_MINALIGN'
     214 | #define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
         |                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h:305:33: note: in expansion of macro 'KMALLOC_MIN_SIZE'
     305 | #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
         |                                 ^~~~~~~~~~~~~~~~
   mm/slab.c:163:36: note: in expansion of macro 'SLAB_OBJ_MIN_SIZE'
     163 |                                 <= SLAB_OBJ_MIN_SIZE) ? 1 : 0)
         |                                    ^~~~~~~~~~~~~~~~~
   mm/slab.c:165:5: note: in expansion of macro 'FREELIST_BYTE_INDEX'
     165 | #if FREELIST_BYTE_INDEX
         |     ^~~~~~~~~~~~~~~~~~~


vim +51 arch/arm64/include/asm/cache.h

    42	
    43	/*
    44	 * Memory returned by kmalloc() may be used for DMA, so we must make
    45	 * sure that all such allocations are cache aligned. Otherwise,
    46	 * unrelated code may cause parts of the buffer to be read into the
    47	 * cache before the transfer is done, causing old data to be seen by
    48	 * the CPU.
    49	 */
    50	#define ARCH_DMA_MINALIGN	(128)
  > 51	#define ARCH_KMALLOC_MINALIGN	__alignof__(unsigned long long)
    52	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
