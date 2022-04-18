Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D89504E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiDRJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiDRJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:05:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD513DFD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650272548; x=1681808548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6fhqi6GLfn7V/FDZexOM50kekWme0QsVXroGnJzP2/A=;
  b=hPfXwRH6YZClxR1Q3J4yvLS0eH5vzMcKeRUULVF/oOiPY5QUyk7mdlec
   Yn1exgZakCf3A20fsSx16yLUXXhH9ikXjwt6gad/bVsBCkDJKixbDeNsx
   PYzMVwBoUPQDTZcpMmILub5dXCQL9PW51kZdcemrbW7rxlew/cjTJZB9o
   lUrHQsQ/UXMz2QG6pL3CoaK443ht6wLqFF5GlnONLexl3k2rhmxN+2nGU
   Yx6UadI3LATAnn/sCkORbvSq6zq2VXi58rDVfIzuGwTmeWorWnevtRQy3
   DsrYDjxIpVKElw7p7nkOoqUYYU+o+cVylPRBWo41zoK+FZTiOKWFGKcNG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245374248"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="245374248"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 02:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="646804763"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2022 02:02:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngNH0-0004Up-HD;
        Mon, 18 Apr 2022 09:02:18 +0000
Date:   Mon, 18 Apr 2022 17:01:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap 45/47] include/linux/bitmap.h:305:25: error: cast to
 pointer from integer of different size
Message-ID: <202204181659.gwd7pDJ8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   45a9e3feb171ccf077979b7ff6a0c6a732cfc17b
commit: 1a21df17d726b4f3c19a148e10d09ec632603f1c [45/47] lib: add bitmap_{from,to}_arr64
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220418/202204181659.gwd7pDJ8-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/1a21df17d726b4f3c19a148e10d09ec632603f1c
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 1a21df17d726b4f3c19a148e10d09ec632603f1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/test_bitops.c:9:
   include/linux/bitmap.h: In function 'bitmap_from_u64':
>> include/linux/bitmap.h:305:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     305 |                         (const unsigned long *) (buf), (nbits))
         |                         ^
   include/linux/bitmap.h:615:16: note: in expansion of macro 'bitmap_from_arr64'
     615 |         return bitmap_from_arr64(dst, mask, 64);
         |                ^~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +305 include/linux/bitmap.h

   292	
   293	/*
   294	 * On 64-bit systems bitmaps are represented as u64 arrays internally. On LE32
   295	 * machines the order of hi and lo parts of nubmers match the bitmap structure.
   296	 * In both cases conversion is not needed when copying data from/to arrays of
   297	 * u64.
   298	 */
   299	#if (BITS_PER_LONG == 32) && defined (__BIG_ENDIAN)
   300	void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
   301	void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
   302	#else
   303	#define bitmap_from_arr64(bitmap, buf, nbits)			\
   304		bitmap_copy_clear_tail((unsigned long *) (bitmap),	\
 > 305				(const unsigned long *) (buf), (nbits))
   306	#define bitmap_to_arr64(buf, bitmap, nbits)			\
   307		bitmap_copy_clear_tail((unsigned long *) (buf),		\
   308				(const unsigned long *) (bitmap), (nbits))
   309	#endif
   310	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
