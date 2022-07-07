Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D48569E48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiGGJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGGJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:08:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA0EC13
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657184916; x=1688720916;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XLKDwx63TgUoGLkIDj6RGrJv34h+ODJs1hILYPzgMhs=;
  b=UJP5bZxnU4xxGql/txE7Fn6UQMOyoUx8I1bQwS8634soz3hZdEcw6OcN
   6uImqJfNgzfKpz90UXBReD+yc4RKB0/v58qh+9MNZgz7wuiOVpnhxkqY/
   dZtejfc1+kn94rwMX48QMiclhN8Vk+gl3gFR30QTYcsAuNYNA8Eux12JE
   rIzTuvgbJLkC6y2lXOI7rnhDGSZF/oSGaHhmZTuzxpJryt4T5zRdp5FHG
   YFHObT6Oqw21Ntjmy8xoTKuqvMAqckiiNLfIyzV95tLK3E/B1sMiai2Iw
   a+TAhdHbyzGzYvdiym/IYe/2tS5S92cPp6wQ35YJMP7yOrJhJnNBex0ve
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281522661"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="281522661"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 02:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="683243838"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2022 02:08:35 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9NUw-000Lnw-J6;
        Thu, 07 Jul 2022 09:08:34 +0000
Date:   Thu, 7 Jul 2022 17:08:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 34/50]
 drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:38:27: warning:
 cast from pointer to integer of different size
Message-ID: <202207071751.cBaGYxUU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   943858df470556d0b7f3b31fcc10931603f0f3cc
commit: 4c89873ac3af6a251049da47ab78862c05de9fad [34/50] dmaengine: Add dw-axi-dmac-starfive driver for JH7100
config: riscv-buildonly-randconfig-r003-20220707 (https://download.01.org/0day-ci/archive/20220707/202207071751.cBaGYxUU-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/4c89873ac3af6a251049da47ab78862c05de9fad
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 4c89873ac3af6a251049da47ab78862c05de9fad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/dma/dw-axi-dmac-starfive/

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
   include/linux/printk.h:436:33: note: in definition of macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
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
   include/linux/printk.h:436:33: note: in definition of macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/soc/starfive/jh7100_dma.h:13:9: note: in expansion of macro 'printk'
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |         ^~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:165:9: note: in expansion of macro 'DMA_DEBUG'
     165 |         DMA_DEBUG("src=%#llx, dst=%#llx\n", (u64)src, (u64)dst);
         |         ^~~~~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:187:9: error: implicit declaration of function 'sifive_l2_flush64_range'; did you mean 'sifive_l2_flush_range'? [-Werror=implicit-function-declaration]
     187 |         sifive_l2_flush64_range(src_dma, size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         sifive_l2_flush_range
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
   include/linux/printk.h:436:25: note: in definition of macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
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
   include/linux/printk.h:436:25: note: in definition of macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
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
