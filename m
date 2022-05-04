Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676BE51992D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbiEDIHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiEDIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:07:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EC71FCDC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651651440; x=1683187440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gL0S9ZXu3OIbgnNyXFOlMdlDsvB1Vg2oL5Upehzauzc=;
  b=aQgOuQszhnuDscl1SyBmeZjXppngwaLJcKW1rExHs6HmLB5G7AEH0G6H
   lKGt75LaNL9B3w9iTgovfrdlyOmNw5LEAC5SKwOZuhF46XMbi7gYIZKV4
   IX/r9YxxeUUaRhc1IFa9XRxqSWyLz67yATmJ86WuWOm+Ssn2PJGpc4viU
   02ymt6pQKETWKJRDnYLREOYYwOJWm5InY7yKLjXXkSMvBskTM8QwB+Xhz
   2Vf+tev2t9QMRc8NNno8UPKxk6abEOSE8rI3yUcmwe3GfJ2jRAQXsMovk
   P76V5/rZrlDlgko1KPwtHT0B4vyETwz5IrWH0dZrN38VlzTzV728h5X/z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248237090"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="248237090"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="599432517"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2022 01:03:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm9zK-000BC3-5Z;
        Wed, 04 May 2022 08:03:58 +0000
Date:   Wed, 4 May 2022 16:02:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson:wip/sc8180x-next-20220502 7/29]
 drivers/phy/qualcomm/phy-qcom-qmp.c:6189: undefined reference to
 `typec_switch_get_drvdata'
Message-ID: <202205041511.NkA9shqv-lkp@intel.com>
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

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220502
head:   6199153320a3b7d1dce23ad1ea4d894a86793cb6
commit: 5cc3b17921dda08e833aa7933dc2da40d7e47b43 [7/29] phy: qcom-qmp: Register as a typec switch for orientation detection
config: csky-randconfig-r021-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041511.NkA9shqv-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/5cc3b17921dda08e833aa7933dc2da40d7e47b43
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220502
        git checkout 5cc3b17921dda08e833aa7933dc2da40d7e47b43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_typec_switch_set':
>> drivers/phy/qualcomm/phy-qcom-qmp.c:6189: undefined reference to `typec_switch_get_drvdata'
   csky-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_dp_phy_configure':
   drivers/phy/qualcomm/phy-qcom-qmp.c:5065: undefined reference to `typec_switch_get_drvdata'
   csky-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_typec_switch_register':
>> drivers/phy/qualcomm/phy-qcom-qmp.c:6205: undefined reference to `typec_switch_register'
   csky-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `usleep_range':
   include/linux/delay.h:67: undefined reference to `typec_switch_register'


vim +6189 drivers/phy/qualcomm/phy-qcom-qmp.c

  6183	
  6184	//#if IS_ENABLED(CONFIG_PHY_QCOM_QMP_TYPEC)
  6185	#if 1
  6186	static int qcom_qmp_phy_typec_switch_set(struct typec_switch_dev *sw,
  6187			enum typec_orientation orientation)
  6188	{
> 6189		struct qcom_qmp *qmp = typec_switch_get_drvdata(sw);
  6190	
  6191		qmp->orientation = orientation;
  6192	
  6193		return 0;
  6194	}
  6195	
  6196	static int qcom_qmp_phy_typec_switch_register(struct qcom_qmp *qmp, const struct qmp_phy_cfg *cfg)
  6197	{
  6198		struct typec_switch_desc sw_desc;
  6199		struct device *dev = qmp->dev;
  6200	
  6201		if (cfg->has_phy_dp_com_ctrl) {
  6202			sw_desc.drvdata = qmp;
  6203			sw_desc.fwnode = dev->fwnode;
  6204			sw_desc.set = qcom_qmp_phy_typec_switch_set;
> 6205			qmp->sw = typec_switch_register(dev, &sw_desc);
  6206			if (IS_ERR(qmp->sw)) {
  6207				dev_err(dev, "Error registering typec switch: %ld\n",
  6208						PTR_ERR(qmp->sw));
  6209			}
  6210		}
  6211	
  6212		return 0;
  6213	}
  6214	#else
  6215	static int qcom_qmp_phy_typec_switch_register(struct qcom_qmp *qmp, const struct qmp_phy_cfg *cfg)
  6216	{
  6217		return 0;
  6218	}
  6219	#endif
  6220	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
