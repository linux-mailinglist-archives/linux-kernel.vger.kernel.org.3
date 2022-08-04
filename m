Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5D58A403
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbiHDXu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiHDXuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:50:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7BE7171A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659657052; x=1691193052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QI2l2GHEGVRAUryTF6hy4yfT8HPIOGEfhK6uM+xfLK8=;
  b=BzYNIV3sNBHGAOPJ9qqr81QzH4HvBlnsnEwz5P0z+nijsxx2GvNNADzS
   c4sZQl/Fno6KuAoV0ti1oQGEH9Oti9E8Gato/fbEuQm2TPtlEsTj0q8W2
   3zOL6HYA2WeeOpk/bohnlxVNZw+bXP3hQZYy4iLawIOimAopOVlxMl78v
   rP+q/PQD69zdwMZrBg0PyqQfSJReAPxvzZRCm+/5zP0UcZpnrygDWBgRO
   ITDxdRAC9gyNW1FTOWTvB8LLEalai5g+EBjY6e8Z4RPiNvaT3IIAAbfqp
   hKnqXxQInC3ouUPxUZgubDkgrgPBeyPIuAWpyhg1H/dq6e5TH5RPM7Gpc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="277001930"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="277001930"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 16:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636296401"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2022 16:50:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJkc5-000Ixb-31;
        Thu, 04 Aug 2022 23:50:49 +0000
Date:   Fri, 5 Aug 2022 07:50:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220722 19/165] ERROR: modpost:
 "kernel_recvmsg" [drivers/soc/qcom/qmi_helpers.ko] undefined!
Message-ID: <202208050729.6vFekrLZ-lkp@intel.com>
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

Hi Bjorn,

First bad commit (maybe != root cause):

tree:   https://github.com/steev/linux sc8280xp-next-20220722
head:   55f65506289dc60362cf0ca980db7e0a989bba7a
commit: 89eb57ddfa8f5e563a5ccb042bf74c0c51c3e390 [19/165] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
config: arm-randconfig-c033-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050729.6vFekrLZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/89eb57ddfa8f5e563a5ccb042bf74c0c51c3e390
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220722
        git checkout 89eb57ddfa8f5e563a5ccb042bf74c0c51c3e390
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "ntb_register_device" [drivers/pci/endpoint/functions/pci-epf-vntb.ko] undefined!
ERROR: modpost: "ntb_db_event" [drivers/pci/endpoint/functions/pci-epf-vntb.ko] undefined!
ERROR: modpost: "ntb_link_event" [drivers/pci/endpoint/functions/pci-epf-vntb.ko] undefined!
>> ERROR: modpost: "kernel_recvmsg" [drivers/soc/qcom/qmi_helpers.ko] undefined!
>> ERROR: modpost: "init_net" [drivers/soc/qcom/qmi_helpers.ko] undefined!
>> ERROR: modpost: "kernel_getsockname" [drivers/soc/qcom/qmi_helpers.ko] undefined!
>> ERROR: modpost: "sock_create_kern" [drivers/soc/qcom/qmi_helpers.ko] undefined!
>> ERROR: modpost: "sock_release" [drivers/soc/qcom/qmi_helpers.ko] undefined!
>> ERROR: modpost: "kernel_sendmsg" [drivers/soc/qcom/qmi_helpers.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
   Depends on [n]: NET [=n]
   Selected by [m]:
   - QCOM_PDR_HELPERS [=m]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
