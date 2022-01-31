Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE78B4A4AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379942AbiAaPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:51:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:48306 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245307AbiAaPvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643644299; x=1675180299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D8pZ80Z1PAc5bkN0uwqf7Ix/ofUTXdxKDZ3K+0kzqNU=;
  b=e1FcVoDAM+tra5MUj1ULh0PjN+ji6mm4zLdS0aKQvDMeFvv1PGy0bB4+
   9sfDmjZqGLKokWWW+UPk87/r33IHL8HW3QcVwtseIrC4ON6VJyjDlNvgw
   2j4YcYVIqMfmJy97kz7nwKooZx4A8J8J+w0v93IDfCHMWyOlkiBcohCL2
   XJRDNGAZV9omXg83lXFXIXuTKY5JhZI3JoQ4bCeU8Mr3sAzDJqIt0ACeq
   p0AgqGrHyYU8xcWO+dMQHHatjk24Gxzz1SzfVNa0A7uKw8R7DahtKLG/S
   ybdpPEZENP2dfG4qYH5sinPZnThnxlLjFi+9JJRdtjYZEI8UmnekvaLm8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308218275"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="308218275"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 07:51:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="768625230"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2022 07:51:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEYxs-000S6M-KX; Mon, 31 Jan 2022 15:51:36 +0000
Date:   Mon, 31 Jan 2022 23:50:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 40/62]
 drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:38:27: warning:
 cast from pointer to integer of different size
Message-ID: <202201312340.akcSj1ii-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   8c758048edfd830baceb991167131c9d55786544
commit: c6446aeaac5b13c1f8db7f55e88ad4cd912841f1 [40/62] dmaengine: Add dw-axi-dmac-starfive driver for JH7100
config: riscv-randconfig-r003-20220131 (https://download.01.org/0day-ci/archive/20220131/202201312340.akcSj1ii-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/c6446aeaac5b13c1f8db7f55e88ad4cd912841f1
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout c6446aeaac5b13c1f8db7f55e88ad4cd912841f1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/dma/dw-axi-dmac-starfive/ drivers/gpu/drm/ drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
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
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
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
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/soc/starfive/jh7100_dma.h:13:9: note: in expansion of macro 'printk'
      13 |         printk("[DW_DMA_DEBUG] %s():%d \n" fmt, __func__, __LINE__, ##__VA_ARGS__)
         |         ^~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:165:9: note: in expansion of macro 'DMA_DEBUG'
     165 |         DMA_DEBUG("src=%#llx, dst=%#llx\n", (u64)src, (u64)dst);
         |         ^~~~~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:187:9: error: implicit declaration of function 'sifive_l2_flush64_range' [-Werror=implicit-function-declaration]
     187 |         sifive_l2_flush64_range(src_dma, size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
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
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
