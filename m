Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE64C9494
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiCATnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiCATnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:43:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858AE3204D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646163744; x=1677699744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dpxOOIB6sqQOx/PE9m23Xx1Uoq97ViXCm8f9RA7bK+k=;
  b=Cc9xp1W42uqzywNfKMEoWmED8lxrBpTDJkP6Gk2iL7ZBz9PKo6rRfKLv
   ek984L1ZnsRNvtioavTGfcRCB5N7/nopQ2g931I6+n1AAiZhTiAxJvNVC
   Gp7jtWJnJRNQUWrgO7Uvos7OT9vV3qpdlozTwt/CFtIwTN1HhcnMxK6Lf
   v2Ly0oHJ0lXyJZUxMwKVYgM57xAJIPt1JzKg3viwd73zz8VDjtC/EBr98
   HVPPwXjE8AbVhjNn9qbA7W/Gys+cSustFhyBba67CU29PATAkrzLT3O7W
   6xkiQaSZZ3rPZJmk4TO8qp2W1Ly9zHDCnHXcD4sqPGgnKjhVdHi+42/GK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253412865"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253412865"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:42:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="575821728"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2022 11:42:08 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP8Nr-0000wH-Dd; Tue, 01 Mar 2022 19:42:07 +0000
Date:   Wed, 2 Mar 2022 03:41:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 2/7] clocksource/drivers/timer-microchip-pit64b: remove
 timer-of depenency
Message-ID: <202203020342.D25UnKWg-lkp@intel.com>
References: <20220301123449.2816625-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301123449.2816625-3-claudiu.beznea@microchip.com>
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

Hi Claudiu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on soc/for-next linus/master v5.17-rc6 next-20220301]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220301-203520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 35e13e9da9afbce13c1d36465504ece4e65f24fe
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220302/202203020342.D25UnKWg-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/71455500f0209daebcb4729fbcee97a5e81dad14
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Claudiu-Beznea/clocksource-drivers-timer-microchip-pit64b-fixes-and-improvements/20220301-203520
        git checkout 71455500f0209daebcb4729fbcee97a5e81dad14
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> ld: warning: orphan section `__timer_of_table' from `drivers/clocksource/timer-microchip-pit64b.o' being placed in section `__timer_of_table'
>> ld: warning: orphan section `__timer_of_table' from `drivers/clocksource/timer-microchip-pit64b.o' being placed in section `__timer_of_table'
>> ld: warning: orphan section `__timer_of_table' from `drivers/clocksource/timer-microchip-pit64b.o' being placed in section `__timer_of_table'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
