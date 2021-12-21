Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A346547C157
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhLUOUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:20:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:50888 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234213AbhLUOUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640096400; x=1671632400;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2jc9rhBb6jVW67VHv6/2nS5oRjaeExlRDPRSyBv0DeA=;
  b=fW37JtROHxNTS579KNwtL7IJycPT7toCuLPI+ccnljt/fQPIoFFjQInW
   aYknl+RjycAc93BSgDbcF4/mPlMwqDc36YUb68plItHykDYec6esAqNEA
   yUjrd3KaXe6r5VgsrfpVX1mVF8dEMim2zFnXnzl5V2Vjv9GwUak9DPZzT
   9gfAm1TBHQOIMcXHvwU8dL3yCtp7kPAAdPpwSD/4Lt6W4IaAlUvkYudmr
   e7mNgpHc6jECzDFF/vo2mTkJ75wc+lV8VllzYfMuHsAcwxJxRFThOz2cY
   rTjeyTpMIPZMobOXb2IwAbGpOrRfswkRtRli0VHgIpTriGDwERjOaGTzM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240206848"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="240206848"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 06:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="508086329"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2021 06:19:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzfzi-00098q-0O; Tue, 21 Dec 2021 14:19:58 +0000
Date:   Tue, 21 Dec 2021 22:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211215 33/35] dp_debug.c:undefined
 reference to `dp_panel_tpg_config'
Message-ID: <202112212258.GaBWCstq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sm8350-next-20211215
head:   525164cde506e9a9353b07816e50e26685e57fe4
commit: 78d97ba5fc73e3d73729d57551fb7b4521a94755 [33/35] drm/msm/dp: Make it possible to enable the test pattern
config: arm-randconfig-c002-20211220 (https://download.01.org/0day-ci/archive/20211221/202112212258.GaBWCstq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/78d97ba5fc73e3d73729d57551fb7b4521a94755
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211215
        git checkout 78d97ba5fc73e3d73729d57551fb7b4521a94755
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/gpu/drm/msm/dp/dp_debug.o: in function `dp_test_active_write':
>> dp_debug.c:(.text+0x398): undefined reference to `dp_panel_tpg_config'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
