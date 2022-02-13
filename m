Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C194B3B88
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiBMNNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:13:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBMNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:13:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447FB5AEF3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644757977; x=1676293977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yMEM7X/7nrrFn1z7/KbgGO708wO+6+qYnCm/lkiLXbE=;
  b=QM81wBQI4Sdt1YOuDtHQoDm0/nqcs3Pal+c3e3PrbCBl+gVWDn8HzkAm
   dixspS/RovDR23oKRUMvj696kbbDTDnjq7wBbGF6BlsSJYlzGCDypUMkk
   vaFgKq5hd3w4yXqRW9HQj3jscvO3Sy8xtjjW+AjghxQGjT1Z+GXqWOUL7
   MknM+0MkSVRw3+zXPhxp0pzcvRflgSiRCH3j5HvL3FVBtkAN0XJ8jlC0O
   cGg/to4L4qc9vFoI4uvHegovB0FyJfYHIDdrgxMHiuzjD97S8mSKdCBfh
   TnOwPylaLSvpgA0qOClGmgluKTNiLL3RtE76ozubs4+X9V65LDFODsQci
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="233498262"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="233498262"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 05:12:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="542738267"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 05:12:55 -0800
Date:   Sun, 13 Feb 2022 21:11:38 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Nick Terrell <terrelln@fb.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: lib/zstd/common/entropy_common.c:257:1: warning: the frame size
 of 1056 bytes is larger than 1024 bytes
Message-ID: <YgkDigfDPLJHV9Cw@rli9-dbox>
References: <202202131904.0y0h7bnY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202131904.0y0h7bnY-lkp@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 07:51:37PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
> date:   3 months ago
> config: powerpc-randconfig-r035-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131904.0y0h7bnY-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/mtd/devices/ lib/zstd/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/zstd/common/entropy_common.c: In function 'HUF_readStats':
> >> lib/zstd/common/entropy_common.c:257:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Sorry for the false positive, kindly ignore this report.

>      257 | }
>          | ^
> 
> 
> vim +257 lib/zstd/common/entropy_common.c
> 
>    242	
>    243	
>    244	/*! HUF_readStats() :
>    245	    Read compact Huffman tree, saved by HUF_writeCTable().
>    246	    `huffWeight` is destination buffer.
>    247	    `rankStats` is assumed to be a table of at least HUF_TABLELOG_MAX U32.
>    248	    @return : size read from `src` , or an error Code .
>    249	    Note : Needed by HUF_readCTable() and HUF_readDTableX?() .
>    250	*/
>    251	size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>    252	                     U32* nbSymbolsPtr, U32* tableLogPtr,
>    253	                     const void* src, size_t srcSize)
>    254	{
>    255	    U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
>    256	    return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
>  > 257	}
>    258	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
