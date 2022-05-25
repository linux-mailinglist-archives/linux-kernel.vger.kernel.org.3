Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C355346DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbiEYWya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiEYWyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:54:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF63A5A8B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653519262; x=1685055262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m2aojPMgue6+E5/0+nOyweCRz5sLX+mQS17DDb1TwN8=;
  b=ChLXQHlS5QAvE9PnOgas2RkaDyI+JH4pNhxt6PF6OZZACf5rs8NoAAd/
   yNO/Kswk3MLfvgblot31NIUxXvARSpTzDX/h/KARB1buvUNRQ50/D28t9
   yOB15u13SyzI2zjJDEZFUQBVYFH8UjXp1V++B9WIESthFK+rrXdbKAY+D
   Tv32qd/r7DtOJYN1YuafDyUmCHlfX7HyBNg/o/8GEQXs6jW2D8Ztsye93
   EDrY/vyVDSOoPQAM6f49Z3XIFICmJ6QIkV0dEZyCdD7Y5qmy+wkfua1Le
   KSJ+Yryye4DrBeJ7F81VPT1RseqLUD0/6zNkKD08uRmxd1cXelf6GK2DJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271529494"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="271529494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 15:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="745981952"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2022 15:54:20 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntztT-0003Nq-MO;
        Wed, 25 May 2022 22:54:19 +0000
Date:   Thu, 26 May 2022 06:53:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 17/33] drivers/cpufreq/ti-cpufreq.c:331:19:
 error: incompatible pointer types initializing 'const u32 *' (aka 'const
 unsigned int *') with an expression of type 'u32 (*)[2]' (aka 'unsigned int
 (*)[2]')
Message-ID: <202205260656.mE4aquA1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config
head:   d730dc101c586defb49eeafd8eea9b7bb0baa01b
commit: f834c0b7a54d96f6322c544479bbe897309b4a0a [17/33] cpufreq: ti: Migrate to dev_pm_opp_set_config()
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220526/202205260656.mE4aquA1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=f834c0b7a54d96f6322c544479bbe897309b4a0a
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout f834c0b7a54d96f6322c544479bbe897309b4a0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cpufreq/ti-cpufreq.c:331:19: error: incompatible pointer types initializing 'const u32 *' (aka 'const unsigned int *') with an expression of type 'u32 (*)[2]' (aka 'unsigned int (*)[2]') [-Werror,-Wincompatible-pointer-types]
                   .supported_hw = &version,
                                   ^~~~~~~~
>> drivers/cpufreq/ti-cpufreq.c:360:8: error: use of undeclared label 'fail_put_node'
                   goto fail_put_node;
                        ^
   2 errors generated.


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
 > 360			goto fail_put_node;
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
   374			goto fail_put_node;
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
