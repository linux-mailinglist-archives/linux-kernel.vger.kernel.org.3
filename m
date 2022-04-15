Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88990502137
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349394AbiDOEVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiDOEVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:21:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E26E237
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649996361; x=1681532361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vPpXIcfyh/mU0Fbs0W1R/5/8eNPVnQlfmhfymOXQLD0=;
  b=TIGhIH+rnZbAZLVAXmgWAmVUnaEpsFJ/RnuOuSuLY8HMvnJ07ZydFYPw
   0uRchU5nBXf766iMG1vhFAUAfbvXHUtkZ9ljegelAJqHu3+JTwlrTGluy
   fstEQh4y4IgFKyNzdNym3nv8cHADHLWiaohPi1PZbOKfaskBmMeVLkcdC
   29R5N00OgNMHFt9vncJFjsF4HE5dxVx9+gYimmshrmxzFIN03DTKQItEA
   mjE4rdU291PuKjt6Vbgq+pNvFUOUrB3tP6wU0D/iP1n1ero+5S6A5mTxJ
   wnqjPnGczLHH77i6ZBN8WClmau/TcDBWUResNnO7RRtpHJ4qnsgYBDq10
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349525636"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="349525636"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 21:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="527161406"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2022 21:19:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfDQU-0001Vn-41;
        Fri, 15 Apr 2022 04:19:18 +0000
Date:   Fri, 15 Apr 2022 12:18:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [cxl:pending 20/22] drivers/cxl/core/suspend.c:8:6: warning: no
 previous prototype for 'cxl_mem_active'
Message-ID: <202204151219.KoL7lvcZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
head:   4f497e0dd3530981f8c897d5d47ee880b62baefb
commit: fcf0b70f7e80f49f323cc21b8a497a24151d9c28 [20/22] PM: CXL: Disable suspend
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220415/202204151219.KoL7lvcZ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=fcf0b70f7e80f49f323cc21b8a497a24151d9c28
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl pending
        git checkout fcf0b70f7e80f49f323cc21b8a497a24151d9c28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/suspend.c:8:6: warning: no previous prototype for 'cxl_mem_active' [-Wmissing-prototypes]
       8 | bool cxl_mem_active(void)
         |      ^~~~~~~~~~~~~~
>> drivers/cxl/core/suspend.c:13:6: warning: no previous prototype for 'cxl_mem_active_inc' [-Wmissing-prototypes]
      13 | void cxl_mem_active_inc(void)
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/cxl/core/suspend.c:19:6: warning: no previous prototype for 'cxl_mem_active_dec' [-Wmissing-prototypes]
      19 | void cxl_mem_active_dec(void)
         |      ^~~~~~~~~~~~~~~~~~


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
