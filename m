Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747D24CB17E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245386AbiCBVkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiCBVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:40:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59170CA316
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646257188; x=1677793188;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=288nTnHU1heIoBqRJG2x5bM7aPN2dJSWejDk5g+kUiE=;
  b=LdnL7WEnSEF4otlgvmOTEKG5E4GcYZ5tCLZu9JG12JfFADH/qL7r8qSO
   /Bfsv10ko5w6Akzt0W4CHx5hkTP5mUDtSisRIfJ8ZUCW4aWXS4OtEgLbE
   BBz6cN4qtaqc61Rv7oRuHtiZaUJDWMzpvzd/TwShGgyMoktumSTXv13qO
   8c+nwVsFD+teNpHKPQrG8I3HBpF7k6ADMHRIc0rH8LyKzYRG0O3PLq3sp
   kP7cacTKeYFMt6Hhix5KEvI7UniyWJzABx7VPQY72PylObjJPwBGIX6Ut
   4QIQ51JxJBku+Xrs/kuKWX6Dra+H6R1MNmNbufV0pXWp6ctiupOa6oMOz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252340385"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="252340385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 13:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="641854042"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 13:39:45 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPWhF-0001wz-2c; Wed, 02 Mar 2022 21:39:45 +0000
Date:   Thu, 3 Mar 2022 05:38:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Kiryanov <rkir@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Lingfeng Yang <lfy@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.4-p-release
 8768/9922] drivers/platform/goldfish/goldfish_pipe_v2.c:814:21: warning:
 format '%llx' expects argument of type 'long long unsigned int', but
 argument 4 has type 'dma_addr_t {aka unsigned int}'
Message-ID: <202203030511.uZ7gsNlS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.4-p-release
head:   c159ade87311501e4e4b40eb2f35aa5607732957
commit: 3702e76fb6e907cc75887fe5780fe160946e7c68 [8768/9922] goldfish: pipe: ANDROID: Add DMA support
config: i386-randconfig-a012-20211118 (https://download.01.org/0day-ci/archive/20220303/202203030511.uZ7gsNlS-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/3702e76fb6e907cc75887fe5780fe160946e7c68
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.4-p-release
        git checkout 3702e76fb6e907cc75887fe5780fe160946e7c68
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/goldfish/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:277:0,
                    from drivers/platform/goldfish/goldfish_pipe_v2.c:49:
   drivers/platform/goldfish/goldfish_pipe_v2.c: In function 'goldfish_pipe_dma_release_host':
>> drivers/platform/goldfish/goldfish_pipe_v2.c:814:21: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
      dev_dbg(pdev_dev, "Last ref for dma region @ 0x%llx\n",
                        ^
       dma->phys_begin);
       ~~~~~~            
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:814:3: note: in expansion of macro 'dev_dbg'
      dev_dbg(pdev_dev, "Last ref for dma region @ 0x%llx\n",
      ^~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:824:3: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
      "after delete of dma @ 0x%llx: alloc total %zu\n",
      ^
      dma->phys_begin, pipe->dev->dma_alloc_total);
      ~~~~~~
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:823:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(pdev_dev,
     ^~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c: In function 'goldfish_pipe_dma_release_guest':
   drivers/platform/goldfish/goldfish_pipe_v2.c:847:4: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
       "after delete of dma @ 0x%llx: alloc total %zu\n",
       ^
       dma->phys_begin, pipe->dev->dma_alloc_total);
       ~~~~~~
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:846:3: note: in expansion of macro 'dev_dbg'
      dev_dbg(pdev_dev,
      ^~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c: In function 'goldfish_pipe_dma_alloc_locked':
   drivers/platform/goldfish/goldfish_pipe_v2.c:956:20: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
     dev_dbg(pdev_dev, "%s: got v/p addrs "
                       ^
   drivers/platform/goldfish/goldfish_pipe_v2.c:960:3:
      dma->phys_begin,
      ~~~~~~            
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:956:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(pdev_dev, "%s: got v/p addrs "
     ^~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:957:12: note: format string is defined here
      "%p 0x%llx sz %zu total alloc %zu\n",
            ~~~^
            %x
   In file included from include/linux/printk.h:277:0,
                    from drivers/platform/goldfish/goldfish_pipe_v2.c:49:
   drivers/platform/goldfish/goldfish_pipe_v2.c: In function 'goldfish_dma_mmap_locked':
   drivers/platform/goldfish/goldfish_pipe_v2.c:982:20: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
     dev_dbg(pdev_dev, "Mapping dma at 0x%llx\n", dma->phys_begin);
                       ^                          ~~~~~~
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:982:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(pdev_dev, "Mapping dma at 0x%llx\n", dma->phys_begin);
     ^~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:1003:20: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
     dev_dbg(pdev_dev, "goldfish_dma_mmap for host vaddr 0x%llx succeeded\n",
                       ^
      dma->phys_begin);
      ~~~~~~            
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:1003:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(pdev_dev, "goldfish_dma_mmap for host vaddr 0x%llx succeeded\n",
     ^~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c: At top level:
   drivers/platform/goldfish/goldfish_pipe_v2.c:1059:6: warning: no previous declaration for 'goldfish_dma_ioctl_getoff' [-Wmissing-declarations]
    long goldfish_dma_ioctl_getoff(struct goldfish_pipe *pipe, unsigned long arg)
         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c:1096:6: warning: no previous declaration for 'goldfish_dma_ioctl_create_region' [-Wmissing-declarations]
    long goldfish_dma_ioctl_create_region(struct goldfish_pipe *pipe,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/goldfish/goldfish_pipe_v2.c: In function 'transfer_max_buffers':
   drivers/platform/goldfish/goldfish_pipe_v2.c:407:1: warning: the frame size of 1384 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:206: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'


vim +814 drivers/platform/goldfish/goldfish_pipe_v2.c

   802	
   803	static void goldfish_pipe_dma_release_host(struct goldfish_pipe *pipe)
   804	{
   805		struct goldfish_dma_context *dma = pipe->dma;
   806		struct device *pdev_dev;
   807	
   808		if (!dma)
   809			return;
   810	
   811		pdev_dev = pipe->dev->pdev_dev;
   812	
   813		if (dma->dma_vaddr) {
 > 814			dev_dbg(pdev_dev, "Last ref for dma region @ 0x%llx\n",
   815				dma->phys_begin);
   816	
   817			pipe->command_buffer->dma_maphost_params.dma_paddr =
   818				dma->phys_begin;
   819			pipe->command_buffer->dma_maphost_params.sz = dma->dma_size;
   820			goldfish_pipe_cmd(pipe, PIPE_CMD_DMA_HOST_UNMAP);
   821		}
   822	
   823		dev_dbg(pdev_dev,
   824			"after delete of dma @ 0x%llx: alloc total %zu\n",
   825			dma->phys_begin, pipe->dev->dma_alloc_total);
   826	}
   827	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
