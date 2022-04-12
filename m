Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2054FEB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiDLXTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiDLXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:19:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099555BD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649804902; x=1681340902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gD0Av9T9NnnpIKoXx8jW0XjtjLsvOAGvaoP5Wf1H8sc=;
  b=bDFJCwRZElWI19/5SSNrD+NTeXjUla0TRT7bD5NwSietmfKXdMOzwJTu
   QEbpkShnEB9v6QEuBlgExmT9/RQQ30ZTCGqLFwe236yiaB/utb7tN1jbn
   kyhoqsFmZ9FsLx1Q1EYNLJrsQ6gxB23sEVbczRNPdvc326C9lK6aXcher
   mV9uf26SwEVANmWhL5Oo1sC4GPBO2gl7PUtb4YB8rzxaGYOeXzh9WDlUf
   EvopfTO4NzXVQ9+JB1dTwUFYqNvVERmf2EAk2pi6SN8bRvw/PWA9s1nKE
   yxQisDCJtbggBKNCdttzspO8e9/+C2kuuYe0nYjl27IP2Vwgs54idlVtb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261374652"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="261374652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 16:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="526252861"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2022 16:08:20 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nePcR-0003Ev-AW;
        Tue, 12 Apr 2022 23:08:19 +0000
Date:   Wed, 13 Apr 2022 07:07:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.4 7091/9999]
 drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit
 declaration of function 'claim_dma_lock'
Message-ID: <202204130751.lUeRF1y2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
head:   9185989d84b918f49f720061cedc29c8ed039797
commit: 53a72858bcae7eaa7df8d167dbf60682d70f82a6 [7091/9999] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
config: m68k-randconfig-r011-20220412 (https://download.01.org/0day-ci/archive/20220413/202204130751.lUeRF1y2-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/staging/comedi/drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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
                    from drivers/staging/comedi/drivers/comedi_isadma.c:7:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/asm-generic/bug.h:182:32: note: in definition of macro 'WARN_ON'
     182 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/dma-mapping.h:355:13: note: in expansion of macro 'WARN_ON_ONCE'
     355 |         if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |             ^~~~~~~~~~~~
   arch/m68k/include/asm/page_mm.h:170:33: note: in expansion of macro 'virt_addr_valid'
     170 | #define pfn_valid(pfn)          virt_addr_valid(pfn_to_virt(pfn))
         |                                 ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:355:26: note: in expansion of macro 'pfn_valid'
     355 |         if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                          ^~~~~~~~~
   drivers/staging/comedi/drivers/comedi_isadma.c: In function 'comedi_isadma_program':
>> drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
      25 |         flags = claim_dma_lock();
         |                 ^~~~~~~~~~~~~~
>> drivers/staging/comedi/drivers/comedi_isadma.c:31:9: error: implicit declaration of function 'release_dma_lock' [-Werror=implicit-function-declaration]
      31 |         release_dma_lock(flags);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/claim_dma_lock +25 drivers/staging/comedi/drivers/comedi_isadma.c

20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  16  
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  17  /**
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  18   * comedi_isadma_program - program and enable an ISA DMA transfer
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  19   * @desc:	the ISA DMA cookie to program and enable
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  20   */
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  21  void comedi_isadma_program(struct comedi_isadma_desc *desc)
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  22  {
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  23  	unsigned long flags;
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  24  
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14 @25  	flags = claim_dma_lock();
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  26  	clear_dma_ff(desc->chan);
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  27  	set_dma_mode(desc->chan, desc->mode);
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  28  	set_dma_addr(desc->chan, desc->hw_addr);
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  29  	set_dma_count(desc->chan, desc->size);
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  30  	enable_dma(desc->chan);
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14 @31  	release_dma_lock(flags);
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  32  }
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  33  EXPORT_SYMBOL_GPL(comedi_isadma_program);
20a1ea7d6ba184a H Hartley Sweeten 2015-01-14  34  

:::::: The code at line 25 was first introduced by commit
:::::: 20a1ea7d6ba184a1f6e25e85786738003387cada staging: comedi: comedi_isadma: introduce helper module for ISA DMA

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
