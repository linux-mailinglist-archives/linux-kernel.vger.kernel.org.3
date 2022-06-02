Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B353B12E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiFBAkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiFBAkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:40:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276CA21F9A6;
        Wed,  1 Jun 2022 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654130400; x=1685666400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/NEsbvbuUCxR99tcx+zO5i0VaG0aRU9+4mB4ZBYmo6g=;
  b=mIXIU3mzEiutZrlKgT5tf4f6OeXOGjB/lCYO7kzfjLDrzQtQd5H8jdu6
   IkyDAXg9Ezi6OCbYqLzQkgml9TykG328qqg2dgTs/kxEdoCjSPkd341u1
   3UO1UfOg0V/c3+EoihP6S2XOTRwBuOw5eYNtl6Obo8MKlpGwy4pl5Vt4J
   XTXUq3rvJ6OYfwwhXJCS+yE/TXzDCYeavR15OcJP7mAGh9aU909nJ8vuL
   FfhfDjlMNmNqPK9wmcBiDTjDp3h+GMzA3RDS0OfQW4zt7m+6q5NISSQq8
   KdeqzGYBDLs+FGeD1zf9LgYxJQpMmV+GQLGL+sB4qkMZVNeKyH5jZjJhE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301137991"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="301137991"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 17:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="612575503"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2022 17:39:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwYsW-0004aE-05;
        Thu, 02 Jun 2022 00:39:56 +0000
Date:   Thu, 2 Jun 2022 08:39:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] thermal/debugfs: Add debugfs information
Message-ID: <202206020816.0blG5XwC-lkp@intel.com>
References: <20220601151441.9128-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601151441.9128-2-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Encapsulate-the-set_cur_state-function/20220601-231733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220602/202206020816.0blG5XwC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/04c295f7e8b49af742179609949736f6f056b49c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Encapsulate-the-set_cur_state-function/20220601-231733
        git checkout 04c295f7e8b49af742179609949736f6f056b49c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/thermal/thermal_core.c:27:
   In file included from drivers/thermal/thermal_core.h:16:
>> drivers/thermal/thermal_debugfs.h:11:20: warning: function 'thermal_debugfs_init' has internal linkage but is not defined [-Wundefined-internal]
   static inline void thermal_debugfs_init(void);
                      ^
   drivers/thermal/thermal_core.c:1496:2: note: used here
           thermal_debugfs_init();
           ^
   1 warning generated.


vim +/thermal_debugfs_init +11 drivers/thermal/thermal_debugfs.h

     2	
     3	#ifdef CONFIG_THERMAL_DEBUGFS
     4	void thermal_debugfs_init(void);
     5	void thermal_debugfs_cdev_register(struct thermal_cooling_device *cdev);
     6	void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *cdev);
     7	void thermal_debugfs_tz_register(struct thermal_zone_device *tz);
     8	void thermal_debugfs_tz_unregister(struct thermal_zone_device *tz);
     9	void thermal_debugfs_cdev_transition(struct thermal_cooling_device *cdev, int state);
    10	#else
  > 11	static inline void thermal_debugfs_init(void);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
