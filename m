Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72875134FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiD1NZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiD1NZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:25:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DAAABF5C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651152113; x=1682688113;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uy8zSGdRbmu9x6oWV3PwTp0oEkokUG8PpRwrZP5QiPc=;
  b=Lf18CP0tCW5h7vfsY1loFzINNxoOqdYSZhO6YrVWt9xSiG7Oa9p+ouH7
   myc8f+PNRD0LMh+K5hr89S/jzmBlxdJmqL6HroHR5FJf/Xf2QXL9LLJ1l
   wzNC2V7f0NdWpYpogapD670MzRocl6YCeukrRpZYd2U5iBL0SscWB1ODX
   mMuGp9wXIlVZM/LjpFURwxBMZCvWiyu63iRyTn8OL9Abwqs51EvqKA3P/
   bSC6H0UU+lei6Q4WW0ysQhY5PXne2vcKOgO6yzO2va4cnXiWwTG2Yd7ql
   yH/J6BBKBiBtPvGkOVE/43obchqUEkjdpuzK2Tomz3Bb+DJpypk9bja6V
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266101894"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266101894"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 06:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="541279049"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 06:21:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk45f-0005OQ-1H;
        Thu, 28 Apr 2022 13:21:51 +0000
Date:   Thu, 28 Apr 2022 21:21:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/stringop-overflow 1/1]
 drivers/gpu/drm/i915/intel_pm.c:3106:9: error: 'intel_read_wm_latency'
 accessing 16 bytes in a region of size 10
Message-ID: <202204282134.8kzHtDU9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/stringop-overflow
head:   841e98dddf647582547543eba0a1e3e8c8f8db9c
commit: 841e98dddf647582547543eba0a1e3e8c8f8db9c [1/1] Makefile: Enable -Wstringop-overflow
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220428/202204282134.8kzHtDU9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=841e98dddf647582547543eba0a1e3e8c8f8db9c
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/stringop-overflow
        git checkout 841e98dddf647582547543eba0a1e3e8c8f8db9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/intel_pm.c: In function 'ilk_setup_wm_latency':
>> drivers/gpu/drm/i915/intel_pm.c:3106:9: error: 'intel_read_wm_latency' accessing 16 bytes in a region of size 10 [-Werror=stringop-overflow=]
    3106 |         intel_read_wm_latency(dev_priv, dev_priv->wm.pri_latency);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/intel_pm.c:3106:9: note: referencing argument 2 of type 'u16 *' {aka 'short unsigned int *'}
   drivers/gpu/drm/i915/intel_pm.c:2861:13: note: in a call to function 'intel_read_wm_latency'
    2861 | static void intel_read_wm_latency(struct drm_i915_private *dev_priv,
         |             ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/intel_read_wm_latency +3106 drivers/gpu/drm/i915/intel_pm.c

03981c6ebec4fc7 Ville Syrjälä   2018-11-14  3103  
bb7265197a86bd6 Ville Syrjälä   2016-10-31  3104  static void ilk_setup_wm_latency(struct drm_i915_private *dev_priv)
53615a5e129534f Ville Syrjälä   2013-08-01  3105  {
bb7265197a86bd6 Ville Syrjälä   2016-10-31 @3106  	intel_read_wm_latency(dev_priv, dev_priv->wm.pri_latency);
53615a5e129534f Ville Syrjälä   2013-08-01  3107  
53615a5e129534f Ville Syrjälä   2013-08-01  3108  	memcpy(dev_priv->wm.spr_latency, dev_priv->wm.pri_latency,
53615a5e129534f Ville Syrjälä   2013-08-01  3109  	       sizeof(dev_priv->wm.pri_latency));
53615a5e129534f Ville Syrjälä   2013-08-01  3110  	memcpy(dev_priv->wm.cur_latency, dev_priv->wm.pri_latency,
53615a5e129534f Ville Syrjälä   2013-08-01  3111  	       sizeof(dev_priv->wm.pri_latency));
53615a5e129534f Ville Syrjälä   2013-08-01  3112  
5db9401983ac7bf Tvrtko Ursulin  2016-10-13  3113  	intel_fixup_spr_wm_latency(dev_priv, dev_priv->wm.spr_latency);
fd6b8f43c9e9a3a Tvrtko Ursulin  2016-10-14  3114  	intel_fixup_cur_wm_latency(dev_priv, dev_priv->wm.cur_latency);
26ec971e302c53b Ville Syrjälä   2013-08-01  3115  
5db9401983ac7bf Tvrtko Ursulin  2016-10-13  3116  	intel_print_wm_latency(dev_priv, "Primary", dev_priv->wm.pri_latency);
5db9401983ac7bf Tvrtko Ursulin  2016-10-13  3117  	intel_print_wm_latency(dev_priv, "Sprite", dev_priv->wm.spr_latency);
5db9401983ac7bf Tvrtko Ursulin  2016-10-13  3118  	intel_print_wm_latency(dev_priv, "Cursor", dev_priv->wm.cur_latency);
e95a2f7509f5219 Ville Syrjälä   2014-05-08  3119  
93e7e61eb448318 Lucas De Marchi 2021-04-12  3120  	if (DISPLAY_VER(dev_priv) == 6) {
bb7265197a86bd6 Ville Syrjälä   2016-10-31  3121  		snb_wm_latency_quirk(dev_priv);
03981c6ebec4fc7 Ville Syrjälä   2018-11-14  3122  		snb_wm_lp3_irq_quirk(dev_priv);
03981c6ebec4fc7 Ville Syrjälä   2018-11-14  3123  	}
53615a5e129534f Ville Syrjälä   2013-08-01  3124  }
53615a5e129534f Ville Syrjälä   2013-08-01  3125  

:::::: The code at line 3106 was first introduced by commit
:::::: bb7265197a86bd68078825723b572599fcc60d2b drm/i915: Pass dev_priv to ilk_setup_wm_latency() & co.

:::::: TO: Ville Syrjälä <ville.syrjala@linux.intel.com>
:::::: CC: Ville Syrjälä <ville.syrjala@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
