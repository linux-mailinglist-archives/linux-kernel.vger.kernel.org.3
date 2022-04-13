Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4184FF67A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiDMMNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiDMMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:13:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017349F38
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649851876; x=1681387876;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q1LBazRwlxDRL0neWWfPeZfDvwo2lF2UwCcqRqWpbf8=;
  b=HvHxwyOEVI791IdLuD5nyzcEG8XDMQylj7HQsabf5EPVGcVUQ9Uz3ehR
   zXQv9CfppVNHyApy4m3roD66MYZsdv0MdqA9bI7R91hhoV82YC0H166FL
   xEg86H63ECVwk1y5BHwD67MxV2rJUPLd+34hIEOq5ah+87UO3xV0fjdgT
   HuHye4H/weoIR31BiACdtjyftzTG/lu9tXcpQj4vvvLB5A7qilI4NrriE
   9y2DHuDVkrMnUcZH8Q0AqHsXzcuVVaWnB995A8F3Zem3NZxMgqSsVfl3z
   nSHz9z4SXlRt1s8rzWkqeRZj71M+uoQbSg52KNtispr3JNtabkh0iV7KZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="325552018"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="325552018"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="611859541"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2022 05:11:14 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nebq6-0000Gi-6c;
        Wed, 13 Apr 2022 12:11:14 +0000
Date:   Wed, 13 Apr 2022 20:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 7/13] include/linux/overflow.h:66:22: warning:
 comparison of distinct pointer types lacks a cast
Message-ID: <202204132034.dp2f42wp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   fc388f906088fe5f5f2db6a36931e00124f52042
commit: 1af524ce30ddf820ec974c8635d3299caefc72ed [7/13] iommufd: Data structure to provide IOVA to PFN mapping
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220413/202204132034.dp2f42wp-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/1af524ce30ddf820ec974c8635d3299caefc72ed
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 1af524ce30ddf820ec974c8635d3299caefc72ed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask.h:14,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from drivers/iommu/iommufd/io_pagetable.c:11:
   drivers/iommu/iommufd/io_pagetable.c: In function 'iopt_unaccess_pages':
>> include/linux/overflow.h:66:22: warning: comparison of distinct pointer types lacks a cast
      66 |         (void) (&__a == &__b);                  \
         |                      ^~
   include/asm-generic/bug.h:121:32: note: in definition of macro 'WARN_ON'
     121 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   drivers/iommu/iommufd/io_pagetable.c:486:21: note: in expansion of macro 'check_add_overflow'
     486 |             WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
         |                     ^~~~~~~~~~~~~~~~~~


vim +66 include/linux/overflow.h

9b80e4c4ddaca35 Kees Cook        2020-08-12  53  
f0907827a8a9152 Rasmus Villemoes 2018-05-08  54  /*
f0907827a8a9152 Rasmus Villemoes 2018-05-08  55   * For simplicity and code hygiene, the fallback code below insists on
f0907827a8a9152 Rasmus Villemoes 2018-05-08  56   * a, b and *d having the same type (similar to the min() and max()
f0907827a8a9152 Rasmus Villemoes 2018-05-08  57   * macros), whereas gcc's type-generic overflow checkers accept
f0907827a8a9152 Rasmus Villemoes 2018-05-08  58   * different types. Hence we don't just make check_add_overflow an
f0907827a8a9152 Rasmus Villemoes 2018-05-08  59   * alias for __builtin_add_overflow, but add type checks similar to
f0907827a8a9152 Rasmus Villemoes 2018-05-08  60   * below.
f0907827a8a9152 Rasmus Villemoes 2018-05-08  61   */
9b80e4c4ddaca35 Kees Cook        2020-08-12  62  #define check_add_overflow(a, b, d) __must_check_overflow(({	\
f0907827a8a9152 Rasmus Villemoes 2018-05-08  63  	typeof(a) __a = (a);			\
f0907827a8a9152 Rasmus Villemoes 2018-05-08  64  	typeof(b) __b = (b);			\
f0907827a8a9152 Rasmus Villemoes 2018-05-08  65  	typeof(d) __d = (d);			\
f0907827a8a9152 Rasmus Villemoes 2018-05-08 @66  	(void) (&__a == &__b);			\
f0907827a8a9152 Rasmus Villemoes 2018-05-08  67  	(void) (&__a == __d);			\
f0907827a8a9152 Rasmus Villemoes 2018-05-08  68  	__builtin_add_overflow(__a, __b, __d);	\
9b80e4c4ddaca35 Kees Cook        2020-08-12  69  }))
f0907827a8a9152 Rasmus Villemoes 2018-05-08  70  

:::::: The code at line 66 was first introduced by commit
:::::: f0907827a8a9152aedac2833ed1b674a7b2a44f2 compiler.h: enable builtin overflow checkers and add fallback code

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
