Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2557D5467FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349982AbiFJN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349663AbiFJN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:58:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC95232DBE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654869463; x=1686405463;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5gb1zQ0JyYGJutTfQxXJtGVRtZT/kcvLVqigXecq0UI=;
  b=IQL41YsdHVODcQ3ftIjS+4t3pUWvKLi5yY0Qg+QGSw1qwbbsfZqK7eO6
   L/lzMzlxYQxXTC6OhSocQ9FoCgHSf6Hd7mToR6WrMFlhyhAjo3ti/be86
   w9hRqaLm8g3MXH9N7X78zlwLEYAue8jfhaRpWX63ZrMk3CNycviWlg1Vc
   DKMGCdmOnt7ufJPFJU4qI4Z6CTbcXURUSaAoMkEYz9z5TB2Asi+eFmuZz
   dEXBwJUsU5i5Rlsl2TtARb5TWOfpvDiNAQlkIi7N2kb90HT9yBw5yf3BX
   sKqCswKCNzAP6vqoyB8OR9xKomUC91sBvxM8l5mjjT+Q4qNO4tP1GlZB5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="258072676"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="258072676"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 06:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616491031"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2022 06:57:41 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzf8u-000Hzd-Gr;
        Fri, 10 Jun 2022 13:57:40 +0000
Date:   Fri, 10 Jun 2022 21:57:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 33/54]
 drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:38:27: warning:
 cast from pointer to integer of different size
Message-ID: <202206102138.ihQBkC9n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   906be7ef2fb9e2f1fcb740d3d506768cddfc52ca
commit: 6f7b441aa698d7dd9a8878ff241c10080561bf8e [33/54] dmaengine: Add dw-axi-dmac-starfive driver for JH7100
config: riscv-randconfig-s032-20220610 (https://download.01.org/0day-ci/archive/20220610/202206102138.ihQBkC9n-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/esmil/linux/commit/6f7b441aa698d7dd9a8878ff241c10080561bf8e
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 6f7b441aa698d7dd9a8878ff241c10080561bf8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/dma/dw-axi-dmac-starfive/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c: In function 'dw_virt_to_phys':
>> drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:38:27: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      38 |         u64 pfn_offset = ((u64)vaddr) & 0xfff;
         |                           ^
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c: In function 'dw_dma_async_do_memcpy':
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:153:9: error: implicit declaration of function 'iort_dma_setup' [-Werror=implicit-function-declaration]
     153 |         iort_dma_setup(dma_dev, &dma_addr, &dma_size);
         |         ^~~~~~~~~~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:154:15: warning: assignment to 'const struct iommu_ops *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     154 |         iommu = iort_iommu_configure_id(dma_dev, NULL);
         |               ^
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/acpi_iort.h:10,
                    from drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:16:
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:165:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     165 |         DMA_DEBUG("src=%#llx, dst=%#llx\n", (u64)src, (u64)dst);
         |                                             ^
   include/linux/printk.h:447:33: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/soc/starfive/jh7100_dma.h:13:9: note: in expansion of macro 'printk'
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |         ^~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:165:9: note: in expansion of macro 'DMA_DEBUG'
     165 |         DMA_DEBUG("src=%#llx, dst=%#llx\n", (u64)src, (u64)dst);
         |         ^~~~~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:165:55: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     165 |         DMA_DEBUG("src=%#llx, dst=%#llx\n", (u64)src, (u64)dst);
         |                                                       ^
   include/linux/printk.h:447:33: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/soc/starfive/jh7100_dma.h:13:9: note: in expansion of macro 'printk'
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |         ^~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:165:9: note: in expansion of macro 'DMA_DEBUG'
     165 |         DMA_DEBUG("src=%#llx, dst=%#llx\n", (u64)src, (u64)dst);
         |         ^~~~~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c: In function 'dw_dma_memcpy_raw':
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:224:15: warning: assignment to 'const struct iommu_ops *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     224 |         iommu = iort_iommu_configure_id(dma_dev, NULL);
         |               ^
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/acpi_iort.h:10,
                    from drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:16:
>> include/soc/starfive/jh7100_dma.h:13:16: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/soc/starfive/jh7100_dma.h:13:9: note: in expansion of macro 'printk'
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |         ^~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:237:9: note: in expansion of macro 'DMA_DEBUG'
     237 |         DMA_DEBUG("src_dma=%#llx, dst_dma=%#llx \n", src_dma, dst_dma);
         |         ^~~~~~~~~
   include/soc/starfive/jh7100_dma.h:13:16: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:447:25: note: in definition of macro 'printk_index_wrap'
     447 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/soc/starfive/jh7100_dma.h:13:9: note: in expansion of macro 'printk'
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |         ^~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:237:9: note: in expansion of macro 'DMA_DEBUG'
     237 |         DMA_DEBUG("src_dma=%#llx, dst_dma=%#llx \n", src_dma, dst_dma);
         |         ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +38 drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c

    35	
    36	u64 dw_virt_to_phys(void *vaddr)
    37	{
  > 38		u64 pfn_offset = ((u64)vaddr) & 0xfff;
    39	
    40		return _dw_virt_to_phys((u64 *)vaddr) + pfn_offset;
    41	}
    42	EXPORT_SYMBOL(dw_virt_to_phys);
    43	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
