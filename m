Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCC58A2BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiHDV2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiHDV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:28:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA21CFCC
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659648517; x=1691184517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iAoNfZ+Oo6ucq4NddFbvyYBRFu7wG8wSbyBDspFs4sc=;
  b=kXcMu56jkGp7q8W+/+F3StmMTKRgYesei5hFB4jjSlHKm+XFRzRBcUv8
   mD8D3njIgq+nsk2DkfPBlu+O7ctLelBOh/nNual1ZNdFzMYJZM8mPL+NS
   qvofWd7WJW/ZR9jdEi4uT4jK4I1aWnDAoCnHG64LTxVy71kIUlKsXtBzq
   TPawyMY2j6eWMx6fzdGhYrfZ0gjEjQI7mr6EQmzhQ8F3+5u4h26DM7PUx
   H0fFvgTeVuDmVi43urLCL0YPuf2sWeGN6akZnmuX/2Fc0Na4scH/AeUX9
   XGzdY1i/Hn/V5q3IZxE6DCDhAp6W8nsjloVKv3gkZgYEuUNG3gEnVkZHM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354047721"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354047721"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="745625108"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2022 14:28:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJiOR-000Is1-1m;
        Thu, 04 Aug 2022 21:28:35 +0000
Date:   Fri, 5 Aug 2022 05:28:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220722 140/165] ERROR: modpost:
 "dp_panel_tpg_config" [drivers/gpu/drm/msm/msm.ko] undefined!
Message-ID: <202208050521.PDJfFPKf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-next-20220722
head:   55f65506289dc60362cf0ca980db7e0a989bba7a
commit: 8afcd508f5d1ee33f4ec1a9e98d76b4c731ac513 [140/165] drm/msm/dp: Make it possible to enable the test pattern
config: parisc-randconfig-r011-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050521.PDJfFPKf-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/8afcd508f5d1ee33f4ec1a9e98d76b4c731ac513
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220722
        git checkout 8afcd508f5d1ee33f4ec1a9e98d76b4c731ac513
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "dp_panel_tpg_config" [drivers/gpu/drm/msm/msm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
