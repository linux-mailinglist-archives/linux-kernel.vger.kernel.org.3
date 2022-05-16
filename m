Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B646528BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiEPRZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbiEPRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:25:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60D13DF7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652721943; x=1684257943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4wTfdXeGKL2uZh8t3c24YC/m4aBIrVRT4kSq3cD/L4s=;
  b=ITW8q+UiEBFae7AlAD/nhiYk9uJwfdJrpLQ8OpQlV8QSD5ipJEbGeH8e
   LQdNA0JMBpmlZWMarSlpIgevgkqBhGXehTR4F6QQV/JLpWM9DJVMWBok5
   5SOC/5ofSJeSjFg71QWfhX9Hn/peiVw4YNPCe2WvyT5HwHqAEQ5HUCmLv
   zb32pInLL7d79e6/ABhZAP9GBjTnO54HWNGz1TvDiOGa7QZ0ZiclAmLw5
   RSmoklFBx+OlxFSQKPs/FkqibH+pjEC6C8BCE1MNznQQCutv4gq08Vrwj
   Euz3sFzVmxPaqgN88cNVz5fxIzKQT/tKHXkYtTbrN0P9mf7Lcb7T729Ri
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270850326"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270850326"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="522547827"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2022 10:25:40 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqeTT-0000Dh-OL;
        Mon, 16 May 2022 17:25:39 +0000
Date:   Tue, 17 May 2022 01:24:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kevin Kim <ckkim@hardkernel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: [tobetter:odroid-5.18.y 97/131] drivers/pwm/pwm-gpio.c:60:22:
 warning: no previous prototype for 'gpio_pwm_timer'
Message-ID: <202205170132.c95JkC0F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.18.y
head:   a4a3b755d6825af3be1a233d3d927f40356ff545
commit: 523b4a5fc40c035f7fb9cc079b1f0a9ba38f16d8 [97/131] ODROID-COMMON: pwm: gpio: Add a generic gpio based PWM driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220517/202205170132.c95JkC0F-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/523b4a5fc40c035f7fb9cc079b1f0a9ba38f16d8
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.18.y
        git checkout 523b4a5fc40c035f7fb9cc079b1f0a9ba38f16d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/pwm/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
