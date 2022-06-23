Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F56557D17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiFWNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiFWNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:31:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF037A3C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655991104; x=1687527104;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bvDuU8qkN4AXM/nVISJBOe5cH0fY2soREQcUINywYYE=;
  b=SeucIpBOc0/hZafxnUBQAwgdFiMnFVu5p0F20GAtU0FTI6MWzmDn3GHa
   TohYRzED5aBWmB/rSXaxglZrtwBNIFaaHV1Sif0Evl4qRd/412n/Ltrgz
   mqXulRvYkc3fiKaTBX+6+lGa0LVI8d03kmTRICzM3WrghWca//X4noJ8/
   XGjl8WKGfg55u16ihA+ui1DnUbhaulYCVQfEzmEg6VzDgs+VCgT08dNqW
   di1hlZQVs79lZHUeKHiGkAMtrxZq1Z9b9auT5xhafFCkG1V9DzWH3aSUB
   u7R1K4nJWsHx3XLNaxgWXuPlVkKdzc1hTr1cJe0WEDLocyScZRwTho73Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263752881"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="263752881"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 06:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="834640661"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 06:31:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Mvs-0001Jx-SM;
        Thu, 23 Jun 2022 13:31:40 +0000
Date:   Thu, 23 Jun 2022 21:31:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 49/49] powerpc-linux-ld: pmem.c:undefined reference to
 `cxl_region_rwsem'
Message-ID: <202206232128.Jkbxz0ZU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: b2d4fd5c97b59f622e6c45ac51020cdcd66bb022 [49/49] cxl/region: Introduce cxl_pmem_region objects
config: powerpc-randconfig-r031-20220622 (https://download.01.org/0day-ci/archive/20220623/202206232128.Jkbxz0ZU-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/cxl/core/port.o: in function `modalias_show':
   port.c:(.text+0x156): undefined reference to `cxl_region_type'
   powerpc-linux-ld: port.c:(.text+0x15e): undefined reference to `cxl_region_type'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_root_decoder_visible':
   port.c:(.text+0x1e6): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: port.c:(.text+0x1ea): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: port.c:(.text+0x1fa): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: port.c:(.text+0x1fe): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxld_unregister':
   port.c:(.text+0x9ea): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x9f2): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0xa0c): undefined reference to `cxl_region_detach'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_core_exit':
   port.c:(.text+0xad0): undefined reference to `cxl_region_exit'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_bus_match':
   port.c:(.text+0x1196): undefined reference to `cxl_region_type'
   powerpc-linux-ld: port.c:(.text+0x119e): undefined reference to `cxl_region_type'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_bus_uevent':
   port.c:(.text+0x12d6): undefined reference to `cxl_region_type'
   powerpc-linux-ld: port.c:(.text+0x12de): undefined reference to `cxl_region_type'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `region_show':
   port.c:(.text+0x1d4a): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x1d4e): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_decoder_autoremove':
   port.c:(.text+0x3a4e): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x3a52): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x3a68): undefined reference to `cxl_region_detach'
   powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x130): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x134): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_core_init':
   port.c:(.init.text+0x78): undefined reference to `cxl_region_init'
   powerpc-linux-ld: drivers/cxl/core/pmem.o: in function `devm_cxl_add_pmem_region':
   pmem.c:(.text+0x60e): undefined reference to `cxl_region_rwsem'
>> powerpc-linux-ld: pmem.c:(.text+0x612): undefined reference to `cxl_region_rwsem'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
