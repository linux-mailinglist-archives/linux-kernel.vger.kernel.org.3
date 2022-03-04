Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C334CCCAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiCDEvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiCDEv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:51:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1594180D37
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646369442; x=1677905442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y1EIFb0hbrwuTnbPwetKPQSFa5pVtnHwNw6ckjC0A3M=;
  b=PJnCwMaai2BXBQTpX832AbJewGGle3GqLRO5n7QwHFgRG4p7+jo92s9I
   8XR8PoyTS9w2sHnkKF2d21vx1vva7U/ONNz8xCK8aS8iQIrOA3ha48895
   lsS2xOj7Z+F9ZTPLTvuN8guxO7y25cfdMGs9yFIjqEctPao22X12IyQ5/
   Di1MOjzPeT+xRw/Pkb0ro71VkGS0yHSDOfWNbRKAmh4NT/yBnk9dj3PXq
   7rFoPSVyLY4JdTtjPyQeuRfjDguGk/+mpVWRDmUj5zcjm4dZmDJiAWE8I
   klwBYodCSMFWdjajre4LxW/k+tOsR2SGTnqxRbMMDeDsHrajMKL00V6OC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="241317036"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="241317036"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 20:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="779525847"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Mar 2022 20:50:41 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPzto-0001HD-Aa; Fri, 04 Mar 2022 04:50:40 +0000
Date:   Fri, 4 Mar 2022 12:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:tuxsuite 9/42]
 drivers/gpu/drm/i915/display/intel_dp.c:4838:36: error: passing argument 2
 of 'test_bit' from incompatible pointer type
Message-ID: <202203041222.EU5Eal5c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel tuxsuite
head:   0fff1d7836dde54d8a7ce2f9010fd46a40f23aee
commit: f5897d405897f092921dfbc5e00c4f3fb4172b01 [9/42] drm: Add HPD state to drm_connector_oob_hotplug_event()
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220304/202203041222.EU5Eal5c-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/andersson/kernel/commit/f5897d405897f092921dfbc5e00c4f3fb4172b01
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson tuxsuite
        git checkout f5897d405897f092921dfbc5e00c4f3fb4172b01
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/display/intel_dp.c: In function 'intel_dp_oob_hotplug_event':
>> drivers/gpu/drm/i915/display/intel_dp.c:4838:36: error: passing argument 2 of 'test_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
    4838 |  if (hpd_high != test_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpd_pin)) {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                    |
         |                                    unsigned int *
   In file included from arch/x86/include/asm/bitops.h:390,
                    from include/linux/bitops.h:33,
                    from include/linux/of.h:15,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/gpu/drm/i915/display/intel_dp.c:29:
   include/asm-generic/bitops/instrumented-non-atomic.h:132:77: note: expected 'const volatile long unsigned int *' but argument is of type 'unsigned int *'
     132 | static __always_inline bool test_bit(long nr, const volatile unsigned long *addr)
         |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/gpu/drm/i915/display/intel_dp.c:4838:18: error: too many arguments to function 'test_bit'
    4838 |  if (hpd_high != test_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpd_pin)) {
         |                  ^~~~~~~~
   In file included from arch/x86/include/asm/bitops.h:390,
                    from include/linux/bitops.h:33,
                    from include/linux/of.h:15,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/gpu/drm/i915/display/intel_dp.c:29:
   include/asm-generic/bitops/instrumented-non-atomic.h:132:29: note: declared here
     132 | static __always_inline bool test_bit(long nr, const volatile unsigned long *addr)
         |                             ^~~~~~~~
>> drivers/gpu/drm/i915/display/intel_dp.c:4841:64: error: 'hpg_high' undeclared (first use in this function); did you mean 'hpd_high'?
    4841 |   __assign_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpg_high);
         |                                                                ^~~~~~~~
         |                                                                hpd_high
   drivers/gpu/drm/i915/display/intel_dp.c:4841:64: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/i915/display/intel_dp.c:4841:25: error: passing argument 2 of '__assign_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
    4841 |   __assign_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpg_high);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         unsigned int *
   In file included from include/linux/of.h:15,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/gpu/drm/i915/display/intel_dp.c:29:
   include/linux/bitops.h:214:75: note: expected 'volatile long unsigned int *' but argument is of type 'unsigned int *'
     214 | static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
         |                                                   ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/test_bit +4838 drivers/gpu/drm/i915/display/intel_dp.c

  4827	
  4828	static void intel_dp_oob_hotplug_event(struct drm_connector *connector,
  4829					       enum drm_connector_hpd_state hpd_state)
  4830	{
  4831		struct intel_encoder *encoder = intel_attached_encoder(to_intel_connector(connector));
  4832		struct drm_i915_private *i915 = to_i915(connector->dev);
  4833		bool hpd_high = hpd_state == DRM_CONNECTOR_HPD_HIGH;
  4834		unsigned int hpd_pin = encoder->hpd_pin;
  4835		bool need_work = false;
  4836	
  4837		spin_lock_irq(&i915->irq_lock);
> 4838		if (hpd_high != test_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpd_pin)) {
  4839			i915->hotplug.event_bits |= BIT(hpd_pin);
  4840	
> 4841			__assign_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpg_high);
  4842			need_work = true;
  4843		}
  4844		spin_unlock_irq(&i915->irq_lock);
  4845	
  4846		if (need_work)
  4847			queue_delayed_work(system_wq, &i915->hotplug.hotplug_work, 0);
  4848	}
  4849	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
