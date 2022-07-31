Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9884B585E94
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiGaK4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGaK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:56:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D247669
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659264966; x=1690800966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j67uCdV1x6jPf2RaRQCHqnMQXiIoU3lqe3S27XWqYd8=;
  b=AYQ9u3SEjTpoDrowXIbROXznoV1tdt+ghgwoOQqkz96J9XI+D7VxazMB
   2Rv9xktck0rcagjR5CfI4T2y0IsTcdYsm2B00hv+Tn6NS5gBcWIqxfNiM
   5l8rgsVqzmr/Y61ceC53aXpSGWeuFqjZhqrTs9EE5enoOaMLODTWGbD9H
   N4ULNhl2avLDE5th1LKpg8YWfwe0qmM9ZsgcZR3WDAjNHwbl7xKCyb7hg
   1TOaHmvb8Gck5mx87dnQbuS2fcAuLLl7v6YW3zF+InJ8UNWjeZITLVXWZ
   jUVL2sYr47gea/gvQKsR4EzheTW7+MNU2uytt7lnqF9EThbtYWzcSHQyw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="352990822"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="352990822"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 03:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577459103"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 03:56:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI6c7-000E3D-2g;
        Sun, 31 Jul 2022 10:56:03 +0000
Date:   Sun, 31 Jul 2022 18:55:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:linux-v5.19.0-rc8-tests 109/182]
 drivers/interconnect/qcom/icc-rpm.c:378:30: error: 'src_qn' undeclared
Message-ID: <202207311852.O8ROmInD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-v5.19.0-rc8-tests
head:   171125613e081f0d0d9aeb710dc7469ce2c6a219
commit: 20386c070c2d12a74092d72aef1c8be37a5f5177 [109/182] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220731/202207311852.O8ROmInD-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/div64.h:107,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:25,
                    from include/linux/clk.h:13,
                    from drivers/interconnect/qcom/icc-rpm.c:6:
   drivers/interconnect/qcom/icc-rpm.c: In function 'qcom_icc_set':
>> drivers/interconnect/qcom/icc-rpm.c:378:30: error: 'src_qn' undeclared (first use in this function)
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
   drivers/interconnect/qcom/icc-rpm.c:335:13: warning: variable 'max_peak_bw' set but not used [-Wunused-but-set-variable]
     335 |         u64 max_peak_bw;
         |             ^~~~~~~~~~~


vim +/src_qn +378 drivers/interconnect/qcom/icc-rpm.c

   328	
   329	static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
   330	{
   331		struct qcom_icc_provider *qp;
   332		struct qcom_icc_node *qn;
   333		struct icc_provider *provider;
   334		u64 sum_bw;
   335		u64 max_peak_bw;
   336		u64 rate;
   337		u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
   338		u64 max_agg_avg, max_agg_peak;
   339		int ret, i;
   340		int bucket;
   341	
   342		qn = src->data;
   343		provider = src->provider;
   344		qp = to_qcom_provider(provider);
   345	
   346		qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg,
   347				       &max_agg_peak);
   348	
   349		sum_bw = icc_units_to_bps(max_agg_avg);
   350		max_peak_bw = icc_units_to_bps(max_agg_peak);
   351	
   352		if (!qn->qos.ap_owned) {
   353			/* send bandwidth request message to the RPM processor */
   354			ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
   355			if (ret)
   356				return ret;
   357		} else if (qn->qos.qos_mode != -1) {
   358			/* set bandwidth directly from the AP */
   359			ret = qcom_icc_qos_set(src, sum_bw);
   360			if (ret)
   361				return ret;
   362		}
   363	
   364		for (i = 0; i < qp->num_clks; i++) {
   365			/*
   366			* Use WAKE bucket for active clock, otherwise, use SLEEP bucket
   367			* for other clocks.  If a platform doesn't set interconnect
   368			* path tags, by default use sleep bucket for all clocks.
   369			*
   370			* Note, AMC bucket is not supported yet.
   371			*/
   372			if (!strcmp(qp->bus_clks[i].id, "bus_a"))
   373				bucket = QCOM_ICC_BUCKET_WAKE;
   374			else
   375				bucket = QCOM_ICC_BUCKET_SLEEP;
   376	
   377			rate = icc_units_to_bps(max(agg_avg[bucket], agg_peak[bucket]));
 > 378			do_div(rate, src_qn->buswidth);
   379			rate = min_t(u64, rate, LONG_MAX);
   380	
   381			if (qp->bus_clk_rate[i] == rate)
   382				continue;
   383	
   384			ret = clk_set_rate(qp->bus_clks[i].clk, rate);
   385			if (ret) {
   386				pr_err("%s clk_set_rate error: %d\n",
   387				       qp->bus_clks[i].id, ret);
   388				return ret;
   389			}
   390			qp->bus_clk_rate[i] = rate;
   391		}
   392	
   393		return 0;
   394	}
   395	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
