Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286EB4F8CA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiDHDPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDHDPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:15:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740F55776
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649387598; x=1680923598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0ihDt0aKyyXJbY4f8vFtS419TVQj/vjKRNtqPfph3Ew=;
  b=oCj+6wpGG6tryJQWD/456/wEPs7GChyYloqZWXn9IZSl0nVtZ7hXT60N
   RUGxqGoE4YBL837ztG7Oedb19T0IyiPFcYSlF3MfZtQ5FnDmEiyOkk0J9
   6SqEQh1i2fQDbXDGf9Gz4XZkWEPyKSh5WSM5/CoWOWnAyghTV9z7YIE76
   sNWyrXft91JkRJdGy9f3b4RkoCUxl1JtGIWWrmiZ5mN27NBNMAkm3WBbJ
   cO9l+TbwmV+noHXaghPVD/ta9USGRSp8X9AuvPFftuoQ5qW1Dbls3kaAq
   6M6vC5ft9UvAecrDDIlaiPodq8N2k4RZYu6LpYNPllXySrbJOb6Nyb059
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260332059"
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="260332059"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 20:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="524629128"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Apr 2022 20:13:16 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncf3j-0005zr-NT;
        Fri, 08 Apr 2022 03:13:15 +0000
Date:   Fri, 8 Apr 2022 11:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/sparc/include/asm/cacheflush_32.h:38:37: warning: 'struct page'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202204081146.wZyxhSbb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42e7a03d3badebd4e70aea5362d6914dfc7c220b
commit: 0e03b8fd29363f2df44e2a7a176d486de550757a crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST
date:   4 weeks ago
config: sparc-randconfig-r013-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081146.wZyxhSbb-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e03b8fd29363f2df44e2a7a176d486de550757a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0e03b8fd29363f2df44e2a7a176d486de550757a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/crypto/xilinx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/cacheflush.h:11,
                    from include/linux/cacheflush.h:5,
                    from drivers/crypto/xilinx/zynqmp-sha.c:6:
>> arch/sparc/include/asm/cacheflush_32.h:38:37: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
      38 | void sparc_flush_page_to_ram(struct page *page);
         |                                     ^~~~
   In file included from drivers/crypto/xilinx/zynqmp-sha.c:6:
   include/linux/cacheflush.h:9:32: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
       9 | void flush_dcache_folio(struct folio *folio);
         |                                ^~~~~


vim +38 arch/sparc/include/asm/cacheflush_32.h

f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  19  
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  20  #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  21  	do {							\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  22  		flush_cache_page(vma, vaddr, page_to_pfn(page));\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  23  		memcpy(dst, src, len);				\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  24  	} while (0)
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  25  #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  26  	do {							\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  27  		flush_cache_page(vma, vaddr, page_to_pfn(page));\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  28  		memcpy(dst, src, len);				\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  29  	} while (0)
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  30  
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller 2012-05-13  31  #define __flush_page_to_ram(addr) \
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller 2012-05-13  32  	sparc32_cachetlb_ops->page_to_ram(addr)
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller 2012-05-13  33  #define flush_sig_insns(mm,insn_addr) \
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller 2012-05-13  34  	sparc32_cachetlb_ops->sig_insns(mm, insn_addr)
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller 2012-05-13  35  #define flush_page_for_dma(addr) \
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller 2012-05-13  36  	sparc32_cachetlb_ops->page_for_dma(addr)
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  37  
f05a68653e56ca arch/sparc/include/asm/cacheflush_32.h Sam Ravnborg    2014-05-16 @38  void sparc_flush_page_to_ram(struct page *page);
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg    2008-07-17  39  

:::::: The code at line 38 was first introduced by commit
:::::: f05a68653e56ca2f23bccf7e50be69486886f052 sparc: drop use of extern for prototypes in arch/sparc/include/asm

:::::: TO: Sam Ravnborg <sam@ravnborg.org>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
