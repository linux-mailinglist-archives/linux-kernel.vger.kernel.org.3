Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5913591C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbiHMRpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHMRpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:45:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6712A82
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660412728; x=1691948728;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q0tC28WPRGUcU+qYm66yryIpRrYvgf8rGBkp633lJK0=;
  b=Oxq8otu0ZjnILzx+/mC3lB+r6EaMTVy+UXrzETlf+cVEqgGi9nLjIx2Q
   r3Jru/lHRHUWAU1bxDoQDw2/T1HxcW+vOdg9IEHlRs0+whSibLxo+Htv7
   9PDiaUSR0ORqY5AoZwtjJ314DHpN0U47c+XQP18C7irm5qmlQLgkuXEUl
   FBlcxvDzi7XSkMex2vUsYbiNfT2w2xg9LIlKcxaNTeZGchH5d0b2jltzD
   orOxv9hDfeCwN4D2dsQKjXY0/WP7U/nW1EXGDHrCImTNVlEoWNpou+Ken
   0Co9UFwbJUpDMOUnlgyx5kcfEezygC03aDG8g136/ngWIGbvV5+Fk/+Jf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278723001"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="278723001"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="606232617"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2022 10:45:26 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMvCP-0001vl-2b;
        Sat, 13 Aug 2022 17:45:25 +0000
Date:   Sun, 14 Aug 2022 01:44:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.4.y 384/4798] drivers/scsi/BusLogic.c:2005:47:
 error: 'DMA_MODE_CASCADE' undeclared; did you mean 'DMA_MODE_READ'?
Message-ID: <202208140106.w24QUdFP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
head:   de0cd3ea700d1e8ed76705d02e33b524cbb84cf3
commit: 53a72858bcae7eaa7df8d167dbf60682d70f82a6 [384/4798] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
config: m68k-randconfig-r015-20220812 (https://download.01.org/0day-ci/archive/20220814/202208140106.w24QUdFP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=53a72858bcae7eaa7df8d167dbf60682d70f82a6
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.4.y
        git checkout 53a72858bcae7eaa7df8d167dbf60682d70f82a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
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
                    from include/linux/module.h:10:
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
   drivers/scsi/BusLogic.c:1734:46: warning: ordered comparison of pointer with null pointer [-Wextra]
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
