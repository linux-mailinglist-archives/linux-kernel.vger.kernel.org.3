Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED7753F44F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiFGDJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiFGDJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:09:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D89B0D27
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654571381; x=1686107381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X4AfcTkzwc0o+NZUaBBl2V0kNeAWhAXW2/7eSo++gqk=;
  b=E88qV/toUSoPHU4Naql5i0hAJIJ350gSIXyabsc4zoB1DSpGOOcbgg3o
   QwZLZdpX8j8Gbv+Mdh0iqGfPBoEpmEWMPkLgpF9cyV/i0oc08gDjh18cC
   jZPjwp74j6rY3vYIGbPpVUohmKbL5YHwyQu+bBodYiTrQrpkcGaCyKakI
   9Hny0OySRzUeJrbudplZoIh8VS8Cx792EkR7zv6qTXPPOkPt8bmlTHixR
   d1LnX0QbxhNPddj8BTWcqOOs+75plBK3X7seCN8hGnZcBbTjPv0l1ofkl
   ItaNWbuFK1QoaW1StMgvBmj6e/byjgka8tYFijyoorY8OPf1AF0bEvU0T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="302065937"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="302065937"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 20:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="554710382"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jun 2022 20:09:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyPb8-000DHj-E5;
        Tue, 07 Jun 2022 03:09:38 +0000
Date:   Tue, 7 Jun 2022 11:09:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:76:15:
 warning: no previous prototype for function '__wrap_devm_ioremap'
Message-ID: <202206071125.J48v1YBq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e71e60cd74df9386c3f684c54888f2367050b831
commit: 4bdc0d676a643140bdf17dbf7eafedee3d496a3c remove ioremap_nocache and devm_ioremap_nocache
date:   2 years, 5 months ago
config: x86_64-buildonly-randconfig-r003-20220606 (https://download.01.org/0day-ci/archive/20220607/202206071125.J48v1YBq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bdc0d676a643140bdf17dbf7eafedee3d496a3c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4bdc0d676a643140bdf17dbf7eafedee3d496a3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
