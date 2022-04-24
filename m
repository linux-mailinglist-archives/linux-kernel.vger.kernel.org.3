Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B3150CE36
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 03:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiDXBFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 21:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiDXBFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 21:05:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7A7A98B;
        Sat, 23 Apr 2022 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650762125; x=1682298125;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rpGan5ntJOy8zxeFm8vPLI0gLjVg44kjO+7Ud+rL6FI=;
  b=bJJX5C/Ox7FrzKORUrTDtjLUWY+szmx22dmEV6GkwqCvzxTMuOl3m2b1
   BCv3BUNVztplJTdw2+sIWanhfWNapgPVA56y/xMjI6oXjPOWWf6zQTAje
   YNd1JF64fgWtQ+MjA/4Ox4G6qN/0RRLOmjy9gXJmrJJ3mIPrUMUWrtl7I
   QMZEYzLkeoHz5iR9OjCyFFwnErYoLGrOAePu7CcoYIy8zBoBO60TPdiVN
   r0Vi/svWbqxe/mOTKWittgOoAqcH/lpl6m8cnJJp1kMgxPu3yotxvvn1q
   FmOlWlIPyIjUV9IX3qJrc8+sQcGfwRE7+kUmSYkkufzF9uZjjsLrTboiE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="246884862"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="246884862"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 18:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="729106443"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 18:02:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niQdV-0000mX-Rp;
        Sun, 24 Apr 2022 01:02:01 +0000
Date:   Sun, 24 Apr 2022 09:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:3126:34:
 warning: unused variable 'samsung_jpeg_match'
Message-ID: <202204240805.qkqRTjaY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6fc2586d23b574fcd3f6b14430277e91d27cf585
commit: f4104b7851a8d8b9a70899dcbecdb393eb16cd8a media: platform: rename s5p-jpeg/ to samsung/s5p-jpeg/
date:   5 weeks ago
config: arm-randconfig-c002-20220418 (https://download.01.org/0day-ci/archive/20220424/202204240805.qkqRTjaY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b27430f9f46b88bcd54d992debc8d72e131e1bd0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4104b7851a8d8b9a70899dcbecdb393eb16cd8a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f4104b7851a8d8b9a70899dcbecdb393eb16cd8a
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:3126:34: warning: unused variable 'samsung_jpeg_match' [-Wunused-const-variable]
   static const struct of_device_id samsung_jpeg_match[] = {
                                    ^
   In file included from drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:24:
   In file included from include/media/v4l2-event.h:16:
   In file included from include/linux/videodev2.h:61:
   include/uapi/linux/videodev2.h:1746:2: warning: field  within 'struct v4l2_ext_control' is less aligned than 'union v4l2_ext_control::(anonymous at include/uapi/linux/videodev2.h:1746:2)' and is usually due to 'struct v4l2_ext_control' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   2 warnings generated.


clang-analyzer warnings: (new ones prefixed by >>)
   8 warnings generated.
   Suppressed 8 warnings (8 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   11 warnings generated.
   kernel/trace/trace_events.c:1363:3: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcat(buf, "*");
                   ^~~~~~
   kernel/trace/trace_events.c:1363:3: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
                   strcat(buf, "*");
                   ^~~~~~
   kernel/trace/trace_events.c:1365:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(buf, "\n");
           ^~~~~~
   kernel/trace/trace_events.c:1365:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(buf, "\n");
           ^~~~~~
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (10 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (10 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   12 warnings generated.
>> drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1141:3: warning: Value stored to 'length' is never read [clang-analyzer-deadcode.DeadStores]
                   length = 0;
                   ^        ~
   drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1141:3: note: Value stored to 'length' is never read
                   length = 0;
                   ^        ~
   Suppressed 11 warnings (9 in non-user code, 2 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   drivers/hwmon/asc7621.c:425:11: warning: The result of the left shift is undefined because the left operand is negative [clang-analyzer-core.UndefinedBinaryOperatorResult]
           temp = i << 2;
                  ~ ^
   drivers/hwmon/asc7621.c:419:6: note: Assuming the condition is false
           if (kstrtol(buf, 10, &reqval))
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/asc7621.c:419:2: note: Taking false branch
           if (kstrtol(buf, 10, &reqval))
           ^
   drivers/hwmon/asc7621.c:422:11: note: Assuming '__UNIQUE_ID___x280' is <= '__UNIQUE_ID___y281'
           reqval = clamp_val(reqval, -32000, 31750);
                    ^
   include/linux/minmax.h:137:32: note: expanded from macro 'clamp_val'
   #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:124:48: note: expanded from macro 'clamp_t'
   #define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
                                      ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:112:27: note: expanded from macro 'max_t'
   #define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)
                                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/minmax.h:104:48: note: expanded from macro 'min_t'
   #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
                                   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:31:25: note: expanded from macro '__cmp_once'
                   typeof(x) unique_x = (x);               \
                                         ^
   drivers/hwmon/asc7621.c:422:11: note: '?' condition is false
           reqval = clamp_val(reqval, -32000, 31750);
                    ^
   include/linux/minmax.h:137:32: note: expanded from macro 'clamp_val'
   #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
                                  ^
   include/linux/minmax.h:124:48: note: expanded from macro 'clamp_t'
   #define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
                                                  ^
   include/linux/minmax.h:112:27: note: expanded from macro 'max_t'
   #define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)
                                   ^
   include/linux/minmax.h:38:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ^
   include/linux/minmax.h:33:3: note: expanded from macro '__cmp_once'
                   __cmp(unique_x, unique_y, op); })
                   ^
   include/linux/minmax.h:28:26: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                            ^
   drivers/hwmon/asc7621.c:422:11: note: '__UNIQUE_ID___x282' is < '__UNIQUE_ID___y283'
           reqval = clamp_val(reqval, -32000, 31750);
                    ^
   include/linux/minmax.h:137:32: note: expanded from macro 'clamp_val'
   #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:124:36: note: expanded from macro 'clamp_t'
   #define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:104:27: note: expanded from macro 'min_t'
   #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:38:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:3: note: expanded from macro '__cmp_once'
--
                                 ^
   include/linux/compiler.h:48:68: note: expanded from macro 'unlikely'
   #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                                                                        ^
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   net/core/gro.c:708:3: note: Taking false branch
                   if (unlikely(!eth)) {
                   ^
   net/core/gro.c:720:2: note: Calling '__skb_pull'
           __skb_pull(skb, hlen);
           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/skbuff.h:2398:9: note: Assuming field 'len' is >= field 'data_len'
           BUG_ON(skb->len < skb->data_len);
                  ^
   include/asm-generic/bug.h:65:45: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                               ^~~~~~~~~
   include/linux/compiler.h:48:41: note: expanded from macro 'unlikely'
   #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   include/linux/skbuff.h:2398:14: note: Field 'len' is >= field 'data_len'
           BUG_ON(skb->len < skb->data_len);
                       ^
   include/linux/skbuff.h:2398:2: note: Taking false branch
           BUG_ON(skb->len < skb->data_len);
           ^
   include/asm-generic/bug.h:65:32: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                  ^
   include/linux/skbuff.h:2398:2: note: Loop condition is false.  Exiting loop
           BUG_ON(skb->len < skb->data_len);
           ^
   include/asm-generic/bug.h:65:27: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                             ^
   net/core/gro.c:720:2: note: Returning from '__skb_pull'
           __skb_pull(skb, hlen);
           ^~~~~~~~~~~~~~~~~~~~~
   net/core/gro.c:735:24: note: Returning from 'napi_frags_skb'
           struct sk_buff *skb = napi_frags_skb(napi);
                                 ^~~~~~~~~~~~~~~~~~~~
   net/core/gro.c:739:37: note: Calling 'dev_gro_receive'
           ret = napi_frags_finish(napi, skb, dev_gro_receive(napi, skb));
                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/gro.c:450:2: note: Taking true branch
           if (netif_elide_gro(skb->dev))
           ^
   net/core/gro.c:451:3: note: Control jumps to line 544
                   goto normal;
                   ^
   net/core/gro.c:545:2: note: Control jumps to line 530
           goto pull;
           ^
   net/core/gro.c:531:6: note: Assuming 'grow' is > 0
           if (grow > 0)
               ^~~~~~~~
   net/core/gro.c:531:2: note: Taking true branch
           if (grow > 0)
           ^
   net/core/gro.c:532:3: note: Calling 'gro_pull_from_frag0'
                   gro_pull_from_frag0(skb, grow);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/gro.c:402:9: note: Assuming the condition is false
           BUG_ON(skb->end - skb->tail < grow);
                  ^
   include/asm-generic/bug.h:65:45: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                               ^~~~~~~~~
   include/linux/compiler.h:48:41: note: expanded from macro 'unlikely'
   #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                                             ^
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   net/core/gro.c:402:2: note: Taking false branch
           BUG_ON(skb->end - skb->tail < grow);
           ^
   include/asm-generic/bug.h:65:32: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                  ^
   net/core/gro.c:402:2: note: Loop condition is false.  Exiting loop
           BUG_ON(skb->end - skb->tail < grow);
           ^
   include/asm-generic/bug.h:65:27: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                             ^
   net/core/gro.c:404:2: note: Null pointer passed as 2nd argument to memory copy function
           memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
           ^
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   11 warnings generated.
>> drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c:55:2: warning: Value stored to 'm' is never read [clang-analyzer-deadcode.DeadStores]
           m = S5P_PROC_MODE_DECOMPR;
           ^
   drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c:55:2: note: Value stored to 'm' is never read
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   15 warnings generated.
   security/keys/encrypted-keys/encrypted.c:365:3: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcpy(derived_buf, "AUTH_KEY");
                   ^~~~~~
   security/keys/encrypted-keys/encrypted.c:365:3: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                   strcpy(derived_buf, "AUTH_KEY");
                   ^~~~~~
   security/keys/encrypted-keys/encrypted.c:367:3: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcpy(derived_buf, "ENC_KEY");
                   ^~~~~~
   security/keys/encrypted-keys/encrypted.c:367:3: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                   strcpy(derived_buf, "ENC_KEY");
                   ^~~~~~
   security/keys/encrypted-keys/encrypted.c:374:2: warning: Potential leak of memory pointed to by 'derived_buf' [clang-analyzer-unix.Malloc]
           return ret;
           ^
   security/keys/encrypted-keys/encrypted.c:793:6: note: Assuming 'datalen' is > 0
           if (datalen <= 0 || datalen > 32767 || !prep->data)
               ^~~~~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:793:6: note: Left side of '||' is false
   security/keys/encrypted-keys/encrypted.c:793:22: note: Assuming 'datalen' is <= 32767
           if (datalen <= 0 || datalen > 32767 || !prep->data)
                               ^~~~~~~~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:793:6: note: Left side of '||' is false
           if (datalen <= 0 || datalen > 32767 || !prep->data)
               ^
   security/keys/encrypted-keys/encrypted.c:793:41: note: Assuming field 'data' is non-null
           if (datalen <= 0 || datalen > 32767 || !prep->data)
                                                  ^~~~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:793:2: note: Taking false branch
           if (datalen <= 0 || datalen > 32767 || !prep->data)
           ^
   security/keys/encrypted-keys/encrypted.c:797:6: note: Assuming 'datablob' is non-null
           if (!datablob)
               ^~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:797:2: note: Taking false branch
           if (!datablob)
           ^
   security/keys/encrypted-keys/encrypted.c:803:6: note: 'ret' is >= 0
           if (ret < 0)
               ^~~
   security/keys/encrypted-keys/encrypted.c:803:2: note: Taking false branch
           if (ret < 0)
           ^
   security/keys/encrypted-keys/encrypted.c:808:2: note: Taking false branch
           if (IS_ERR(epayload)) {
           ^
   security/keys/encrypted-keys/encrypted.c:812:8: note: Calling 'encrypted_init'
           ret = encrypted_init(epayload, key->description, format, master_desc,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:753:6: note: 'format' is null
           if (format && !strcmp(format, key_format_ecryptfs)) {
               ^~~~~~
   security/keys/encrypted-keys/encrypted.c:753:13: note: Left side of '&&' is false
           if (format && !strcmp(format, key_format_ecryptfs)) {
                      ^
   security/keys/encrypted-keys/encrypted.c:763:7: note: 'hex_encoded_iv' is non-null
           if (!hex_encoded_iv) {
                ^~~~~~~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:763:2: note: Taking false branch
           if (!hex_encoded_iv) {
           ^
   security/keys/encrypted-keys/encrypted.c:769:9: note: Calling 'encrypted_key_decrypt'
                   ret = encrypted_key_decrypt(epayload, format, hex_encoded_iv);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:670:6: note: Assuming the condition is false
           if (strlen(hex_encoded_iv) != asciilen)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/keys/encrypted-keys/encrypted.c:670:2: note: Taking false branch
           if (strlen(hex_encoded_iv) != asciilen)
           ^
   security/keys/encrypted-keys/encrypted.c:675:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   security/keys/encrypted-keys/encrypted.c:675:2: note: Taking false branch
           if (ret < 0)
           ^
   security/keys/encrypted-keys/encrypted.c:679:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   security/keys/encrypted-keys/encrypted.c:679:2: note: Taking false branch
           if (ret < 0)
           ^
   security/keys/encrypted-keys/encrypted.c:685:6: note: Assuming 'ret' is >= 0
           if (ret < 0)
               ^~~~~~~
   security/keys/encrypted-keys/encrypted.c:685:2: note: Taking false branch
           if (ret < 0)
           ^
   security/keys/encrypted-keys/encrypted.c:689:2: note: Taking false branch
           if (IS_ERR(mkey))
           ^
   security/keys/encrypted-keys/encrypted.c:692:8: note: Calling 'datablob_hmac_verify'
           ret = datablob_hmac_verify(epayload, format, master_key, master_keylen);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
                   ^
   drivers/regulator/mt6359-regulator.c:324:14: note: Assuming 'curr_mode' is equal to REGULATOR_MODE_IDLE
                   } else if (curr_mode == REGULATOR_MODE_IDLE) {
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/mt6359-regulator.c:324:10: note: Taking true branch
                   } else if (curr_mode == REGULATOR_MODE_IDLE) {
                          ^
   drivers/regulator/mt6359-regulator.c:326:8: note: Assigned value is garbage or undefined
                           val <<= ffs(info->lp_mode_mask) - 1;
                               ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/mt6359-regulator.c:336:7: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
                   val <<= ffs(info->lp_mode_mask) - 1;
                       ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/mt6359-regulator.c:307:2: note: Control jumps to 'case 4:'  at line 334
           switch (mode) {
           ^
   drivers/regulator/mt6359-regulator.c:336:7: note: Assigned value is garbage or undefined
                   val <<= ffs(info->lp_mode_mask) - 1;
                       ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/mt6359-regulator.c:421:6: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
           val >>= ffs(info->desc.vsel_mask) - 1;
               ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/mt6359-regulator.c:401:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/regulator/mt6359-regulator.c:401:2: note: Taking false branch
           if (ret)
           ^
   drivers/regulator/mt6359-regulator.c:403:2: note: Control jumps to 'case 1:'  at line 409
           switch (val) {
           ^
   drivers/regulator/mt6359-regulator.c:413:3: note:  Execution continues on line 417
                   break;
                   ^
   drivers/regulator/mt6359-regulator.c:417:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/regulator/mt6359-regulator.c:417:2: note: Taking false branch
           if (ret)
           ^
   drivers/regulator/mt6359-regulator.c:421:6: note: Assigned value is garbage or undefined
           val >>= ffs(info->desc.vsel_mask) - 1;
               ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (10 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   12 warnings generated.
>> drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1141:3: warning: Value stored to 'length' is never read [clang-analyzer-deadcode.DeadStores]
                   length = 0;
                   ^        ~
   drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1141:3: note: Value stored to 'length' is never read
                   length = 0;
                   ^        ~
   Suppressed 11 warnings (9 in non-user code, 2 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   11 warnings generated.
>> drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c:55:2: warning: Value stored to 'm' is never read [clang-analyzer-deadcode.DeadStores]
           m = S5P_PROC_MODE_DECOMPR;
           ^
   drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c:55:2: note: Value stored to 'm' is never read
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   11 warnings generated.
   lib/rbtree_test.c:309:3: warning: Value stored to 'node' is never read [clang-analyzer-deadcode.DeadStores]
                   node = rb_first(&root.rb_root);
                   ^      ~~~~~~~~~~~~~~~~~~~~~~~
   lib/rbtree_test.c:309:3: note: Value stored to 'node' is never read
                   node = rb_first(&root.rb_root);
                   ^      ~~~~~~~~~~~~~~~~~~~~~~~
   lib/rbtree_test.c:321:3: warning: Value stored to 'node' is never read [clang-analyzer-deadcode.DeadStores]
                   node = rb_first_cached(&root);
                   ^
   lib/rbtree_test.c:321:3: note: Value stored to 'node' is never read
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   3 warnings generated.
   Suppressed 3 warnings (3 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   31 warnings generated.
   Suppressed 31 warnings (31 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   13 warnings generated.
   Suppressed 13 warnings (13 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   kernel/trace/trace_probe.c:195:3: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcpy(p, trace_probe_log.argv[i]);
                   ^~~~~~
   kernel/trace/trace_probe.c:195:3: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                   strcpy(p, trace_probe_log.argv[i]);
                   ^~~~~~
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   kernel/trace/trace_uprobe.c:549:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
           ret = 0;
           ^     ~
   kernel/trace/trace_uprobe.c:549:2: note: Value stored to 'ret' is never read
           ret = 0;
           ^     ~
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   drivers/phy/marvell/phy-mmp3-usb.c:143:16: warning: Value stored to 'base' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           void __iomem *base = mmp3_usb_phy->base;
                         ^~~~   ~~~~~~~~~~~~~~~~~~
   drivers/phy/marvell/phy-mmp3-usb.c:143:16: note: Value stored to 'base' during its initialization is never read
           void __iomem *base = mmp3_usb_phy->base;
                         ^~~~   ~~~~~~~~~~~~~~~~~~
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   9 warnings generated.
   Suppressed 9 warnings (9 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   11 warnings generated.
   drivers/media/platform/nxp/imx-pxp.c:336:4: warning: The result of the left shift is undefined because the left operand is negative [clang-analyzer-core.UndefinedBinaryOperatorResult]
                           BF_PXP_CSC1_COEF0_UV_OFFSET(-128) |
                           ^
   drivers/media/platform/nxp/imx-pxp.h:598:8: note: expanded from macro 'BF_PXP_CSC1_COEF0_UV_OFFSET'
           (((v) << 9) & BM_PXP_CSC1_COEF0_UV_OFFSET)
             ~~~ ^
   drivers/media/platform/nxp/imx-pxp.c:316:6: note: Assuming the condition is true
           if (pxp_v4l2_pix_fmt_is_yuv(ctx->q_data[V4L2_M2M_SRC].fmt->fourcc) &&
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nxp/imx-pxp.c:316:6: note: Left side of '&&' is true
   drivers/media/platform/nxp/imx-pxp.c:317:6: note: Assuming the condition is true
               !pxp_v4l2_pix_fmt_is_yuv(ctx->q_data[V4L2_M2M_DST].fmt->fourcc)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nxp/imx-pxp.c:316:2: note: Taking true branch
           if (pxp_v4l2_pix_fmt_is_yuv(ctx->q_data[V4L2_M2M_SRC].fmt->fourcc) &&
           ^
   drivers/media/platform/nxp/imx-pxp.c:336:4: note: The result of the left shift is undefined because the left operand is negative
                           BF_PXP_CSC1_COEF0_UV_OFFSET(-128) |
                           ^
   drivers/media/platform/nxp/imx-pxp.h:598:8: note: expanded from macro 'BF_PXP_CSC1_COEF0_UV_OFFSET'
           (((v) << 9) & BM_PXP_CSC1_COEF0_UV_OFFSET)
             ~~~ ^
   Suppressed 10 warnings (9 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.

vim +/samsung_jpeg_match +3126 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c

6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3125  
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18 @3126  static const struct of_device_id samsung_jpeg_match[] = {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3127  	{
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3128  		.compatible = "samsung,s5pv210-jpeg",
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3129  		.data = &s5p_jpeg_drvdata,
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3130  	}, {
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3131  		.compatible = "samsung,exynos3250-jpeg",
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3132  		.data = &exynos3250_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3133  	}, {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3134  		.compatible = "samsung,exynos4210-jpeg",
3246fdaa0ac2d9 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2014-07-11  3135  		.data = &exynos4_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3136  	}, {
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3137  		.compatible = "samsung,exynos4212-jpeg",
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3138  		.data = &exynos4_jpeg_drvdata,
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3139  	}, {
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3140  		.compatible = "samsung,exynos5420-jpeg",
7c15fd4bf3d367 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-03-09  3141  		.data = &exynos5420_jpeg_drvdata,
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3142  	}, {
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3143  		.compatible = "samsung,exynos5433-jpeg",
6c96dbbc2aa9f5 drivers/media/platform/s5p-jpeg/jpeg-core.c Andrzej Pietrasiewicz 2015-09-18  3144  		.data = &exynos5433_jpeg_drvdata,
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3145  	},
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3146  	{},
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3147  };
80529ae5c13725 drivers/media/platform/s5p-jpeg/jpeg-core.c Jacek Anaszewski      2013-12-18  3148  

:::::: The code at line 3126 was first introduced by commit
:::::: 80529ae5c13725e12ba0377e29b2160794ba6b25 [media] s5p-jpeg:  JPEG codec

:::::: TO: Jacek Anaszewski <j.anaszewski@samsung.com>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
