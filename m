Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076CD50C1AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiDVV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiDVV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2251AFF5D;
        Fri, 22 Apr 2022 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650659994; x=1682195994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UMRs4BhTByG3T0yDZhW94axoO98VgNSgjnfEZMM3/as=;
  b=lTZxpBoeWfaai/QN924GKvdQdblQhJN+yIquj7iG17bZU9wVF+ZtEATd
   g4EzUzX2PBNfZxxxhXbdar/MlVdXpCo7G2W5cqIBafWFYEBnbkkBwjHDd
   gQn3aOhXe9muB8XyTHcjnEDOTZVbiyQrZ32OYozuZwk6mUTB0DJn9wmGY
   A0UdrnFc1/hLtAi3JLLwIKvnCAMIAGNwUrMmUfvDNDeozsJnFrLgynl7U
   kAnzMs6BtMA58hC2CEiXWwQB5HFlXFRiGNsmQuEBacqMnfvRc4qRiTfW8
   arGJCAwsyRRkCJ7ojUxgSXFNpzSj6YKQPFGAS5ajFE/wXTLWzd7hTc+zV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325202821"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="325202821"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 11:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="594251782"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Apr 2022 11:16:57 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhxpx-000ARo-9g;
        Fri, 22 Apr 2022 18:16:57 +0000
Date:   Sat, 23 Apr 2022 02:16:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cixi Geng <gengcixi@gmail.com>, sre@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        chenyongzhi811@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Add enable the primary charger interface
Message-ID: <202204230206.9TgyhSb1-lkp@intel.com>
References: <20220422074109.1709106-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422074109.1709106-1-gengcixi@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cixi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cixi-Geng/power-supply-Add-enable-the-primary-charger-interface/20220422-154432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: riscv-randconfig-r042-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230206.9TgyhSb1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a566cf23ffad8453d1e1f611086b6eda3f14515d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cixi-Geng/power-supply-Add-enable-the-primary-charger-interface/20220422-154432
        git checkout a566cf23ffad8453d1e1f611086b6eda3f14515d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/power/supply/sc2731_charger.c:156:13: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (val && !info->charging) {
                      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/sc2731_charger.c:164:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/power/supply/sc2731_charger.c:156:9: note: remove the 'if' if its condition is always true
           } else if (val && !info->charging) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/power/supply/sc2731_charger.c:156:13: warning: variable 'ret' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
           } else if (val && !info->charging) {
                      ^~~
   drivers/power/supply/sc2731_charger.c:164:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/power/supply/sc2731_charger.c:156:13: note: remove the '&&' if its condition is always true
           } else if (val && !info->charging) {
                      ^~~~~~
>> drivers/power/supply/sc2731_charger.c:153:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!val && info->charging) {
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/sc2731_charger.c:164:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/power/supply/sc2731_charger.c:153:2: note: remove the 'if' if its condition is always false
           if (!val && info->charging) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/sc2731_charger.c:151:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   drivers/power/supply/sc2731_charger.c:255:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (val->intval == true) {
                       ^~~~~~~~~~~~~~~~~~~
   drivers/power/supply/sc2731_charger.c:268:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/power/supply/sc2731_charger.c:255:3: note: remove the 'if' if its condition is always true
                   if (val->intval == true) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/sc2731_charger.c:225:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   4 warnings generated.


vim +156 drivers/power/supply/sc2731_charger.c

   148	
   149	static int sc2731_charger_set_status(struct sc2731_charger_info *info, int val)
   150	{
   151		int ret;
   152	
 > 153		if (!val && info->charging) {
   154			sc2731_charger_stop_charge(info);
   155			info->charging = false;
 > 156		} else if (val && !info->charging) {
   157			ret = sc2731_charger_start_charge(info);
   158			if (ret)
   159				dev_err(info->dev, "start charge failed\n");
   160			else
   161				info->charging = true;
   162		}
   163	
   164		return ret;
   165	}
   166	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
