Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725A1504D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiDRIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiDRIH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:07:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63C1DF7A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650269119; x=1681805119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ORFKWVScGNsYP5nsezHq8UHqsDJYmFR4yB/252PQ2Mg=;
  b=IM0RJqPsraDAEUmWAwxQL/esRMENwJV/Q9kFIZcx7zTyORdwrjyv/Nkl
   rPPAk8HFi6Vo3rR8c8GP3ZLFRKy/57V0+asZ03pF+n/7UuFjjE/J9Gje7
   y+VPd2EMFVRYfseRC2M8clLTCRS7mUTgXMeHww8yI/rZCdLIWB0+7ibxo
   XFuVuAcAykPA3tIXSKf7NWVfhUa76wqJXrLOvO8HEiWsuo20tqB7WKrza
   EeVg+x/p/AAWWJ1fI8xdP5ua6hQra2PDlRX0i8TWPy7NBixW0BKl4dr2i
   /uPKbuDBoAE2Gb2UWEi2hnHCFm2HMEAUvydsC22jxs62jCDoSZEdGcSPR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262936715"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262936715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 01:05:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="592319447"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2022 01:05:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngMNp-0004Sr-6C;
        Mon, 18 Apr 2022 08:05:17 +0000
Date:   Mon, 18 Apr 2022 16:04:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap 45/47] include/linux/bitmap.h:615:39: error: passing
 argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast
Message-ID: <202204181517.43MrUpzS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   45a9e3feb171ccf077979b7ff6a0c6a732cfc17b
commit: 1a21df17d726b4f3c19a148e10d09ec632603f1c [45/47] lib: add bitmap_{from,to}_arr64
config: powerpc-randconfig-m031-20220417 (https://download.01.org/0day-ci/archive/20220418/202204181517.43MrUpzS-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/1a21df17d726b4f3c19a148e10d09ec632603f1c
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 1a21df17d726b4f3c19a148e10d09ec632603f1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/powermac/ drivers/w1/masters/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/w1/masters/ds2490.c:8:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/oid_registry.c:8:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   lib/oid_registry.c: At top level:
   lib/oid_registry.c:15:10: fatal error: oid_registry_data.c: No such file or directory
      15 | #include "oid_registry_data.c"
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/crc64.c:36:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   lib/crc64.c: At top level:
   lib/crc64.c:39:10: fatal error: crc64table.h: No such file or directory
      39 | #include "crc64table.h"
         |          ^~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/powerpc/platforms/powermac/pic.c:15:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: error: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Werror=int-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/powerpc/platforms/powermac/smp.c:21:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: error: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Werror=int-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   arch/powerpc/platforms/powermac/smp.c: At top level:
   arch/powerpc/platforms/powermac/smp.c:416:13: error: no previous prototype for 'smp_psurge_take_timebase' [-Werror=missing-prototypes]
     416 | void __init smp_psurge_take_timebase(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/powermac/smp.c:432:13: error: no previous prototype for 'smp_psurge_give_timebase' [-Werror=missing-prototypes]
     432 | void __init smp_psurge_give_timebase(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/w1/masters/ds1wm.c:14:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   drivers/w1/masters/ds1wm.c: In function 'ds1wm_probe':
   drivers/w1/masters/ds1wm.c:512:12: warning: variable 'inten' set but not used [-Wunused-but-set-variable]
     512 |         u8 inten;
         |            ^~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from lib/ubsan.c:15:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   lib/ubsan.c: At top level:
   lib/ubsan.c:242:6: warning: no previous prototype for '__ubsan_handle_type_mismatch' [-Wmissing-prototypes]
     242 | void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from lib/radix-tree.c:12:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   lib/radix-tree.c: At top level:
   lib/radix-tree.c:288:6: warning: no previous prototype for 'radix_tree_node_rcu_free' [-Wmissing-prototypes]
     288 | void radix_tree_node_rcu_free(struct rcu_head *head)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/notifier.h:14,
                    from include/linux/clk.h:14,
                    from lib/vsprintf.c:22:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1704:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1704 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from lib/bitmap.c:7:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   lib/bitmap.c: In function 'bitmap_to_arr64':
>> lib/bitmap.c:1570:30: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1570 |         unsigned long *end = bitmap + BITS_TO_LONGS(nbits);
         |                              ^~~~~~
   lib/bitmap.c:1575:43: warning: left shift count >= width of type [-Wshift-count-overflow]
    1575 |                         *buf |= *bitmap++ << 32;
         |                                           ^~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from lib/test_ida.c:9:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:615:39: warning: passing argument 2 of 'bitmap_from_arr64' makes pointer from integer without a cast [-Wint-conversion]
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                                       ^~~~
         |                                       |
         |                                       u64 {aka long long unsigned int}
   include/linux/bitmap.h:300:58: note: expected 'const u64 *' {aka 'const long long unsigned int *'} but argument is of type 'u64' {aka 'long long unsigned int'}
     300 | void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
         |                                               ~~~~~~~~~~~^~~
   lib/test_ida.c: At top level:
   lib/test_ida.c:16:6: warning: no previous prototype for 'ida_dump' [-Wmissing-prototypes]
      16 | void ida_dump(struct ida *ida) { }
         |      ^~~~~~~~
..


vim +/bitmap_from_arr64 +615 include/linux/bitmap.h

   602	
   603	/**
   604	 * bitmap_from_u64 - Check and swap words within u64.
   605	 *  @mask: source bitmap
   606	 *  @dst:  destination bitmap
   607	 *
   608	 * In 32-bit Big Endian kernel, when using ``(u32 *)(&val)[*]``
   609	 * to read u64 mask, we will get the wrong word.
   610	 * That is ``(u32 *)(&val)[0]`` gets the upper 32 bits,
   611	 * but we expect the lower 32-bits of u64.
   612	 */
   613	static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
   614	{
 > 615		return bitmap_from_arr64(dst, mask, 64);
   616	}
   617	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
