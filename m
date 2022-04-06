Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F47F4F5BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbiDFKQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354738AbiDFKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:08:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A648215839
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649227072; x=1680763072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sNfY3kKWF6XstpO9zanCd4P6Rax/WoTuZBhub1zmDpw=;
  b=KjGTu1kylumAEY1RMnR7wQhEVKz7yTtVp6VSoomjIhavjVSCAsrxdpKl
   X3+bbT/OKUO5ByChFuGHIlRr+WqYt5WwWWWdPZYlpfujV7LmA6NFQfwUM
   eecd2S2A/6DWq5l7jLkNKMiAuWiRky7AuM9/uod4nmmeT4ncxVF6jN/GX
   x61Ig6QQFZ9ygY8bQ+BjuCYG9269LSzqwbjMXmqaNBgTmGHmZPMTVkUxU
   FmKcnyed8CWm6VuftlGicAJg4PMmb7PFmirXBT+XOp0aqUB+MqMoVshsj
   hTd3EDJWR+lk1LtyMJTsAs1DqRvJDmkn75ek0wL/P2g5sVvU51COGMuy7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258551227"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="258551227"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 23:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="722384611"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2022 23:37:50 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbzIc-00048b-6u;
        Wed, 06 Apr 2022 06:37:50 +0000
Date:   Wed, 6 Apr 2022 14:37:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/cxl/core/suspend.c:8:6: warning: no previous prototype for
 'cxl_mem_active'
Message-ID: <202204061427.aSm1HpbH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220406-100617/Dan-Williams/cxl-mem-Disable-suspend/20220403-085917
head:   16a271eb76b492775d76beb93daa896c53d50b95
commit: 16a271eb76b492775d76beb93daa896c53d50b95 PM: CXL: Disable suspend
date:   5 hours ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220406/202204061427.aSm1HpbH-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/16a271eb76b492775d76beb93daa896c53d50b95
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220406-100617/Dan-Williams/cxl-mem-Disable-suspend/20220403-085917
        git checkout 16a271eb76b492775d76beb93daa896c53d50b95
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/cxl/core/

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
