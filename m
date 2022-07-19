Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08BE57A21C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbiGSOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbiGSOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:44:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B050B29E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658241858; x=1689777858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eWIcpWVgO9Vr+YlhDQFGQ7F1fKubPdeuLH4emQrTznc=;
  b=YycnIfivk54hxGUM/3tJiUuirJdG2FtG2fbCeSPYWpGF/ZU6TfyxDbtb
   M7ax1+XhibEIg+gTlNXPG+FOd1uXFelI04koL0YlMqYfScyj7OJRD5NEe
   ZXPhu+Ew2O0VbUNX4kYkg080M/xZKuohMGR1BpzmRpLdrsEiqMQeqIWbf
   J600G6VBaPaZ8phfX1p4iF85mgJDYVwkkp0oRgmcYM74W1fUGbgg5LWI2
   6TFo6095yfmWHYOsJz4XGSAmDaZ9kAqlcS38WBOfuNBhiVxcqeCEt2xfX
   5LCbCx6lThfS/V0IjVs6y2iPssRmXtZIWK4WxHoSf6eosAs6eRGA+7mpJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="287660097"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="287660097"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="774143782"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Jul 2022 07:44:16 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDoSO-0005kK-7Q;
        Tue, 19 Jul 2022 14:44:16 +0000
Date:   Tue, 19 Jul 2022 22:43:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kevin Kim <ckkim@hardkernel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: drivers/pwm/pwm-gpio.c:60:22: warning: no previous prototype for
 'gpio_pwm_timer'
Message-ID: <202207192231.Py9az5ky-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.19.y
head:   0569e1291a824471ea27c9e90132881c0232a3a0
commit: e76d6cf1a5ecd46156c2dc716f5acfba766156f6 ODROID-COMMON: pwm: gpio: Add a generic gpio based PWM driver
date:   8 days ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220719/202207192231.Py9az5ky-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/tobetter/linux/commit/e76d6cf1a5ecd46156c2dc716f5acfba766156f6
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.19.y
        git checkout e76d6cf1a5ecd46156c2dc716f5acfba766156f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag where applicable
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
