Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB259B18A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiHUERi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 00:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUERe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 00:17:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4592A417
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661055453; x=1692591453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9x6aBvnCQITL3DEL0tA2RlqgQLgFLpsEln844SncwfI=;
  b=GlNxLyhIX6xfUB1z9d0+fn0Ig5wR5BmC6Qysl1WinFP8YF8VzLSVfsoU
   IJh8l+zyg/rWkWdqCEQzkOXR2xrLk2ZfZTg78MK7BpuWDL3jOMeDB+mIc
   chRuGHznchAAg82MJQ5KaTX/xvDlScWg0ApKcp9JWkPuag6Om/21gbJHd
   9WoH042bQBmUOL/Updowj2gqv87OUbjjh1k35BWh4NGC1A8DDnq3fmyyI
   haGY7zoS9QSnUdNL8/AQehPVMJsFujgkyKsItlXCxQo5f3/O40Y6x4CW5
   5LdTlp1k4ccBj3DBJqSkZivNw+DfQa0lMI3gLeZV6PxYTyZTzddfLqvoU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="293220895"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="293220895"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 21:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="641659931"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2022 21:17:31 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPcOw-0003df-2x;
        Sun, 21 Aug 2022 04:17:30 +0000
Date:   Sun, 21 Aug 2022 12:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:393:28:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202208211251.eSw2xmFX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: edd4a8667355607345b76d5652adc0f300a28970 s390/boot: get rid of startup archive
date:   4 months ago
config: s390-randconfig-s053-20220821 (https://download.01.org/0day-ci/archive/20220821/202208211251.eSw2xmFX-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edd4a8667355607345b76d5652adc0f300a28970
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout edd4a8667355607345b76d5652adc0f300a28970
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/s390/boot/decompressor.c: note: in included file (through arch/s390/include/uapi/../../../../lib/decompress_unxz.c):
>> arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *

vim +393 arch/s390/include/uapi/../../../../lib/xz/xz_dec_stream.c

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
4f8d7abaa413c3 Lasse Collin 2021-10-11  405  	if (s->temp.buf[HEADER_MAGIC_SIZE + 1] > XZ_CHECK_MAX)
4f8d7abaa413c3 Lasse Collin 2021-10-11  406  		return XZ_OPTIONS_ERROR;
4f8d7abaa413c3 Lasse Collin 2021-10-11  407  
24fa0402a9b6a5 Lasse Collin 2011-01-12  408  	s->check_type = s->temp.buf[HEADER_MAGIC_SIZE + 1];
24fa0402a9b6a5 Lasse Collin 2011-01-12  409  

:::::: The code at line 393 was first introduced by commit
:::::: 24fa0402a9b6a537e87e38341e78b7da86486846 decompressors: add XZ decompressor module

:::::: TO: Lasse Collin <lasse.collin@tukaani.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
