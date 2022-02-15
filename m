Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17714B7648
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242295AbiBORn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:43:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbiBORnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:43:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202997BA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644946993; x=1676482993;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oj8OOXX1ckMDtALqPdHVZbRyMA1rseOv4Z7KiHNiDvY=;
  b=EAU10a564pJkbX5e/PiSj6SbGRy/+Vu5Rx3Rw02nVSKMeTBu+nIY3gW8
   caxhQ+AKZ3gubnjaxl9PPQGwoGvCOXbXXoQ3NEZnxk7f3BITZglvj1/zj
   tNVd80Jxro6ObUuYO1hg1b0iPwx4yMokjxRCmFjtfWhcnWglPUJkdjtnK
   EBlrW57mNDklg89V609aIzYCP6EQoIwrVwPLZJHND3GlWlW79VU1cQI7i
   Kv4EGtvshaunRcZYRksj2qBbwaMnRC6j1qjP151AHDHw51uVeKVVZn0dj
   VuJA3dvtC9iw+WPoSryP0W26aeXmNp40b2D/5VMm47hpyY4EdiSRewQiD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231039124"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="231039124"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 09:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="636028684"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 09:43:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK1qv-0009td-1e; Tue, 15 Feb 2022 17:43:01 +0000
Date:   Wed, 16 Feb 2022 01:42:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kevin Kim <ckkim@hardkernel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dongjin Kim <tobetter@gmail.com>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: [tobetter:odroid-5.17.y 7/41] drivers/pwm/pwm-gpio.c:60:22: warning:
 no previous prototype for function 'gpio_pwm_timer'
Message-ID: <202202160144.hjSHJs2v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.17.y
head:   992855288ffabfafb16c8ed7ce9a81fc64cfc89a
commit: 380f2027a31094e1f64a78ce0e424f02dea66bc7 [7/41] ODROID-COMMON: pwm: gpio: Add a generic gpio based PWM driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220216/202202160144.hjSHJs2v-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/380f2027a31094e1f64a78ce0e424f02dea66bc7
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.17.y
        git checkout 380f2027a31094e1f64a78ce0e424f02dea66bc7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-gpio.c:60:22: warning: no previous prototype for function 'gpio_pwm_timer' [-Wmissing-prototypes]
   enum hrtimer_restart gpio_pwm_timer(struct hrtimer *timer)
                        ^
   drivers/pwm/pwm-gpio.c:60:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   enum hrtimer_restart gpio_pwm_timer(struct hrtimer *timer)
   ^
   static 
   1 warning generated.


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
