Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B262C56B817
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiGHLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiGHLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:10:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE3184EF3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657278647; x=1688814647;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m2sZatXTVpC1uCEucCzQmn4wMvF5W2yGMJ2GCj0uPv0=;
  b=TMcFhcWo9yPdlaGhGnN+FOAYMlLsSNxfMQbtHIMvsbKhd5eB5JATgan6
   CCfMg1mfMbos8qPknWAoJofENJrocJfUNzlrvvbqgdHA4DBzJwyWZ0+WM
   Hti/lbWWs3tG5T9OwE7sUX0m/sPyVn/yNJGcZOcFiyOt+dtBLgxXxQE3T
   295vhOtI6aSrM/vFQeu7vaJAjg27KqWB4d1h37FXNCE7ofMKo+7u/pMyD
   J7X7hr20gpk+Ccyxb4/h+1TiUko7Y89iZ22bv2jI0Hy0IGtTozRLGzem3
   CbZk+Yc3VH3bDB44Oz78p76dhE/vaTMdkd+ncvH+ywf5QrWY3K1s8c6N5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264037298"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="264037298"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 04:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="568906330"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 04:10:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9lsi-000NNi-CY;
        Fri, 08 Jul 2022 11:10:44 +0000
Date:   Fri, 8 Jul 2022 19:09:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.10.y 644/6933] drivers/scsi/BusLogic.c:2006:47:
 error: 'DMA_MODE_CASCADE' undeclared; did you mean 'DMA_MODE_READ'?
Message-ID: <202207081920.7UbEitt3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
head:   7208d1236f72085a3290c41463ee3ee246d8afa5
commit: 87ae522e467e17a13b796e2cb595f9c3943e4d5e [644/6933] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
config: m68k-randconfig-r003-20220703 (https://download.01.org/0day-ci/archive/20220708/202207081920.7UbEitt3-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=87ae522e467e17a13b796e2cb595f9c3943e4d5e
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.10.y
        git checkout 87ae522e467e17a13b796e2cb595f9c3943e4d5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/scsi/BusLogic.c:25:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:143:9: note: in expansion of macro 'BUG_ON'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:143:17: note: in expansion of macro 'virt_addr_valid'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   In file included from drivers/scsi/BusLogic.c:51:
   drivers/scsi/FlashPoint.c: In function 'FlashPoint_AbortCCB':
   drivers/scsi/FlashPoint.c:1618:23: warning: variable 'TID' set but not used [-Wunused-but-set-variable]
    1618 |         unsigned char TID;
         |                       ^~~
   drivers/scsi/BusLogic.c: In function 'blogic_rdconfig':
   drivers/scsi/BusLogic.c:1735:46: warning: ordered comparison of pointer with null pointer [-Wextra]
    1735 |                         (void *) high_memory > (void *) MAX_DMA_ADDRESS)
         |                                              ^
   drivers/scsi/BusLogic.c:1748:46: warning: ordered comparison of pointer with null pointer [-Wextra]
    1748 |                         (void *) high_memory > (void *) MAX_DMA_ADDRESS)
         |                                              ^
   drivers/scsi/BusLogic.c: In function 'blogic_getres':
>> drivers/scsi/BusLogic.c:2006:47: error: 'DMA_MODE_CASCADE' undeclared (first use in this function); did you mean 'DMA_MODE_READ'?
    2006 |                 set_dma_mode(adapter->dma_ch, DMA_MODE_CASCADE);
         |                                               ^~~~~~~~~~~~~~~~
         |                                               DMA_MODE_READ
   drivers/scsi/BusLogic.c:2006:47: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/BusLogic.c: In function 'blogic_msg':
   drivers/scsi/BusLogic.c:3591:9: warning: function 'blogic_msg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3591 |         len = vsprintf(buf, fmt, args);
         |         ^~~


vim +2006 drivers/scsi/BusLogic.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  1980  
839cb99e8f7483 Khalid Aziz    2013-05-16  1981  static bool __init blogic_getres(struct blogic_adapter *adapter)
^1da177e4c3f41 Linus Torvalds 2005-04-16  1982  {
839cb99e8f7483 Khalid Aziz    2013-05-16  1983  	if (adapter->irq_ch == 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  1984  		blogic_err("NO LEGAL INTERRUPT CHANNEL ASSIGNED - DETACHING\n",
839cb99e8f7483 Khalid Aziz    2013-05-16  1985  				adapter);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1986  		return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1987  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  1988  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  1989  	   Acquire shared access to the IRQ Channel.
^1da177e4c3f41 Linus Torvalds 2005-04-16  1990  	 */
839cb99e8f7483 Khalid Aziz    2013-05-16  1991  	if (request_irq(adapter->irq_ch, blogic_inthandler, IRQF_SHARED,
839cb99e8f7483 Khalid Aziz    2013-05-16  1992  				adapter->full_model, adapter) < 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  1993  		blogic_err("UNABLE TO ACQUIRE IRQ CHANNEL %d - DETACHING\n",
839cb99e8f7483 Khalid Aziz    2013-05-16  1994  				adapter, adapter->irq_ch);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1995  		return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1996  	}
839cb99e8f7483 Khalid Aziz    2013-05-16  1997  	adapter->irq_acquired = true;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1998  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  1999  	   Acquire exclusive access to the DMA Channel.
^1da177e4c3f41 Linus Torvalds 2005-04-16  2000  	 */
839cb99e8f7483 Khalid Aziz    2013-05-16  2001  	if (adapter->dma_ch > 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  2002  		if (request_dma(adapter->dma_ch, adapter->full_model) < 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  2003  			blogic_err("UNABLE TO ACQUIRE DMA CHANNEL %d - DETACHING\n", adapter, adapter->dma_ch);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2004  			return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2005  		}
839cb99e8f7483 Khalid Aziz    2013-05-16 @2006  		set_dma_mode(adapter->dma_ch, DMA_MODE_CASCADE);
839cb99e8f7483 Khalid Aziz    2013-05-16  2007  		enable_dma(adapter->dma_ch);
839cb99e8f7483 Khalid Aziz    2013-05-16  2008  		adapter->dma_chan_acquired = true;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2009  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  2010  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  2011  	   Indicate the System Resource Acquisition completed successfully,
^1da177e4c3f41 Linus Torvalds 2005-04-16  2012  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  2013  	return true;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2014  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  2015  

:::::: The code at line 2006 was first introduced by commit
:::::: 839cb99e8f748391059d10388c8aea48a88c142c [SCSI] BusLogic: Fix style issues

:::::: TO: Khalid Aziz <khalid.aziz@oracle.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
