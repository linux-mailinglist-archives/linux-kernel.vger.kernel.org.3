Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C213528D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbiEPS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344847AbiEPS2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:28:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BFF3DDDD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652725729; x=1684261729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OxvJVKuh1590l8L9SWAzftZ2lwfLL9PnE1dUM0/q1fs=;
  b=RIsW19pH7+XveC8hvr+iOqaCYTbpkVqhKgToJ0+LOnuTCsllW41/SKlR
   Y6vrf8DPsz/haBXLI35vleQc7NSFCeSDW/sq/9+fhG5Rmq/MbhEVOOEA7
   CWkwMV5PHqSYFvwfKMSwWMar2fdrynsDlT5AyOFjgIEoAUubvu2+yXgsl
   tc17KfUwl+z4vbIlZBackGcodPK4xYdXBkmP4SP3WOYX9yBLrQa4v8/XF
   26y0cOo38Rl3ntXyY0eyE9E9raF5DQJfb4nQbRJ8wC1aBipV4cso+3C8f
   SLcslORAHhtQfhJH72oRu0MQuh6qcjmkgYv1YfYXIyOHrAMezftFqPYg8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270868921"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270868921"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="638372833"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2022 11:28:42 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqfSU-0000Fw-1y;
        Mon, 16 May 2022 18:28:42 +0000
Date:   Tue, 17 May 2022 02:28:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Meena Shanmugam <meenashanmugam@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.10 60/64]
 arch/m68k/include/asm/bitops.h:61:33: warning: this statement may fall
 through
Message-ID: <202205170258.uYXmpA7O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   678760868882a1b8dd7f45e9b6058f2c0ce109a3
commit: 419aeb75528619e8bfedecb70c70abcc72464e71 [60/64] SUNRPC: Don't call connect() more than once on a TCP socket
config: m68k-randconfig-r003-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170258.uYXmpA7O-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=419aeb75528619e8bfedecb70c70abcc72464e71
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout 419aeb75528619e8bfedecb70c70abcc72464e71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash net/sunrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:6,
                    from net/sunrpc/xprtsock.c:23:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:143:9: note: in expansion of macro 'BUG_ON'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:143:17: note: in expansion of macro 'virt_addr_valid'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/bitops.h:29,
                    from include/linux/kernel.h:12,
                    from include/asm-generic/bug.h:20,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from net/sunrpc/xprtsock.c:24:
   net/sunrpc/xprtsock.c: In function 'xs_tcp_setup_socket':
>> arch/m68k/include/asm/bitops.h:61:33: warning: this statement may fall through [-Wimplicit-fallthrough=]
      61 | #define set_bit(nr, vaddr)      bset_mem_set_bit(nr, vaddr)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/sunrpc/xprtsock.c:2301:17: note: in expansion of macro 'set_bit'
    2301 |                 set_bit(XPRT_SOCK_CONNECT_SENT, &transport->sock_state);
         |                 ^~~~~~~
   net/sunrpc/xprtsock.c:2302:9: note: here
    2302 |         case -EALREADY:
         |         ^~~~


vim +61 arch/m68k/include/asm/bitops.h

171d809df1896c1 Greg Ungerer 2011-05-17  57  
171d809df1896c1 Greg Ungerer 2011-05-17  58  #if defined(CONFIG_COLDFIRE)
171d809df1896c1 Greg Ungerer 2011-05-17  59  #define	set_bit(nr, vaddr)	bset_reg_set_bit(nr, vaddr)
171d809df1896c1 Greg Ungerer 2011-05-17  60  #elif defined(CONFIG_CPU_HAS_NO_BITFIELDS)
171d809df1896c1 Greg Ungerer 2011-05-17 @61  #define	set_bit(nr, vaddr)	bset_mem_set_bit(nr, vaddr)
171d809df1896c1 Greg Ungerer 2011-05-17  62  #else
171d809df1896c1 Greg Ungerer 2011-05-17  63  #define set_bit(nr, vaddr)	(__builtin_constant_p(nr) ? \
171d809df1896c1 Greg Ungerer 2011-05-17  64  				bset_mem_set_bit(nr, vaddr) : \
171d809df1896c1 Greg Ungerer 2011-05-17  65  				bfset_mem_set_bit(nr, vaddr))
171d809df1896c1 Greg Ungerer 2011-05-17  66  #endif
171d809df1896c1 Greg Ungerer 2011-05-17  67  

:::::: The code at line 61 was first introduced by commit
:::::: 171d809df1896c1022f9778cd2788be6c255a7dc m68k: merge mmu and non-mmu bitops.h

:::::: TO: Greg Ungerer <gerg@uclinux.org>
:::::: CC: Greg Ungerer <gerg@uclinux.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
