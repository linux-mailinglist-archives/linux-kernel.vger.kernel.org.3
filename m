Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DD4F8A27
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiDGVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiDGVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:35:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566D510FDED
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649367228; x=1680903228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pQ2l2Yft622tiVLDWS1dgPrfgqMkrlfQmixJxbng0kA=;
  b=Xi8cj3UYIG6H/Y8ZmjLqDYEiZwbsr4o+SmKnxSsUYsyLa6YGsWZIRXEe
   fyCS7+34lrm1PGfVn36axVCEUVvOvl3Y6rDmyXjIy+aH9xTVLZrl0ha0E
   trg3BalOWDid76iPQ9EMw9d7m+5gFQILgNScYtsL88a0fT3CGPJV6oRQQ
   ygSoH+rkwb9U8ppYQurvCS5lwhMBXdRIiSbOJ/Che//FB0uWwmPyI/aOC
   g6yEwg7CdN0z+MH+Y8LZBBU/ZA7HJSKmeO9rlA6TvhteXCfR7Vae1IYb8
   XMK+mVJvioHCK3XUFwMg/34IEp0jC0JYKuAVZEbZdnAH878biIZwzWdZF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261138626"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="261138626"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="524542097"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Apr 2022 14:33:47 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncZlC-0005nf-Am;
        Thu, 07 Apr 2022 21:33:46 +0000
Date:   Fri, 8 Apr 2022 05:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v2 19/20] drivers/opp/core.c:898:33:
 error: 'const struct opp_table' has no member named 'clk'; did you mean
 'clks'?
Message-ID: <202204080548.RCEpmt1c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v2
head:   e10a6c68219eb9b5d79c2f447d8df698c38e5853
commit: ea240d6e8f1e8a618de2d76ff2e89a1cc3d39971 [19/20] pm wip
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220408/202204080548.RCEpmt1c-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/krzk/linux/commit/ea240d6e8f1e8a618de2d76ff2e89a1cc3d39971
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-v2
        git checkout ea240d6e8f1e8a618de2d76ff2e89a1cc3d39971
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/opp/core.c: In function '_set_opp_custom':
>> drivers/opp/core.c:898:33: error: 'const struct opp_table' has no member named 'clk'; did you mean 'clks'?
     898 |         data->clk = (opp_table->clk ? opp_table->clks[0] : NULL);
         |                                 ^~~
         |                                 clks


vim +898 drivers/opp/core.c

   875	
   876	static int _set_opp_custom(const struct opp_table *opp_table,
   877				   struct device *dev, struct dev_pm_opp *opp,
   878				   unsigned long freq)
   879	{
   880		struct dev_pm_set_opp_data *data = opp_table->set_opp_data;
   881		struct dev_pm_opp *old_opp = opp_table->current_opp;
   882		int size;
   883	
   884		/*
   885		 * We support this only if dev_pm_opp_set_regulators() was called
   886		 * earlier.
   887		 */
   888		if (opp_table->sod_supplies) {
   889			size = sizeof(*old_opp->supplies) * opp_table->regulator_count;
   890			memcpy(data->old_opp.supplies, old_opp->supplies, size);
   891			memcpy(data->new_opp.supplies, opp->supplies, size);
   892			data->regulator_count = opp_table->regulator_count;
   893		} else {
   894			data->regulator_count = 0;
   895		}
   896	
   897		data->regulators = opp_table->regulators;
 > 898		data->clk = (opp_table->clk ? opp_table->clks[0] : NULL);
   899		data->dev = dev;
   900		data->old_opp.rate = old_opp->rate;
   901		data->new_opp.rate = freq;
   902	
   903		return opp_table->set_opp(data);
   904	}
   905	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
