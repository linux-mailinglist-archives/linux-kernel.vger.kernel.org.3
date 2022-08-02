Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C08587D02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbiHBNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:24:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C914036
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659446661; x=1690982661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oX9SbSpDs7YibxSiuBBLFfvmst81/SCIHcYuNdQ6FrE=;
  b=J/epDZlCl4/FFvuv67j9I64kTecVwin4zJcLb9zszjbuXkDJeEUAxmIU
   Pd1A1zMaFuIY/IqQIRC6bAetBCidycTQDjL6YvtKsJTdTSo16/Ufo2llO
   U9NAaoUOLUeW0GO4grL1m2P5wVI+sS+8zEzwTkRuI+a4dK20/pVAvru6i
   0Yb5RPoIbk97z5TVQyap43TgYHYIj0JluTGxwRe/FxeyrDq9XMAE42ysG
   PlP6o0FK2JzgWrFP+6ULr4FNvTVHP0xF/Ydo9HLNlflgHb2/tlN+p7nGu
   pGXcaEr7O21y1/cxQGx9apMLoFZgVbFKWrMu6tXSTHdog80QEFecTI68f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290181006"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="290181006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 06:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="929968011"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 06:24:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIrsh-000G4p-0A;
        Tue, 02 Aug 2022 13:24:19 +0000
Date:   Tue, 2 Aug 2022 21:23:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220722 144/153] dp_debug.c:undefined
 reference to `dp_panel_tpg_config'
Message-ID: <202208022122.C9rJXy1e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-next-20220722
head:   40b61aa73f42e6507da8ca5e2cc1a9dde59f9516
commit: c1bc1580b0dd297b7749f6353834295155bfbb48 [144/153] drm/msm/dp: Make it possible to enable the test pattern
config: mips-randconfig-r004-20220801 (https://download.01.org/0day-ci/archive/20220802/202208022122.C9rJXy1e-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/c1bc1580b0dd297b7749f6353834295155bfbb48
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220722
        git checkout c1bc1580b0dd297b7749f6353834295155bfbb48
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips-linux-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_test_active_write':
>> dp_debug.c:(.text+0x50c): undefined reference to `dp_panel_tpg_config'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
