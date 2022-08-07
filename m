Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB99858BAE8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 14:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiHGM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiHGM4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 08:56:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFCB633A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659876994; x=1691412994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hYax+sxEohYijJXRfwl2jHwWkJNzilv1fN42/HJShVQ=;
  b=cloyIfkhqw959aLACjtQY1FKg1ySHGtnrTPMmTUlCENqq0qceCGm9q6M
   hZ1gMP3YmXLiG2N3B7yTjljufbkDgUBdJZDw2W0S77IDpt1sszRoVW3B3
   uemuAT6HZv4vCMJ03CjFCxBSq0rCFMhlHZ2y/caXfR+n3qt0GV5F4HCSx
   ZAVFmWQURzd6/+AYaWgTvavLHBXl2BTiK4J/MEZLg27ZgTgSrtvYo1RbF
   uWVap4qc8EqT84CPmWF5YfVdWbOMLachF9mmmdFH2/1HirvOz/INsZttU
   RTVypQzeja2AJRWmTiFQlkU9BZEoNHHK4I1FHSi5iL45FWNnbP8vscvkT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="316338729"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="316338729"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 05:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="931732131"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 05:56:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKfpY-000LIy-11;
        Sun, 07 Aug 2022 12:56:32 +0000
Date:   Sun, 7 Aug 2022 20:56:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/edac/thunderx_edac.c:438:25: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202208072036.aILldUBV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1612c382ffbdf1f673caec76502b1c00e6d35363
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 months ago
config: arm64-randconfig-s052-20220804 (https://download.01.org/0day-ci/archive/20220807/202208072036.aILldUBV-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/edac/thunderx_edac.c:428:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/edac/thunderx_edac.c:428:14: sparse:     expected void [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:428:14: sparse:     got void *
>> drivers/edac/thunderx_edac.c:438:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/edac/thunderx_edac.c:438:25: sparse:     expected void const *
   drivers/edac/thunderx_edac.c:438:25: sparse:     got void [noderef] __iomem *
>> drivers/edac/thunderx_edac.c:438:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/edac/thunderx_edac.c:438:25: sparse:     expected void const *
   drivers/edac/thunderx_edac.c:438:25: sparse:     got void [noderef] __iomem *
   drivers/edac/thunderx_edac.c:438:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/edac/thunderx_edac.c:438:25: sparse:     expected void const *
   drivers/edac/thunderx_edac.c:438:25: sparse:     got void [noderef] __iomem *
   drivers/edac/thunderx_edac.c:760:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *l2c_ioaddr @@     got void [noderef] __iomem * @@
   drivers/edac/thunderx_edac.c:760:20: sparse:     expected void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:760:20: sparse:     got void [noderef] __iomem *
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:767:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:767:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:767:28: sparse:     got void *l2c_ioaddr
   drivers/edac/thunderx_edac.c:769:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *l2c_ioaddr @@
   drivers/edac/thunderx_edac.c:769:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/edac/thunderx_edac.c:769:17: sparse:     got void *l2c_ioaddr

vim +438 drivers/edac/thunderx_edac.c

41003396f932d7f Sergey Temerkhanov 2017-03-24  405  
41003396f932d7f Sergey Temerkhanov 2017-03-24  406  static ssize_t thunderx_lmc_inject_ecc_write(struct file *file,
41003396f932d7f Sergey Temerkhanov 2017-03-24  407  					     const char __user *data,
41003396f932d7f Sergey Temerkhanov 2017-03-24  408  					     size_t count, loff_t *ppos)
41003396f932d7f Sergey Temerkhanov 2017-03-24  409  {
41003396f932d7f Sergey Temerkhanov 2017-03-24  410  	struct thunderx_lmc *lmc = file->private_data;
41003396f932d7f Sergey Temerkhanov 2017-03-24  411  	unsigned int cline_size = cache_line_size();
6663484b4e2d98f Kees Cook          2018-06-29  412  	u8 *tmp;
41003396f932d7f Sergey Temerkhanov 2017-03-24  413  	void __iomem *addr;
41003396f932d7f Sergey Temerkhanov 2017-03-24  414  	unsigned int offs, timeout = 100000;
41003396f932d7f Sergey Temerkhanov 2017-03-24  415  
41003396f932d7f Sergey Temerkhanov 2017-03-24  416  	atomic_set(&lmc->ecc_int, 0);
41003396f932d7f Sergey Temerkhanov 2017-03-24  417  
41003396f932d7f Sergey Temerkhanov 2017-03-24  418  	lmc->mem = alloc_pages_node(lmc->node, GFP_KERNEL, 0);
41003396f932d7f Sergey Temerkhanov 2017-03-24  419  	if (!lmc->mem)
41003396f932d7f Sergey Temerkhanov 2017-03-24  420  		return -ENOMEM;
41003396f932d7f Sergey Temerkhanov 2017-03-24  421  
6663484b4e2d98f Kees Cook          2018-06-29  422  	tmp = kmalloc(cline_size, GFP_KERNEL);
6663484b4e2d98f Kees Cook          2018-06-29  423  	if (!tmp) {
6663484b4e2d98f Kees Cook          2018-06-29  424  		__free_pages(lmc->mem, 0);
6663484b4e2d98f Kees Cook          2018-06-29  425  		return -ENOMEM;
6663484b4e2d98f Kees Cook          2018-06-29  426  	}
6663484b4e2d98f Kees Cook          2018-06-29  427  
41003396f932d7f Sergey Temerkhanov 2017-03-24  428  	addr = page_address(lmc->mem);
41003396f932d7f Sergey Temerkhanov 2017-03-24  429  
41003396f932d7f Sergey Temerkhanov 2017-03-24  430  	while (!atomic_read(&lmc->ecc_int) && timeout--) {
41003396f932d7f Sergey Temerkhanov 2017-03-24  431  		stop_machine(inject_ecc_fn, lmc, NULL);
41003396f932d7f Sergey Temerkhanov 2017-03-24  432  
6663484b4e2d98f Kees Cook          2018-06-29  433  		for (offs = 0; offs < PAGE_SIZE; offs += cline_size) {
41003396f932d7f Sergey Temerkhanov 2017-03-24  434  			/*
41003396f932d7f Sergey Temerkhanov 2017-03-24  435  			 * Do a load from the previously rigged location
41003396f932d7f Sergey Temerkhanov 2017-03-24  436  			 * This should generate an error interrupt.
41003396f932d7f Sergey Temerkhanov 2017-03-24  437  			 */
41003396f932d7f Sergey Temerkhanov 2017-03-24 @438  			memcpy(tmp, addr + offs, cline_size);
41003396f932d7f Sergey Temerkhanov 2017-03-24  439  			asm volatile("dsb ld\n");
41003396f932d7f Sergey Temerkhanov 2017-03-24  440  		}
41003396f932d7f Sergey Temerkhanov 2017-03-24  441  	}
41003396f932d7f Sergey Temerkhanov 2017-03-24  442  
6663484b4e2d98f Kees Cook          2018-06-29  443  	kfree(tmp);
41003396f932d7f Sergey Temerkhanov 2017-03-24  444  	__free_pages(lmc->mem, 0);
41003396f932d7f Sergey Temerkhanov 2017-03-24  445  
41003396f932d7f Sergey Temerkhanov 2017-03-24  446  	return count;
41003396f932d7f Sergey Temerkhanov 2017-03-24  447  }
41003396f932d7f Sergey Temerkhanov 2017-03-24  448  

:::::: The code at line 438 was first introduced by commit
:::::: 41003396f932d7f027725c7acebb6a7caa41dc3e EDAC, thunderx: Add Cavium ThunderX EDAC driver

:::::: TO: Sergey Temerkhanov <s.temerkhanov@gmail.com>
:::::: CC: Borislav Petkov <bp@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
