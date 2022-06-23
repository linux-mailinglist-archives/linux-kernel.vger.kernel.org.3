Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B68557A97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiFWMpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiFWMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:44:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE1B34BA3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655988281; x=1687524281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7n9A/Npnz8ew2Mwc73SHGQafvWVY0FSCRLT+rkvWIUI=;
  b=ZuENzpua/GR2Y/kQXTwLE1qOn8SwRFm1QvwKmnB44/UhNLbYXuYQ5TCM
   EX0PF39OVyjEhxLeGocZKi/boerLsg/MGMFDTPB+gFkTeG2pJpaHdzV9b
   wxB1ZLcqtJkiYR3cOTkJ9+k7/d5qMfXCtLjXhvgE5irrTn9GuhheByhCF
   2jZRyQf5u4AK7oXsdBcdFHFPuzwCWXykxC+hfk215Vlw4yC3Lr7SlWH+b
   cs8Y8bHPqPFcd1c7n572EHKnmAxVNThXFLM2hvM7eNHzxsJKTb1ZXMVs6
   YIRqA6RKjo6mUfJ72ByNoPnp6pboA3w2CzbW1JgoQKs7dAHOKKPf4O3Nq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263741827"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="263741827"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 05:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="538875156"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2022 05:44:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4MCM-0001GO-6N;
        Thu, 23 Jun 2022 12:44:38 +0000
Date:   Thu, 23 Jun 2022 20:44:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 47/49] powerpc-linux-ld: port.c:undefined reference to
 `cxl_region_type'
Message-ID: <202206231916.mejWiaAb-lkp@intel.com>
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
config: powerpc-randconfig-r031-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231916.mejWiaAb-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=feed7426434db705269ed645f6380e4e2784a77d
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout feed7426434db705269ed645f6380e4e2784a77d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_root_decoder_visible':
   port.c:(.text+0xe2): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: port.c:(.text+0xe6): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: port.c:(.text+0xf6): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: port.c:(.text+0xfa): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxld_unregister':
   port.c:(.text+0x8ea): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x8f2): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x90c): undefined reference to `cxl_region_detach'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_bus_uevent':
   port.c:(.text+0x9ca): undefined reference to `cxl_region_type'
>> powerpc-linux-ld: port.c:(.text+0x9d2): undefined reference to `cxl_region_type'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_core_exit':
   port.c:(.text+0xad0): undefined reference to `cxl_region_exit'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_bus_match':
   port.c:(.text+0x118a): undefined reference to `cxl_region_type'
   powerpc-linux-ld: port.c:(.text+0x1192): undefined reference to `cxl_region_type'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `modalias_show':
   port.c:(.text+0x128a): undefined reference to `cxl_region_type'
   powerpc-linux-ld: port.c:(.text+0x1292): undefined reference to `cxl_region_type'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `region_show':
   port.c:(.text+0x1d06): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x1d0a): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_decoder_autoremove':
   port.c:(.text+0x3a4e): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x3a52): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x3a68): undefined reference to `cxl_region_detach'
   powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x130): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x134): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_core_init':
   port.c:(.init.text+0x78): undefined reference to `cxl_region_init'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
