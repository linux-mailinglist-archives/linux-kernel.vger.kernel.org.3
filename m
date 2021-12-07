Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6246B221
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhLGFUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:20:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:50917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231877AbhLGFUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:20:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323750562"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="323750562"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 21:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="502444631"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2021 21:16:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muSqM-000MCL-H1; Tue, 07 Dec 2021 05:16:46 +0000
Date:   Tue, 7 Dec 2021 13:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211118 38/48]
 drivers/soc/qcom/pmic_glink_pan.c:9:10: fatal error:
 linux/soc/qcom/pmic_glink.h: No such file or directory
Message-ID: <202112071342.1DHkP3SK-lkp@intel.com>
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
config: powerpc-randconfig-m031-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071342.1DHkP3SK-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/af2e40a7c1b6390b42af215ac19c9be35554b397
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211118
        git checkout af2e40a7c1b6390b42af215ac19c9be35554b397
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/soc/qcom/pmic_glink.c:44:26: warning: no previous prototype for 'pmic_glink_register_callback' [-Wmissing-prototypes]
      44 | struct pmic_glink_owner *pmic_glink_register_callback(struct pmic_glink *pg,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/pmic_glink.c:67:6: warning: no previous prototype for 'pmic_glink_unregister_callback' [-Wmissing-prototypes]
      67 | void pmic_glink_unregister_callback(struct pmic_glink *pg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/pmic_glink.c:76:5: warning: no previous prototype for 'pmic_glink_send' [-Wmissing-prototypes]
      76 | int pmic_glink_send(struct pmic_glink *pg, void *data, size_t len)
         |     ^~~~~~~~~~~~~~~
   drivers/soc/qcom/pmic_glink.c:200:34: warning: 'pmic_glink_of_match' defined but not used [-Wunused-const-variable=]
     200 | static const struct of_device_id pmic_glink_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
--
>> drivers/soc/qcom/pmic_glink_pan.c:9:10: fatal error: linux/soc/qcom/pmic_glink.h: No such file or directory
       9 | #include <linux/soc/qcom/pmic_glink.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +9 drivers/soc/qcom/pmic_glink_pan.c

     8	
   > 9	#include <linux/soc/qcom/pmic_glink.h>
    10	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
