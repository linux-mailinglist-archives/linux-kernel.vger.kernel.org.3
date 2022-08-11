Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F1A58F8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiHKH5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiHKH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:57:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6EC1CB29
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660204628; x=1691740628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UKqhP0uRoUYHTttFfhVmsMCf2t40yTrb/oqmgyQl+2E=;
  b=kkyg9VC8dGLnPMyTf9X5NjQlQFp7I8k/mY668Mz4Zpf3ZqZwdLZu17bk
   ItLD6IsPCDf0jOnHS2vnzxE33NhWQOl6edB/l6Uiv0gfYJcn+qZcLoqu7
   MEP68elL/PahcDPiyiIzCU554PgbIF6rZnS8cCZgHDoMTyOKAjn9+CWbK
   yz2Y1KIGGso+HNOJPhYHyrE0Bpx/HEeYL1s7uhcb1TD6Y7lvaHI/ZNkND
   RmhNVhjnYGIzdB4BF00qYRStps8l8dZSQgoA4ulY0xchralycR1uwAKGp
   JVrjNE2bGFERiQNwWzPY8xb/vfeKzkWPQgzqbegkB4+PFHe0C4xbLDqWf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292079098"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292079098"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 00:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="556039613"
Received: from lkp-server02.sh.intel.com (HELO d10ab0927833) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2022 00:57:06 -0700
Received: from kbuild by d10ab0927833 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oM33y-00007F-0f;
        Thu, 11 Aug 2022 07:57:06 +0000
Date:   Thu, 11 Aug 2022 15:57:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/random.h:25:46: error: 'latent_entropy' undeclared;
 did you mean 'add_latent_entropy'?
Message-ID: <202208111537.zfHCewaw-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ffcf9c5700e49c0aee42dcba9a12ba21338e8136
commit: 36d4b36b69590fed99356a4426c940a253a93800 lib/nodemask: inline next_node_in() and node_random()
date:   10 days ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220811/202208111537.zfHCewaw-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=36d4b36b69590fed99356a4426c940a253a93800
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 36d4b36b69590fed99356a4426c940a253a93800
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/nodemask.h:97,
                    from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from arch/powerpc/kernel/prom_init.c:24:
   include/linux/random.h: In function 'add_latent_entropy':
>> include/linux/random.h:25:46: error: 'latent_entropy' undeclared (first use in this function); did you mean 'add_latent_entropy'?
      25 |         add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
         |                                              ^~~~~~~~~~~~~~
         |                                              add_latent_entropy
   include/linux/random.h:25:46: note: each undeclared identifier is reported only once for each function it appears in


vim +25 include/linux/random.h

38addce8b600ca3 Emese Revfy        2016-06-20  21  
7e756f423af808b Vasily Gorbik      2019-05-07  22  #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
38addce8b600ca3 Emese Revfy        2016-06-20  23  static inline void add_latent_entropy(void)
38addce8b600ca3 Emese Revfy        2016-06-20  24  {
2f14062bb14b0fc Jason A. Donenfeld 2022-05-05 @25  	add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
38addce8b600ca3 Emese Revfy        2016-06-20  26  }
38addce8b600ca3 Emese Revfy        2016-06-20  27  #else
38addce8b600ca3 Emese Revfy        2016-06-20  28  static inline void add_latent_entropy(void) { }
38addce8b600ca3 Emese Revfy        2016-06-20  29  #endif
38addce8b600ca3 Emese Revfy        2016-06-20  30  

:::::: The code at line 25 was first introduced by commit
:::::: 2f14062bb14b0fcfcc21e6dc7d5b5c0d25966164 random: handle latent entropy and command line from random_init()

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: Jason A. Donenfeld <Jason@zx2c4.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
