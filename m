Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC248C5E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbiALOXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:23:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:11932 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239105AbiALOXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641997389; x=1673533389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3FFp1jfQfJKwVyTysmzfSD0EivNljy7pSIRbMqDAwYA=;
  b=W0SCq5+9FSFCABpyLQ168wxEIVTMikwbPQI8sUdh4HaJUjBIv270pMP9
   6Nd/8Kp/kP1FP1YBBH6TBJLLOFYpWcFjJkU06+CL9asveA35r1AYUV80+
   /z0VKoK1FVo//5kRDs3XPf27VCbalyZU66Cd58liO85NDjX3BXb3hdcW9
   mABQfcN9z5IQeUAR4IPs5STEq+nzntVllPJypGwcqbjtqKppwZjPbsfXf
   EHunsAAv2NYZ1PfI5guUg+QJ1IrWT1Da5DFur92tEl7WsXpmG+3GTimrr
   YJK0VIzASMxj+mwE/TgpYck5oEAgWqJFBc1ghBhcDdfaNnICiGdCxWNm4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="307091953"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="307091953"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 06:17:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="576560836"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2022 06:17:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7eRk-0005vC-Lh; Wed, 12 Jan 2022 14:17:52 +0000
Date:   Wed, 12 Jan 2022 22:17:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kevin Kim <ckkim@hardkernel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: [tobetter:odroid-5.16.y 8/39] drivers/pwm/pwm-gpio.c:60:22: warning:
 no previous prototype for 'gpio_pwm_timer'
Message-ID: <202201122200.YLzDW2yK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.16.y
head:   cb59f7f629212302d4136a919ef9822aa9c84aac
commit: 9dd6bb4ad958df52219ba8a54e11fad21c546a03 [8/39] ODROID-COMMON: pwm: gpio: Add a generic gpio based PWM driver
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220112/202201122200.YLzDW2yK-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/9dd6bb4ad958df52219ba8a54e11fad21c546a03
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.16.y
        git checkout 9dd6bb4ad958df52219ba8a54e11fad21c546a03
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/pwm/

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
