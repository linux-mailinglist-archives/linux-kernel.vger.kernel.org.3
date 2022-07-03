Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B545648D9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiGCRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:53:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D474C5F98
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656870784; x=1688406784;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ONksqab845PiytPyHEw1zM7ohj0P+01clR0xBXXysY4=;
  b=Ipvuwe6jTQGXvd/OmveGW1f4n8BaLXH2lLL5xTc3JI0vNW/KokUSFF9B
   aUBnwUGNkFXauvfQOTM6rTTGgQXGLj0G/jxq52QM8+Ed5mksek6Dr13im
   HwcQX1I0onMmEpbRmzjeg6ceVu17aQnmc2Mtw8QpDJX1ed4lfuyQlXsiH
   Ttrw3x6mq8Eb5A3ZrPmC8yYJ7tfJm5YI+U28x/ns8/8PehOwLO1ng75BF
   gZB4P9lHLWnI9e/V6+VvV7jRHBRIen7MlELNSZBw4NjX+NzcT6tOE778f
   riFroioiQReNxSyKdRV4Z0BrmWcTEvXOKmxNqgHnQvBImt4qyzRXkmP3n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="369295962"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="369295962"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 10:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="566901602"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2022 10:53:03 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o83mI-000Gmq-Du;
        Sun, 03 Jul 2022 17:53:02 +0000
Date:   Mon, 4 Jul 2022 01:52:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:xdp_hints 25/52] include/linux/build_bug.h:78:41: error:
 static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) +
 sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), tx_tstamp)) %
 sizeof_field(typeof(*md), tx_tstamp) == 0"
Message-ID: <202207040107.DocyfiR6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux xdp_hints
head:   e9f4215398901c2e3f477da53abc668ce7b7e320
commit: c57c9963021291f6e2c2ce97af1a7c62ae657fec [25/52] net, xdp: add basic generic metadata accessors
config: arm-h3600_defconfig (https://download.01.org/0day-ci/archive/20220704/202207040107.DocyfiR6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/c57c9963021291f6e2c2ce97af1a7c62ae657fec
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin xdp_hints
        git checkout c57c9963021291f6e2c2ce97af1a7c62ae657fec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from net/bpf/core.c:6:
   include/net/xdp_meta.h: In function 'xdp_meta_tx_tstamp_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), tx_tstamp)) % sizeof_field(typeof(*md), tx_tstamp) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:134:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     134 | XDP_META_BUILD_ACC(tx, tstamp, 64);
         | ^~~~~~~~~~~~~~~~~~
   include/net/xdp_meta.h: In function 'xdp_meta_rx_tstamp_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), rx_tstamp)) % sizeof_field(typeof(*md), rx_tstamp) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:177:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     177 | XDP_META_BUILD_ACC(rx, tstamp, 64);
         | ^~~~~~~~~~~~~~~~~~
   include/net/xdp_meta.h: In function 'xdp_meta_rx_hash_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), rx_hash)) % sizeof_field(typeof(*md), rx_hash) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:178:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     178 | XDP_META_BUILD_ACC(rx, hash, 32);
         | ^~~~~~~~~~~~~~~~~~
   include/net/xdp_meta.h: In function 'xdp_meta_rx_csum_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), rx_csum)) % sizeof_field(typeof(*md), rx_csum) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:179:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     179 | XDP_META_BUILD_ACC(rx, csum, 32);
         | ^~~~~~~~~~~~~~~~~~
   include/net/xdp_meta.h: In function 'xdp_meta_rx_flags_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), rx_flags)) % sizeof_field(typeof(*md), rx_flags) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:182:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     182 | XDP_META_BUILD_ACC(rx, flags, 32);
         | ^~~~~~~~~~~~~~~~~~
   include/net/xdp_meta.h: In function 'xdp_meta_btf_id_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), btf_id)) % sizeof_field(typeof(*md), btf_id) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:194:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     194 | XDP_META_BUILD_ACC(btf, id, 32);
         | ^~~~~~~~~~~~~~~~~~
   include/net/xdp_meta.h: In function 'xdp_meta_type_id_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), type_id)) % sizeof_field(typeof(*md), type_id) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:195:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     195 | XDP_META_BUILD_ACC(type, id, 32);
         | ^~~~~~~~~~~~~~~~~~
   include/net/xdp_meta.h: In function 'xdp_meta_full_id_set':
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(XDP_PACKET_HEADROOM - sizeof(*md) + sizeof_field(typeof(*md), magic_id) + offsetof(typeof(*md), full_id)) % sizeof_field(typeof(*md), full_id) == 0"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/xdp_meta.h:95:9: note: in expansion of macro 'static_assert'
      95 |         static_assert((XDP_PACKET_HEADROOM - sizeof(*md) +                   \
         |         ^~~~~~~~~~~~~
   include/net/xdp_meta.h:196:1: note: in expansion of macro 'XDP_META_BUILD_ACC'
     196 | XDP_META_BUILD_ACC(full, id, 64);
         | ^~~~~~~~~~~~~~~~~~


vim +78 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10  60  
6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013be Rasmus Villemoes 2019-03-07  79  

:::::: The code at line 78 was first introduced by commit
:::::: 6bab69c65013bed5fce9f101a64a84d0385b3946 build_bug.h: add wrapper for _Static_assert

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
