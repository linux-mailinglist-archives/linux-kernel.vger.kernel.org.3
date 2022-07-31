Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575BD585E51
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGaJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 05:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiGaJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:44:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440811C1F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659260644; x=1690796644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9onjzayIoJmCYioykpKoNXKOUky3/WN04vKb+k50QFs=;
  b=aEta5SJkW7gchwRC4ltQvM593uy8dBDDnZtllu+3YQTyfs6HwFQ5PYwR
   RGdtKxjVWw7aQWVYAADETzlq8J9rwR82z7O+QtrofMcd5ywlJPOm3THWz
   9fXUDR7jIQEdJZ0tXAYBEdYXGtIkSkzIC2DMWgsukkR1X0meeY4tQiDOs
   cVIth9EG2JTgfitvnIxKR952Fl1gC0tvsHa4/tWAD7ueN1zCszJOzVFvt
   GSbRsTcw7RBPwfpzzWkQDNndMdfm5GyCe4OglhO1kKJnR5OwX+iSjMXkX
   KOj2F3iM1ThcYFr4xTHcvQhlNPoLGKjSblDv3LgEse/bBRM2fCOK0BQS7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="290189327"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="290189327"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 02:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="691167543"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2022 02:44:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI5UP-000DzT-1A;
        Sun, 31 Jul 2022 09:44:01 +0000
Date:   Sun, 31 Jul 2022 17:43:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:linux-v5.19.0-rc8-tests 109/182]
 drivers/interconnect/qcom/icc-rpm.c:335:13: warning: variable 'max_peak_bw'
 set but not used
Message-ID: <202207311704.9ojLA4JI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-v5.19.0-rc8-tests
head:   171125613e081f0d0d9aeb710dc7469ce2c6a219
commit: 20386c070c2d12a74092d72aef1c8be37a5f5177 [109/182] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220731/202207311704.9ojLA4JI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/20386c070c2d12a74092d72aef1c8be37a5f5177
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-v5.19.0-rc8-tests
        git checkout 20386c070c2d12a74092d72aef1c8be37a5f5177
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/interconnect/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/div64.h:107,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:25,
                    from include/linux/clk.h:13,
                    from drivers/interconnect/qcom/icc-rpm.c:6:
   drivers/interconnect/qcom/icc-rpm.c: In function 'qcom_icc_set':
   drivers/interconnect/qcom/icc-rpm.c:378:30: error: 'src_qn' undeclared (first use in this function)
     378 |                 do_div(rate, src_qn->buswidth);
         |                              ^~~~~~
   include/asm-generic/div64.h:220:28: note: in definition of macro 'do_div'
     220 |         uint32_t __base = (base);                       \
         |                            ^~~~
   drivers/interconnect/qcom/icc-rpm.c:378:30: note: each undeclared identifier is reported only once for each function it appears in
     378 |                 do_div(rate, src_qn->buswidth);
         |                              ^~~~~~
   include/asm-generic/div64.h:220:28: note: in definition of macro 'do_div'
     220 |         uint32_t __base = (base);                       \
         |                            ^~~~
>> drivers/interconnect/qcom/icc-rpm.c:335:13: warning: variable 'max_peak_bw' set but not used [-Wunused-but-set-variable]
     335 |         u64 max_peak_bw;
         |             ^~~~~~~~~~~


vim +/max_peak_bw +335 drivers/interconnect/qcom/icc-rpm.c

20386c070c2d12 Leo Yan          2022-07-05  328  
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  329  static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  330  {
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  331  	struct qcom_icc_provider *qp;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  332  	struct qcom_icc_node *qn;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  333  	struct icc_provider *provider;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  334  	u64 sum_bw;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04 @335  	u64 max_peak_bw;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  336  	u64 rate;
20386c070c2d12 Leo Yan          2022-07-05  337  	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
20386c070c2d12 Leo Yan          2022-07-05  338  	u64 max_agg_avg, max_agg_peak;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  339  	int ret, i;
20386c070c2d12 Leo Yan          2022-07-05  340  	int bucket;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  341  
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  342  	qn = src->data;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  343  	provider = src->provider;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  344  	qp = to_qcom_provider(provider);
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  345  
20386c070c2d12 Leo Yan          2022-07-05  346  	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg,
20386c070c2d12 Leo Yan          2022-07-05  347  			       &max_agg_peak);
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  348  
20386c070c2d12 Leo Yan          2022-07-05  349  	sum_bw = icc_units_to_bps(max_agg_avg);
20386c070c2d12 Leo Yan          2022-07-05  350  	max_peak_bw = icc_units_to_bps(max_agg_peak);
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  351  
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  352  	if (!qn->qos.ap_owned) {
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  353  		/* send bandwidth request message to the RPM processor */
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  354  		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  355  		if (ret)
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  356  			return ret;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  357  	} else if (qn->qos.qos_mode != -1) {
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  358  		/* set bandwidth directly from the AP */
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  359  		ret = qcom_icc_qos_set(src, sum_bw);
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  360  		if (ret)
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  361  			return ret;
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  362  	}
2b6c7d645118cb Dmitry Baryshkov 2021-09-04  363  
20386c070c2d12 Leo Yan          2022-07-05  364  	for (i = 0; i < qp->num_clks; i++) {
20386c070c2d12 Leo Yan          2022-07-05  365  		/*
20386c070c2d12 Leo Yan          2022-07-05  366  		* Use WAKE bucket for active clock, otherwise, use SLEEP bucket
20386c070c2d12 Leo Yan          2022-07-05  367  		* for other clocks.  If a platform doesn't set interconnect
20386c070c2d12 Leo Yan          2022-07-05  368  		* path tags, by default use sleep bucket for all clocks.
20386c070c2d12 Leo Yan          2022-07-05  369  		*
20386c070c2d12 Leo Yan          2022-07-05  370  		* Note, AMC bucket is not supported yet.
20386c070c2d12 Leo Yan          2022-07-05  371  		*/
20386c070c2d12 Leo Yan          2022-07-05  372  		if (!strcmp(qp->bus_clks[i].id, "bus_a"))
20386c070c2d12 Leo Yan          2022-07-05  373  			bucket = QCOM_ICC_BUCKET_WAKE;
20386c070c2d12 Leo Yan          2022-07-05  374  		else
20386c070c2d12 Leo Yan          2022-07-05  375  			bucket = QCOM_ICC_BUCKET_SLEEP;
62feb14ee8a374 Jun Nie          2020-12-04  376  
20386c070c2d12 Leo Yan          2022-07-05  377  		rate = icc_units_to_bps(max(agg_avg[bucket], agg_peak[bucket]));
20386c070c2d12 Leo Yan          2022-07-05  378  		do_div(rate, src_qn->buswidth);
a7d9436a6c85fc Stephan Gerhold  2021-12-06  379  		rate = min_t(u64, rate, LONG_MAX);
62feb14ee8a374 Jun Nie          2020-12-04  380  
97f7d384ac4fca Leo Yan          2022-05-04  381  		if (qp->bus_clk_rate[i] == rate)
97f7d384ac4fca Leo Yan          2022-05-04  382  			continue;
97f7d384ac4fca Leo Yan          2022-05-04  383  
62feb14ee8a374 Jun Nie          2020-12-04  384  		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
62feb14ee8a374 Jun Nie          2020-12-04  385  		if (ret) {
62feb14ee8a374 Jun Nie          2020-12-04  386  			pr_err("%s clk_set_rate error: %d\n",
62feb14ee8a374 Jun Nie          2020-12-04  387  			       qp->bus_clks[i].id, ret);
62feb14ee8a374 Jun Nie          2020-12-04  388  			return ret;
62feb14ee8a374 Jun Nie          2020-12-04  389  		}
97f7d384ac4fca Leo Yan          2022-05-04  390  		qp->bus_clk_rate[i] = rate;
62feb14ee8a374 Jun Nie          2020-12-04  391  	}
62feb14ee8a374 Jun Nie          2020-12-04  392  
62feb14ee8a374 Jun Nie          2020-12-04  393  	return 0;
62feb14ee8a374 Jun Nie          2020-12-04  394  }
62feb14ee8a374 Jun Nie          2020-12-04  395  

:::::: The code at line 335 was first introduced by commit
:::::: 2b6c7d645118cba7719f16f3b0e4d4a555776f48 interconnect: sdm660: merge common code into icc-rpm

:::::: TO: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
:::::: CC: Georgi Djakov <djakov@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
