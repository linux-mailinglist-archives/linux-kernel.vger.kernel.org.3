Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CBC50E7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiDYSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiDYSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:09:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F5138BCA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650909987; x=1682445987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rrOdhDVkrjSqoJ/S0GscDU5/gE99xaEHwiNxAV66yds=;
  b=L0AEbTcSGjvsLxPnGJVaLh1UTCGaNVQLkLU21aa1JWEVt75zqYP5eGct
   vxY8N6wRIB6F56BqjzrgxQhYW4JLaU2c2bBaSt9XP+cBFE904JoqZt3wa
   jgO9Vfexk+04SFaVx9cxzWUnttnlgOSDYYD05qSVmhqRTnGb0xZd7jOO5
   GFSWJXgCoTEttzIWPWXGCO61g2Fj5kS4rxG22zqvAMCvumr7kN5bDLyT4
   WnRnmo4plF/N7xUKMcH0Vr5SwwNOIBd3WRzr6sb19jSI61JcFaw72EKzJ
   3E/ZIv4fGwlplv6QwDhXsptHZunSUkUpHlOPrmimk+0iuMSvyAowE7mUq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325813053"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="325813053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="704670374"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 11:06:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj36N-0002kk-RW;
        Mon, 25 Apr 2022 18:06:23 +0000
Date:   Tue, 26 Apr 2022 02:05:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, daniel@thingy.jp
Cc:     kbuild-all@lists.01.org, romain.perier@gmail.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] clocksource/drivers: remove unnecessary return in switch
 statement
Message-ID: <202204260158.ccGqDClt-lkp@intel.com>
References: <20220425084644.3495153-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425084644.3495153-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on v5.18-rc4 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/clocksource-drivers-remove-unnecessary-return-in-switch-statement/20220425-170540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ce8abf340e40e1126bfcb9e7679b3d6b524ae3e0
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220426/202204260158.ccGqDClt-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f185e49aea517bee5dfb706df47fa5f70bfac370
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/clocksource-drivers-remove-unnecessary-return-in-switch-statement/20220425-170540
        git checkout f185e49aea517bee5dfb706df47fa5f70bfac370
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-msc313e.c: In function 'msc313e_timer_init':
>> drivers/clocksource/timer-msc313e.c:230:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     230 |         int ret = 0;
         |             ^~~


vim +/ret +230 drivers/clocksource/timer-msc313e.c

5fc1f93f69989e Romain Perier 2021-12-17  227  
5fc1f93f69989e Romain Perier 2021-12-17  228  static int __init msc313e_timer_init(struct device_node *np)
5fc1f93f69989e Romain Perier 2021-12-17  229  {
5fc1f93f69989e Romain Perier 2021-12-17 @230  	int ret = 0;
5fc1f93f69989e Romain Perier 2021-12-17  231  	static int num_called;
5fc1f93f69989e Romain Perier 2021-12-17  232  
5fc1f93f69989e Romain Perier 2021-12-17  233  	switch (num_called) {
5fc1f93f69989e Romain Perier 2021-12-17  234  	case 0:
5fc1f93f69989e Romain Perier 2021-12-17  235  		ret = msc313e_clksrc_init(np);
5fc1f93f69989e Romain Perier 2021-12-17  236  		break;
5fc1f93f69989e Romain Perier 2021-12-17  237  
5fc1f93f69989e Romain Perier 2021-12-17  238  	default:
5fc1f93f69989e Romain Perier 2021-12-17  239  		ret = msc313e_clkevt_init(np);
5fc1f93f69989e Romain Perier 2021-12-17  240  		break;
5fc1f93f69989e Romain Perier 2021-12-17  241  	}
5fc1f93f69989e Romain Perier 2021-12-17  242  
5fc1f93f69989e Romain Perier 2021-12-17  243  	num_called++;
5fc1f93f69989e Romain Perier 2021-12-17  244  
5fc1f93f69989e Romain Perier 2021-12-17  245  	return 0;
5fc1f93f69989e Romain Perier 2021-12-17  246  }
5fc1f93f69989e Romain Perier 2021-12-17  247  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
