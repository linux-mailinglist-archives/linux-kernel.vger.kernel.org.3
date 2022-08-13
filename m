Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6564591AFC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiHMOai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiHMOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:30:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3991A3A4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660401022; x=1691937022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=THbTY28KsFoccvyKHnJLd3Y/pGvbWLvLzLKbzQbXTtg=;
  b=JYZekK9KjVVehF3nqKoGQm/mIg1MWs5qKrcSt/LFOycnRYFdHwlvgb1U
   JTCWHj25GuNP0KJD82CHbcfPiYXyZJblYVhi+oMUHnF/1Iib6sWcFMgK/
   qtJXJ/KHuLU/rhpPtvCrg+wz6xAhFO7vsbTdSnOTNwNjOp3lxG+5rTQyQ
   8RUbPYKYQq29C/96wmlJ11RDLH9Tx6VeTjaxFcdhUog9qjLz5Y2EoB8nn
   LiBTfeVTRPCJJ4fUXDzAEld6tWG/6b0jtXZT96K5ZRZ+K0YM+G34qCQ3q
   48bJgoXXfyqLVsSQiXbr0Ypbh/CaC/mFSPMyDTb4j1XxKUiSb8PSSMBza
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="378046923"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="378046923"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 07:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="782233506"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2022 07:30:20 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMs9c-0001lb-0T;
        Sat, 13 Aug 2022 14:30:20 +0000
Date:   Sat, 13 Aug 2022 22:29:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220722 140/165] arceb-elf-ld:
 dp_debug.c:undefined reference to `dp_panel_tpg_config'
Message-ID: <202208132255.EyqLKu5Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-next-20220722
head:   55f65506289dc60362cf0ca980db7e0a989bba7a
commit: 8afcd508f5d1ee33f4ec1a9e98d76b4c731ac513 [140/165] drm/msm/dp: Make it possible to enable the test pattern
config: arc-buildonly-randconfig-r003-20220803 (https://download.01.org/0day-ci/archive/20220813/202208132255.EyqLKu5Z-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/8afcd508f5d1ee33f4ec1a9e98d76b4c731ac513
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220722
        git checkout 8afcd508f5d1ee33f4ec1a9e98d76b4c731ac513
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_test_active_write':
   dp_debug.c:(.text+0x190): undefined reference to `dp_panel_tpg_config'
>> arceb-elf-ld: dp_debug.c:(.text+0x190): undefined reference to `dp_panel_tpg_config'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
