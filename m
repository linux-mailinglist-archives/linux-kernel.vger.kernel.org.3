Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4945A207A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbiHZFv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHZFvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:51:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A45C04DA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661493113; x=1693029113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5rJxMTQV0P3rcT5R2f0m7QLY0y5vYKqa1BnBPwfkBew=;
  b=HtZgbiilNP7PuIzVq26yhV2aG0dGD1ndW+1CO9XJMSbx656pH68yMFpt
   nDlWCTOpac67PWqrCmCEEbCLO+AB0bFKpRlIIns6JsET4kM9RvngIOLVN
   JlT1KNNFB5TioHcuPNA38zEf3CwRQm4I2rwFQEFBc+YxQ8AgucOwi6W2D
   pNZSQkusUOHrH0zWQPrd+dJr3wqjycIlh4MOqNmYUd5aj5ODG0PFog+gC
   d3qCafr4PiAhmxCBPekZGg6qCy+T3KaigU/dOV9UVITczVrlfwrkJHX7o
   wXziY1lNXPAqGDSTGkmqbFXgsUHnMqNFmZCsvQp9osOs37OIkpc6ndnr4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="281402024"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="281402024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 22:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="938632228"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2022 22:51:52 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRSFz-0003Ua-1R;
        Fri, 26 Aug 2022 05:51:51 +0000
Date:   Fri, 26 Aug 2022 13:51:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-6.0.y-rt-rebase 23/59] kernel/softirq.c:641:1:
 sparse: sparse: symbol '__pcpu_scope_pending_timer_softirq' was not
 declared. Should it be static?
Message-ID: <202208261333.gsZk17N6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-6.0.y-rt-rebase
head:   1d8c2694d3f649c97636d991dca099bd86f63f97
commit: 6b4c722d9a8c4017626b41c4321539a74c62b6ad [23/59] tick: Fix timer storm since introduction of timersd
config: alpha-randconfig-s051-20220824 (https://download.01.org/0day-ci/archive/20220826/202208261333.gsZk17N6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=6b4c722d9a8c4017626b41c4321539a74c62b6ad
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-6.0.y-rt-rebase
        git checkout 6b4c722d9a8c4017626b41c4321539a74c62b6ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   kernel/softirq.c:640:1: sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be static?
>> kernel/softirq.c:641:1: sparse: sparse: symbol '__pcpu_scope_pending_timer_softirq' was not declared. Should it be static?

vim +/__pcpu_scope_pending_timer_softirq +641 kernel/softirq.c

   639	
   640	DEFINE_PER_CPU(struct task_struct *, timersd);
 > 641	DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
   642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
