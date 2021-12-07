Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7846B713
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhLGJdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:33:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:54243 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233856AbhLGJdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:33:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237767081"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237767081"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 01:29:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="750850052"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2021 01:29:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muWnH-000MPG-06; Tue, 07 Dec 2021 09:29:51 +0000
Date:   Tue, 7 Dec 2021 17:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211118 38/48]
 drivers/power/supply/qcom_pmic_glink_power.c:10:10: fatal error:
 linux/soc/qcom/pmic_glink.h: No such file or directory
Message-ID: <202112071752.oMiQp01k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sm8350-next-20211118
head:   801a35a569988584ffd5f6028a992f636c2a6634
commit: af2e40a7c1b6390b42af215ac19c9be35554b397 [38/48] pmic_glink: Initial patch
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211207/202112071752.oMiQp01k-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/af2e40a7c1b6390b42af215ac19c9be35554b397
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211118
        git checkout af2e40a7c1b6390b42af215ac19c9be35554b397
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/power/supply/qcom_pmic_glink_power.c:10:10: fatal error: linux/soc/qcom/pmic_glink.h: No such file or directory
      10 | #include <linux/soc/qcom/pmic_glink.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +10 drivers/power/supply/qcom_pmic_glink_power.c

     9	
  > 10	#include <linux/soc/qcom/pmic_glink.h>
    11	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
