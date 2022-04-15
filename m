Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7D5024E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350083AbiDOFxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiDOFxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:53:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480AA3A720
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650001875; x=1681537875;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=33vxnHab5WzokZ+vZHp5UAIHJKFj53j56xmXMENnAAk=;
  b=KzKjWE7e33VeXSLaPKhEXlkt4HyvsyeZWB59OU0/ecOakatYUhL8zxhg
   sUMn/Flvpw/zCLnPta89N3Rf9NsAisUE5DBBxlkBgdv1qLJMu/4Zo8oPe
   sivq3Ig/Ih6gPLqk1KTiaLpcsjLDnXn5Fvw3CNy9q1pnlXHLt/0rgcjDT
   zBaAJnFF13+k8gqoRFXqOMVMR14n5b8famyUk25dq8k0AiMJmfNVKi4VU
   nLNNcRi004j12dinYOLhhyoT9FjZu5Dmjn2LcWg27jSQp32xo5ySkOZ6+
   z1OG8vSmfB123etTfusNSmnwtoRb797ENUt8PH7Mq1ih8kisH0A1wVTTL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250397711"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="250397711"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 22:51:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="527180012"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2022 22:51:12 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfErP-0001bm-Il;
        Fri, 15 Apr 2022 05:51:11 +0000
Date:   Fri, 15 Apr 2022 13:51:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [cxl:pending 20/22] drivers/cxl/core/suspend.c:8:6: warning: no
 previous prototype for function 'cxl_mem_active'
Message-ID: <202204151330.tjVHw5dN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
head:   4f497e0dd3530981f8c897d5d47ee880b62baefb
commit: fcf0b70f7e80f49f323cc21b8a497a24151d9c28 [20/22] PM: CXL: Disable suspend
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220415/202204151330.tjVHw5dN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=fcf0b70f7e80f49f323cc21b8a497a24151d9c28
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl pending
        git checkout fcf0b70f7e80f49f323cc21b8a497a24151d9c28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/suspend.c:8:6: warning: no previous prototype for function 'cxl_mem_active' [-Wmissing-prototypes]
   bool cxl_mem_active(void)
        ^
   drivers/cxl/core/suspend.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool cxl_mem_active(void)
   ^
   static 
>> drivers/cxl/core/suspend.c:13:6: warning: no previous prototype for function 'cxl_mem_active_inc' [-Wmissing-prototypes]
   void cxl_mem_active_inc(void)
        ^
   drivers/cxl/core/suspend.c:13:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cxl_mem_active_inc(void)
   ^
   static 
>> drivers/cxl/core/suspend.c:19:6: warning: no previous prototype for function 'cxl_mem_active_dec' [-Wmissing-prototypes]
   void cxl_mem_active_dec(void)
        ^
   drivers/cxl/core/suspend.c:19:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cxl_mem_active_dec(void)
   ^
   static 
   3 warnings generated.


vim +/cxl_mem_active +8 drivers/cxl/core/suspend.c

     7	
   > 8	bool cxl_mem_active(void)
     9	{
    10		return atomic_read(&mem_active) != 0;
    11	}
    12	
  > 13	void cxl_mem_active_inc(void)
    14	{
    15		atomic_inc(&mem_active);
    16	}
    17	EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, CXL);
    18	
  > 19	void cxl_mem_active_dec(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
