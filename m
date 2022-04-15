Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF865024F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349332AbiDOFy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243552AbiDOFyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:54:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ADC4553E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650001945; x=1681537945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jf8KqANgd4gggg0XPljowAJmG/3j+mtyAqvVnanxg30=;
  b=T2WxvF6i6MV1Wr4VJiPSdtPgQTNVUK2nGbWPmZv1abIvtkIzJ0rGbMgm
   2M3nfxN6CBjMWbSQbOR/0Kc/RWzA6Ix1x89X6dI3KpWqzdf9uLyPo2bD5
   gI9PPAgCJ1vydpWK3pJk+UI+hOVy039Hl4EqLys89CYXfKOCDyF9LWnOj
   YqPxULYiAy1bIZyampODBuCxGM6vT9H3sEG/vNcFFb0v+wJLcIOfTE6B0
   Nfln8IH/ZWjG/ij39Mc0SfS1iOcuSwrmHAgQ7wR0SsVVhVK6+ZCJgrYg0
   DKUhtTu/a41ywYWPx/x0qCMLJpPTlFJtqEE3SiQJHfcZuw41Es3jJmVYn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262852588"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="262852588"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 22:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="527703659"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 22:52:22 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfEsX-0001c8-AI;
        Fri, 15 Apr 2022 05:52:21 +0000
Date:   Fri, 15 Apr 2022 13:51:12 +0800
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
Message-ID: <202204151342.h9mvfwgG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220415/202204151342.h9mvfwgG-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cxl/core/

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
