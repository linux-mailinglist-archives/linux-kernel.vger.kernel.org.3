Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4D547A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiFLMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiFLMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:49:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC962BCC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655038149; x=1686574149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wyw1SzrVB8IJKOlV176J9ZCu92I0WyZttvi9HwS1CE0=;
  b=AwM4Rwx2Jw3/ESyn9dTTgvgf1MDugNjSc4rLVaYdFB5kqRfENcAPE1LS
   /myAVY46c7hBu0xi1BftxO+zTO/Wp3rT8yzSry5qRCvSQrQZxIASFSa9w
   ClKaNZgM/S1eu8Y74K/QggFMqEIhxSjOzywNKsuGKMw5gkRZdb/gyAW3e
   vEFu8p6PPx+etXpf6ubc1QDOw7n1L+Z665B3Wtws9Gdpy6uD4M5/w/S3f
   6ZvTc2ovWvCkNS7Gy2Q+z44d0qdC4shgWqgyeBHBo6MU2vGVg2i6kWYG1
   DB6Ywb7FlLCeD/986qsdjW6/s0ahNh15+qypTf8Jyk8BoY+ruZ+S5dRIf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="278078565"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="278078565"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 05:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="611363071"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2022 05:49:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0N1f-000JvO-3w;
        Sun, 12 Jun 2022 12:49:07 +0000
Date:   Sun, 12 Jun 2022 20:48:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 199/204]
 drivers/iio/adc/intel_mrfld_adc.c:222:58: error: array has incomplete
 element type 'const struct platform_device_id'
Message-ID: <202206122000.ehsJVvx5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   20b4fa69eeaa2b6389ff83662a96c8f0f1f414ab
commit: 8e3460e351d063ba81c3f50ed946dd825848d892 [199/204] iio: core: drop of.h from iio.h
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220612/202206122000.ehsJVvx5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6466c9abf3674bade1f6ee859f24ebc7aaf9cd88)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=8e3460e351d063ba81c3f50ed946dd825848d892
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout 8e3460e351d063ba81c3f50ed946dd825848d892
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/adc/intel_mrfld_adc.c:222:58: error: array has incomplete element type 'const struct platform_device_id'
   static const struct platform_device_id mrfld_adc_id_table[] = {
                                                            ^
   include/linux/platform_device.h:21:8: note: forward declaration of 'struct platform_device_id'
   struct platform_device_id;
          ^
   1 error generated.


vim +222 drivers/iio/adc/intel_mrfld_adc.c

a7118662734a3f Vincent Pelletier 2019-03-26  221  
a7118662734a3f Vincent Pelletier 2019-03-26 @222  static const struct platform_device_id mrfld_adc_id_table[] = {
a7118662734a3f Vincent Pelletier 2019-03-26  223  	{ .name = "mrfld_bcove_adc" },
a7118662734a3f Vincent Pelletier 2019-03-26  224  	{}
a7118662734a3f Vincent Pelletier 2019-03-26  225  };
a7118662734a3f Vincent Pelletier 2019-03-26  226  MODULE_DEVICE_TABLE(platform, mrfld_adc_id_table);
a7118662734a3f Vincent Pelletier 2019-03-26  227  

:::::: The code at line 222 was first introduced by commit
:::::: a7118662734a3f97622d8274708cb61fd53d693a iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver

:::::: TO: Vincent Pelletier <plr.vincent@gmail.com>
:::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
