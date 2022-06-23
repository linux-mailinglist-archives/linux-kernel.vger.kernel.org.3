Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40189557D18
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiFWNcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiFWNb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:31:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C704BFEC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655991106; x=1687527106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WNLujTxRUaWm4SEGJFAxZyA0gcMS31jEwCZ5ldYOd8g=;
  b=MEBGUjCUEeu9YR3I4VTFWzed1Tr4l57ttM4i5ZtVNQi3h0taz7Cv4N2f
   eFNQeXR9tHr1ifNRQyV5EtzLqzwoS4WT418On8CZgVYUR9yVZ7nsGVvAj
   V6i2zhBirg7XsccU6C6x4N3JhQ9+nt2CGTc34Fm5Xa/Zg+71UG5XqnO/i
   JJ1dZROIVnuWvaY1DIv5+K7npsg++OhmhET//N/gQ+yct4nbf9z6ojwFZ
   ofKgjB12gt4Z272PhTTK1MN6q4/AgFO1qV5VQjaQ6sSnvnyRgXiyweH7J
   kIZ9v3HPSc1kN5JyB2JiuJUlwCYLve2ao144h6REarChnSNghWPxSnyn/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263752883"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="263752883"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 06:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="834640663"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 06:31:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Mvs-0001Jv-RC;
        Thu, 23 Jun 2022 13:31:40 +0000
Date:   Thu, 23 Jun 2022 21:31:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 47/49] csky-linux-ld: port.c:undefined reference to
 `cxl_region_init'
Message-ID: <202206232108.duHMmFSt-lkp@intel.com>
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
commit: feed7426434db705269ed645f6380e4e2784a77d [47/49] cxl/region: Add region driver boiler plate
config: csky-randconfig-r002-20220622 (https://download.01.org/0day-ci/archive/20220623/202206232108.duHMmFSt-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=feed7426434db705269ed645f6380e4e2784a77d
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout feed7426434db705269ed645f6380e4e2784a77d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/cxl/core/port.o: in function `cxl_device_id':
   port.c:(.text+0xc0): undefined reference to `cxl_region_type'
   csky-linux-ld: drivers/cxl/core/port.o: in function `cxld_unregister':
   port.c:(.text+0x51a): undefined reference to `cxl_region_detach'
   csky-linux-ld: port.c:(.text+0x548): undefined reference to `cxl_region_rwsem'
   csky-linux-ld: port.c:(.text+0x550): undefined reference to `cxl_region_detach'
   csky-linux-ld: drivers/cxl/core/port.o: in function `cxl_core_exit':
   port.c:(.text+0x5ba): undefined reference to `cxl_region_exit'
   csky-linux-ld: drivers/cxl/core/port.o: in function `lockdep_init_map_waits.constprop.0':
   port.c:(.text+0x6bc): undefined reference to `cxl_region_exit'
   csky-linux-ld: drivers/cxl/core/port.o: in function `is_switch_decoder':
   port.c:(.text+0xed0): undefined reference to `dev_attr_create_pmem_region'
   csky-linux-ld: port.c:(.text+0xed4): undefined reference to `dev_attr_delete_region'
   csky-linux-ld: drivers/cxl/core/port.o: in function `region_show':
   port.c:(.text+0xf9c): undefined reference to `cxl_region_rwsem'
   csky-linux-ld: drivers/cxl/core/port.o:(.data+0x1a0): undefined reference to `dev_attr_create_pmem_region'
   csky-linux-ld: drivers/cxl/core/port.o:(.data+0x1a4): undefined reference to `dev_attr_delete_region'
   csky-linux-ld: drivers/cxl/core/port.o: in function `cxl_core_init':
   port.c:(.init.text+0x32): undefined reference to `cxl_region_init'
>> csky-linux-ld: port.c:(.init.text+0x78): undefined reference to `cxl_region_init'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
