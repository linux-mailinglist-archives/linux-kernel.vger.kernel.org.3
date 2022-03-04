Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCD4CCCBF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiCDFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiCDFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:01:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2945313CEC7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646370043; x=1677906043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uftcfHaCc9mV3BnvBIiFIMK1B9Kr8o+zKwYw3mfzutg=;
  b=aAzP4HgDSPyzhFWF2DDZ5eb0ubcjbpWpu4wjX6Jj2uKZlg5PHenAvolj
   DGxZZ8wwS4bV2AFMELu8NedTDHV8ZhryG56q6tKqM6houFks72LymHjXE
   2wpGFFzfaZx4jYRAf+gVYfdFa4r7NZEcy04v6UTTMAvNQPsZ9G0MwNgTU
   MOhiE89YEIfmAaXhdqD3eaSEC02c7iPhDdyfNfdryrVL8FCxpihS1wtvm
   RYAaxlQ/eTl0pwJsLvt2pbWfKbyX4LO2lOOIUwXgY7E55UDzlY2QDLcx4
   iU+CBa8SOqORHlDlKWUWcTGI1ilS0gUPXlWRmu+oOo15yn4MmIrgN3JoM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="254087948"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="254087948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 21:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="576768479"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 21:00:41 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nQ03U-0001HW-HE; Fri, 04 Mar 2022 05:00:40 +0000
Date:   Fri, 4 Mar 2022 13:00:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:tuxsuite 9/42]
 drivers/gpu/drm/i915/display/intel_dp.c:4838:75: error: too many arguments
 to function call, expected 2, have 3
Message-ID: <202203041231.YHLqlCBb-lkp@intel.com>
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

tree:   https://github.com/andersson/kernel tuxsuite
head:   0fff1d7836dde54d8a7ce2f9010fd46a40f23aee
commit: f5897d405897f092921dfbc5e00c4f3fb4172b01 [9/42] drm: Add HPD state to drm_connector_oob_hotplug_event()
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220304/202203041231.YHLqlCBb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/f5897d405897f092921dfbc5e00c4f3fb4172b01
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson tuxsuite
        git checkout f5897d405897f092921dfbc5e00c4f3fb4172b01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_dp.c:4838:75: error: too many arguments to function call, expected 2, have 3
           if (hpd_high != test_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpd_pin)) {
                           ~~~~~~~~                                                 ^~~~~~~
   include/asm-generic/bitops/instrumented-non-atomic.h:132:29: note: 'test_bit' declared here
   static __always_inline bool test_bit(long nr, const volatile unsigned long *addr)
                               ^
>> drivers/gpu/drm/i915/display/intel_dp.c:4841:64: error: use of undeclared identifier 'hpg_high'; did you mean 'hpd_high'?
                   __assign_bit(hpd_pin, &i915->hotplug.oob_hotplug_last_state, hpg_high);
                                                                                ^~~~~~~~
                                                                                hpd_high
   drivers/gpu/drm/i915/display/intel_dp.c:4833:7: note: 'hpd_high' declared here
           bool hpd_high = hpd_state == DRM_CONNECTOR_HPD_HIGH;
                ^
   2 errors generated.


vim +4838 drivers/gpu/drm/i915/display/intel_dp.c

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
