Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756D547685
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiFKQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiFKQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:44:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF22182
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654965864; x=1686501864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4HitFCdBPXiYkZ3gaeuzkbNd/dxt9elajBwRomlnFn8=;
  b=HVj1ClTaYjSg7RlA5XAs/WXL/sCj/hcnIxxrMCRRjBnQFgSvKtinj4yf
   uTngob3XIZOEgptaaVU7IaDqhsnw/ArBrB+wISxTsUhhRWurmV5IseUz0
   vKReiv+KINeufCT5iXhK9chhXob6eBG6smArrUrIR44SS+lD8W92DP7xv
   0nCgPlxcDG56iScv0w0Fut74hyHJdbuFD9PaF9Q1JP/US1qji+L007MkH
   k/ViM6tUz6bF7PSm18PgvbWoqVIIQVol1ntIPkr8RmfN+RgY/YsqbjsT1
   Kg66dDhEACPzPA3i4wMcapm+x+ryixXKjlylRmNKtsNr0/drnKZ1K4q2L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="341937339"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="341937339"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 09:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="611150072"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2022 09:44:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o04Dl-000J61-ON;
        Sat, 11 Jun 2022 16:44:21 +0000
Date:   Sun, 12 Jun 2022 00:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 199/199]
 drivers/iio/adc/intel_mrfld_adc.c:222:40: warning: 'mrfld_adc_id_table'
 defined but not used
Message-ID: <202206120003.GMmufF0x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   8e3460e351d063ba81c3f50ed946dd825848d892
commit: 8e3460e351d063ba81c3f50ed946dd825848d892 [199/199] iio: core: drop of.h from iio.h
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220612/202206120003.GMmufF0x-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=8e3460e351d063ba81c3f50ed946dd825848d892
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout 8e3460e351d063ba81c3f50ed946dd825848d892
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/adc/intel_mrfld_adc.c:222:40: error: array type has incomplete element type 'struct platform_device_id'
     222 | static const struct platform_device_id mrfld_adc_id_table[] = {
         |                                        ^~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/intel_mrfld_adc.c:222:40: warning: 'mrfld_adc_id_table' defined but not used [-Wunused-variable]


vim +/mrfld_adc_id_table +222 drivers/iio/adc/intel_mrfld_adc.c

a7118662734a3f9 Vincent Pelletier 2019-03-26  221  
a7118662734a3f9 Vincent Pelletier 2019-03-26 @222  static const struct platform_device_id mrfld_adc_id_table[] = {
a7118662734a3f9 Vincent Pelletier 2019-03-26  223  	{ .name = "mrfld_bcove_adc" },
a7118662734a3f9 Vincent Pelletier 2019-03-26  224  	{}
a7118662734a3f9 Vincent Pelletier 2019-03-26  225  };
a7118662734a3f9 Vincent Pelletier 2019-03-26  226  MODULE_DEVICE_TABLE(platform, mrfld_adc_id_table);
a7118662734a3f9 Vincent Pelletier 2019-03-26  227  

:::::: The code at line 222 was first introduced by commit
:::::: a7118662734a3f97622d8274708cb61fd53d693a iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver

:::::: TO: Vincent Pelletier <plr.vincent@gmail.com>
:::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
