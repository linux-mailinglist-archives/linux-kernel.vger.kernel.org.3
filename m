Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9785325E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiEXI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiEXI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:59:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A629BAFB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653382678; x=1684918678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FRHWMtWpMD6hVeQCVr6hG+QDa+OVeRJKIGC6Ydhd6HQ=;
  b=hJPpxYtiY4NqvUHYE32+DEwl/IqVc9G9tr37uNRLGUeo1rrA0M7DNV8W
   QzWI4ZNzQ+C2DyW3ZeAzmkd1KOquEBR3ceEfquP5E73QQPK2RtT8W2TlL
   N3VJABgDCjajrhV2KXmLXd5KgfKxauGayTUYi0SvKfqvOCBw5kb1/wNXT
   7RNdoZIeFBQJQIP5yy1XyTmvGdxcUmNrHFifmAazGhYgfjg5eNXQYPOqV
   Wf/RDNLC9EDBXQHRbRxkWn3tOSkvwqCdP40cASz1K1s9VydEw0jYsDzGb
   B/3t1UoQpvJLUO2XahbrWf/taVMXQbx55FgCIaQY6jqIo3nIG1lwq8u9R
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="359868390"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="359868390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 01:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="526322699"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2022 01:57:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntQLn-0001uI-6W;
        Tue, 24 May 2022 08:57:11 +0000
Date:   Tue, 24 May 2022 16:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-bwmon-v3 21/22]
 drivers/soc/qcom/icc-bwmon.c:160:35: warning: variable 'irq_enable' set but
 not used
Message-ID: <202205241624.KBClsJGP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-bwmon-v3
head:   f595f77c2d91820ce85df16e278315e522172710
commit: 3cd6e62deb674c541c6e46597273ee0235c339ec [21/22] bwmon v3
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220524/202205241624.KBClsJGP-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/3cd6e62deb674c541c6e46597273ee0235c339ec
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-bwmon-v3
        git checkout 3cd6e62deb674c541c6e46597273ee0235c339ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/qcom/icc-bwmon.c: In function 'bwmon_start':
>> drivers/soc/qcom/icc-bwmon.c:160:35: warning: variable 'irq_enable' set but not used [-Wunused-but-set-variable]
     160 |         unsigned int thres_count, irq_enable;
         |                                   ^~~~~~~~~~


vim +/irq_enable +160 drivers/soc/qcom/icc-bwmon.c

1598903c24dd56 Krzysztof Kozlowski 2022-04-22  156  
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  157  static void bwmon_start(struct icc_bwmon *bwmon,
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  158  			const struct icc_bwmon_data *data)
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  159  {
1598903c24dd56 Krzysztof Kozlowski 2022-04-22 @160  	unsigned int thres_count, irq_enable;
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  161  	int window;
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  162  
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  163  	bwmon_clear(bwmon);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  164  
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  165  	window = mult_frac(bwmon->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  166  	writel_relaxed(window, bwmon->base + BWMON_SAMPLE_WINDOW);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  167  
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  168  	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH,
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  169  			    data->default_highbw_kbps);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  170  	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED,
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  171  			    data->default_medbw_kbps);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  172  	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_LOW,
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  173  			    data->default_lowbw_kbps);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  174  
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  175  	thres_count = data->zone3_thres_count << BWMON_THRESHOLD_COUNT_ZONE3_SHIFT |
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  176  		      BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT << BWMON_THRESHOLD_COUNT_ZONE2_SHIFT |
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  177  		      data->zone1_thres_count << BWMON_THRESHOLD_COUNT_ZONE1_SHIFT |
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  178  		      BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT;
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  179  	writel_relaxed(thres_count, bwmon->base + BWMON_THRESHOLD_COUNT);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  180  	writel_relaxed(BWMON_ZONE_ACTIONS_DEFAULT,
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  181  		       bwmon->base + BWMON_ZONE_ACTIONS);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  182  
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  183  	/* Write barriers in bwmon_clear() */
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  184  	irq_enable = BIT(BWMON_IRQ_ENABLE_ZONE1_SHIFT) |
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  185  		     BIT(BWMON_IRQ_ENABLE_ZONE3_SHIFT);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  186  	bwmon_clear(bwmon);
3cd6e62deb674c Krzysztof Kozlowski 2022-05-24  187  	bwmon_enable(bwmon, BWMON_IRQ_ENABLE_MASK);
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  188  }
1598903c24dd56 Krzysztof Kozlowski 2022-04-22  189  

:::::: The code at line 160 was first introduced by commit
:::::: 1598903c24dd564eb700ef2439ca169bc6c52fb0 soc: qcom: icc-bwmon: Add bandwidth monitoring driver

:::::: TO: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
:::::: CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
