Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5CB516908
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379349AbiEBAZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378333AbiEBAZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:25:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213DF1B7BD
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651450905; x=1682986905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LE/ULwGYubCRXsXIWQbmp8BQ0OI+oGKUCsSU38uy48g=;
  b=ihI0PvrMiRz4bLTnj9dbJmLCGsd5mpim9tL0OS6qEK1a0jCNSAxnwhoZ
   l1ok/E/r58mQvts0bO9hI4A5xsI7Qz0bJHvapuFppZNhgYbmsDId81mwv
   t10t571PyizFbVqQU6HNMRjceVsbtWRNFYDDjRjqDcIDOcuB8vB1OBJ6c
   EDMw4OZw/SZPZ2133k43T39EeB850VT8rnLUfj6ERsnllvvJCfGvTwbEI
   hkXVPhBbYjM+V/63na8Bt/MtXQWzm8ZBXjvinTS1wLr7UeuCFns42icC6
   2q513c7+4FaWmoXoKyfsAeXoatZrja09e64R9M403I7O+rWsupFhvoFbD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="327619121"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="327619121"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 17:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="598384429"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 May 2022 17:21:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlJos-00099b-6G;
        Mon, 02 May 2022 00:21:42 +0000
Date:   Mon, 2 May 2022 08:21:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:asahi-soc/rtkit-sart-nvme 4/6]
 drivers/soc/apple/sart.c:284:4: warning: format specifies type 'unsigned
 long long' but the argument has type 'phys_addr_t' (aka 'unsigned int')
Message-ID: <202205020811.kEEGO8QC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi-soc/rtkit-sart-nvme
head:   b483360a58a6f47f31a470feffc9fd41e8d66b36
commit: 09724d641508aead22e8e4a9761b2255ee6a38fc [4/6] soc: apple: Add SART driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205020811.kEEGO8QC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/09724d641508aead22e8e4a9761b2255ee6a38fc
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi-soc/rtkit-sart-nvme
        git checkout 09724d641508aead22e8e4a9761b2255ee6a38fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/apple/sart.c:284:4: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                    paddr, size);
                    ^~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +284 drivers/soc/apple/sart.c

   253	
   254	int apple_sart_remove_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
   255					     size_t size)
   256	{
   257		int i;
   258	
   259		dev_dbg(sart->dev,
   260			"will remove [paddr: %pa, size: 0x%zx] from allowed regions\n",
   261			&paddr, size);
   262	
   263		for (i = 0; i < APPLE_SART_MAX_ENTRIES; ++i) {
   264			u8 eflags;
   265			size_t esize;
   266			phys_addr_t epaddr;
   267	
   268			if (test_bit(i, &sart->protected_entries))
   269				continue;
   270	
   271			sart->ops->get_entry(sart, i, &eflags, &epaddr, &esize);
   272	
   273			if (epaddr != paddr || esize != size)
   274				continue;
   275	
   276			sart->ops->set_entry(sart, i, 0, 0, 0);
   277	
   278			clear_bit(i, &sart->used_entries);
   279			dev_dbg(sart->dev, "cleared entry %d\n", i);
   280			return 0;
   281		}
   282	
   283		dev_warn(sart->dev, "entry [paddr: 0x%llx, size: 0x%zx] not found\n",
 > 284			 paddr, size);
   285	
   286		return -EINVAL;
   287	}
   288	EXPORT_SYMBOL_GPL(apple_sart_remove_allowed_region);
   289	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
