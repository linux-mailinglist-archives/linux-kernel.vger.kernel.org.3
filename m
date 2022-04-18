Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB01504E52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiDRJZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiDRJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:25:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40815FD6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650273741; x=1681809741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6U6qS+cBzfxjjNBBrQ1LVtF/dPLZrMp6Sfv/1HLsJhs=;
  b=S7YpcaqAuQl2rMad+fxL6QgGkpPh3QvRNKqcH6kRzGb/I4Z2zOEa1WYc
   AzPckE4J0PzUTWw8Vl3G3HJYs4jo3XxAl78eMuA7PVE6EoWeyQVoM6HGO
   Lfx2n/Y6cjxP/8ESA+OZDpSnFC7Q+lCdD6gipiiiAYOXIzAwcKVwwZK8P
   0AIEl5gTzYx+4pX5q8J9XfI5k/c4YMQ645d7/Y1jHejrytYRi/6anZMuS
   48QjLVxqdU1uvXggAdBh/NEcfs/LKhErbtdKBg83rlXGuwBI//c1oU0LX
   t3njW2sCsR9GdFhsLVQV5Tc7Zfrj823Qjv83abEJWH8WvqHTX2mhx+KX/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262344244"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262344244"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 02:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="528799918"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Apr 2022 02:22:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngNaM-0004VH-QU;
        Mon, 18 Apr 2022 09:22:18 +0000
Date:   Mon, 18 Apr 2022 17:22:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap 44/47] include/linux/bitmap.h:259:9: warning: 'memcpy'
 forming offset [84, 87] is out of the bounds [0, 84] of object
 'link_usettings' with type 'struct ethtool_link_usettings'
Message-ID: <202204181725.iv9g9yFO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   45a9e3feb171ccf077979b7ff6a0c6a732cfc17b
commit: 44fa42b086fd02ab7d41d92800b6888ee240fcdf [44/47] lib/bitmap: don't implement bitmap_(from,to)_arr32 on LE systems
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220418/202204181725.iv9g9yFO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/44fa42b086fd02ab7d41d92800b6888ee240fcdf
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 44fa42b086fd02ab7d41d92800b6888ee240fcdf
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/ethtool/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from net/ethtool/ioctl.c:10:
   net/ethtool/ioctl.c: In function 'store_link_ksettings_for_user.constprop':
   include/linux/bitmap.h:270:44: warning: array subscript 'long unsigned int[10]' is partly outside array bounds of 'struct ethtool_link_usettings[1]' [-Warray-bounds]
     270 |                 dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
         |                                            ^~
   net/ethtool/ioctl.c:516:39: note: while referencing 'link_usettings'
     516 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from net/ethtool/ioctl.c:10:
   include/linux/bitmap.h:270:44: warning: array subscript 'long unsigned int[10]' is partly outside array bounds of 'struct ethtool_link_usettings[1]' [-Warray-bounds]
     270 |                 dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
         |                                            ^
   net/ethtool/ioctl.c:516:39: note: while referencing 'link_usettings'
     516 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from net/ethtool/ioctl.c:10:
   In function 'bitmap_copy',
       inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:268:2,
       inlined from 'store_link_ksettings_for_user.constprop' at net/ethtool/ioctl.c:525:2:
>> include/linux/bitmap.h:259:9: warning: 'memcpy' forming offset [84, 87] is out of the bounds [0, 84] of object 'link_usettings' with type 'struct ethtool_link_usettings' [-Warray-bounds]
     259 |         memcpy(dst, src, len);
         |         ^~~~~~~~~~~~~~~~~~~~~
   net/ethtool/ioctl.c: In function 'store_link_ksettings_for_user.constprop':
   net/ethtool/ioctl.c:516:39: note: 'link_usettings' declared here
     516 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from net/ethtool/ioctl.c:10:
   In function 'bitmap_copy',
       inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:268:2,
       inlined from 'load_link_ksettings_from_user' at net/ethtool/ioctl.c:483:2:
>> include/linux/bitmap.h:259:9: warning: 'memcpy' forming offset [84, 87] is out of the bounds [0, 84] of object 'link_usettings' with type 'struct ethtool_link_usettings' [-Warray-bounds]
     259 |         memcpy(dst, src, len);
         |         ^~~~~~~~~~~~~~~~~~~~~
   net/ethtool/ioctl.c: In function 'load_link_ksettings_from_user':
   net/ethtool/ioctl.c:471:39: note: 'link_usettings' declared here
     471 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~


vim +259 include/linux/bitmap.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  254  
^1da177e4c3f41 Linus Torvalds   2005-04-16  255  static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
8b4daad52fee77 Rasmus Villemoes 2015-02-12  256  			unsigned int nbits)
^1da177e4c3f41 Linus Torvalds   2005-04-16  257  {
8b4daad52fee77 Rasmus Villemoes 2015-02-12  258  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
^1da177e4c3f41 Linus Torvalds   2005-04-16 @259  	memcpy(dst, src, len);
^1da177e4c3f41 Linus Torvalds   2005-04-16  260  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  261  

:::::: The code at line 259 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
