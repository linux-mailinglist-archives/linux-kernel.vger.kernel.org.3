Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4665483A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiFMJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiFMJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:32:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9176C1902A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655112720; x=1686648720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HenzMw3TO2R2zh9Do1HWZPuoecncHXidGIwE0OXVkdk=;
  b=h4e087tuFMWcAdE8MS9vW1sX+2fh9Q1Ys8qUyct3sVTWzyaXuM3R5V2d
   bTbunDCKfpSi19/ZEe8lDpP8XYkhlnIM/u5r92j974Hj1uC+eIPMlgNNi
   raM7BP6XziWG8Nz9REo8btC3knHq5xjMrWZGmT0wjQ7IYPOvRNlBopQug
   FEqNK5cASelr2gXE3DdwAnCJzNxfYRij3onh6EstmShjwsCTIHz0QK9io
   0IbyQpmvljo2F18vECU4maoJ2jYCNVyOxvk09mZtFbZvBQaVxPLks9EM1
   fbibUQj99zymPa48vetBJfsKjLty7TDE0PjmrFShS4w/TtTnAH87N042M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="278949505"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="278949505"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 02:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="587703777"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 02:31:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0gQP-000KgD-NY;
        Mon, 13 Jun 2022 09:31:57 +0000
Date:   Mon, 13 Jun 2022 17:31:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [alobakin:bitops 3/6] include/linux/bitops.h:39:35: error:
 'arch___set_bit' undeclared here (not in a function); did you mean
 'generic___set_bit'?
Message-ID: <202206131730.NRGzSajz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux bitops
head:   d8371d0e4328c4cb6fa25350bd5132f25b386672
commit: 4f9a98e0945a7cb9130bb04be4b3ecec35e16a81 [3/6] bitops: unify non-atomic bitops prototypes across architectures
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220613/202206131730.NRGzSajz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/4f9a98e0945a7cb9130bb04be4b3ecec35e16a81
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin bitops
        git checkout 4f9a98e0945a7cb9130bb04be4b3ecec35e16a81
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bits.h:22,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/bitops.h:39:35: error: 'arch___set_bit' undeclared here (not in a function); did you mean 'generic___set_bit'?
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                                   ^~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:42:1: note: in expansion of macro '__check_bitop_pr'
      42 | __check_bitop_pr(__set_bit);
         | ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:42:1: note: in expansion of macro '__check_bitop_pr'
      42 | __check_bitop_pr(__set_bit);
         | ^~~~~~~~~~~~~~~~
>> include/linux/bitops.h:39:35: error: 'arch___clear_bit' undeclared here (not in a function); did you mean 'generic___clear_bit'?
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                                   ^~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:43:1: note: in expansion of macro '__check_bitop_pr'
      43 | __check_bitop_pr(__clear_bit);
         | ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:43:1: note: in expansion of macro '__check_bitop_pr'
      43 | __check_bitop_pr(__clear_bit);
         | ^~~~~~~~~~~~~~~~
>> include/linux/bitops.h:39:35: error: 'arch___change_bit' undeclared here (not in a function); did you mean 'bfchg_mem_change_bit'?
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                                   ^~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:44:1: note: in expansion of macro '__check_bitop_pr'
      44 | __check_bitop_pr(__change_bit);
         | ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:44:1: note: in expansion of macro '__check_bitop_pr'
      44 | __check_bitop_pr(__change_bit);
         | ^~~~~~~~~~~~~~~~
>> include/linux/bitops.h:39:35: error: 'arch___test_and_set_bit' undeclared here (not in a function); did you mean 'generic___test_and_set_bit'?
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                                   ^~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:45:1: note: in expansion of macro '__check_bitop_pr'
      45 | __check_bitop_pr(__test_and_set_bit);
         | ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:45:1: note: in expansion of macro '__check_bitop_pr'
      45 | __check_bitop_pr(__test_and_set_bit);
         | ^~~~~~~~~~~~~~~~
>> include/linux/bitops.h:39:35: error: 'arch___test_and_clear_bit' undeclared here (not in a function); did you mean 'generic___test_and_clear_bit'?
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                                   ^~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:46:1: note: in expansion of macro '__check_bitop_pr'
      46 | __check_bitop_pr(__test_and_clear_bit);
         | ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:46:1: note: in expansion of macro '__check_bitop_pr'
      46 | __check_bitop_pr(__test_and_clear_bit);
         | ^~~~~~~~~~~~~~~~
>> include/linux/bitops.h:39:35: error: 'arch___test_and_change_bit' undeclared here (not in a function); did you mean 'bfchg_mem_test_and_change_bit'?
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                                   ^~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:47:1: note: in expansion of macro '__check_bitop_pr'
      47 | __check_bitop_pr(__test_and_change_bit);
         | ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:47:1: note: in expansion of macro '__check_bitop_pr'
      47 | __check_bitop_pr(__test_and_change_bit);
         | ^~~~~~~~~~~~~~~~
>> include/linux/bitops.h:39:35: error: 'arch_test_bit' undeclared here (not in a function); did you mean 'test_bit'?
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                                   ^~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:48:1: note: in expansion of macro '__check_bitop_pr'
      48 | __check_bitop_pr(test_bit);
         | ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/bitops.h:39:9: note: in expansion of macro 'static_assert'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |         ^~~~~~~~~~~~~
   include/linux/bitops.h:39:23: note: in expansion of macro '__same_type'
      39 |         static_assert(__same_type(arch_##name, generic_##name) &&       \
         |                       ^~~~~~~~~~~
   include/linux/bitops.h:48:1: note: in expansion of macro '__check_bitop_pr'
      48 | __check_bitop_pr(test_bit);
         | ^~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +39 include/linux/bitops.h

    36	
    37	/* Check that the bitops prototypes are sane */
    38	#define __check_bitop_pr(name)						\
  > 39		static_assert(__same_type(arch_##name, generic_##name) &&	\
    40			      __same_type(name, generic_##name))
    41	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
