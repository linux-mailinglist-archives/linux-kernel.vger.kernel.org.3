Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CDF545898
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiFIXV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiFIXV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:21:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D2E4435
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654816915; x=1686352915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZs4jRka2kIZp+xDSykoMtHa4470prxyVP0U9JcSCns=;
  b=F3Ljp7t/MO80aOfmjVoYa8RlwWVV45tciX01ThKZzAysvzJ8CfM9lLnu
   OrAmlJL4h2zLGnKdHJg+/9dwxqD/xZWauhfDRQiS/itqo3cVKYgIJp1SP
   mALc1i2jrpFexe5nHD58heCHFWhSNAMGdowhXmnQqq3bI7VwuWBGn+K1P
   brMNgzPckvQUG3Scff+yIqt1/DL3NqygYtGdRSKcy92cyygDmlPP238I8
   nm+iblFwZVlVLe45AvRR2FuDEDpHFPrekZ5PmNIXhhfgZeKRghv9RRAZG
   uCblFyz8KQLkaS+qFSDB1x01fAxMIN7Y/apKPpyA7I2U63KVa2Xwe+SGu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363779049"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363779049"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 16:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="566612434"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2022 16:21:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzRTL-000GUH-WE;
        Thu, 09 Jun 2022 23:21:52 +0000
Date:   Fri, 10 Jun 2022 07:21:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v7 20/21]
 include/linux/pci-p2pdma.h:99:1: error: non-void function does not return a
 value
Message-ID: <202206100713.eqeobRjO-lkp@intel.com>
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

tree:   https://github.com/sbates130272/linux-p2pmem.git p2pdma_user_cmb_v7
head:   45dd3bf6fe468175153066cb70820a2b2edbc61b
commit: 54606cc552a950ad3eaa201cd8b1a2d1f2e6abd3 [20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
config: s390-randconfig-r005-20220608 (https://download.01.org/0day-ci/archive/20220610/202206100713.eqeobRjO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/sbates130272/linux-p2pmem/commit/54606cc552a950ad3eaa201cd8b1a2d1f2e6abd3
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem p2pdma_user_cmb_v7
        git checkout 54606cc552a950ad3eaa201cd8b1a2d1f2e6abd3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/nvme/target/configfs.c:12:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/nvme/target/configfs.c:12:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/nvme/target/configfs.c:12:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   In file included from drivers/nvme/target/configfs.c:13:
>> include/linux/pci-p2pdma.h:99:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   12 warnings and 1 error generated.
--
   In file included from drivers/nvme/target/core.c:10:
   In file included from include/linux/pci-p2pdma.h:14:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/nvme/target/core.c:10:
   In file included from include/linux/pci-p2pdma.h:14:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/nvme/target/core.c:10:
   In file included from include/linux/pci-p2pdma.h:14:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   In file included from drivers/nvme/target/core.c:10:
>> include/linux/pci-p2pdma.h:99:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   In file included from drivers/nvme/target/core.c:14:
   In file included from drivers/nvme/target/trace.h:165:
   include/trace/define_trace.h:95:10: fatal error: './trace.h' file not found
   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:90:32: note: expanded from macro 'TRACE_INCLUDE'
   # define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:87:34: note: expanded from macro '__TRACE_INCLUDE'
   # define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stringify.h:10:27: note: expanded from macro '__stringify'
   #define __stringify(x...)       __stringify_1(x)
                                   ^~~~~~~~~~~~~~~~
   include/linux/stringify.h:9:29: note: expanded from macro '__stringify_1'
   #define __stringify_1(x...)     #x
                                   ^~
   <scratch space>:87:1: note: expanded from here
   "./trace.h"
   ^~~~~~~~~~~
   12 warnings and 2 errors generated.


vim +99 include/linux/pci-p2pdma.h

    18	
    19	#ifdef CONFIG_PCI_P2PDMA
    20	int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
    21			u64 offset);
    22	int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
    23				     int num_clients, bool verbose);
    24	bool pci_has_p2pmem(struct pci_dev *pdev);
    25	struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients);
    26	void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size);
    27	void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size);
    28	pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr);
    29	struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
    30						 unsigned int *nents, u32 length);
    31	void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
    32	void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
    33	int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
    34				    bool *use_p2pdma);
    35	ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
    36				       bool use_p2pdma);
    37	int pci_p2pdma_file_open(struct pci_dev *pdev, struct file *file);
    38	void pci_p2pdma_file_release(struct file *file);
    39	int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma);
    40	#else /* CONFIG_PCI_P2PDMA */
    41	static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
    42			size_t size, u64 offset)
    43	{
    44		return -EOPNOTSUPP;
    45	}
    46	static inline int pci_p2pdma_distance_many(struct pci_dev *provider,
    47		struct device **clients, int num_clients, bool verbose)
    48	{
    49		return -1;
    50	}
    51	static inline bool pci_has_p2pmem(struct pci_dev *pdev)
    52	{
    53		return false;
    54	}
    55	static inline struct pci_dev *pci_p2pmem_find_many(struct device **clients,
    56							   int num_clients)
    57	{
    58		return NULL;
    59	}
    60	static inline void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
    61	{
    62		return NULL;
    63	}
    64	static inline void pci_free_p2pmem(struct pci_dev *pdev, void *addr,
    65			size_t size)
    66	{
    67	}
    68	static inline pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev,
    69							    void *addr)
    70	{
    71		return 0;
    72	}
    73	static inline struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
    74			unsigned int *nents, u32 length)
    75	{
    76		return NULL;
    77	}
    78	static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
    79			struct scatterlist *sgl)
    80	{
    81	}
    82	static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
    83	{
    84	}
    85	static inline int pci_p2pdma_enable_store(const char *page,
    86			struct pci_dev **p2p_dev, bool *use_p2pdma)
    87	{
    88		*use_p2pdma = false;
    89		return 0;
    90	}
    91	static inline ssize_t pci_p2pdma_enable_show(char *page,
    92			struct pci_dev *p2p_dev, bool use_p2pdma)
    93	{
    94		return sprintf(page, "none\n");
    95	}
    96	static inline int pci_p2pdma_file_open(struct pci_dev *pdev,
    97					       struct file *file)
    98	{
  > 99	}
   100	static inline void pci_p2pdma_file_release(struct file *file)
   101	{
   102	}
   103	static inline int pci_mmap_p2pmem(struct pci_dev *pdev,
   104					  struct vm_area_struct *vma)
   105	{
   106		return -EOPNOTSUPP;
   107	}
   108	#endif /* CONFIG_PCI_P2PDMA */
   109	
   110	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
