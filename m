Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551755342A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbiEYSEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiEYSEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:04:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE659C2F0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653501876; x=1685037876;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pm30+PUW/S28pt9vFLXKnwJexHgxReaTpMC4SzbOa18=;
  b=V30Ko1Zn7C/98NE6bdQifudQWCYVSTI2Fuojqvj8rPyoKnWk6ESdsxTO
   vhX7es1E2RxxmYLrNa54B6v/AumaKI8jJiLxAUnRT6+Fyye0ouv/1QSuS
   0qudNCuTl17EkKZLV6wOnX4E5/9Mky+o0G3JzMSqu/ZRGWhpRdWpMhgqg
   Z0JfFrS3Zh2aUmGDKYtnxlwUgTYvNmr1vaoiufPIdtf0bS0trvFy8sy9U
   pJfGqE2P57eTzgWb2sJCpVKtb6hy4bR3Bm8ea8YfwNdXr+LTQ7ZjGHFNJ
   rFRwiw54VWuaF99udjm9cUwA6LR7oZigRf+VG35aEPU++hLfBEJ/Qzxly
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253766051"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253766051"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 11:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="526975819"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2022 11:04:04 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntvMZ-0003Dq-Rj;
        Wed, 25 May 2022 18:04:03 +0000
Date:   Thu, 26 May 2022 02:03:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vireshk-pm:opp/config 14/33] drivers/cpufreq/sti-cpufreq.c:163:33:
 error: initialization of 'const u32 *' {aka 'const unsigned int *'} from
 incompatible pointer type 'unsigned int (*)[3]'
Message-ID: <202205260212.nwth1TXT-lkp@intel.com>
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
commit: fde02a60d6932a408e7330eb5887de842eae2dbb [14/33] cpufreq: sti: Migrate to dev_pm_opp_set_config()
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220526/202205260212.nwth1TXT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?id=fde02a60d6932a408e7330eb5887de842eae2dbb
        git remote add vireshk-pm https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
        git fetch --no-tags vireshk-pm opp/config
        git checkout fde02a60d6932a408e7330eb5887de842eae2dbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cpufreq/sti-cpufreq.c: In function 'sti_cpufreq_set_opp_info':
>> drivers/cpufreq/sti-cpufreq.c:163:33: error: initialization of 'const u32 *' {aka 'const unsigned int *'} from incompatible pointer type 'unsigned int (*)[3]' [-Werror=incompatible-pointer-types]
     163 |                 .supported_hw = &version,
         |                                 ^
   drivers/cpufreq/sti-cpufreq.c:163:33: note: (near initialization for 'config.supported_hw')
   cc1: some warnings being treated as errors


vim +163 drivers/cpufreq/sti-cpufreq.c

   150	
   151	static int sti_cpufreq_set_opp_info(void)
   152	{
   153		struct device *dev = ddata.cpu;
   154		struct device_node *np = dev->of_node;
   155		const struct reg_field *reg_fields;
   156		unsigned int hw_info_offset;
   157		unsigned int version[VERSION_ELEMENTS];
   158		int pcode, substrate, major, minor;
   159		int ret;
   160		char name[MAX_PCODE_NAME_LEN];
   161		struct opp_table *opp_table;
   162		struct dev_pm_opp_config config = {
 > 163			.supported_hw = &version,
   164			.supported_hw_count = ARRAY_SIZE(version),
   165			.prop_name = name,
   166		};
   167	
   168		reg_fields = sti_cpufreq_match();
   169		if (!reg_fields) {
   170			dev_err(dev, "This SoC doesn't support voltage scaling\n");
   171			return -ENODEV;
   172		}
   173	
   174		ret = of_property_read_u32_index(np, "st,syscfg-eng",
   175						 HW_INFO_INDEX, &hw_info_offset);
   176		if (ret) {
   177			dev_warn(dev, "Failed to read HW info offset from DT\n");
   178			substrate = DEFAULT_VERSION;
   179			pcode = 0;
   180			goto use_defaults;
   181		}
   182	
   183		pcode = sti_cpufreq_fetch_regmap_field(reg_fields,
   184						       hw_info_offset,
   185						       PCODE);
   186		if (pcode < 0) {
   187			dev_warn(dev, "Failed to obtain process code\n");
   188			/* Use default pcode */
   189			pcode = 0;
   190		}
   191	
   192		substrate = sti_cpufreq_fetch_regmap_field(reg_fields,
   193							   hw_info_offset,
   194							   SUBSTRATE);
   195		if (substrate) {
   196			dev_warn(dev, "Failed to obtain substrate code\n");
   197			/* Use default substrate */
   198			substrate = DEFAULT_VERSION;
   199		}
   200	
   201	use_defaults:
   202		major = sti_cpufreq_fetch_major();
   203		if (major < 0) {
   204			dev_err(dev, "Failed to obtain major version\n");
   205			/* Use default major number */
   206			major = DEFAULT_VERSION;
   207		}
   208	
   209		minor = sti_cpufreq_fetch_minor();
   210		if (minor < 0) {
   211			dev_err(dev, "Failed to obtain minor version\n");
   212			/* Use default minor number */
   213			minor = DEFAULT_VERSION;
   214		}
   215	
   216		snprintf(name, MAX_PCODE_NAME_LEN, "pcode%d", pcode);
   217	
   218		version[0] = BIT(major);
   219		version[1] = BIT(minor);
   220		version[2] = BIT(substrate);
   221	
   222		opp_table = dev_pm_opp_set_config(dev, &config);
   223		if (IS_ERR(opp_table)) {
   224			dev_err(dev, "Failed to set OPP config\n");
   225			return PTR_ERR(opp_table);
   226		}
   227	
   228		dev_dbg(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
   229			pcode, major, minor, substrate);
   230		dev_dbg(dev, "version[0]: %x version[1]: %x version[2]: %x\n",
   231			version[0], version[1], version[2]);
   232	
   233		return 0;
   234	}
   235	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
