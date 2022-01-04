Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA0484087
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiADLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:11:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:54681 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbiADLLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641294708; x=1672830708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IADbxBFaMBK6BbZqBCKG8Xmwi38R/KDXR9SAt5XPJvg=;
  b=APyCxfT2aVOpaBdZ9zlGlJkWXxML9UGR1YLyMw9BtpbQTPHhVAwoipaW
   Pi/vOe6kG2gDsWdFeVfIzORjgAyz8QQbadsl/OHyFPPNypKUQaABjVBqI
   e/fKR7NuHaZryh2wAwsJY2HXGP3glgO2denUoMobimQ15/OTXZ8dP76Hj
   5UMKyjHPbZsIWmjMDzWq1R1ctjw3rLA5EjWEDImmHgHCgMVwLzIwVikYp
   caybDuYiwlYSIXgHhrshHaOebyir8yBPixhaUMKUv84+qtIKTwlZ25tKA
   9RbfUMLYF/56sWYg0HRZvKn+TC/d3c04hx9mBPWmWZHKgSudCkW/8uNjM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="305557760"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="305557760"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 03:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="620613706"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2022 03:11:46 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4hjF-000FFB-O3; Tue, 04 Jan 2022 11:11:45 +0000
Date:   Tue, 4 Jan 2022 19:11:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [narmstrong-oxnas:oxnas/v5.10/dma 1/2]
 drivers/dma/oxnas_adma.c:374:45: warning: format '%x' expects argument of
 type 'unsigned int', but argument 6 has type 'dma_addr_t' {aka 'long long
 unsigned int'}
Message-ID: <202201041921.RvnfQhD8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git oxnas/v5.10/dma
head:   3bd8beb561b1c68fd95c5b6ff855690dc64eb0f1
commit: 7e67852a5a05099cb1df2d7bfdb39f35c91f2bd0 [1/2] dmaengine: Add Oxford Semiconductor OXNAS DMA Controller
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220104/202201041921.RvnfQhD8-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git/commit/?id=7e67852a5a05099cb1df2d7bfdb39f35c91f2bd0
        git remote add narmstrong-oxnas https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
        git fetch --no-tags narmstrong-oxnas oxnas/v5.10/dma
        git checkout 7e67852a5a05099cb1df2d7bfdb39f35c91f2bd0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c: In function 'oxnas_dma_start_next':
>> drivers/dma/oxnas_adma.c:374:45: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     374 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:374:17: note: in expansion of macro 'dev_dbg'
     374 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:374:75: note: format string is defined here
     374 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                                                        ~~~^
         |                                                                           |
         |                                                                           unsigned int
         |                                                                        %08llx
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c:374:45: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     374 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:374:17: note: in expansion of macro 'dev_dbg'
     374 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:374:83: note: format string is defined here
     374 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                                                                ~~~^
         |                                                                                   |
         |                                                                                   unsigned int
         |                                                                                %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/oxnas_adma.c:15:
   drivers/dma/oxnas_adma.c: In function 'oxnas_dma_prep_slave_sg':
>> drivers/dma/oxnas_adma.c:460:53: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     460 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/dma/oxnas_adma.c:460:25: note: in expansion of macro 'dev_err'
     460 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                         ^~~~~~~
   drivers/dma/oxnas_adma.c:460:80: note: format string is defined here
     460 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                                             ~~~^
         |                                                                                |
         |                                                                                unsigned int
         |                                                                             %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/oxnas_adma.c:15:
   drivers/dma/oxnas_adma.c:472:53: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     472 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/dma/oxnas_adma.c:472:25: note: in expansion of macro 'dev_err'
     472 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                         ^~~~~~~
   drivers/dma/oxnas_adma.c:472:80: note: format string is defined here
     472 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                                             ~~~^
         |                                                                                |
         |                                                                                unsigned int
         |                                                                             %08llx
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c:509:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     509 |         dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:509:9: note: in expansion of macro 'dev_dbg'
     509 |         dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
         |         ^~~~~~~
   drivers/dma/oxnas_adma.c:509:55: note: format string is defined here
     509 |         dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
         |                                                    ~~~^
         |                                                       |
         |                                                       unsigned int
         |                                                    %08llx
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c:526:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     526 |         dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:526:9: note: in expansion of macro 'dev_dbg'
     526 |         dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
         |         ^~~~~~~
   drivers/dma/oxnas_adma.c:526:51: note: format string is defined here
     526 |         dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
         |                                                ~~~^
         |                                                   |
         |                                                   unsigned int
         |                                                %08llx
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c:526:37: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     526 |         dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
--
         |                                                   ~~~^
         |                                                      |
         |                                                      unsigned int
         |                                                   %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/oxnas_adma.c:15:
   drivers/dma/oxnas_adma.c: In function 'oxnas_dma_prep_dma_memcpy':
   drivers/dma/oxnas_adma.c:643:45: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     643 |                 dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/dma/oxnas_adma.c:643:17: note: in expansion of macro 'dev_err'
     643 |                 dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:643:72: note: format string is defined here
     643 |                 dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                                     ~~~^
         |                                                                        |
         |                                                                        unsigned int
         |                                                                     %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/oxnas_adma.c:15:
   drivers/dma/oxnas_adma.c:649:45: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     649 |                 dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/dma/oxnas_adma.c:649:17: note: in expansion of macro 'dev_err'
     649 |                 dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:649:72: note: format string is defined here
     649 |                 dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                                     ~~~^
         |                                                                        |
         |                                                                        unsigned int
         |                                                                     %08llx
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c:659:37: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     659 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:659:9: note: in expansion of macro 'dev_dbg'
     659 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |         ^~~~~~~
   drivers/dma/oxnas_adma.c:659:63: note: format string is defined here
     659 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |                                                            ~~~^
         |                                                               |
         |                                                               unsigned int
         |                                                            %08llx
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c:659:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     659 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:659:9: note: in expansion of macro 'dev_dbg'
     659 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |         ^~~~~~~
   drivers/dma/oxnas_adma.c:659:71: note: format string is defined here
     659 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |                                                                    ~~~^
         |                                                                       |
         |                                                                       unsigned int
         |                                                                    %08llx
   drivers/dma/oxnas_adma.c: At top level:
>> drivers/dma/oxnas_adma.c:742:17: warning: no previous prototype for 'oxnas_dma_tx_status' [-Wmissing-prototypes]
     742 | enum dma_status oxnas_dma_tx_status(struct dma_chan *chan,
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c: In function 'oxnas_dma_probe':
   drivers/dma/oxnas_adma.c:870:37: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     870 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:870:17: note: in expansion of macro 'dev_dbg'
     870 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:870:43: note: format string is defined here
     870 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                        ~~~^
         |                                           |
         |                                           unsigned int
         |                                        %08llx
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/dma/oxnas_adma.c:9:
   drivers/dma/oxnas_adma.c:870:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     870 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:29: note: in definition of macro '__dynamic_func_call'
     129 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:9: note: in expansion of macro '_dynamic_func_call'
     161 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:9: note: in expansion of macro 'dynamic_dev_dbg'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:30: note: in expansion of macro 'dev_fmt'
     123 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:870:17: note: in expansion of macro 'dev_dbg'
     870 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:870:50: note: format string is defined here
     870 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                               ~~~^
         |                                                  |
         |                                                  unsigned int
         |                                               %08llx


vim +374 drivers/dma/oxnas_adma.c

   318	
   319	static void oxnas_dma_start_next(oxnas_dma_channel_t *channel)
   320	{
   321		oxnas_dma_device_t *dmadev = channel->dmadev;
   322		struct virt_dma_desc *vd = vchan_next_desc(&channel->vc);
   323		oxnas_dma_desc_t *desc;
   324		unsigned long ctrl_status;
   325		
   326		if (!vd) {
   327			channel->cur = NULL;
   328			return;
   329		}
   330	
   331		list_del(&vd->node);
   332	
   333		channel->cur = desc = container_of(&vd->tx, oxnas_dma_desc_t, vd.tx);
   334	
   335		if (desc->type == OXNAS_DMA_TYPE_SIMPLE) {
   336			/* Write the control/status value to the DMAC */
   337			writel(desc->ctrl, dmadev->dma_base + 
   338				DMA_CALC_REG_ADR(channel->id, DMA_CTRL_STATUS));
   339	
   340			/* Ensure control/status word makes it to the DMAC before
   341			 * we write address/length info
   342			 */
   343			wmb();
   344	
   345			/* Write the source addresses to the DMAC */
   346			writel(desc->src_adr & OXNAS_DMA_ADR_MASK,  dmadev->dma_base + 
   347				DMA_CALC_REG_ADR(channel->id, DMA_BASE_SRC_ADR));
   348	
   349			/* Write the destination addresses to the DMAC */
   350			writel(desc->dst_adr & OXNAS_DMA_ADR_MASK,  dmadev->dma_base + 
   351				DMA_CALC_REG_ADR(channel->id, DMA_BASE_DST_ADR));
   352	
   353			/* Write the length, with EOT configuration
   354			 * for the single transfer
   355			 */
   356			writel(desc->len, dmadev->dma_base + 
   357					DMA_CALC_REG_ADR(channel->id, DMA_BYTE_CNT));
   358	
   359			/* Ensure adr/len info makes it to DMAC before later modifications to
   360			 * control/status register due to starting the transfer, which happens in
   361			 * oxnas_dma_start()
   362			 */
   363			wmb();
   364	
   365			/* Setup channel data */
   366			atomic_set(&channel->active, 1);
   367	
   368			/* Single transfer mode, so unpause the DMA controller channel */
   369			ctrl_status = readl(dmadev->dma_base + 
   370				DMA_CALC_REG_ADR(channel->id, DMA_CTRL_STATUS));
   371			writel(ctrl_status & ~DMA_CTRL_STATUS_PAUSE, dmadev->dma_base + 
   372				DMA_CALC_REG_ADR(channel->id, DMA_CTRL_STATUS));
   373	
 > 374			dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
   375				 channel->id, vd->tx.cookie,
   376				 desc->src_adr, desc->dst_adr,
   377				 desc->len & OXNAS_DMA_MAX_TRANSFER_LENGTH);
   378		} else if (desc->type == OXNAS_DMA_TYPE_SG) {
   379			/* Write to the SG-DMA channel's reset register to reset the control
   380			 * in case the previous SG-DMA transfer failed in some way, thus
   381			 * leaving the SG-DMA controller hung up part way through processing
   382			 * its SG list. The reset bits are self-clearing */
   383			writel(BIT(DMA_SG_RESETS_CONTROL_BIT), dmadev->sgdma_base + 
   384				DMA_SG_CALC_REG_ADR(channel->id, DMA_SG_RESETS));
   385			
   386			/* Copy the sg_info structure */
   387			memcpy(channel->sg_info, &desc->sg_info, sizeof(oxnas_dma_sg_info_t));
   388			wmb();
   389	
   390			/* Write the pointer to the SG info struct into the Request Pointer reg */
   391	        	writel(channel->p_sg_info,  dmadev->sgdma_base + 
   392				DMA_SG_CALC_REG_ADR(channel->id, DMA_SG_REQ_PTR));
   393	
   394			/* Setup channel data */
   395			atomic_set(&channel->active, 1);
   396	
   397			/* Start the transfert */
   398			writel(BIT(DMA_SG_CONTROL_START_BIT) |
   399			       BIT(DMA_SG_CONTROL_QUEUING_ENABLE_BIT) |
   400			       BIT(DMA_SG_CONTROL_HBURST_ENABLE_BIT),
   401			       dmadev->sgdma_base +
   402			       	DMA_SG_CALC_REG_ADR(channel->id, DMA_SG_CONTROL));
   403	
   404			dev_dbg(&dmadev->pdev->dev, "ch%d: started %d sg req with %d entries\n",
   405				 channel->id, vd->tx.cookie,
   406				 desc->entries);
   407		}
   408	}
   409	
   410	static void oxnas_dma_sched(unsigned long data)
   411	{
   412		oxnas_dma_device_t *dmadev = (oxnas_dma_device_t*)data;
   413		LIST_HEAD(head);
   414	
   415		spin_lock_irq(&dmadev->lock);
   416		list_splice_tail_init(&dmadev->pending, &head);
   417		spin_unlock_irq(&dmadev->lock);
   418	
   419		while (!list_empty(&head)) {
   420			oxnas_dma_channel_t *ch = list_first_entry(&head,
   421				oxnas_dma_channel_t, node);
   422	
   423			spin_lock_irq(&ch->vc.lock);
   424			list_del_init(&ch->node);
   425			oxnas_dma_start_next(ch);
   426			spin_unlock_irq(&ch->vc.lock);
   427		}
   428	}
   429	
   430	static int oxnas_check_address(oxnas_dma_device_t *dmadev, dma_addr_t address)
   431	{
   432		int i;
   433		
   434		for (i = 0 ; i <  dmadev->authorized_types_count ; ++i) {
   435			if (address >= dmadev->authorized_types[i].start &&
   436			    address < dmadev->authorized_types[i].end)
   437				return dmadev->authorized_types[i].type;
   438		}
   439	
   440		return -1;
   441	}
   442	
   443	static struct dma_async_tx_descriptor *oxnas_dma_prep_slave_sg(
   444		struct dma_chan *chan, struct scatterlist *sgl, unsigned sglen,
   445		enum dma_transfer_direction dir, unsigned long flags, void *context)
   446	{
   447		oxnas_dma_channel_t *channel = container_of(chan, oxnas_dma_channel_t, vc.chan);
   448		oxnas_dma_device_t *dmadev = channel->dmadev;
   449		oxnas_dma_desc_t *desc;
   450		struct scatterlist *sgent;
   451		oxnas_dma_sg_entry_t *entry_mem = NULL, *prev_entry_mem = NULL;
   452		oxnas_dma_sg_entry_t *entry_dev = NULL;
   453		unsigned i;
   454		int src_memory = OXNAS_DMA_DREQ_MEMORY;
   455		int dst_memory = OXNAS_DMA_DREQ_MEMORY;
   456	
   457		if (dir == DMA_DEV_TO_MEM) {
   458			src_memory = oxnas_check_address(dmadev, channel->cfg.src_addr);
   459			if (src_memory == -1) {
 > 460				dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
   461						channel->cfg.src_addr);
   462				return NULL;
   463			}
   464			if (src_memory == OXNAS_DMA_DREQ_MEMORY) {
   465				dev_err(&dmadev->pdev->dev, "In DEV_TO_MEM, src cannot be memory\n");
   466				return NULL;
   467			}
   468		}
   469		else if (dir == DMA_MEM_TO_DEV) {
   470			dst_memory = oxnas_check_address(dmadev, channel->cfg.dst_addr);
   471			if (dst_memory == -1) {
   472				dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
   473						channel->cfg.dst_addr);
   474				return NULL;
   475			}
   476			if (dst_memory == OXNAS_DMA_DREQ_MEMORY) {
   477				dev_err(&dmadev->pdev->dev, "In MEM_TO_DEV, dst cannot be memory\n");
   478				return NULL;
   479			}
   480		}
   481		else {
   482			dev_err(&dmadev->pdev->dev, "invalid direction\n");
   483			return NULL;
   484		}
   485	
   486		if (atomic_read(&dmadev->free_entries_count) < (sglen + 1)) {
   487			dev_err(&dmadev->pdev->dev, "Missing sg entries...\n");
   488			return NULL;
   489		}
   490	
   491		desc = kzalloc(sizeof(oxnas_dma_desc_t), GFP_KERNEL);
   492		if (unlikely(!desc))
   493			return NULL;
   494		desc->channel = channel;
   495	
   496		INIT_LIST_HEAD(&desc->sg_entries);
   497		desc->entries = 0;
   498	
   499		/* Device single entry */
   500		entry_dev = list_first_entry_or_null(&dmadev->free_entries,
   501						     oxnas_dma_sg_entry_t, entry);
   502		if (!entry_dev) {
   503			dev_err(&dmadev->pdev->dev, "Fatal error: Missing dev sg entry...\n");
   504			goto entries_cleanup;
   505		}
   506		atomic_dec(&dmadev->free_entries_count);
   507		list_move(&entry_dev->entry, &desc->sg_entries);
   508		++desc->entries;
   509		dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
   510	
   511		entry_dev->next_entry = NULL;
   512		entry_dev->p_next_entry = 0;
   513		entry_dev->data_length = 0; /* Completed by mem sg entries */
   514	
   515		if (dir == DMA_DEV_TO_MEM) {
   516			entry_dev->data_addr = channel->cfg.src_addr & OXNAS_DMA_ADR_MASK;
   517			desc->sg_info.srcEntries = entry_dev;
   518			desc->sg_info.p_srcEntries = entry_dev->this_paddr;
   519			dev_dbg(&dmadev->pdev->dev, "src set %p\n", entry_dev);
   520		} else if (dir == DMA_MEM_TO_DEV) {
   521			entry_dev->data_addr = channel->cfg.dst_addr & OXNAS_DMA_ADR_MASK;
   522			desc->sg_info.dstEntries = entry_dev;
   523			desc->sg_info.p_dstEntries = entry_dev->this_paddr;
   524			dev_dbg(&dmadev->pdev->dev, "dst set %p\n", entry_dev);
   525		}
   526		dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
   527				desc->sg_info.srcEntries, desc->sg_info.p_srcEntries,
   528				desc->sg_info.dstEntries, desc->sg_info.p_dstEntries);
   529	
   530		/* Memory entries */
   531		for_each_sg(sgl, sgent, sglen, i) {
   532			entry_mem = list_first_entry_or_null(&dmadev->free_entries,
   533							     oxnas_dma_sg_entry_t, entry);
   534			if (!entry_mem) {
   535				dev_err(&dmadev->pdev->dev, "Fatal error: Missing mem sg entries...\n");
   536				goto entries_cleanup;
   537			}
   538			atomic_dec(&dmadev->free_entries_count);
   539			list_move(&entry_mem->entry, &desc->sg_entries);
   540			++desc->entries;
   541			dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_mem, entry_mem->this_paddr);
   542	
   543			/* Fill the linked list */
   544			if (prev_entry_mem) {
   545				prev_entry_mem->next_entry = entry_mem;
   546				prev_entry_mem->p_next_entry = entry_mem->this_paddr;
   547			}
   548			else {
   549				if (dir == DMA_DEV_TO_MEM) {
   550					desc->sg_info.dstEntries = entry_mem;
   551					desc->sg_info.p_dstEntries = entry_mem->this_paddr;
   552					dev_dbg(&dmadev->pdev->dev, "src set %p\n", entry_mem);
   553				} else if (dir == DMA_MEM_TO_DEV) {
   554					desc->sg_info.srcEntries = entry_mem;
   555					desc->sg_info.p_srcEntries = entry_mem->this_paddr;
   556					dev_dbg(&dmadev->pdev->dev, "dst set %p\n", entry_mem);
   557				}
   558				dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
   559				desc->sg_info.srcEntries, desc->sg_info.p_srcEntries,
   560				desc->sg_info.dstEntries, desc->sg_info.p_dstEntries);
   561			}
   562			prev_entry_mem = entry_mem;
   563	
   564			/* Fill the entry from the SG */
   565			entry_mem->next_entry = NULL;
   566			entry_mem->p_next_entry = 0;
   567	
   568			entry_mem->data_addr = sg_dma_address(sgent) & OXNAS_DMA_ADR_MASK;
   569			entry_mem->data_length = sg_dma_len(sgent);
   570			dev_dbg(&dmadev->pdev->dev, "sg = %08x len = %d\n",
   571						sg_dma_address(sgent),
   572						sg_dma_len(sgent));
   573	
   574			/* Add to dev sg length */
   575			entry_dev->data_length += sg_dma_len(sgent);
   576		}
   577		dev_dbg(&dmadev->pdev->dev, "allocated %d sg entries\n", desc->entries);
   578	
   579		desc->sg_info.qualifier = (channel->id << OXNAS_DMA_SG_CHANNEL_BIT) |
   580					  BIT(OXNAS_DMA_SG_QUALIFIER_BIT);
   581		if (dir == DMA_DEV_TO_MEM)
   582			desc->sg_info.qualifier |= (2 << OXNAS_DMA_SG_SRC_EOT_BIT);
   583		else if (dir == DMA_MEM_TO_DEV)
   584			desc->sg_info.qualifier |= (2 << OXNAS_DMA_SG_DST_EOT_BIT);
   585	
   586		desc->sg_info.control = (DMA_CTRL_STATUS_INTERRUPT_ENABLE |
   587					 DMA_CTRL_STATUS_FAIR_SHARE_ARB |
   588					 DMA_CTRL_STATUS_INTR_CLEAR_ENABLE);
   589		desc->sg_info.control |= (src_memory << DMA_CTRL_STATUS_SRC_DREQ_SHIFT);
   590		desc->sg_info.control |= (dst_memory << DMA_CTRL_STATUS_DEST_DREQ_SHIFT);
   591	
   592		if (dir == DMA_DEV_TO_MEM) {
   593			desc->sg_info.control |= DMA_CTRL_STATUS_SRC_ADR_MODE;
   594			desc->sg_info.control &= ~DMA_CTRL_STATUS_SOURCE_ADDRESS_FIXED;
   595			desc->sg_info.control |= DMA_CTRL_STATUS_DEST_ADR_MODE;
   596			desc->sg_info.control &= ~DMA_CTRL_STATUS_DESTINATION_ADDRESS_FIXED;
   597		} else if (dir == DMA_MEM_TO_DEV) {
   598			desc->sg_info.control |= DMA_CTRL_STATUS_SRC_ADR_MODE;
   599			desc->sg_info.control &= DMA_CTRL_STATUS_SOURCE_ADDRESS_FIXED;
   600			desc->sg_info.control |= DMA_CTRL_STATUS_DEST_ADR_MODE;
   601			desc->sg_info.control &= ~DMA_CTRL_STATUS_DESTINATION_ADDRESS_FIXED;
   602		}
   603		desc->sg_info.control |= DMA_CTRL_STATUS_TRANSFER_MODE_A;
   604		desc->sg_info.control |= DMA_CTRL_STATUS_TRANSFER_MODE_B;
   605		desc->sg_info.control |= (OXNAS_DMA_A_TO_B << DMA_CTRL_STATUS_DIR_SHIFT);
   606	
   607		desc->sg_info.control |= (OXNAS_DMA_TRANSFER_WIDTH_32BITS << DMA_CTRL_STATUS_SRC_WIDTH_SHIFT);
   608		desc->sg_info.control |= (OXNAS_DMA_TRANSFER_WIDTH_32BITS << DMA_CTRL_STATUS_DEST_WIDTH_SHIFT);
   609		desc->sg_info.control &= ~DMA_CTRL_STATUS_STARVE_LOW_PRIORITY;
   610	
   611		desc->type = OXNAS_DMA_TYPE_SG;
   612	
   613		return vchan_tx_prep(&channel->vc, &desc->vd, flags);
   614	
   615	entries_cleanup:
   616		/* Put back all entries in the free entries... */
   617		list_splice_tail_init(&desc->sg_entries, &dmadev->free_entries);
   618		atomic_add(desc->entries, &dmadev->free_entries_count);
   619		dev_dbg(&dmadev->pdev->dev, "freed %d sg entries\n", desc->entries);
   620	
   621		kfree(desc);
   622	
   623		return NULL;
   624	}
   625	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
