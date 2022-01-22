Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A904496DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiAVUQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:16:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:2429 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbiAVUQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642882566; x=1674418566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I05j7AIiy5VYCwKC09ZWpINZcZRo6HaH+XfW4ySU/b8=;
  b=T8gDYv6XsygFkyEItxOKv5aQ7xHDDhi4oyuTouQRzKEVO3krCI5dN5MX
   Ba2ZdY2eHYPD6zQ5GjZCysmwqDgBNijRxURLcQQIjFQ/P+oBp+BMj2cV6
   YRVPOL9si1mwToojN3+SM1mqJG3zSZJMtMCYSEqmD7cjI8PPiTMCSmrHI
   XnwB+Ro9k+ACRZqNlhifju90xTwli2J4WjaoAYdDS2LzQBB4xX7ArDN0a
   QIael1OY441rp/ml0NJyShDb6mJhfx+YF8SUrZbfWkMhJNo2p/pctBPzC
   DqFufkHycL+SanQbrQPTqVgIUlnQGWGy7fy48vRNWrY6DymvKVwYB+ML0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10235"; a="306563077"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="306563077"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 12:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="616845117"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2022 12:16:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBMnq-000GjK-Br; Sat, 22 Jan 2022 20:16:02 +0000
Date:   Sun, 23 Jan 2022 04:15:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 45/53] drivers/cxl/core/port.c:853:26: error: use of
 undeclared identifier 'CXL_REGLOC_RBI_COMPONENT'
Message-ID: <202201230041.j2B2ds4Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   e675fabdbbcdb6e32dba688a20fb0bd42e0e2d5d
commit: bdcd1df24905ea3d8196ef7e62b077b136d18ab1 [45/53] cxl/core/port: Add switch port enumeration
config: mips-randconfig-c004-20220120 (https://download.01.org/0day-ci/archive/20220123/202201230041.j2B2ds4Z-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=bdcd1df24905ea3d8196ef7e62b077b136d18ab1
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout bdcd1df24905ea3d8196ef7e62b077b136d18ab1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cxl/core/port.c:853:26: error: use of undeclared identifier 'CXL_REGLOC_RBI_COMPONENT'
           cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
                                   ^
>> drivers/cxl/core/port.c:854:9: error: implicit declaration of function 'cxl_regmap_to_base' [-Werror,-Wimplicit-function-declaration]
           return cxl_regmap_to_base(pdev, &map);
                  ^
   drivers/cxl/core/port.c:998:18: warning: no previous prototype for function 'cxl_mem_find_port' [-Wmissing-prototypes]
   struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
                    ^
   drivers/cxl/core/port.c:998:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
   ^
   static 
   1 warning and 2 errors generated.


vim +/CXL_REGLOC_RBI_COMPONENT +853 drivers/cxl/core/port.c

   838	
   839	static resource_size_t find_component_registers(struct device *dev)
   840	{
   841		struct cxl_register_map map;
   842		struct pci_dev *pdev;
   843	
   844		/*
   845		 * Theoretically, CXL component registers can be hosted on a
   846		 * non-PCI device, in practice, only cxl_test hits this case.
   847		 */
   848		if (!dev_is_pci(dev))
   849			return CXL_RESOURCE_NONE;
   850	
   851		pdev = to_pci_dev(dev);
   852	
 > 853		cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 > 854		return cxl_regmap_to_base(pdev, &map);
   855	}
   856	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
