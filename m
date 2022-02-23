Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4D4C0C75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiBWGMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiBWGMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:12:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB160A9B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645596740; x=1677132740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rPrDwdV+fwXkxD66SgxisXDNvJdD1ZXhO/UGqyu8Rvg=;
  b=mb4QaR7aTpkylcAoJ+rF9usTR8b5iIO27acuPFL1IWgYN3aDojMpCK0M
   N/vJoWCQmfV525hXWdfoI00VyDWuj6D111v2JM1KVnXcI95aiFhFZq57u
   APQ4IpSNgXX4Kxxe7sP1SPYX+0TY3vV0dx41jzzq+ZRVdhfKogNjqYnAX
   hKh895x/8DRiE2zNpVpULUAuH0o+b1sY3/0AxKFRBfq1LrE+qRq35zTfO
   osVRLXRNHzVKAbGrrQ1uuT2LO3j4SR6oROFES0xhclokRak9uYIePojhB
   DSUHUkG0Xzi9W0Tv/NGTy69DLH1nnwTDykeoqItt940g8UXCIt9sPcXRy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251629328"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251629328"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 22:12:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="505800853"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Feb 2022 22:12:18 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMksr-00013T-Cg; Wed, 23 Feb 2022 06:12:17 +0000
Date:   Wed, 23 Feb 2022 14:11:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 56/66] ERROR: modpost: "devm_gen_pool_create"
 [drivers/cxl/cxl_acpi.ko] undefined!
Message-ID: <202202231409.fEwgg5q5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   3e9e1e72c0c24fcbeb8c96f4e886be138f61496f
commit: 560e2708e4272ad7903fcd9696fca542c96301d5 [56/66] cxl/acpi: Handle address space allocation
config: i386-randconfig-a005-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231409.fEwgg5q5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=560e2708e4272ad7903fcd9696fca542c96301d5
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 560e2708e4272ad7903fcd9696fca542c96301d5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__umoddi3" [drivers/cxl/cxl_region.ko] undefined!
>> ERROR: modpost: "devm_gen_pool_create" [drivers/cxl/cxl_acpi.ko] undefined!
>> ERROR: modpost: "gen_pool_add_owner" [drivers/cxl/cxl_acpi.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
