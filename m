Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E24BE6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbiBUNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:09:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349408AbiBUNIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:08:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50431FA56
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645448907; x=1676984907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NdL9GJMZER1d4aJFTjQKh4fUo24Zia4iCGe8G1BZw6o=;
  b=eyEG9tkUDuj1bpwQ7z/gVDu8S4Eou8sCTwRN202TexhTt4qLweEUhwXW
   TMU1miorbiKoa3ZASt4GRzxHZLmP4Awu98AMC0pMkWXwqjEnxW3ZZmE1Q
   MdhK4wVlsEY+1B1e3/YGA+0f8oq3OPn7XutadAsmBKuLHwxk/iAjn333v
   LzvTiwX2Qk33b9rQGrY7ZKuRbtkD8SBFJ9eutkfbb8tVTn3iidoN4TCdk
   okh+v08pbf8eDEDrHcJwQhkn80YQuWZ68hpaWwMlFSYt81McBoOXwwVmU
   Sph+qIcNFD1hJa2ZwZRK+UbJzexPHwHbxCRIWkD4d5ASPIdNjYU6Ek1dl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238919416"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="238919416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="683200262"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2022 05:08:15 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM8QJ-0001ch-0b; Mon, 21 Feb 2022 13:08:15 +0000
Date:   Mon, 21 Feb 2022 21:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [drm-msm:msm-next-staging 7/60]
 drivers/gpu/drm/msm/msm_io_utils.c:65:31: sparse: sparse: incorrect type in
 return expression (different address spaces)
Message-ID: <202202212126.kJLPeuny-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/drm/msm.git msm-next-staging
head:   bc2112583a0b473f5c4ba87c00da84abd5d0b3fd
commit: d89e5028346bd80f79c3073d132123e7a17e1177 [7/60] drm/msm: move utility functions from msm_drv.c
config: ia64-randconfig-s031-20220221 (https://download.01.org/0day-ci/archive/20220221/202202212126.kJLPeuny-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add drm-msm https://gitlab.freedesktop.org/drm/msm.git
        git fetch --no-tags drm-msm msm-next-staging
        git checkout d89e5028346bd80f79c3073d132123e7a17e1177
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/msm/msm_io_utils.c:65:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/msm_io_utils.c:65:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/msm_io_utils.c:65:31: sparse:     got void *
   drivers/gpu/drm/msm/msm_io_utils.c:74:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/msm_io_utils.c:74:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/msm_io_utils.c:74:31: sparse:     got void *

vim +65 drivers/gpu/drm/msm/msm_io_utils.c

    49	
    50	static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name,
    51					  bool quiet, phys_addr_t *psize)
    52	{
    53		struct resource *res;
    54		unsigned long size;
    55		void __iomem *ptr;
    56	
    57		if (name)
    58			res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
    59		else
    60			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    61	
    62		if (!res) {
    63			if (!quiet)
    64				DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
  > 65			return ERR_PTR(-EINVAL);
    66		}
    67	
    68		size = resource_size(res);
    69	
    70		ptr = devm_ioremap(&pdev->dev, res->start, size);
    71		if (!ptr) {
    72			if (!quiet)
    73				DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n", name);
    74			return ERR_PTR(-ENOMEM);
    75		}
    76	
    77		if (psize)
    78			*psize = size;
    79	
    80		return ptr;
    81	}
    82	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
