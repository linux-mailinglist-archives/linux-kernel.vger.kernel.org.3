Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51844F4EAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836172AbiDFAfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392097AbiDENtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:49:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307715A19
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649163014; x=1680699014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qxoy9OT5Ut6sbXF8QToZ++jWRIjeGEhQJxFwexjVZxs=;
  b=h06K7gYCJDvlUb5n7a231PNZjoZEppGxqXBpbWbq5BHiGwY9ZpQ94YOE
   rli8+dUOI9XD4OvaWCMNWyPqJbgmaLWOhNgtqejdVx5ftLT+K9bWmzaSu
   rJQa+6ESl9f3QL6HD8LVDi5eHsrqEaZ5UTl04sYZ3u9xKsZWserMag5OI
   avCRXQATRWPWB5JT+/0D+r10+Iyy8Yyz72RsTBSQjQjPFRkH8J+Uj8ikq
   ddpAS5YzSkQ7M+T0PMWypRsXoJSqLys47FzngP+8o6czTsZdh0jZHgLSd
   MBQ7D8vShl1xOd2ftTAu0fCTHlZGkMmRVFIUlh9g0fyCW2O0MtAPQltcR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="241325672"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="241325672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 05:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523980426"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 05:50:12 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbidP-0003Hv-Ps;
        Tue, 05 Apr 2022 12:50:11 +0000
Date:   Tue, 5 Apr 2022 20:49:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: drivers/gpu/drm/msm/msm_io_utils.c:65:31: sparse: sparse: incorrect
 type in return expression (different address spaces)
Message-ID: <202204052038.RxcTSgob-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: d89e5028346bd80f79c3073d132123e7a17e1177 drm/msm: move utility functions from msm_drv.c
date:   7 weeks ago
config: sparc64-randconfig-s031-20220405 (https://download.01.org/0day-ci/archive/20220405/202204052038.RxcTSgob-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d89e5028346bd80f79c3073d132123e7a17e1177
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d89e5028346bd80f79c3073d132123e7a17e1177
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/gpu/drm/msm/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
