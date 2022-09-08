Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE065B1DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiIHNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIHNG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:06:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1D7435E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662642388; x=1694178388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ceNr1+sPPwrh5Fh+T4eFSEZzh9oMtgKuBzPKarFhCLk=;
  b=IV/MXvIx2dZQZc/KIqrnTRWI8GD/oNHkPvT9FaBNeqSLB35R0Rk75N5t
   KK8xTj2qPHyqrgJ9mHcgFITRNAFd2QFN4Xo/GReIPC7KO55V4XxxLzS+b
   BH8CbwF8KSE7Khb1/r8M/+s3QwQt3Y1PRj6macGY5+XRe1aZ3JhQAPZV/
   IsEzYB4tM7fok60nIQj2nMbYBc7DeN4IpE16jtrBF5zC9eJL3x3IapV74
   8/1Qtj1t6KWJVSOTPthr9Wta7Dep/o82phB0U7y8eY6yvZkdVNBYhw1TC
   zFukrPfvxRgHto0mPgUQyU7mTuIFJhQ/Klis4tW04i71M0f+4xRqWpVdh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="361120677"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="361120677"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="648033113"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Sep 2022 06:04:09 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWHCT-0007m9-0l;
        Thu, 08 Sep 2022 13:04:09 +0000
Date:   Thu, 8 Sep 2022 21:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:files2POTT 66/93] undefined reference to
 `slim_stream_prepare'
Message-ID: <202209082046.AZVfl0da-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git files2POTT
head:   e9e7df88996d64544178f48b0299dfe736c6aa22
commit: 5b7f4e5de61ba8c44317718936864da29eeba62a [66/93] ASoC: codecs: allow compile testing without MFD drivers
config: microblaze-buildonly-randconfig-r004-20220907 (https://download.01.org/0day-ci/archive/20220908/202209082046.AZVfl0da-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=5b7f4e5de61ba8c44317718936864da29eeba62a
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci files2POTT
        git checkout 5b7f4e5de61ba8c44317718936864da29eeba62a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the broonie-ci/files2POTT HEAD e9e7df88996d64544178f48b0299dfe736c6aa22 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   microblaze-linux-ld: sound/soc/codecs/wcd934x.o: in function `wcd934x_trigger':
>> (.text+0x3f8): undefined reference to `slim_stream_prepare'
>> microblaze-linux-ld: (.text+0x404): undefined reference to `slim_stream_enable'
>> microblaze-linux-ld: (.text+0x434): undefined reference to `slim_stream_unprepare'
>> microblaze-linux-ld: (.text+0x440): undefined reference to `slim_stream_disable'
   microblaze-linux-ld: sound/soc/codecs/wcd934x.o: in function `wcd934x_slim_set_hw_params':
>> (.text+0x3854): undefined reference to `slim_stream_allocate'
   microblaze-linux-ld: sound/soc/codecs/wcd934x.o: in function `wcd934x_codec_probe':
>> (.text+0x44c4): undefined reference to `of_slim_get_device'
>> microblaze-linux-ld: (.text+0x44dc): undefined reference to `slim_get_logical_addr'
>> microblaze-linux-ld: (.text+0x4500): undefined reference to `__regmap_init_slimbus'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
