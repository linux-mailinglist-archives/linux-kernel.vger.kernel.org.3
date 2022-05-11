Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0592523C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbiEKSUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346182AbiEKSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:20:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B88140C4D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652293205; x=1683829205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FCWlvxW8P/xsxWnEPS70tTaTfJl0ScknRtB+LWbMgdI=;
  b=Ac4JdRa95tQntFfabXh+38S7y5cR6SH8HqsJlP0gAZDegWtUo3D9OI1Y
   d9B+tZI/HW0ZUaG+fQ7Ty9CNv6XQbDgmfh12cIwlQV8T/6RLT0NGZYp+f
   PddUR42PygkiiG4z+F+n7NovAWdH7G9snUdkTvqUgwxxpizhbVabmAMvb
   /BhkTU8we0g6bfYHvE4AcxhwOd+fhq8AZzQ0WjHdCHFdJBjKa95CFWnf3
   HdJ/fw+Mq+Evp0wn1O3Dvaa7kfPSZltADJ/190dxqNLVrsE4SBcIE5cmd
   GZW7ROBh83K4xTIkctmueIsTasleHdEBBo339Z/uUFYJ131tHb0R9+qJL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268613873"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="268613873"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 11:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="520622476"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2022 11:20:03 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noqwM-000JOc-Gu;
        Wed, 11 May 2022 18:20:02 +0000
Date:   Thu, 12 May 2022 02:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v3 16/31]
 drivers/scsi/ufs/ufshcd-pltfrm.c:117:14: warning: variable 'clocks_done' set
 but not used
Message-ID: <202205120230.SQL9AwU0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v3
head:   a37fb33a00889e90edd1c74de967b3315980a65d
commit: 1fe1bd364f49815ffd716b8a0f58e62a338305ff [16/31] wip
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220512/202205120230.SQL9AwU0-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/1fe1bd364f49815ffd716b8a0f58e62a338305ff
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-v3
        git checkout 1fe1bd364f49815ffd716b8a0f58e62a338305ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/ufs/ufshcd-pltfrm.c: In function 'ufshcd_parse_operating_points':
   drivers/scsi/ufs/ufshcd-pltfrm.c:175:12: error: 'struct ufs_hba' has no member named 'use_pm_opp'
     175 |         hba->use_pm_opp = true;
         |            ^~
   drivers/scsi/ufs/ufshcd-pltfrm.c:118:18: warning: unused variable 'i' [-Wunused-variable]
     118 |         int cnt, i, ret;
         |                  ^
>> drivers/scsi/ufs/ufshcd-pltfrm.c:117:14: warning: variable 'clocks_done' set but not used [-Wunused-but-set-variable]
     117 |         bool clocks_done;
         |              ^~~~~~~~~~~
   drivers/scsi/ufs/ufshcd-pltfrm.c:115:30: warning: unused variable 'clki' [-Wunused-variable]
     115 |         struct ufs_clk_info *clki;
         |                              ^~~~
   At top level:
   drivers/scsi/ufs/ufshcd-pltfrm.c:111:12: warning: 'ufshcd_parse_operating_points' defined but not used [-Wunused-function]
     111 | static int ufshcd_parse_operating_points(struct ufs_hba *hba)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/clocks_done +117 drivers/scsi/ufs/ufshcd-pltfrm.c

   110	
   111	static int ufshcd_parse_operating_points(struct ufs_hba *hba)
   112	{
   113		struct device *dev = hba->dev;
   114		struct device_node *np = dev->of_node;
   115		struct ufs_clk_info *clki;
   116		const char *names[16];
 > 117		bool clocks_done;
   118		int cnt, i, ret;
   119	
   120		if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
   121			return 0;
   122	
   123		cnt = of_property_count_strings(np, "clock-names");
   124		if (cnt <= 0) {
   125			dev_warn(dev, "%s: Missing clock-names\n",
   126				 __func__);
   127			return -EINVAL;
   128		}
   129	
   130		if (cnt > ARRAY_SIZE(names)) {
   131			dev_info(dev, "%s: Too many clock-names\n",  __func__);
   132			return -EINVAL;
   133		}
   134	
   135		/* clocks parsed by ufshcd_parse_clock_info() */
   136		clocks_done = !!of_find_property(np, "freq-table-hz", NULL);
   137	
   138		/*
   139		for (i = 0; i < cnt; i++) {
   140			ret = of_property_read_string_index(np, "clock-names", i,
   141							    &names[i]);
   142			if (ret)
   143				return ret;
   144	
   145			if (clocks_done)
   146				continue;
   147	
   148			clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
   149			if (!clki)
   150				return -ENOMEM;
   151	
   152			clki->name = devm_kstrdup(dev, names[i], GFP_KERNEL);
   153			if (!clki->name)
   154				return -ENOMEM;
   155	
   156			if (!strcmp(names[i], "ref_clk"))
   157				clki->keep_link_active = true;
   158	
   159			list_add_tail(&clki->list, &hba->clk_list_head);
   160		}
   161	
   162		ret = devm_pm_opp_set_clknames(dev, names, i);
   163		if (ret)
   164			return ret;
   165			*/
   166	
   167		ret = devm_pm_opp_register_set_opp_helper(dev, ufshcd_set_opp);
   168		if (ret)
   169			return ret;
   170	
   171		ret = devm_pm_opp_of_add_table(dev);
   172		if (ret)
   173			return ret;
   174	
 > 175		hba->use_pm_opp = true;
   176	
   177		return 0;
   178	}
   179	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
