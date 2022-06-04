Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156BC53D891
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiFDU65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiFDU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:58:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F61408B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654376334; x=1685912334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZbzfPw3KEU8aEBadzUpmPpbs+lKGvDyOUyDE8IgRrE0=;
  b=BcNBpLwHypX8dNZ1BjBnvpZwJbVEirikrXw8T/nyma5ADMU+6dPRNuH/
   mSCnhWhzdDcisjENLmqRa4K1+xHrPvsnSCHltDQ1X5pMPKcN7joDpz9ZC
   MZEiYO1163z46ORrmDse3AeJRxgDuFzMgkjvFHwPBlSbJ7F0smJNC9/1W
   zo2Le1p2sjfmNaD8KSK1k+TBbQuwWMj9We2XunRis9Um0YN66RlVyy+fQ
   CGnFQX4K2yqXtyLxcB/H40IjKBFE7h+TT6vUe/tk6tiXzUGoTwKvI4lGR
   vxVlIwlg2k+mnauweGJJlOK6AN3vBLFxBWarzmflQTPPTW/J3JapCSISP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="275277365"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="275277365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 13:58:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="722235184"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jun 2022 13:58:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxarE-000BCx-BO;
        Sat, 04 Jun 2022 20:58:52 +0000
Date:   Sun, 5 Jun 2022 04:58:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>
Subject: arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202206050405.j880lgTy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 606b102876e3741851dfb09d53f3ee57f650a52c drm: fb_helper: fix CONFIG_FB dependency
date:   8 months ago
config: arm-randconfig-s031-20220605 (https://download.01.org/0day-ci/archive/20220605/202206050405.j880lgTy-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=606b102876e3741851dfb09d53f3ee57f650a52c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 606b102876e3741851dfb09d53f3ee57f650a52c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arm/boot/compressed/decompress.c: note: in included file (through arch/arm/boot/compressed/../../../../lib/decompress_unxz.c):
   include/linux/decompress/mm.h:31:30: sparse: sparse: symbol 'malloc_ptr' was not declared. Should it be static?
   include/linux/decompress/mm.h:32:20: sparse: sparse: symbol 'malloc_count' was not declared. Should it be static?
   arch/arm/boot/compressed/decompress.c: note: in included file (through arch/arm/boot/compressed/../../../../lib/decompress_unxz.c):
   arch/arm/boot/compressed/decompress.c: note: in included file (through arch/arm/boot/compressed/../../../../lib/decompress_unxz.c):
>> arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *

vim +393 arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c

24fa0402a9b6a5 Lasse Collin 2011-01-12  385  
24fa0402a9b6a5 Lasse Collin 2011-01-12  386  /* Decode the Stream Header field (the first 12 bytes of the .xz Stream). */
24fa0402a9b6a5 Lasse Collin 2011-01-12  387  static enum xz_ret dec_stream_header(struct xz_dec *s)
24fa0402a9b6a5 Lasse Collin 2011-01-12  388  {
24fa0402a9b6a5 Lasse Collin 2011-01-12  389  	if (!memeq(s->temp.buf, HEADER_MAGIC, HEADER_MAGIC_SIZE))
24fa0402a9b6a5 Lasse Collin 2011-01-12  390  		return XZ_FORMAT_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  391  
24fa0402a9b6a5 Lasse Collin 2011-01-12  392  	if (xz_crc32(s->temp.buf + HEADER_MAGIC_SIZE, 2, 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12 @393  			!= get_le32(s->temp.buf + HEADER_MAGIC_SIZE + 2))
24fa0402a9b6a5 Lasse Collin 2011-01-12  394  		return XZ_DATA_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  395  
24fa0402a9b6a5 Lasse Collin 2011-01-12  396  	if (s->temp.buf[HEADER_MAGIC_SIZE] != 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12  397  		return XZ_OPTIONS_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  398  
24fa0402a9b6a5 Lasse Collin 2011-01-12  399  	/*
24fa0402a9b6a5 Lasse Collin 2011-01-12  400  	 * Of integrity checks, we support only none (Check ID = 0) and
24fa0402a9b6a5 Lasse Collin 2011-01-12  401  	 * CRC32 (Check ID = 1). However, if XZ_DEC_ANY_CHECK is defined,
24fa0402a9b6a5 Lasse Collin 2011-01-12  402  	 * we will accept other check types too, but then the check won't
24fa0402a9b6a5 Lasse Collin 2011-01-12  403  	 * be verified and a warning (XZ_UNSUPPORTED_CHECK) will be given.
24fa0402a9b6a5 Lasse Collin 2011-01-12  404  	 */
24fa0402a9b6a5 Lasse Collin 2011-01-12  405  	s->check_type = s->temp.buf[HEADER_MAGIC_SIZE + 1];
24fa0402a9b6a5 Lasse Collin 2011-01-12  406  

:::::: The code at line 393 was first introduced by commit
:::::: 24fa0402a9b6a537e87e38341e78b7da86486846 decompressors: add XZ decompressor module

:::::: TO: Lasse Collin <lasse.collin@tukaani.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
