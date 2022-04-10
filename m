Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674A4FB057
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 23:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbiDJVXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbiDJVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 17:23:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AB6E3D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649625678; x=1681161678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ziPfFp9611FJlX7VRYRPEoEzmDMwCtMOWXYO5NJQa0Y=;
  b=UYIrXWQaM2hwwDodc7VT7QgDBK1kOg7cgSysnqzWkDamtrzalzAEAKRD
   yeq2ckGqyqQkOTeyXVVGazVnCvSbQ/GnWGDj43msiojQlEWQ1bowEKcnc
   L3BrBSo07Z5SRXglX40D5phpZxBH0/W3blPP071EQ/iGyyhMfIjTZSX9r
   PZpcjMxbMTfmX4UPcE7T+IYyahTTr/W7jfLgeeCnLcrdxUCOJ2pot6/Jb
   ii+yX+rFaveaohK1hyeRKGd42QISSxp859firpMDZLjqNNqmAypRxaLgM
   OOx+JwNo0eSwMjyo/zeRcTM32SOlmkQYfpXE1kqcNh0Smiw7LIJCe1+cT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243879838"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="243879838"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 14:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="525714244"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2022 14:21:17 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndezk-00016h-IN;
        Sun, 10 Apr 2022 21:21:16 +0000
Date:   Mon, 11 Apr 2022 05:21:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-for-next 43/43] lib/bitmap.c:1571:36: warning:
 operation on 'i' may be undefined
Message-ID: <202204110512.jCY23V15-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-for-next
head:   a136dfabd10d0c1354c41a069cc4e00147a721e1
commit: a136dfabd10d0c1354c41a069cc4e00147a721e1 [43/43] bitmap_from_arr64
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220411/202204110512.jCY23V15-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/a136dfabd10d0c1354c41a069cc4e00147a721e1
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-for-next
        git checkout a136dfabd10d0c1354c41a069cc4e00147a721e1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/bitmap.c: In function 'bitmap_to_arr64':
>> lib/bitmap.c:1571:36: warning: operation on 'i' may be undefined [-Wsequence-point]
    1571 |                 buf[i/2] = bitmap[i++];
         |                                   ~^~
>> lib/bitmap.c:1573:49: warning: left shift count >= width of type [-Wshift-count-overflow]
    1573 |                         buf[i/2] |= bitmap[i++] << 32;
         |                                                 ^~
   lib/bitmap.c:1573:45: warning: operation on 'i' may be undefined [-Wsequence-point]
    1573 |                         buf[i/2] |= bitmap[i++] << 32;
         |                                            ~^~
   lib/bitmap.c:1573:45: warning: operation on 'i' may be undefined [-Wsequence-point]


vim +/i +1571 lib/bitmap.c

  1559	
  1560	/**
  1561	 * bitmap_to_arr64 - copy the contents of bitmap to a u64 array of bits
  1562	 *	@buf: array of u64 (in host byte order), the dest bitmap
  1563	 *	@bitmap: array of unsigned longs, the source bitmap
  1564	 *	@nbits: number of bits in @bitmap
  1565	 */
  1566	void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits)
  1567	{
  1568		unsigned int i = 0, words = BITS_TO_LONGS(nbits);
  1569	
  1570		while (i < words) {
> 1571			buf[i/2] = bitmap[i++];
  1572			if (i < words)
> 1573				buf[i/2] |= bitmap[i++] << 32;
  1574		}
  1575	
  1576		/* Clear tail bits in last element of array beyond nbits. */
  1577		if (nbits % 64)
  1578			buf[i - 1] &= GENMASK_ULL(nbits, 0);
  1579	}
  1580	EXPORT_SYMBOL(bitmap_to_arr64);
  1581	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
