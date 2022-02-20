Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87324BD271
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbiBTXHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:07:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243876AbiBTXHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:07:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE16597
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645398419; x=1676934419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sJKCTKh/XM5Qhakn2XfXHfaktQJPFXRiN0o1QP/dvAY=;
  b=ZvBbYQs4S5TOH8m6h8UeDM5j3UsUEReYcVuowOGUxkViBtKgZFN9TJ0O
   1B5K8zWV4vBlA6oDYjAyNBAhqd53PT8Q8wBDdzJwoEHhahd7exWTz638x
   Mp74cg9VdqIERCHc9YrCabZunH7P5YHMo1yAT3JB/mVpXT8qQOZRIwdqR
   EwKib/CnJ/DOiiVy6FzREXCwTeDM6sugu52KSBO19kYFCo/YPYF7+Q/DU
   3bk+k4ad01NaNOsz/bim7zgP2EcNVGH9Ryi2hB+Vdmt8nMV0RI2m2+YVa
   lGidJdaPOWSSM+hIcYg2zsFqMhDq+03By9rCX36uAdKPDmwOyuB0naJP5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="275998401"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="275998401"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="504689059"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 15:06:56 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLvI8-0000zE-7X; Sun, 20 Feb 2022 23:06:56 +0000
Date:   Mon, 21 Feb 2022 07:06:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.4 7869/9999]
 drivers/scsi/BusLogic.c:2005:47: error: 'DMA_MODE_CASCADE' undeclared; did
 you mean 'DMA_MODE_READ'?
Message-ID: <202202210725.9aO2whR7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
head:   12571a43bda6770e6338998a94ba915b3028255d
commit: 53a72858bcae7eaa7df8d167dbf60682d70f82a6 [7869/9999] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
config: m68k-buildonly-randconfig-r005-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210725.9aO2whR7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=53a72858bcae7eaa7df8d167dbf60682d70f82a6
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.4
        git checkout 53a72858bcae7eaa7df8d167dbf60682d70f82a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers/scsi/BusLogic.c:25:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/asm-generic/bug.h:139:34: note: in definition of macro 'WARN_ON_ONCE'
     139 |         int __ret_warn_once = !!(condition);                    \
         |                                  ^~~~~~~~~
   arch/m68k/include/asm/page_mm.h:170:33: note: in expansion of macro 'virt_addr_valid'
     170 | #define pfn_valid(pfn)          virt_addr_valid(pfn_to_virt(pfn))
         |                                 ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:355:26: note: in expansion of macro 'pfn_valid'
     355 |         if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                          ^~~~~~~~~
   drivers/scsi/BusLogic.c: In function 'blogic_rdconfig':
>> drivers/scsi/BusLogic.c:1734:46: warning: ordered comparison of pointer with null pointer [-Wextra]
    1734 |                         (void *) high_memory > (void *) MAX_DMA_ADDRESS)
         |                                              ^
   drivers/scsi/BusLogic.c:1747:46: warning: ordered comparison of pointer with null pointer [-Wextra]
    1747 |                         (void *) high_memory > (void *) MAX_DMA_ADDRESS)
         |                                              ^
   drivers/scsi/BusLogic.c: In function 'blogic_getres':
>> drivers/scsi/BusLogic.c:2005:47: error: 'DMA_MODE_CASCADE' undeclared (first use in this function); did you mean 'DMA_MODE_READ'?
    2005 |                 set_dma_mode(adapter->dma_ch, DMA_MODE_CASCADE);
         |                                               ^~~~~~~~~~~~~~~~
         |                                               DMA_MODE_READ
   drivers/scsi/BusLogic.c:2005:47: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/BusLogic.c: In function 'blogic_msg':
   drivers/scsi/BusLogic.c:3589:9: warning: function 'blogic_msg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3589 |         len = vsprintf(buf, fmt, args);
         |         ^~~


vim +2005 drivers/scsi/BusLogic.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  1979  
839cb99e8f7483 Khalid Aziz    2013-05-16  1980  static bool __init blogic_getres(struct blogic_adapter *adapter)
^1da177e4c3f41 Linus Torvalds 2005-04-16  1981  {
839cb99e8f7483 Khalid Aziz    2013-05-16  1982  	if (adapter->irq_ch == 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  1983  		blogic_err("NO LEGAL INTERRUPT CHANNEL ASSIGNED - DETACHING\n",
839cb99e8f7483 Khalid Aziz    2013-05-16  1984  				adapter);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1985  		return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1986  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  1987  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  1988  	   Acquire shared access to the IRQ Channel.
^1da177e4c3f41 Linus Torvalds 2005-04-16  1989  	 */
839cb99e8f7483 Khalid Aziz    2013-05-16  1990  	if (request_irq(adapter->irq_ch, blogic_inthandler, IRQF_SHARED,
839cb99e8f7483 Khalid Aziz    2013-05-16  1991  				adapter->full_model, adapter) < 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  1992  		blogic_err("UNABLE TO ACQUIRE IRQ CHANNEL %d - DETACHING\n",
839cb99e8f7483 Khalid Aziz    2013-05-16  1993  				adapter, adapter->irq_ch);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1994  		return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1995  	}
839cb99e8f7483 Khalid Aziz    2013-05-16  1996  	adapter->irq_acquired = true;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1997  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  1998  	   Acquire exclusive access to the DMA Channel.
^1da177e4c3f41 Linus Torvalds 2005-04-16  1999  	 */
839cb99e8f7483 Khalid Aziz    2013-05-16  2000  	if (adapter->dma_ch > 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  2001  		if (request_dma(adapter->dma_ch, adapter->full_model) < 0) {
839cb99e8f7483 Khalid Aziz    2013-05-16  2002  			blogic_err("UNABLE TO ACQUIRE DMA CHANNEL %d - DETACHING\n", adapter, adapter->dma_ch);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2003  			return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2004  		}
839cb99e8f7483 Khalid Aziz    2013-05-16 @2005  		set_dma_mode(adapter->dma_ch, DMA_MODE_CASCADE);
839cb99e8f7483 Khalid Aziz    2013-05-16  2006  		enable_dma(adapter->dma_ch);
839cb99e8f7483 Khalid Aziz    2013-05-16  2007  		adapter->dma_chan_acquired = true;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2008  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  2009  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  2010  	   Indicate the System Resource Acquisition completed successfully,
^1da177e4c3f41 Linus Torvalds 2005-04-16  2011  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  2012  	return true;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2013  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  2014  

:::::: The code at line 2005 was first introduced by commit
:::::: 839cb99e8f748391059d10388c8aea48a88c142c [SCSI] BusLogic: Fix style issues

:::::: TO: Khalid Aziz <khalid.aziz@oracle.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
