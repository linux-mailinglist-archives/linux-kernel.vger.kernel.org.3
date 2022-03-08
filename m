Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2474D230D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350325AbiCHVIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiCHVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:08:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B201140E4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646773660; x=1678309660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GnMW+vZ9HVxe/HmNFuE/y1U+U+G1TdLCAHPjIqy2Z2o=;
  b=nVhozu+Ei0wDoEJ6av+cN5E4nrKeWihf/kdKlcXUcud716XPj5CFj1Mo
   E4q22WqZVVsEKvgq57zSYgkvxBEsFX2G5/haMK9GpxSNIz8mil/NxeHzk
   ZyYMuFmft3JFahsWbo7kU/mxHKrPkNLPPvwaI7UE0fQNVisYeQ/LMWX78
   BpBqlJH0bN/MYNAivJdFdTDyKGhonLkeUGeNdiLOhRSkwQBtCChLjqVHQ
   DeIN8E0eKTgVWZurYaiso/ZCmoZoAaiH6v+m9aiBSencPGae+B4//QkH/
   BS6cc4PeKyBFqZPskuj4ArkSe4uWqyNRJ50BkN7AvIbIDYaHLFZM4D820
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318043896"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="318043896"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:07:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495602818"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 13:07:38 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRh3R-0001xQ-Ko; Tue, 08 Mar 2022 21:07:37 +0000
Date:   Wed, 9 Mar 2022 05:07:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:76:15:
 warning: no previous prototype for function '__wrap_devm_ioremap'
Message-ID: <202203090551.R89uT00F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ea4424be16887a37735d6550cfd0611528dbe5d9
commit: 4bdc0d676a643140bdf17dbf7eafedee3d496a3c remove ioremap_nocache and devm_ioremap_nocache
date:   2 years, 2 months ago
config: x86_64-buildonly-randconfig-r003-20220214 (https://download.01.org/0day-ci/archive/20220309/202203090551.R89uT00F-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bdc0d676a643140bdf17dbf7eafedee3d496a3c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4bdc0d676a643140bdf17dbf7eafedee3d496a3c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:65:15: warning: no previous prototype for function '__nfit_test_ioremap' [-Wmissing-prototypes]
   void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
                 ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:65:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
   ^
   static 
>> drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:76:15: warning: no previous prototype for function '__wrap_devm_ioremap' [-Wmissing-prototypes]
   void __iomem *__wrap_devm_ioremap(struct device *dev,
                 ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:76:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __iomem *__wrap_devm_ioremap(struct device *dev,
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:88:7: warning: no previous prototype for function '__wrap_devm_memremap' [-Wmissing-prototypes]
   void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
         ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:88:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:126:7: warning: no previous prototype for function '__wrap_devm_memremap_pages' [-Wmissing-prototypes]
   void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
         ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:126:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:159:7: warning: no previous prototype for function '__wrap_phys_to_pfn_t' [-Wmissing-prototypes]
   pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
         ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:159:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:169:7: warning: no previous prototype for function '__wrap_memremap' [-Wmissing-prototypes]
   void *__wrap_memremap(resource_size_t offset, size_t size,
         ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:169:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *__wrap_memremap(resource_size_t offset, size_t size,
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:180:6: warning: no previous prototype for function '__wrap_devm_memunmap' [-Wmissing-prototypes]
   void __wrap_devm_memunmap(struct device *dev, void *addr)
        ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:180:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __wrap_devm_memunmap(struct device *dev, void *addr)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:190:15: warning: no previous prototype for function '__wrap_ioremap' [-Wmissing-prototypes]
   void __iomem *__wrap_ioremap(resource_size_t offset, unsigned long size)
                 ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:190:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __iomem *__wrap_ioremap(resource_size_t offset, unsigned long size)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:196:15: warning: no previous prototype for function '__wrap_ioremap_wc' [-Wmissing-prototypes]
   void __iomem *__wrap_ioremap_wc(resource_size_t offset, unsigned long size)
                 ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:196:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __iomem *__wrap_ioremap_wc(resource_size_t offset, unsigned long size)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:211:6: warning: no previous prototype for function '__wrap_memunmap' [-Wmissing-prototypes]
   void __wrap_memunmap(void *addr)
        ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:211:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __wrap_memunmap(void *addr)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:347:18: warning: no previous prototype for function '__wrap___request_region' [-Wmissing-prototypes]
   struct resource *__wrap___request_region(struct resource *parent,
                    ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:347:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct resource *__wrap___request_region(struct resource *parent,
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:355:5: warning: no previous prototype for function '__wrap_insert_resource' [-Wmissing-prototypes]
   int __wrap_insert_resource(struct resource *parent, struct resource *res)
       ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:355:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __wrap_insert_resource(struct resource *parent, struct resource *res)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:363:5: warning: no previous prototype for function '__wrap_remove_resource' [-Wmissing-prototypes]
   int __wrap_remove_resource(struct resource *res)
       ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:363:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __wrap_remove_resource(struct resource *res)
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:371:18: warning: no previous prototype for function '__wrap___devm_request_region' [-Wmissing-prototypes]
   struct resource *__wrap___devm_request_region(struct device *dev,
                    ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:371:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct resource *__wrap___devm_request_region(struct device *dev,
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:381:6: warning: no previous prototype for function '__wrap___release_region' [-Wmissing-prototypes]
   void __wrap___release_region(struct resource *parent, resource_size_t start,
        ^
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:381:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __wrap___release_region(struct resource *parent, resource_size_t start,
   ^
   static 
   drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:389:6: warning: no previous prototype for function '__wrap___devm_release_region' [-Wmissing-prototypes]
   void __wrap___devm_release_region(struct device *dev, struct resource *parent,
        ^


vim +/__wrap_devm_ioremap +76 drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c

    64	
  > 65	void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
    66			void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
    67	{
    68		struct nfit_test_resource *nfit_res = get_nfit_res(offset);
    69	
    70		if (nfit_res)
    71			return (void __iomem *) nfit_res->buf + offset
    72				- nfit_res->res.start;
    73		return fallback_fn(offset, size);
    74	}
    75	
  > 76	void __iomem *__wrap_devm_ioremap(struct device *dev,
    77			resource_size_t offset, unsigned long size)
    78	{
    79		struct nfit_test_resource *nfit_res = get_nfit_res(offset);
    80	
    81		if (nfit_res)
    82			return (void __iomem *) nfit_res->buf + offset
    83				- nfit_res->res.start;
    84		return devm_ioremap(dev, offset, size);
    85	}
    86	EXPORT_SYMBOL(__wrap_devm_ioremap);
    87	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
