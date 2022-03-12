Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB94D6E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiCLL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:58:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3866636
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 03:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647086249; x=1678622249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n+r/05ty8wuYi6HVNPU/YRxwgGdRCe7Fb68usCM4KaI=;
  b=aNYsC8xEXlNRsOuEv43uFxWUu/RDVnkMfOTL8ZH4IgFyIh9ylSnoLbrE
   gLvsN+n/iKHqeNm8lQ3v840vhpSDnjrgHgoYi3kfxXluYfAykaw6kdd7F
   YoY6jTws0XCwRJjftYpvK6Se5h++gsX4oy/vAGO+WQFg08NsJuQ7G5Cyv
   yxn7A6vLtUm8X9bkkLgeVwlG28+l1s+MqKIZyziUtIdhg8QjHRwRhB1MK
   nVy/ZmLosc/5J3m7fvIBVQHpWZjlwGCXi1MkBZfHydguwCIP62UedlX1H
   B887nhrWnctUUYXuJR48GeM1xQnqx9zqK3nH7VOR9Xn20XZyH3Y0wZp7T
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255738079"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255738079"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 03:57:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="539357282"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2022 03:57:27 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT0ND-0007pw-9k; Sat, 12 Mar 2022 11:57:27 +0000
Date:   Sat, 12 Mar 2022 19:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 184/199] include/linux/container_of.h:19:47: error:
 dereferencing pointer to incomplete type 'struct b53_device'
Message-ID: <202203121918.sHSVyIki-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220312/202203121918.sHSVyIki-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 648a4dae40d98210ca4b54b2aefffe2e4cf3bcf8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from drivers/net/dsa/bcm_sf2.c:8:
   drivers/net/dsa/b53/b53_priv.h: In function 'pcs_to_b53_pcs':
>> include/linux/container_of.h:19:47: error: dereferencing pointer to incomplete type 'struct b53_device'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                                               ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:2: note: in expansion of macro 'static_assert'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |  ^~~~~~~~~~~~~
   include/linux/container_of.h:19:16: note: in expansion of macro '__same_type'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
   include/linux/compiler_types.h:276:27: error: expression in static assertion is not an integer
     276 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:2: note: in expansion of macro 'static_assert'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |  ^~~~~~~~~~~~~
   include/linux/container_of.h:19:16: note: in expansion of macro '__same_type'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/compiler_types.h:140:35: error: invalid use of undefined type 'struct b53_device'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:21: note: in expansion of macro 'offsetof'
      22 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
   drivers/net/dsa/bcm_sf2.c: In function 'bcm_sf2_sw_validate':
   drivers/net/dsa/bcm_sf2.c:702:23: warning: unused variable 'priv' [-Wunused-variable]
     702 |  struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
         |                       ^~~~
--
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from drivers/net/dsa/bcm_sf2_cfp.c:8:
   drivers/net/dsa/b53/b53_priv.h: In function 'pcs_to_b53_pcs':
>> include/linux/container_of.h:19:47: error: dereferencing pointer to incomplete type 'struct b53_device'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                                               ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:2: note: in expansion of macro 'static_assert'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |  ^~~~~~~~~~~~~
   include/linux/container_of.h:19:16: note: in expansion of macro '__same_type'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
   include/linux/compiler_types.h:276:27: error: expression in static assertion is not an integer
     276 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:2: note: in expansion of macro 'static_assert'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |  ^~~~~~~~~~~~~
   include/linux/container_of.h:19:16: note: in expansion of macro '__same_type'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/compiler_types.h:140:35: error: invalid use of undefined type 'struct b53_device'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:21: note: in expansion of macro 'offsetof'
      22 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
--
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from arch/x86/include/asm/div64.h:8,
                    from include/linux/math.h:5,
                    from include/linux/delay.h:22,
                    from drivers/net/dsa/b53/b53_serdes.c:10:
   drivers/net/dsa/b53/b53_priv.h: In function 'pcs_to_b53_pcs':
>> include/linux/container_of.h:19:47: error: dereferencing pointer to incomplete type 'struct b53_device'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                                               ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:2: note: in expansion of macro 'static_assert'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |  ^~~~~~~~~~~~~
   include/linux/container_of.h:19:16: note: in expansion of macro '__same_type'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
   include/linux/compiler_types.h:276:27: error: expression in static assertion is not an integer
     276 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:2: note: in expansion of macro 'static_assert'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |  ^~~~~~~~~~~~~
   include/linux/container_of.h:19:16: note: in expansion of macro '__same_type'
      19 |  static_assert(__same_type(*(ptr), ((type *)0)->member) || \
         |                ^~~~~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/compiler_types.h:140:35: error: invalid use of undefined type 'struct b53_device'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:21: note: in expansion of macro 'offsetof'
      22 |  ((type *)(__mptr - offsetof(type, member))); })
         |                     ^~~~~~~~
   drivers/net/dsa/b53/b53_priv.h:89:9: note: in expansion of macro 'container_of'
      89 |  return container_of(pcs, struct b53_device, pcs);
         |         ^~~~~~~~~~~~
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
