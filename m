Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FDB496CC6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 16:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiAVPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 10:05:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:1753 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbiAVPFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 10:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642863944; x=1674399944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sLgbzBecYjat1+PQO/DoTusxlo2VOsby49r7bF8xlXw=;
  b=oIkQvbv3Py3m54N4CBP/ApprW5WMRRV/w9gY9imi0RYxVXAfsJFwaKMw
   Dk1ealmTnEtz+Ld3i8RqkzKac3qxxzBaxOsEYvPZyS5rVUb1EkLIlC+OB
   ZD8H+fpjxEczlaQit45ha7lIJSZHOG9J8+Y9Wn87waJm9hKPcY9ZsTgnW
   A45cDF4R0ornx/milqp/I3jlps6jqYabw48K7/CpBqIRSM1QSgZ6GJrrt
   y8Pfdw7JttbXMmzA6jqUPqZOs3C67BCrA+S+MqzJwR9F2/5S4VWv7EYDJ
   s46l8Djnk0UpcnDgRpUkMyzU3v8BQsc+W2Z861lBu/XKUvqqzShhoC4TB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="306544500"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="306544500"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 07:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="765985612"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2022 07:05:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBHxV-000GWR-3O; Sat, 22 Jan 2022 15:05:41 +0000
Date:   Sat, 22 Jan 2022 23:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [cxl:preview 20/53] drivers/cxl/core/regs.c:256:18: error: use of
 undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK'
Message-ID: <202201222305.il9hV9Zh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   e675fabdbbcdb6e32dba688a20fb0bd42e0e2d5d
commit: 0deb1229ea40390e8402361338d680619a750270 [20/53] cxl/acpi: Map component registers for Root Ports
config: mips-randconfig-c004-20220120 (https://download.01.org/0day-ci/archive/20220122/202201222305.il9hV9Zh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=0deb1229ea40390e8402361338d680619a750270
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 0deb1229ea40390e8402361338d680619a750270
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cxl/core/regs.c:256:18: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK'
                               (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
                                         ^
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
           map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
                                  ^
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:25: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BIR_MASK'
>> drivers/cxl/core/regs.c:257:13: error: assigning to 'u8' (aka 'unsigned char') from incompatible type 'void'
           map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cxl/core/regs.c:258:28: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK'
           map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
                                     ^
>> drivers/cxl/core/regs.c:258:28: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK'
>> drivers/cxl/core/regs.c:258:28: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK'
>> drivers/cxl/core/regs.c:258:28: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK'
>> drivers/cxl/core/regs.c:258:28: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK'
>> drivers/cxl/core/regs.c:258:28: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK'
>> drivers/cxl/core/regs.c:258:28: error: use of undeclared identifier 'CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK'
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +/CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK +256 drivers/cxl/core/regs.c

   251	
   252	static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
   253					struct cxl_register_map *map)
   254	{
   255		map->block_offset = ((u64)reg_hi << 32) |
 > 256				    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
 > 257		map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
 > 258		map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
   259	}
   260	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
