Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB94CBAE1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiCCKAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiCCKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:00:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CDE175831
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646301592; x=1677837592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BfQi6SqIuk56gwUKmagQXJHTEPZhDx7hfib06zcSfds=;
  b=mbpaGMgg3Ex2Z6bcR9lrIEEpQYZ9Gr1Kq1sW0iIVtGI+tChtIaO6xLrp
   XnNUg/ln4A1Xp/BukjFo7Qsjeh9Kp3WjnFOznc8beNJ6gSUzS7vMyhOq/
   ybJR7o90JwOPknA70sEvujSoe9QkI6kLhfjVgvB/1FlI6wYsLUTVNl946
   tx/bD2Yh9zlYjuOJLbM8gHb9ngMzj9SlwhYOsNjLgkL2fdgo/c4qW/nob
   sANnUqzGMGZtSHoZn1ta+wxPS1sTcQZOtaXp5p6+1IUu4xQxX67tsgVdP
   Yrw3dAQwrtLe4b3JAd1ZD+euydXso3S5pM9t26DJk+Ns4zvn3XFt6iG6o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253824106"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253824106"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 01:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642060606"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 01:59:49 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPiFR-0000N9-9g; Thu, 03 Mar 2022 09:59:49 +0000
Date:   Thu, 3 Mar 2022 17:59:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kevin Kim <ckkim@hardkernel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: [tobetter:odroid-5.17.y 7/41] drivers/pwm/pwm-gpio.c:60:22: warning:
 no previous prototype for 'gpio_pwm_timer'
Message-ID: <202203031749.bVBWeeSH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.17.y
head:   e882d3aa45fcf49791433e9606016225df72a12e
commit: dcc53b9a58ba6a4174df361f3668e0bd5250e9fc [7/41] ODROID-COMMON: pwm: gpio: Add a generic gpio based PWM driver
config: nios2-randconfig-r016-20220303 (https://download.01.org/0day-ci/archive/20220303/202203031749.bVBWeeSH-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/dcc53b9a58ba6a4174df361f3668e0bd5250e9fc
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.17.y
        git checkout dcc53b9a58ba6a4174df361f3668e0bd5250e9fc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-gpio.c:60:22: warning: no previous prototype for 'gpio_pwm_timer' [-Wmissing-prototypes]
      60 | enum hrtimer_restart gpio_pwm_timer(struct hrtimer *timer)
         |                      ^~~~~~~~~~~~~~


vim +/gpio_pwm_timer +60 drivers/pwm/pwm-gpio.c

    59	
  > 60	enum hrtimer_restart gpio_pwm_timer(struct hrtimer *timer)
    61	{
    62		struct gpio_pwm_data *gpio_data = container_of(timer,
    63							      struct gpio_pwm_data,
    64							      timer);
    65		if (!gpio_data->run) {
    66			gpio_pwm_off(gpio_data);
    67			gpio_data->pin_on = false;
    68			return HRTIMER_NORESTART;
    69		}
    70	
    71		if (!gpio_data->pin_on) {
    72			hrtimer_forward_now(&gpio_data->timer,
    73					    ns_to_ktime(gpio_data->on_time));
    74			gpio_pwm_on(gpio_data);
    75			gpio_data->pin_on = true;
    76		} else {
    77			hrtimer_forward_now(&gpio_data->timer,
    78					    ns_to_ktime(gpio_data->off_time));
    79			gpio_pwm_off(gpio_data);
    80			gpio_data->pin_on = false;
    81		}
    82	
    83		return HRTIMER_RESTART;
    84	}
    85	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
