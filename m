Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78D4EF90D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbiDARkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbiDARkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:40:21 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17751EC9A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648834710; x=1680370710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1sXInO0WcC5PaI49sZEA8uZPMt8e2+U3uhkMTkC/2nM=;
  b=MhfB2eYZIvqyBgkNg9IznblaMktEaaCVoHe8pbnLbnR/0vyOikgbtURS
   FtBz8B2WdEC4oLf2MPGM8VOssTkYo+ifMmyHq6MpYfwV7yTYIWI89RegZ
   l4BlyUWyvnfdHWO1/pwXK+Bjr8ssYwwCVZ5rysp9sUb74KEUTqKKZsDTy
   7TvDWTc4FDajgzvmyinr736W2LoXzHuKeXCoQE6nGR3xQlalVnWGkd2Rt
   hJj6jHGKj2tE/41fH5QZVmSgUVqXEVOtDSr006Mm1Qy7r/gPB/5j11//u
   BRUUubihRvgPM+3NQwQjtImqTaGVlSGE/2T7Vpz4ZjVwGlOE9I0X6We6O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="320892389"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="320892389"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="720962357"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2022 10:38:29 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naLEC-0001QI-Hj;
        Fri, 01 Apr 2022 17:38:28 +0000
Date:   Sat, 2 Apr 2022 01:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp 16/18]
 drivers/scsi/ufs/ufshcd.c:1168:23: warning: variable 'pm_opp_target_rate'
 set but not used
Message-ID: <202204020157.isDVHFsp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp
head:   df7fc04027f28b5b133954ef8e766e3190a30d4f
commit: ab65d39794d1521614271985db9322211816dbb6 [16/18] WIP
config: mips-randconfig-r013-20220331 (https://download.01.org/0day-ci/archive/20220402/202204020157.isDVHFsp-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/ab65d39794d1521614271985db9322211816dbb6
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp
        git checkout ab65d39794d1521614271985db9322211816dbb6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/mm/ drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/ufs/ufshcd.c: In function 'ufshcd_scale_gear':
>> drivers/scsi/ufs/ufshcd.c:1168:23: warning: variable 'pm_opp_target_rate' set but not used [-Wunused-but-set-variable]
    1168 |         unsigned long pm_opp_target_rate;
         |                       ^~~~~~~~~~~~~~~~~~


vim +/pm_opp_target_rate +1168 drivers/scsi/ufs/ufshcd.c

  1154	
  1155	/**
  1156	 * ufshcd_scale_gear - scale up/down UFS gear
  1157	 * @hba: per adapter instance
  1158	 * @scale_up: True for scaling up gear and false for scaling down
  1159	 *
  1160	 * Returns 0 for success,
  1161	 * Returns -EBUSY if scaling can't happen at this time
  1162	 * Returns non-zero for any other errors
  1163	 */
  1164	static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
  1165	{
  1166		int ret = 0;
  1167		struct ufs_clk_info *clki;
> 1168		unsigned long pm_opp_target_rate;
  1169		struct ufs_pa_layer_attr new_pwr_info;
  1170	
  1171		dev_err(hba->dev, "AAAA ufshcd_scale_gear %d - %d\n",
  1172			scale_up, hba->use_pm_opp);
  1173		clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
  1174	
  1175		if (scale_up) {
  1176			memcpy(&new_pwr_info, &hba->clk_scaling.saved_pwr_info.info,
  1177			       sizeof(struct ufs_pa_layer_attr));
  1178			pm_opp_target_rate = clki->max_freq;
  1179		} else {
  1180			memcpy(&new_pwr_info, &hba->pwr_info,
  1181			       sizeof(struct ufs_pa_layer_attr));
  1182	
  1183			if (hba->pwr_info.gear_tx > hba->clk_scaling.min_gear ||
  1184			    hba->pwr_info.gear_rx > hba->clk_scaling.min_gear) {
  1185				/* save the current power mode */
  1186				memcpy(&hba->clk_scaling.saved_pwr_info.info,
  1187					&hba->pwr_info,
  1188					sizeof(struct ufs_pa_layer_attr));
  1189	
  1190				/* scale down gear */
  1191				new_pwr_info.gear_tx = hba->clk_scaling.min_gear;
  1192				new_pwr_info.gear_rx = hba->clk_scaling.min_gear;
  1193			}
  1194			pm_opp_target_rate = clki->min_freq;
  1195		}
  1196	
  1197		if (hba->use_pm_opp && scale_up) {
  1198			//ret = dev_pm_opp_set_rate(hba->dev, pm_opp_target_rate);
  1199			//dev_err(hba->dev, "AAA dev_pm_opp_set_rate %d\n", ret);
  1200			//ret = 0;
  1201		}
  1202	
  1203		/* check if the power mode needs to be changed or not? */
  1204		ret = ufshcd_config_pwr_mode(hba, &new_pwr_info);
  1205		if (ret)
  1206			dev_err(hba->dev, "%s: failed err %d, old gear: (tx %d rx %d), new gear: (tx %d rx %d)",
  1207				__func__, ret,
  1208				hba->pwr_info.gear_tx, hba->pwr_info.gear_rx,
  1209				new_pwr_info.gear_tx, new_pwr_info.gear_rx);
  1210	
  1211		if (hba->use_pm_opp && !scale_up) {
  1212			//ret = dev_pm_opp_set_rate(hba->dev, pm_opp_target_rate);
  1213			//dev_err(hba->dev, "AAA dev_pm_opp_set_rate %d\n", ret);
  1214			//ret = 0;
  1215		}
  1216	
  1217		return ret;
  1218	}
  1219	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
