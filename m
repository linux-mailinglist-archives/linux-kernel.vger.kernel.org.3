Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB64AC29D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442743AbiBGPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442159AbiBGOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:47:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1587C03FEC1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644245253; x=1675781253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ra8d5E373NELndTwrBeiptvSq0aJOWl1lEu/cUMyUuU=;
  b=G55lyscsG93/dfJGK1384eZldPsmwPBB4nTJHHfZrtyFt9FOCUHDU54n
   yJCwKad3J27FRN7ni+u3JOonW6OPBwVVXcnhlttgfbs38meAyXONKopgB
   /Bf8yvqWI+p5HMqrNBtrRdNCGyVYKYIHpGIbrQxBa/K5poEKTBhN3N6U2
   zW+cxQUxsGljhVH9liBTw4frXhXt+k31G0gROURW5u20AZF5RA4GuJtvm
   gaIlMX2kIfnCRUA+lq/XhdDLu/tTZTlZzAWey8xt3MmkTtC/CmjFdI8rN
   NzONUJXatOgVxK3MYjqRw6Wt5Qp00TTABCrZQf8Y+iEZ/v52C8Ne8EKMa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228698623"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="228698623"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="536231363"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2022 06:47:32 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH5Ih-0000d7-M8; Mon, 07 Feb 2022 14:47:31 +0000
Date:   Mon, 7 Feb 2022 22:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: [sunxi:sunxi/clk-for-5.18 2/2]
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h:6:10: fatal error:
 dt-bindings/clock/sun6i-rtc.h: No such file or directory
Message-ID: <202202072224.hjVEpIij-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/clk-for-5.18
head:   4f88abd86756e574c733d2ca14676be335cc0058
commit: 4f88abd86756e574c733d2ca14676be335cc0058 [2/2] clk: sunxi-ng: Add support for the sun6i RTC clocks
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220207/202202072224.hjVEpIij-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?id=4f88abd86756e574c733d2ca14676be335cc0058
        git remote add sunxi https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
        git fetch --no-tags sunxi sunxi/clk-for-5.18
        git checkout 4f88abd86756e574c733d2ca14676be335cc0058
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:18:
>> drivers/clk/sunxi-ng/ccu-sun6i-rtc.h:6:10: fatal error: dt-bindings/clock/sun6i-rtc.h: No such file or directory
       6 | #include <dt-bindings/clock/sun6i-rtc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +6 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h

     5	
   > 6	#include <dt-bindings/clock/sun6i-rtc.h>
     7	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
