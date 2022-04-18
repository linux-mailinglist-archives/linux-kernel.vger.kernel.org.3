Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58C9504EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiDRKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiDRKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:48:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A1B165A5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650278724; x=1681814724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BnOF4mBFdDpA+edMDstDLQHgz1p7Hn6gaO0haCK3REI=;
  b=XlEYM+lbcT4497vvmlfip+MsG76HGt2KdEe2zhTXl/kGgCf7XDZq8G8q
   GCdqdw3941KEs16xVNLMS3ggj83S2QOA3SkOHjIUrAMGZIzci6BCwXa3D
   sEhTMMj78+jhB1oB+XAy+8r5DcKmidsVkvf+31vnqzABlFRRPrXH8HThz
   yWE9Z3ghjEKlx0vpPvANdjb8PS3LfrV+fDlQqqyBxSt3ZBYkfRHIgXxba
   xLAm9wUTFQnzg8w590KFUb6EovByyHKKn2s+EaAvp4sj1eeMFL1c1AOMn
   VsVVTCtQ8DAUfyLmsb8j3+Cqswb94fI8V/zZVTMVMnJb9dpFnx3ljHDE/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="349944780"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="349944780"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 03:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="592353831"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2022 03:45:22 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngOsk-0004Yc-2M;
        Mon, 18 Apr 2022 10:45:22 +0000
Date:   Mon, 18 Apr 2022 18:44:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap 45/47] include/linux/bitmap.h:259:9: warning: 'memcpy'
 forming offset [20, 23] is out of the bounds [0, 20]
Message-ID: <202204181840.J2i3sYYd-lkp@intel.com>
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
commit: 1a21df17d726b4f3c19a148e10d09ec632603f1c [45/47] lib: add bitmap_{from,to}_arr64
config: arm-randconfig-c002-20220418 (https://download.01.org/0day-ci/archive/20220418/202204181840.J2i3sYYd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/1a21df17d726b4f3c19a148e10d09ec632603f1c
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 1a21df17d726b4f3c19a148e10d09ec632603f1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/rfkill.h:35,
                    from net/bluetooth/hci_core.c:29:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
   include/linux/bitmap.h:305:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/rfkill.h:35,
                    from net/bluetooth/hci_core.c:29:
   In function 'bitmap_copy',
       inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:268:2,
       inlined from 'bitmap_from_u64' at include/linux/bitmap.h:615:9,
       inlined from 'hci_bdaddr_list_add_with_flags' at net/bluetooth/hci_core.c:2156:2:
>> include/linux/bitmap.h:259:9: warning: 'memcpy' forming offset [20, 23] is out of the bounds [0, 20] [-Warray-bounds]
     259 |         memcpy(dst, src, len);
         |         ^~~~~~~~~~~~~~~~~~~~~


vim +/memcpy +259 include/linux/bitmap.h

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
