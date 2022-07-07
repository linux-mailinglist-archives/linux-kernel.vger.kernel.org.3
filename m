Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73956ACF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiGGUtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiGGUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:49:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054922CCB5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657226947; x=1688762947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E8BuNpBBVmMJP9jq1fil2nEMkRBXTukmDfxQ057TMXc=;
  b=afWIIgXCvzKYzDhN3h5dpypZPVIsoLbzhcR/gXtzo2p9gP/86VpmjhRE
   l4e0Y1X4v/rvAA7Q8OadKwlXimlQFewnNP5FzrGKAmBnR+ieBEvOledB9
   KJq2HGAf21+TwjCB/kTGANnx25VgrErxOFo2OlJBiKSAolXlf8737gGeM
   yGfWWR4iAzDPkFq/XRkgKSknZjRJvQqlvAOkWQFOzd09GKgj2EX7rzddj
   dxTbb0gD50/6zjLbQJbimBjsDjih85UBMBoMh59uxK/lJgR79HwBWHi5Q
   lnjXMhu9rr3Tkuf+iiFedUeVkNFicy5/iuubYCo5er6+5cI6a2/icrg4K
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="263900066"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="263900066"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 13:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="568665717"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2022 13:49:04 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9YQq-000MTS-0J;
        Thu, 07 Jul 2022 20:49:04 +0000
Date:   Fri, 8 Jul 2022 04:48:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 9222/9999]
 drivers/media/i2c/ov02a10.c:720:26: error: 'v4l2_subdev_link_validate'
 undeclared here (not in a function); did you mean 'v4l2_subdev_init'?
Message-ID: <202207080426.FvjKNJDm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 649bb4174147a7d63a610bb86b442dee6171822d [9222/9999] FROMLIST: media: i2c: Add Omnivision OV02A10 camera sensor driver
config: parisc-buildonly-randconfig-r005-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080426.FvjKNJDm-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/649bb4174147a7d63a610bb86b442dee6171822d
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 649bb4174147a7d63a610bb86b442dee6171822d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/i2c/ov02a10.c:720:26: error: 'v4l2_subdev_link_validate' undeclared here (not in a function); did you mean 'v4l2_subdev_init'?
     720 |         .link_validate = v4l2_subdev_link_validate,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                          v4l2_subdev_init
   drivers/media/i2c/ov02a10.c: In function 'ov02a10_probe':
>> drivers/media/i2c/ov02a10.c:989:24: error: 'struct v4l2_subdev' has no member named 'entity'
     989 |         ov02a10->subdev.entity.ops = &ov02a10_subdev_entity_ops;
         |                        ^
   drivers/media/i2c/ov02a10.c:990:24: error: 'struct v4l2_subdev' has no member named 'entity'
     990 |         ov02a10->subdev.entity.function = MEDIA_ENT_F_CAM_SENSOR;
         |                        ^
   drivers/media/i2c/ov02a10.c:992:54: error: 'struct v4l2_subdev' has no member named 'entity'
     992 |         ret = media_entity_pads_init(&ov02a10->subdev.entity, 1, &ov02a10->pad);
         |                                                      ^


vim +720 drivers/media/i2c/ov02a10.c

   718	
   719	static const struct media_entity_operations ov02a10_subdev_entity_ops = {
 > 720		.link_validate = v4l2_subdev_link_validate,
   721	};
   722	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
