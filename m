Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1251504D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiDRIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDRIH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:07:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6ADF73
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650269119; x=1681805119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dYknuPY0EPU/18Zcs7Q/b477tD6wQec6hE1aWlICgsY=;
  b=CQ4+zmIl1ipdlhHdCLbKktQeS1OtHHggUG0WWCj0gJRWMcwk36ugKW0h
   nmQD5/4Kyk9HGLefBp6ZkkGCodPwX8U5/nsUEdo9M4nircXDx4IwV0w90
   bEUYNbVVKglDWhBUiS8lg5weFGUGqi1eU5s3JLYqezguWe3mIz+mSkdFd
   ubM45tJqGLPF9jYQiS9YC1DHhFoG5+6DO5TkYmNXs+jF6H19pMyKWL+cw
   zj7FMEngdCv86dAT1fz9vXcl54H8IoK+fzQoE4p6XqS/i32tFljQWff52
   9VwTQjmAilcrrS3zGrGVoFl8Ys6PcSGChJG0rYZD1tCVl24NAIVTJBi9o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="250777483"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="250777483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 01:05:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="646792197"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2022 01:05:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngMNp-0004Sv-7v;
        Mon, 18 Apr 2022 08:05:17 +0000
Date:   Mon, 18 Apr 2022 16:04:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap 44/47] include/linux/bitmap.h:270:44: warning: array
 subscript 'long unsigned int[10]' is partly outside array bounds of 'struct
 ethtool_link_usettings[1]'
Message-ID: <202204181531.Chxo5619-lkp@intel.com>
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
commit: 44fa42b086fd02ab7d41d92800b6888ee240fcdf [44/47] lib/bitmap: don't implement bitmap_(from,to)_arr32 on LE systems
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220418/202204181531.Chxo5619-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/44fa42b086fd02ab7d41d92800b6888ee240fcdf
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 44fa42b086fd02ab7d41d92800b6888ee240fcdf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash net/ethtool/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from net/ethtool/ioctl.c:10:
   net/ethtool/ioctl.c: In function 'store_link_ksettings_for_user.constprop':
>> include/linux/bitmap.h:270:44: warning: array subscript 'long unsigned int[10]' is partly outside array bounds of 'struct ethtool_link_usettings[1]' [-Warray-bounds]
     270 |                 dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
         |                                            ^~
   net/ethtool/ioctl.c:516:39: note: while referencing 'link_usettings'
     516 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from net/ethtool/ioctl.c:10:
>> include/linux/bitmap.h:270:44: warning: array subscript 'long unsigned int[10]' is partly outside array bounds of 'struct ethtool_link_usettings[1]' [-Warray-bounds]
     270 |                 dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
         |                                            ^
   net/ethtool/ioctl.c:516:39: note: while referencing 'link_usettings'
     516 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from net/ethtool/ioctl.c:10:
   In function 'bitmap_copy',
       inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:268:2,
       inlined from 'store_link_ksettings_for_user.constprop' at net/ethtool/ioctl.c:525:2:
>> arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' forming offset [84, 87] is out of the bounds [0, 84] of object 'link_usettings' with type 'struct ethtool_link_usettings' [-Warray-bounds]
      22 | #define memcpy __builtin_memcpy
   include/linux/bitmap.h:259:9: note: in expansion of macro 'memcpy'
     259 |         memcpy(dst, src, len);
         |         ^~~~~~
   net/ethtool/ioctl.c: In function 'store_link_ksettings_for_user.constprop':
   net/ethtool/ioctl.c:516:39: note: 'link_usettings' declared here
     516 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from net/ethtool/ioctl.c:10:
   In function 'bitmap_copy',
       inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:268:2,
       inlined from 'load_link_ksettings_from_user' at net/ethtool/ioctl.c:483:2:
>> arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' forming offset [84, 87] is out of the bounds [0, 84] of object 'link_usettings' with type 'struct ethtool_link_usettings' [-Warray-bounds]
      22 | #define memcpy __builtin_memcpy
   include/linux/bitmap.h:259:9: note: in expansion of macro 'memcpy'
     259 |         memcpy(dst, src, len);
         |         ^~~~~~
   net/ethtool/ioctl.c: In function 'load_link_ksettings_from_user':
   net/ethtool/ioctl.c:471:39: note: 'link_usettings' declared here
     471 |         struct ethtool_link_usettings link_usettings;
         |                                       ^~~~~~~~~~~~~~


vim +270 include/linux/bitmap.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  261  
c724f193619c89 Yury Norov     2018-02-06  262  /*
c724f193619c89 Yury Norov     2018-02-06  263   * Copy bitmap and clear tail bits in last word.
c724f193619c89 Yury Norov     2018-02-06  264   */
c724f193619c89 Yury Norov     2018-02-06  265  static inline void bitmap_copy_clear_tail(unsigned long *dst,
c724f193619c89 Yury Norov     2018-02-06  266  		const unsigned long *src, unsigned int nbits)
c724f193619c89 Yury Norov     2018-02-06  267  {
c724f193619c89 Yury Norov     2018-02-06  268  	bitmap_copy(dst, src, nbits);
c724f193619c89 Yury Norov     2018-02-06  269  	if (nbits % BITS_PER_LONG)
c724f193619c89 Yury Norov     2018-02-06 @270  		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
c724f193619c89 Yury Norov     2018-02-06  271  }
c724f193619c89 Yury Norov     2018-02-06  272  

:::::: The code at line 270 was first introduced by commit
:::::: c724f193619c896621bf5818d71ce77437f49a06 bitmap: new bitmap_copy_safe and bitmap_{from,to}_arr32

:::::: TO: Yury Norov <ynorov@caviumnetworks.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
