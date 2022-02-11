Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B04B1E14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiBKGDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:03:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiBKGDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:03:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC410C1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644559413; x=1676095413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y0VNBOZ5Sh9/nTjwXOs1YqmIAmngoIuSIrg8ZcPmqNM=;
  b=nOIjKRwBFyHJVm1mqtHGUHXFeG8jlTH+8kLDHLW3k06CnPY3/Ebf7zE/
   chhRcXlAgwJoUAnwYf0hlxm+22fjarPTMgTfCFeN4QEaSk+C4sO+xSuKO
   E3k+tjhqcsjr11go1+Q0OQWESuJ+m5v9e7tBmPJYGpagTIUMFmjn6ivsB
   FBpZONhc5UvVjmxvmOqUVm3u4qNJ6DQqb25Fqw1wKaHWCCLVfrYd6Da7s
   GM9uJJ1neDtkiF6RQyCK4jh0f32Jt/xFJoDGhL76wCYLKerKZ0qMu+/Hd
   jrIZV/GoSkQbd2pvNjLnXXBiyUhHIwsaF/Zxr8mJ5XG1FKcDDey9iqBq4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="229633921"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="229633921"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="486835143"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Feb 2022 22:03:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIP1n-0004CD-4T; Fri, 11 Feb 2022 06:03:31 +0000
Date:   Fri, 11 Feb 2022 14:02:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zack Rusin <zackr@vmware.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Martin Krastev <krastevm@vmware.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:123:22: sparse: sparse:
 symbol 'vmw_pt_sys_placement' was not declared. Should it be static?
Message-ID: <202202111321.hKklCURO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1baf68e1383f6ed93eb9cff2866d46562607a43
commit: f6be23264bbac88d1e2bb39658e1b8a397e3f46d drm/vmwgfx: Introduce a new placement for MOB page tables
date:   2 months ago
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220211/202202111321.hKklCURO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f6be23264bbac88d1e2bb39658e1b8a397e3f46d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f6be23264bbac88d1e2bb39658e1b8a397e3f46d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/vmwgfx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:123:22: sparse: sparse: symbol 'vmw_pt_sys_placement' was not declared. Should it be static?

vim +/vmw_pt_sys_placement +123 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c

   122	
 > 123	struct ttm_placement vmw_pt_sys_placement = {
   124		.num_placement = 1,
   125		.placement = &vmw_sys_placement_flags,
   126		.num_busy_placement = 1,
   127		.busy_placement = &vmw_sys_placement_flags
   128	};
   129	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
