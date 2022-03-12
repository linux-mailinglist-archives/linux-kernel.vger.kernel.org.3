Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49C4D6BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 02:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiCLBOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCLBOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 20:14:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009921DF27
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 17:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647047583; x=1678583583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vjx50F+8LXY0mc5/R+S8iGlv9N58orjUWyfvimwsWwQ=;
  b=mtaBROCQg456mhDx1TcbAT1nvSVGQBloA6uBmMEtPmkF1DVDmPvS6eEO
   3sEjyv6VRquXN1rJ0H8AadlDXqSIbKa+/Z92r4xa5oki+VB05uf/qhVrF
   d1m7trciVCFBE3kkJJPVU0ASmJsfP7WU07kpN0/skBYYogF1snNdd7h68
   po4vzZUxCXSxspTcf1mvUhdey9cP5tno+2e9alED1Os3QCproE9tCp4pA
   rDU+lZ6i/wm+b/Vvkd3+GVkeMQpequdJjZde5XeDbWoaELpkfqgEwKEIt
   raU3JMPOXDh4qyc+akQds823g/X8Tlh0pnT7MbiDLcQ/jkTtULp9m1F26
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255879275"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255879275"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 17:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="511568491"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2022 17:13:01 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSqJY-0007M2-W0; Sat, 12 Mar 2022 01:13:00 +0000
Date:   Sat, 12 Mar 2022 09:12:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 184/199] include/linux/container_of.h:19:54: error:
 invalid use of undefined type 'struct b53_device'
Message-ID: <202203120915.ngsC6dne-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   6c861f50ef8f930ea963f334f1b9cf06e9d040f6
commit: 648a4dae40d98210ca4b54b2aefffe2e4cf3bcf8 [184/199] net: dsa: b53: convert to phylink_pcs
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220312/202203120915.ngsC6dne-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 648a4dae40d98210ca4b54b2aefffe2e4cf3bcf8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/net/dsa/b53/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/sh/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/delay.h:22,
                    from drivers/net/dsa/b53/b53_common.c:20:
   drivers/net/dsa/b53/b53_priv.h: In function 'pcs_to_b53_pcs':
>> include/linux/container_of.h:19:54: error: invalid use of undefined type 'struct b53_device'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:16: note: in expansion of macro 'container_of'
      89 |         return container_of(pcs, struct b53_device, pcs);
         |                ^~~~~~~~~~~~
>> include/linux/compiler_types.h:276:27: error: expression in static assertion is not an integer
     276 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:16: note: in expansion of macro 'container_of'
      89 |         return container_of(pcs, struct b53_device, pcs);
         |                ^~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/compiler_types.h:140:41: error: invalid use of undefined type 'struct b53_device'
     140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:28: note: in expansion of macro 'offsetof'
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:16: note: in expansion of macro 'container_of'
      89 |         return container_of(pcs, struct b53_device, pcs);
         |                ^~~~~~~~~~~~
--
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/sh/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/delay.h:22,
                    from drivers/net/dsa/b53/b53_serdes.c:10:
   drivers/net/dsa/b53/b53_priv.h: In function 'pcs_to_b53_pcs':
>> include/linux/container_of.h:19:54: error: invalid use of undefined type 'struct b53_device'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:16: note: in expansion of macro 'container_of'
      89 |         return container_of(pcs, struct b53_device, pcs);
         |                ^~~~~~~~~~~~
>> include/linux/compiler_types.h:276:27: error: expression in static assertion is not an integer
     276 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:16: note: in expansion of macro 'container_of'
      89 |         return container_of(pcs, struct b53_device, pcs);
         |                ^~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/compiler_types.h:140:41: error: invalid use of undefined type 'struct b53_device'
     140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:28: note: in expansion of macro 'offsetof'
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:16: note: in expansion of macro 'container_of'
      89 |         return container_of(pcs, struct b53_device, pcs);
         |                ^~~~~~~~~~~~
   In file included from drivers/net/dsa/b53/b53_serdes.c:16:
   drivers/net/dsa/b53/b53_priv.h:90:1: error: control reaches end of non-void function [-Werror=return-type]
      90 | }
         | ^
   cc1: some warnings being treated as errors


vim +19 include/linux/container_of.h

d2a8ebbf8192b8 Andy Shevchenko  2021-11-08   9  
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  10  /**
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  11   * container_of - cast a member of a structure out to the containing structure
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  12   * @ptr:	the pointer to the member.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  13   * @type:	the type of the container struct this is embedded in.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  14   * @member:	the name of the member within the struct.
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  15   *
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  16   */
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  17  #define container_of(ptr, type, member) ({				\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  18  	void *__mptr = (void *)(ptr);					\
e1edc277e6f6df Rasmus Villemoes 2021-11-08 @19  	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
e1edc277e6f6df Rasmus Villemoes 2021-11-08  20  		      __same_type(*(ptr), void),			\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  21  		      "pointer type mismatch in container_of()");	\
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  22  	((type *)(__mptr - offsetof(type, member))); })
d2a8ebbf8192b8 Andy Shevchenko  2021-11-08  23  

:::::: The code at line 19 was first introduced by commit
:::::: e1edc277e6f6dfb372216522dfc57f9381c39e35 linux/container_of.h: switch to static_assert

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
