Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31653135F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiEWPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbiEWPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:49:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9C934B8B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653320950; x=1684856950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8lhQ/KID3ztUPGBkFXjcOy6u1hxj1gnvDoqTjbmBCrI=;
  b=We5q2IMW6ldaSKHwYn0WQj6NY168ek9oIlnggqKYikFQlzi5rJGEbJcp
   g4NFqRrdVw7XsL55UH9YXKyvErb7RtxcqZP8Ruk/idRnmQJ/IW23IN9yV
   9m2S5lKuM/IVf1yAaVzaXZR0D8PNmQpstbz+W9J0a0bX1A2qvC5l5ivCx
   t+4803m3VUORtOO/e+dJPL2yWs5dI9P/tdzRzcsdbVYnn9cp+qrQWIw0+
   i86KHM6AvdZoGfp3htPj2JGZubUE6RQoZD7NCZEd0f4J1L17DKg7oGT26
   zpGJNFwIlv3CF3O8iNIaM4bzcxbfKgpXu6uImDX95pijhP1m75slXswow
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="272984064"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="272984064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="577457627"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2022 08:49:08 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntAIt-0001E2-H3;
        Mon, 23 May 2022 15:49:07 +0000
Date:   Mon, 23 May 2022 23:49:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 8/17] ld.lld: error:
 undefined symbol: kernel_sec_start
Message-ID: <202205232354.0am40aBc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   a9b76a04739b5b4dbad86664342c8945e83d8e95
commit: 06f73703766c6f636c79d04aae9f83446f1b8ff2 [8/17] ARM: Compile the kernel into VMALLOC
config: arm-randconfig-r021-20220522 (https://download.01.org/0day-ci/archive/20220523/202205232354.0am40aBc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=06f73703766c6f636c79d04aae9f83446f1b8ff2
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 06f73703766c6f636c79d04aae9f83446f1b8ff2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: kernel_sec_start
   >>> referenced by init.c
   >>>               mm/init.o:(arm_memblock_init) in archive arch/arm/built-in.a
   >>> referenced by init.c
   >>>               mm/init.o:(arm_memblock_init) in archive arch/arm/built-in.a
--
>> mm/gup.c:1599:28: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
                           pages[i] = virt_to_page(start);
                                                   ^~~~~
   arch/arm/include/asm/memory.h:441:53: note: expanded from macro 'virt_to_page'
   #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
                                                           ^~~~~
   include/asm-generic/memory_model.h:18:41: note: expanded from macro '__pfn_to_page'
   #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
                                                ^~~
   arch/arm/include/asm/memory.h:322:53: note: passing argument to parameter 'p' here
   static inline unsigned long virt_to_pfn(const void *p)
                                                       ^
   1 warning generated.
--
>> mm/nommu.c:501:36: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
                   struct page *page = virt_to_page(from);
                                                    ^~~~
   arch/arm/include/asm/memory.h:441:53: note: expanded from macro 'virt_to_page'
   #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
                                                           ^~~~~
   include/asm-generic/memory_model.h:18:41: note: expanded from macro '__pfn_to_page'
   #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
                                                ^~~
   arch/arm/include/asm/memory.h:322:53: note: passing argument to parameter 'p' here
   static inline unsigned long virt_to_pfn(const void *p)
                                                       ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
