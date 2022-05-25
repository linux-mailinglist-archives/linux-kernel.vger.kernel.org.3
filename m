Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D453443F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiEYTfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiEYTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:35:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCC1260C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653507308; x=1685043308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8v4mHTLDfEiLlOFne91JG1tFC6p0/OgpHGPuL8g6CO8=;
  b=TNiCl3pN2P7MIXpGYnPM2dDwAaELSNHYKF4B8WFs0Mg4aviH2WMSU3RQ
   iUSrkX3hekcB1f1GY2SABhgx8zG+uu8Y0fNFWXz+rC3zMjn5t4OLgZE4M
   7HpU7ziWN6/wmTzOrF+EFinAIXJdJh91q8dpYiDwp6vOWqC6LVllK0ZJH
   fGqn+UWk1Q8KUnHlC8xCythaa0wdZigLlObEHXBKJd/AyoXIsgSpvL0Fe
   uKHRDjsnZvdk0bnna+0PKlp6SD0ZvsxrtmRjq6qfVzqVO3R6ImDfuwDY3
   PuMDMOxXEqDiE+w46xL2y+SkzPBlVsFmVGp7G3PIgGekR7RSEzB5xM8SQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253789330"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253789330"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 12:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="527009023"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2022 12:35:07 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntwmg-0003GS-Fx;
        Wed, 25 May 2022 19:35:06 +0000
Date:   Thu, 26 May 2022 03:34:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 17/33] drivers/cpufreq/ti-cpufreq.c:331:33:
 error: initialization of 'const u32 *' {aka 'const unsigned int *'} from
 incompatible pointer type 'u32 (*)[2]' {aka 'unsigned int (*)[2]'}
Message-ID: <202205260322.hhkrrLYq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config
head:   d730dc101c586defb49eeafd8eea9b7bb0baa01b
commit: f834c0b7a54d96f6322c544479bbe897309b4a0a [17/33] cpufreq: ti: Migrate to dev_pm_opp_set_config()
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220526/202205260322.hhkrrLYq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=f834c0b7a54d96f6322c544479bbe897309b4a0a
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout f834c0b7a54d96f6322c544479bbe897309b4a0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cpufreq/ti-cpufreq.c: In function 'ti_cpufreq_probe':
>> drivers/cpufreq/ti-cpufreq.c:331:33: error: initialization of 'const u32 *' {aka 'const unsigned int *'} from incompatible pointer type 'u32 (*)[2]' {aka 'unsigned int (*)[2]'} [-Werror=incompatible-pointer-types]
     331 |                 .supported_hw = &version,
         |                                 ^
   drivers/cpufreq/ti-cpufreq.c:331:33: note: (near initialization for 'config.supported_hw')
>> drivers/cpufreq/ti-cpufreq.c:374:17: error: label 'fail_put_node' used but not defined
     374 |                 goto fail_put_node;
         |                 ^~~~
   cc1: some warnings being treated as errors


vim +331 drivers/cpufreq/ti-cpufreq.c

   322	
   323	static int ti_cpufreq_probe(struct platform_device *pdev)
   324	{
   325		u32 version[VERSION_COUNT];
   326		const struct of_device_id *match;
   327		struct ti_cpufreq_data *opp_data;
   328		const char * const default_reg_names[] = {"vdd", "vbb"};
   329		int ret;
   330		struct dev_pm_opp_config config = {
 > 331			.supported_hw = &version,
   332			.supported_hw_count = ARRAY_SIZE(version),
   333		};
   334	
   335		match = dev_get_platdata(&pdev->dev);
   336		if (!match)
   337			return -ENODEV;
   338	
   339		opp_data = devm_kzalloc(&pdev->dev, sizeof(*opp_data), GFP_KERNEL);
   340		if (!opp_data)
   341			return -ENOMEM;
   342	
   343		opp_data->soc_data = match->data;
   344	
   345		opp_data->cpu_dev = get_cpu_device(0);
   346		if (!opp_data->cpu_dev) {
   347			pr_err("%s: Failed to get device for CPU0\n", __func__);
   348			return -ENODEV;
   349		}
   350	
   351		opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
   352		if (!opp_data->opp_node) {
   353			dev_info(opp_data->cpu_dev,
   354				 "OPP-v2 not supported, cpufreq-dt will attempt to use legacy tables.\n");
   355			goto register_cpufreq_dt;
   356		}
   357	
   358		ret = ti_cpufreq_setup_syscon_register(opp_data);
   359		if (ret)
   360			goto fail_put_node;
   361	
   362		/*
   363		 * OPPs determine whether or not they are supported based on
   364		 * two metrics:
   365		 *	0 - SoC Revision
   366		 *	1 - eFuse value
   367		 */
   368		ret = ti_cpufreq_get_rev(opp_data, &version[0]);
   369		if (ret)
   370			goto fail_put_node;
   371	
   372		ret = ti_cpufreq_get_efuse(opp_data, &version[1]);
   373		if (ret)
 > 374			goto fail_put_node;
   375	
   376		if (opp_data->soc_data->multi_regulator) {
   377			config.regulator_count = ARRAY_SIZE(default_reg_names);
   378	
   379			if (opp_data->soc_data->reg_names)
   380				config.regulator_names = opp_data->soc_data->reg_names;
   381			else
   382				config.regulator_names = default_reg_names;
   383		}
   384	
   385		opp_data->opp_table = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
   386		of_node_put(opp_data->opp_node);
   387	
   388		if (IS_ERR(opp_data->opp_table)) {
   389			dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
   390			return PTR_ERR(opp_data->opp_table);
   391		}
   392	
   393	register_cpufreq_dt:
   394		platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
   395	
   396		return 0;
   397	}
   398	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
