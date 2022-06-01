Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EAB53B07B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiFAWzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiFAWzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:55:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA063C3D1D;
        Wed,  1 Jun 2022 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654124130; x=1685660130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXIMFyOzlfpo6o9ipdECaK7wJn/4iqwzAp2siE0lhV8=;
  b=A2D/CzzXXo6AO/RH/xnszknGm2aMqUDHsNc5uhC6LoADF2ObsF1FzYs+
   II/I4rBFUTvJAOt8kBO8PG6vSr0+6w8cys4rGQjyyFPn35UT6yIuQ+nwh
   OZEXbBabYSrrI61o2X/oYOTfgKjdm+8Ig54D+JJ2x+vdI3VdkrcTretbg
   6+AVocDTzrUk8YKnWzcivNuglmBQlre+o4VepeQu46iM0Skebinn1CPuN
   YKm2TAwD3J9HPlLWYhK7WvRgBiF0fLYcFQKYPtLH+98Ukd/C3Pty9CbHW
   1npFAci3G8o32Q49Dhj+SaUeN9ZP+V+AEhJCS1fYFvYrPamU9tWpxsXBg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257824297"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="257824297"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 15:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="667665784"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2022 15:55:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwXFP-0004Uw-Ar;
        Wed, 01 Jun 2022 22:55:27 +0000
Date:   Thu, 2 Jun 2022 06:55:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] thermal/debugfs: Add debugfs information
Message-ID: <202206020607.DHohHTFP-lkp@intel.com>
References: <20220601151441.9128-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601151441.9128-2-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Encapsulate-the-set_cur_state-function/20220601-231733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220602/202206020607.DHohHTFP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/04c295f7e8b49af742179609949736f6f056b49c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Encapsulate-the-set_cur_state-function/20220601-231733
        git checkout 04c295f7e8b49af742179609949736f6f056b49c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/thermal/thermal_core.o: in function `thermal_init':
>> drivers/thermal/thermal_core.c:1496: undefined reference to `thermal_debugfs_init'


vim +1496 drivers/thermal/thermal_core.c

  1470	
  1471	static int __init thermal_init(void)
  1472	{
  1473		int result;
  1474	
  1475		result = thermal_netlink_init();
  1476		if (result)
  1477			goto error;
  1478	
  1479		result = thermal_register_governors();
  1480		if (result)
  1481			goto error;
  1482	
  1483		result = class_register(&thermal_class);
  1484		if (result)
  1485			goto unregister_governors;
  1486	
  1487		result = of_parse_thermal_zones();
  1488		if (result)
  1489			goto unregister_class;
  1490	
  1491		result = register_pm_notifier(&thermal_pm_nb);
  1492		if (result)
  1493			pr_warn("Thermal: Can not register suspend notifier, return %d\n",
  1494				result);
  1495	
> 1496		thermal_debugfs_init();

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
