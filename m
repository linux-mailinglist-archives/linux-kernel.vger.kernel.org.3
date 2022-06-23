Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1E557A99
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiFWMo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiFWMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:44:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A99F3DA7B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655988281; x=1687524281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T5MFRciMFQm/Vz9Jf8VerHzvU2pKofTMWXjJeG4rfVE=;
  b=JiWJUAVY6iwzLwIMBpfpS1p4RLELvJBft872BuqYzkm7UACVV18g32Fx
   HrVwkT8mZokSvEMIoAQPgfqQ6R8Xsrn5bwWbVXYEMsOIn3kwy7yPKoyHU
   Z1kDld6A5s7aajUDfr7KLu7KaaLlsGi2zLs6f/mxArglig0xG/YwDDi/G
   RQdtCAodcBMAQlmIwBCj68X1YVLTWRNT/x9pnjMgSvIB+XCmetYO7iiN1
   q5H9brXAxbzuXaY6VCZvgkDmA48aQoU8htYD/2YnwrRXGwkltoSjEcIBB
   h1gmP64zUqnkX6szmVgpFosjqmJ4x7CmlqACosu/NrFpWArO/RNqBBGtX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="269432551"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="269432551"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 05:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="834623556"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 05:44:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4MCM-0001GM-5p;
        Thu, 23 Jun 2022 12:44:38 +0000
Date:   Thu, 23 Jun 2022 20:44:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 42/49] port.c:undefined reference to `cxl_region_rwsem'
Message-ID: <202206231921.bj93USvP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: 26b65f41272efb6f9c691f56f02fe4159985d187 [42/49] cxl/region: Enable the assignment of endpoint decoders to regions
config: arc-randconfig-r032-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231921.bj93USvP-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=26b65f41272efb6f9c691f56f02fe4159985d187
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 26b65f41272efb6f9c691f56f02fe4159985d187
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/cxl/core/port.o: in function `cxld_unregister':
>> port.c:(.text+0x33e): undefined reference to `cxl_region_rwsem'
>> arc-elf-ld: port.c:(.text+0x33e): undefined reference to `cxl_region_rwsem'
>> arc-elf-ld: port.c:(.text+0x34e): undefined reference to `cxl_region_detach'
>> arc-elf-ld: port.c:(.text+0x34e): undefined reference to `cxl_region_detach'
   arc-elf-ld: port.c:(.text+0x356): undefined reference to `cxl_region_rwsem'
   arc-elf-ld: port.c:(.text+0x356): undefined reference to `cxl_region_rwsem'
   arc-elf-ld: drivers/cxl/core/port.o: in function `cxl_root_decoder_visible':
   port.c:(.text+0xd5e): undefined reference to `dev_attr_create_pmem_region'
   arc-elf-ld: port.c:(.text+0xd5e): undefined reference to `dev_attr_create_pmem_region'
   arc-elf-ld: port.c:(.text+0xd7c): undefined reference to `dev_attr_delete_region'
   arc-elf-ld: port.c:(.text+0xd7c): undefined reference to `dev_attr_delete_region'
   arc-elf-ld: drivers/cxl/core/port.o: in function `region_show':
   port.c:(.text+0xe34): undefined reference to `cxl_region_rwsem'
   arc-elf-ld: port.c:(.text+0xe34): undefined reference to `cxl_region_rwsem'
   arc-elf-ld: port.c:(.text+0xe62): undefined reference to `cxl_region_rwsem'
   arc-elf-ld: port.c:(.text+0xe62): undefined reference to `cxl_region_rwsem'
   arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a0): undefined reference to `dev_attr_create_pmem_region'
   arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a0): undefined reference to `dev_attr_create_pmem_region'
   arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a4): undefined reference to `dev_attr_delete_region'
   arc-elf-ld: drivers/cxl/core/port.o:(.data+0x1a4): undefined reference to `dev_attr_delete_region'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
