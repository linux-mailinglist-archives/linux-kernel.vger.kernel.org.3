Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19255762E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiFWJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiFWJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:02:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523A46CB0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655974949; x=1687510949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rOdguUzREfaDZkZ/+ZWuAbnYuWbuUf8LF36WhgQPXG4=;
  b=lpcSijL/FzHyv1iNsT9/OvTG7U5sC/hO+U6XPcpnQPemhfGOJWPP3CFb
   CG905YphiQw8XCewe/5R5UCb3IeQPFYxPNt5XI+1nF1hTE69GXD4O2s7E
   cwNBgqEvQJnKVyto0e+dNNDCaoX97Rsni3n4RmghaJKZkCz0OI0pDgo2O
   FHf6KrDKq2X/yFcDpJv/qxvOKjHw8ayPfId2TL81P4rYTRTsMTVZB1lq0
   MCjIwEgF2NhX/Eol7FnwP3hwCGIgetBd4Q0CVE/f4PuCloRQ+X6aK1s6G
   XFmr4uCC8R2xQKzDiLAQJn8RsNOXCYRbTOJIcugs3Qsj+dyPXctz7Dipr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260483766"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="260483766"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 02:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834547243"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 02:02:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4IjK-0000zl-Pz;
        Thu, 23 Jun 2022 09:02:26 +0000
Date:   Thu, 23 Jun 2022 17:01:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 41/49] powerpc-linux-ld: port.c:undefined reference to
 `dev_attr_create_pmem_region'
Message-ID: <202206231626.oruggHVP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: 96ec07f789bf8a52f5c00d3310d9b7ec4c701738 [41/49] cxl/region: Allocate host physical address (HPA) capacity to new regions
config: powerpc-randconfig-r031-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231626.oruggHVP-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=96ec07f789bf8a52f5c00d3310d9b7ec4c701738
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 96ec07f789bf8a52f5c00d3310d9b7ec4c701738
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_root_decoder_visible':
   port.c:(.text+0x1a6): undefined reference to `dev_attr_create_pmem_region'
>> powerpc-linux-ld: port.c:(.text+0x1aa): undefined reference to `dev_attr_create_pmem_region'
>> powerpc-linux-ld: port.c:(.text+0x1ba): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: port.c:(.text+0x1be): undefined reference to `dev_attr_delete_region'
>> powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x130): undefined reference to `dev_attr_create_pmem_region'
>> powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x134): undefined reference to `dev_attr_delete_region'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
