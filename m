Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70D509836
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385158AbiDUGsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355550AbiDUGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A21570E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523433; x=1682059433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qz2FyRcYx9P0Cl1oGC1k45NE3pHNwJbUokz+OkNz/As=;
  b=IUC6/PRe9IchLuXCxqAgl0KC9lUy8Z/Ok3YPJHP2Yi+qD8shnsCACy4T
   JlmzHpVTXanMBFiiC+xhqDz+JewkWnIeHgublEqMiM9w4178x2CnwEfEv
   xKCGtmRC3cw6xoFz4RZpCtJlFmZvZEjgVm+nV0Tl3N7HyFrqI4KH897+h
   x2pAyasreqcMM5nhHKBvpB2t07hCH/rEad2QYk8rGSxfNHtotR+eBOI4k
   R1bWTT65+aLaffAvmzHuVjCIF0wuhX+VFvAEzDUfG7ZJfNYxNZn3H5ATj
   zpybNk4ZGZXTskvrkWkoQjdTAXYIHIvtROt/ia5QZIeI6p1YO97Nd5mD6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324700500"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="324700500"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="702961480"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXe-00080Z-U3;
        Thu, 21 Apr 2022 06:43:50 +0000
Date:   Thu, 21 Apr 2022 14:43:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2394/2579]
 kernel/module_decompress.c:226:65: error: 'PAGE_KERNEL' undeclared
Message-ID: <202204210620.WCK3GeUD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 121f9c630c04142cd7a6ada2c297d5e5c85d73d3 [2394/2579] headers/deps: mm: Optimize <linux/highmem.h> dependencies, remove MM headers from the !CONFIG_HIGHMEM path
config: sparc64-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220421/202204210620.WCK3GeUD-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=121f9c630c04142cd7a6ada2c297d5e5c85d73d3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 121f9c630c04142cd7a6ada2c297d5e5c85d73d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/module_decompress.c: In function 'module_decompress':
>> kernel/module_decompress.c:226:65: error: 'PAGE_KERNEL' undeclared (first use in this function)
     226 |         info->hdr = vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL);
         |                                                                 ^~~~~~~~~~~
   kernel/module_decompress.c:226:65: note: each undeclared identifier is reported only once for each function it appears in


vim +/PAGE_KERNEL +226 kernel/module_decompress.c

b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  206  
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  207  int module_decompress(struct load_info *info, const void *buf, size_t size)
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  208  {
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  209  	unsigned int n_pages;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  210  	ssize_t data_size;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  211  	int error;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  212  
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  213  	/*
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  214  	 * Start with number of pages twice as big as needed for
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  215  	 * compressed data.
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  216  	 */
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  217  	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  218  	error = module_extend_max_pages(info, n_pages);
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  219  
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  220  	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  221  	if (data_size < 0) {
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  222  		error = data_size;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  223  		goto err;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  224  	}
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  225  
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05 @226  	info->hdr = vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL);
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  227  	if (!info->hdr) {
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  228  		error = -ENOMEM;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  229  		goto err;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  230  	}
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  231  
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  232  	info->len = data_size;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  233  	return 0;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  234  
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  235  err:
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  236  	module_decompress_cleanup(info);
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  237  	return error;
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  238  }
b1ae6dc41eaaa9 Dmitry Torokhov 2022-01-05  239  

:::::: The code at line 226 was first introduced by commit
:::::: b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7 module: add in-kernel support for decompressing

:::::: TO: Dmitry Torokhov <dmitry.torokhov@gmail.com>
:::::: CC: Luis Chamberlain <mcgrof@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
