Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9663250A9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392362AbiDUU34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382681AbiDUU3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:29:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7F4D25D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650572824; x=1682108824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y8unbK9Ek6KCDiTDsxDHyypG4mp4nnlyjAuZ37/RS2g=;
  b=VAZng06+FFXkUX1072W0H++6aldcryOW4ug6nv1oPX2g49yGpXf4oQrj
   hR6786tDXubqcil4er7tz0WIkPIndRFoxiJn1/0RvzL8Giig4HVUVA6yx
   TKTZ7qcULTXE/75A8n2svEhxU4cnDr5oGuAD0OUtUPQbi/2uhskr41C3I
   FT9n6OH83X9/wkM1y74O0hqfl9seRpbTGMEeX1WSkEF4pYpL3oxlducpW
   3Rp6Ef4QTRC0eBhn7rOgVV9FjaxjO/Ezl+2YPhtRvvrhuADEBO8WeNi2S
   FEh9G4uPcolIW4bw1G8jg5AGxzaTD1pldkwCjFf8HjO0t+J40N0iaMG7+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264639515"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="264639515"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 13:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="577452614"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2022 13:26:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhdO0-0008l8-BL;
        Thu, 21 Apr 2022 20:26:44 +0000
Date:   Fri, 22 Apr 2022 04:25:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap 45/47] lib/bitmap.c:1570:17: error: initializing
 'unsigned long *' with an expression of type 'const unsigned long *'
 discards qualifiers
Message-ID: <202204220430.uHgyhQL9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   29f3046c8c2929f8dbe5e1cb4f25ebdd5366ebe7
commit: f1cbd19c47bf73d532ff30571601c7ede57d5f82 [45/47] lib: add bitmap_{from,to}_arr64
config: mips-allnoconfig (https://download.01.org/0day-ci/archive/20220422/202204220430.uHgyhQL9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/norov/linux/commit/f1cbd19c47bf73d532ff30571601c7ede57d5f82
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout f1cbd19c47bf73d532ff30571601c7ede57d5f82
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/bitmap.c:1570:17: error: initializing 'unsigned long *' with an expression of type 'const unsigned long *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           unsigned long *end = bitmap + BITS_TO_LONGS(nbits);
                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/bitmap.c:1575:22: warning: shift count >= width of type [-Wshift-count-overflow]
                           *buf |= *bitmap++ << 32;
                                             ^  ~~
   1 warning and 1 error generated.


vim +1570 lib/bitmap.c

  1561	
  1562	/**
  1563	 * bitmap_to_arr64 - copy the contents of bitmap to a u64 array of bits
  1564	 *	@buf: array of u64 (in host byte order), the dest bitmap
  1565	 *	@bitmap: array of unsigned longs, the source bitmap
  1566	 *	@nbits: number of bits in @bitmap
  1567	 */
  1568	void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits)
  1569	{
> 1570		unsigned long *end = bitmap + BITS_TO_LONGS(nbits);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
