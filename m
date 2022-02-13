Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE414B3B2E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiBMLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 06:52:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiBMLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 06:51:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB95F5B895
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 03:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644753113; x=1676289113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lpL0C+CK39D7RRq144RaugCt+85mNqxlvr2xQqxf8nE=;
  b=H4BPQFPTNZkynyPf1/JinuVAWTIU68R63nb+lDoQN2MfU4SDChgmSWyZ
   e8OR8pPE+h7G+hzosI6zXnFGtsOsfXWbKakdrxPV2D1dzE0dpfIsi+n1A
   2wIscNY1NhJdqlWaRIf+JHG42q9KJRdT0P7ikm86lYmeRuCbpb0eHIign
   uM3eHD0PGRn71QQVckGi6t2OHf+W6Eg7amsa10QPrCf1EJA/e9y8IR3FS
   CCG/dFUMDvxDbsxDNX/oaSi+yGOWMORR6Eh531hzW3R9vz0ORJVfFTAFV
   Ibo6xgTdzACe3SQ1n1sTsTw7ZMj0ScAJPJduQbYIrLqEkepDyMDA/GdPs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="237351406"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="237351406"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 03:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="501241894"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 03:51:52 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJDPz-0007Rm-Oa; Sun, 13 Feb 2022 11:51:51 +0000
Date:   Sun, 13 Feb 2022 19:51:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: lib/zstd/common/entropy_common.c:257:1: warning: the frame size of
 1056 bytes is larger than 1024 bytes
Message-ID: <202202131904.0y0h7bnY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
date:   3 months ago
config: powerpc-randconfig-r035-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131904.0y0h7bnY-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/mtd/devices/ lib/zstd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/zstd/common/entropy_common.c: In function 'HUF_readStats':
>> lib/zstd/common/entropy_common.c:257:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     257 | }
         | ^


vim +257 lib/zstd/common/entropy_common.c

   242	
   243	
   244	/*! HUF_readStats() :
   245	    Read compact Huffman tree, saved by HUF_writeCTable().
   246	    `huffWeight` is destination buffer.
   247	    `rankStats` is assumed to be a table of at least HUF_TABLELOG_MAX U32.
   248	    @return : size read from `src` , or an error Code .
   249	    Note : Needed by HUF_readCTable() and HUF_readDTableX?() .
   250	*/
   251	size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
   252	                     U32* nbSymbolsPtr, U32* tableLogPtr,
   253	                     const void* src, size_t srcSize)
   254	{
   255	    U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
   256	    return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
 > 257	}
   258	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
