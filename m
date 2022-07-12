Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C618572172
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiGLQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGLQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:55:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5488B3D4B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657644926; x=1689180926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RkulpFMaDCPfKZH1MhfG6E5Oi/4BKRCv+mbAWTJF10M=;
  b=JRpmu+GcJYgktpfo679ahJM1uEzzCYvaZz5YyF1KejCUFPJrBXubcsKm
   o6Zdbe2lWUwIbvNY3PSCNXqGW+CO6O+ysA+ZB2uPQrmw2EVh66Ht7EtMP
   4mqWyrAy8ofveGi35Ubq/K1BAtU6xuM/Kr4K3esDJFv0X4gvePMyDxp2+
   FuorQ2wPpYrrNZU/xF6owbKMSPJkGfgyY//7hDpfacW5GUfw5dXkH3srl
   n2c+EzFBKmyf4IfcDNvoTkLkX1X7tPs9e6TQILrNwGTIQBo9mwKYGq8A5
   vsVkpDlanuQK2SiwsY20Px8yfsvMEAZC8BoWH6rV/fIQYPQhEIdujF+AP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265400882"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265400882"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 09:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="684839642"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2022 09:55:25 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBJAT-0002T1-88;
        Tue, 12 Jul 2022 16:55:25 +0000
Date:   Wed, 13 Jul 2022 00:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chunkuang-hu:pagecaller 2/2] mm/vmstat.c:1551:25: error: implicit
 declaration of function 'kallsyms_lookup'
Message-ID: <202207130026.0vnQ1Yl0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git pagecaller
head:   de987a7312cd3e22d7d6985225db9839c3bd9818
commit: de987a7312cd3e22d7d6985225db9839c3bd9818 [2/2] mm: vmstat: add pagecaller information
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220713/202207130026.0vnQ1Yl0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?id=de987a7312cd3e22d7d6985225db9839c3bd9818
        git remote add chunkuang-hu https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git
        git fetch --no-tags chunkuang-hu pagecaller
        git checkout de987a7312cd3e22d7d6985225db9839c3bd9818
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/vmstat.c: In function 'dump_pagecaller':
>> mm/vmstat.c:1551:25: error: implicit declaration of function 'kallsyms_lookup' [-Werror=implicit-function-declaration]
    1551 |                         kallsyms_lookup(pagecaller[i], &symbolsize,
         |                         ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/kallsyms_lookup +1551 mm/vmstat.c

  1531	
  1532	static void dump_pagecaller(struct seq_file *m)
  1533	{
  1534		unsigned long i;
  1535	
  1536		seq_printf(m, "max_pfn = %lu\n", max_pfn);
  1537		seq_printf(m, "pagecaller_nr = %lu\n", pagecaller_nr);
  1538	
  1539		for (i = 0; i < pagecaller_nr; i++)
  1540			if (pagecaller[i] == 0) {
  1541				seq_printf(m, "0x%016lx %16lu [Free memory]\n",
  1542					   pagecaller[i], pagecaller_cnt[i] * 4);
  1543			} else if (pagecaller[i] == 0xffffffffffffffff) {
  1544				seq_printf(m, "0x%016lx %16lu [Reserved memory]\n",
  1545					   pagecaller[i], pagecaller_cnt[i] * 4);
  1546			} else {
  1547				char symbol[80];
  1548				unsigned long symbolsize;
  1549				unsigned long offset;
  1550				char *modname;
> 1551				kallsyms_lookup(pagecaller[i], &symbolsize,
  1552						&offset, &modname, symbol);
  1553				seq_printf(m, "0x%016lx %16lu %s\n", pagecaller[i],
  1554					   pagecaller_cnt[i] * 4, symbol);
  1555			}
  1556	}
  1557	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
