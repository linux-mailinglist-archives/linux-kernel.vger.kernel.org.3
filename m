Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57C4790CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhLQP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:59:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:48699 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233490AbhLQP7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639756763; x=1671292763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=spt2TZS4capHt+wzFhSAQnCBn7Fh2qkwHcRnr0zaM0U=;
  b=nHAuO9fMSoZRruuA/Dcrsbhm4YUKQlYym/wVi/Dqu+NtPeyhfGeyA8bb
   TnlS+9UnW1DRiboCxOMWgyPmd215JCoHSS4ilMVY1BLh+XKogh+4BC9WQ
   a+9hyjBJ3WzBDOeHJuozHY/wNEVVgE4ycUUP9Z4N5wuuop0fDf1kSPAEF
   cdvBghOpFgSmdhCqJ1goZ3xIKxHthCKB5G2CZq6rrfPXzcsCTkWGUKkwk
   oE7GyxU1zCFMvJWx6drog5t19yAAprh/cQIlrN+H1rZlXXMMtO2xn5nAM
   tWHM6SNrjPXMJTaAUxLNgKKXdlMntDs2cCPD850TU/pWwax727x3daqly
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="303152276"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="303152276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 07:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="465158376"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2021 07:59:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myFdd-0004tT-Gh; Fri, 17 Dec 2021 15:59:17 +0000
Date:   Fri, 17 Dec 2021 23:58:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kbuild-all@lists.01.org,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 10/37] drm/imx/dcss: Use drm_module_platform_driver()
 to register the driver
Message-ID: <202112172338.SdP9K7tX-lkp@intel.com>
References: <20211217003752.3946210-11-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217003752.3946210-11-javierm@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20211215]
[also build test ERROR on v5.16-rc5]
[cannot apply to drm/drm-next shawnguo/for-next pinchartl-media/drm/du/next drm-exynos/exynos-drm-next v5.16-rc5 v5.16-rc4 v5.16-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Javier-Martinez-Canillas/drm-Make-drivers-to-honour-the-nomodeset-parameter/20211217-084031
base:    93bf6eee76c0e716f6b32de690b1c52991547bb4
config: arm64-randconfig-r034-20211216 (https://download.01.org/0day-ci/archive/20211217/202112172338.SdP9K7tX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c7b8e02dcec35660bbc9101ae0c1db11e5f7d1ab
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Javier-Martinez-Canillas/drm-Make-drivers-to-honour-the-nomodeset-parameter/20211217-084031
        git checkout c7b8e02dcec35660bbc9101ae0c1db11e5f7d1ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/imx/dcss/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/gpu/drm/imx/dcss/dcss-drv.c:134:1: warning: data definition has no type or storage class
     134 | drm_module_platform_driver(dcss_platform_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/imx/dcss/dcss-drv.c:134:1: error: type defaults to 'int' in declaration of 'drm_module_platform_driver' [-Werror=implicit-int]
>> drivers/gpu/drm/imx/dcss/dcss-drv.c:134:1: warning: parameter names (without types) in function declaration
   drivers/gpu/drm/imx/dcss/dcss-drv.c:124:31: warning: 'dcss_platform_driver' defined but not used [-Wunused-variable]
     124 | static struct platform_driver dcss_platform_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +134 drivers/gpu/drm/imx/dcss/dcss-drv.c

   133	
 > 134	drm_module_platform_driver(dcss_platform_driver);
   135	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
