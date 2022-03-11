Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8CF4D5A64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346444AbiCKFU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346318AbiCKFU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:20:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EC53B40
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646975963; x=1678511963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xwc2i6LlEWjmFgoAFpU4R582uWeKh9r/XjxfgQG3MqM=;
  b=cCUwcgQCLksDBdkjR5ZtUHDOUGhxXaPPeD6ehvkHan23W9rC5sLHPTVV
   CkOxp1khI0g+dgXfqNLx0dWU5oVrEv4jPvCe91LZAcGq3n8bO7FY9VGhj
   /sZWpQv+rBB8yGfrF5PjjZdjt8rVhlw3w5Wr2Z1yOVHVOBR33uUTm0J1d
   Qf9z2ScebkmSKGNffMDwAtJxcvcHd2YNcZ5akwT4wKbcJOa88G3l6MIc2
   gX74MlKzZ2GD4M/3gWG6EEkfoXYslQ795ZSo9Cc54vTNHy2pmdWNUqxKM
   RTi1P/VsRwWSA3/BGzJThqlb8zTyTrtgmk5GCA5iUSgqbkgBhg5NnY56T
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253066608"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="253066608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 21:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="644818916"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2022 21:19:22 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSXgP-0005sG-Eh; Fri, 11 Mar 2022 05:19:21 +0000
Date:   Fri, 11 Mar 2022 13:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zack Rusin <zackr@vmware.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Martin Krastev <krastevm@vmware.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:123:22: sparse: sparse:
 symbol 'vmw_pt_sys_placement' was not declared. Should it be static?
Message-ID: <202203111316.4BboSv7D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dda64ead7e82caa47fafe0edc36067ee64df2203
commit: f6be23264bbac88d1e2bb39658e1b8a397e3f46d drm/vmwgfx: Introduce a new placement for MOB page tables
date:   3 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220311/202203111316.4BboSv7D-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f6be23264bbac88d1e2bb39658e1b8a397e3f46d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f6be23264bbac88d1e2bb39658e1b8a397e3f46d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/vmwgfx/

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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
