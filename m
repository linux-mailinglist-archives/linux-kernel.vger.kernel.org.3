Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7E4ABD91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388735AbiBGLpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386042AbiBGLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:33:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B839C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644233602; x=1675769602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PvS+cZh5V/ODGurp+2LHIOoc0Up83psXPXZTlCRizIU=;
  b=eutZucXyy2nl6fjojQRePPPJNerKjS+/7tz+7FYn9qb86+evzmpSqoRR
   8svgfobKFvy4xXLR3t/7AgwdrsXUakCuJjzE7KupmkxAwNGAOMt0Z3SYO
   8VmNEq1jPJU3KTmbMQ1kFnFg0HRmCQLCSKUd/HlPEsRrric6pYXPwmYc6
   S8WwaXr/IRx3EpHieOd18pIXjciW8Bsx5EiE+br939J56gsTJ0p6BYirD
   hawXS8yxPIfqWNY/y9+DAXEY5MYNW0cwtpailC3bTzF4dm5Iy51W4MVgL
   tXTIMSZUMd/pPSlghDNekJfWmj9QZv+wjHgslyH3CizpPw2BFONiOTGMI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228665509"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="228665509"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:33:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="481556851"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Feb 2022 03:33:20 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH2Gl-0000Th-UD; Mon, 07 Feb 2022 11:33:19 +0000
Date:   Mon, 7 Feb 2022 19:33:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: [sunxi:sunxi/clk-for-5.18 2/2] drivers/rtc/rtc-sun6i.c:689:51:
 error: 'dev' undeclared; did you mean 'pdev'?
Message-ID: <202202071955.hQjU2RLW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/clk-for-5.18
head:   4f88abd86756e574c733d2ca14676be335cc0058
commit: 4f88abd86756e574c733d2ca14676be335cc0058 [2/2] clk: sunxi-ng: Add support for the sun6i RTC clocks
config: microblaze-randconfig-r001-20220207 (https://download.01.org/0day-ci/archive/20220207/202202071955.hQjU2RLW-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?id=4f88abd86756e574c733d2ca14676be335cc0058
        git remote add sunxi https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
        git fetch --no-tags sunxi sunxi/clk-for-5.18
        git checkout 4f88abd86756e574c733d2ca14676be335cc0058
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-sun6i.c: In function 'sun6i_rtc_probe':
>> drivers/rtc/rtc-sun6i.c:689:51: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?
     689 |                         ret = sun6i_rtc_ccu_probe(dev, chip->base);
         |                                                   ^~~
         |                                                   pdev
   drivers/rtc/rtc-sun6i.c:689:51: note: each undeclared identifier is reported only once for each function it appears in


vim +689 drivers/rtc/rtc-sun6i.c

   668	
   669	static SIMPLE_DEV_PM_OPS(sun6i_rtc_pm_ops,
   670		sun6i_rtc_suspend, sun6i_rtc_resume);
   671	
   672	static int sun6i_rtc_probe(struct platform_device *pdev)
   673	{
   674		struct sun6i_rtc_dev *chip = sun6i_rtc;
   675		int ret;
   676	
   677		if (!chip) {
   678			chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
   679			if (!chip)
   680				return -ENOMEM;
   681	
   682			spin_lock_init(&chip->lock);
   683	
   684			chip->base = devm_platform_ioremap_resource(pdev, 0);
   685			if (IS_ERR(chip->base))
   686				return PTR_ERR(chip->base);
   687	
   688			if (IS_REACHABLE(CONFIG_SUN6I_RTC_CCU)) {
 > 689				ret = sun6i_rtc_ccu_probe(dev, chip->base);
   690				if (ret)
   691					return ret;
   692			}
   693		}
   694	
   695		platform_set_drvdata(pdev, chip);
   696	
   697		chip->irq = platform_get_irq(pdev, 0);
   698		if (chip->irq < 0)
   699			return chip->irq;
   700	
   701		ret = devm_request_irq(&pdev->dev, chip->irq, sun6i_rtc_alarmirq,
   702				       0, dev_name(&pdev->dev), chip);
   703		if (ret) {
   704			dev_err(&pdev->dev, "Could not request IRQ\n");
   705			return ret;
   706		}
   707	
   708		/* clear the alarm counter value */
   709		writel(0, chip->base + SUN6I_ALRM_COUNTER);
   710	
   711		/* disable counter alarm */
   712		writel(0, chip->base + SUN6I_ALRM_EN);
   713	
   714		/* disable counter alarm interrupt */
   715		writel(0, chip->base + SUN6I_ALRM_IRQ_EN);
   716	
   717		/* disable week alarm */
   718		writel(0, chip->base + SUN6I_ALRM1_EN);
   719	
   720		/* disable week alarm interrupt */
   721		writel(0, chip->base + SUN6I_ALRM1_IRQ_EN);
   722	
   723		/* clear counter alarm pending interrupts */
   724		writel(SUN6I_ALRM_IRQ_STA_CNT_IRQ_PEND,
   725		       chip->base + SUN6I_ALRM_IRQ_STA);
   726	
   727		/* clear week alarm pending interrupts */
   728		writel(SUN6I_ALRM1_IRQ_STA_WEEK_IRQ_PEND,
   729		       chip->base + SUN6I_ALRM1_IRQ_STA);
   730	
   731		/* disable alarm wakeup */
   732		writel(0, chip->base + SUN6I_ALARM_CONFIG);
   733	
   734		clk_prepare_enable(chip->losc);
   735	
   736		device_init_wakeup(&pdev->dev, 1);
   737	
   738		chip->rtc = devm_rtc_allocate_device(&pdev->dev);
   739		if (IS_ERR(chip->rtc))
   740			return PTR_ERR(chip->rtc);
   741	
   742		chip->rtc->ops = &sun6i_rtc_ops;
   743		chip->rtc->range_max = 2019686399LL; /* 2033-12-31 23:59:59 */
   744	
   745		ret = devm_rtc_register_device(chip->rtc);
   746		if (ret)
   747			return ret;
   748	
   749		dev_info(&pdev->dev, "RTC enabled\n");
   750	
   751		return 0;
   752	}
   753	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
