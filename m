Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F934D9539
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbiCOH10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbiCOH1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:27:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA53CA6C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647329173; x=1678865173;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u1qBeiwIyVDonTHN/OhvfGexu+Qnpt6KzpTkZ89X6Bs=;
  b=hmoMmUuGqfYlLd8SrOCviwB8pUMSsGCsA6YrxDvN9tfnourJAePg5PhU
   rPKyfXeI2G4phKdTZyjyfA3BhhfyiO7RpG7+2R4s8nQKHW8L/GxOEldwH
   1tKfII1eM82q8pJX2Cc/YzNYfDr2W3s1m+PB6/lfg3DIr9zeu82u7ZvJd
   DJiTpWBgw5Y/Q0ARa4t1xTSXjEsgqP1rLuzQyxnsJe52qTooenWq7d2Kq
   d08FOgnDDWS8tIzDSw/H17v1FbMv3AlaBqAIBcH4Om99ZXVjhSghJ6cRZ
   Ch9aCbmCRfk/08MNmFkYm7+c0Ae1TDcwUwJ0eOPMwG3p8Bs/kwmyB9SGZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319454424"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="319454424"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 00:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="515757779"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 00:26:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU1ZJ-000AgU-Uj; Tue, 15 Mar 2022 07:26:09 +0000
Date:   Tue, 15 Mar 2022 15:25:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 55/78] drivers/cxl/region.c:104: undefined reference to
 `__umoddi3'
Message-ID: <202203151541.AJJWxAas-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   9b688fc651b9d2b633e8d959454670aba1c39162
commit: 786e9e583773745bcd55c225d3a2643454dcca84 [55/78] cxl/region: Introduce a cxl_region driver
config: i386-randconfig-c021-20220314 (https://download.01.org/0day-ci/archive/20220315/202203151541.AJJWxAas-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=786e9e583773745bcd55c225d3a2643454dcca84
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 786e9e583773745bcd55c225d3a2643454dcca84
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/cxl/region.o: in function `sanitize_region':
>> drivers/cxl/region.c:104: undefined reference to `__umoddi3'


vim +104 drivers/cxl/region.c

    66	
    67	/**
    68	 * sanitize_region() - Check is region is reasonably configured
    69	 * @cxlr: The region to check
    70	 *
    71	 * Determination as to whether or not a region can possibly be configured is
    72	 * described in CXL Memory Device SW Guide. In order to implement the algorithms
    73	 * described there, certain more basic configuration parameters must first need
    74	 * to be validated. That is accomplished by this function.
    75	 *
    76	 * Returns 0 if the region is reasonably configured, else returns a negative
    77	 * error code.
    78	 */
    79	static int sanitize_region(const struct cxl_region *cxlr)
    80	{
    81		const int ig = region_granularity(cxlr);
    82		const int iw = region_ways(cxlr);
    83		int i;
    84	
    85		if (dev_WARN_ONCE(&cxlr->dev, !is_cxl_region_configured(cxlr),
    86				  "unconfigured regions can't be probed (race?)\n")) {
    87			return -ENXIO;
    88		}
    89	
    90		/*
    91		 * Interleave attributes should be caught by later math, but it's
    92		 * easiest to find those issues here, now.
    93		 */
    94		if (!cxl_is_interleave_ways_valid(iw)) {
    95			dev_dbg(&cxlr->dev, "Invalid number of ways\n");
    96			return -ENXIO;
    97		}
    98	
    99		if (!cxl_is_interleave_granularity_valid(ig)) {
   100			dev_dbg(&cxlr->dev, "Invalid interleave granularity\n");
   101			return -ENXIO;
   102		}
   103	
 > 104		if (cxlr->config.size % (SZ_256M * iw)) {
   105			dev_dbg(&cxlr->dev, "Invalid size. Must be multiple of %uM\n",
   106				256 * iw);
   107			return -ENXIO;
   108		}
   109	
   110		for (i = 0; i < iw; i++) {
   111			if (!cxlr->config.targets[i]) {
   112				dev_dbg(&cxlr->dev, "Missing memory device target%u",
   113					i);
   114				return -ENXIO;
   115			}
   116			if (!cxlr->config.targets[i]->dev.driver) {
   117				dev_dbg(&cxlr->dev, "%s isn't CXL.mem capable\n",
   118					dev_name(&cxlr->config.targets[i]->dev));
   119				return -ENODEV;
   120			}
   121		}
   122	
   123		return 0;
   124	}
   125	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
