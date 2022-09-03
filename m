Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC85AC0BE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiICS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:29:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA642AE9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662229740; x=1693765740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8WKt1oEVOBZWaPvR7msRUcf06y5oJYLOrbFtRIAH5sU=;
  b=FkeZrdUcYhJwl7w6LyvpQ9zjw+97MBE0itcvAjoe059Fh9RI2zTDIfUm
   4zpTVbPnuwFmJ8qobxq5Sx4pyrAeVYZNA8zruR/K+O9M/Qa47b9SgUUNE
   Pv4yYSclrupqv8mf1Gx9zCYWfgmSCqns/K6NS9do2gMT52z4eXCa2rCfw
   YZ+6144gbEPzYMhpgmQRg0UFeB8pGbszjczx4afWSSZ32Og4CAtrDD6oE
   stqHUPVjr2DDNgYHgMsc2WeqKve9iwOgqyySvPpQQ10x2gERV8hPTuvYl
   CL6MC+gSb9VRsMt5Kk1gXEY4VmozV3jdcovOyWc0wB+FO/sRcTD3W5kje
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="279193395"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="279193395"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 11:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="941641184"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2022 11:28:58 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUXt3-00020v-31;
        Sat, 03 Sep 2022 18:28:57 +0000
Date:   Sun, 4 Sep 2022 02:28:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:c630-6.0.0-rc3 27/94]
 drivers/interconnect/qcom/icc-rpm.c:352:13: error: redefinition of
 'qcom_icc_bus_aggregate'
Message-ID: <202209040243.Cd4XFUph-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux c630-6.0.0-rc3
head:   012f3cdd2a60528b877305877b52135b0076e028
commit: 1ecec38075e2393a1ed0b00d6c34aef77a3ec540 [27/94] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220904/202209040243.Cd4XFUph-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/1ecec38075e2393a1ed0b00d6c34aef77a3ec540
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev c630-6.0.0-rc3
        git checkout 1ecec38075e2393a1ed0b00d6c34aef77a3ec540
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/interconnect/qcom/icc-rpm.c:352:13: error: redefinition of 'qcom_icc_bus_aggregate'
     352 | static void qcom_icc_bus_aggregate(struct icc_provider *provider,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/interconnect/qcom/icc-rpm.c:312:13: note: previous definition of 'qcom_icc_bus_aggregate' with type 'void(struct icc_provider *, u64 *, u64 *, u64 *)' {aka 'void(struct icc_provider *, long long unsigned int *, long long unsigned int *, long long unsigned int *)'}
     312 | static void qcom_icc_bus_aggregate(struct icc_provider *provider,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/interconnect/qcom/icc-rpm.c:312:13: warning: 'qcom_icc_bus_aggregate' defined but not used [-Wunused-function]


vim +/qcom_icc_bus_aggregate +352 drivers/interconnect/qcom/icc-rpm.c

   344	
   345	/**
   346	 * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
   347	 * @provider: generic interconnect provider
   348	 * @agg_avg: an array for aggregated average bandwidth of buckets
   349	 * @agg_peak: an array for aggregated peak bandwidth of buckets
   350	 * @max_agg_avg: pointer to max value of aggregated average bandwidth
   351	 */
 > 352	static void qcom_icc_bus_aggregate(struct icc_provider *provider,
   353						u64 *agg_avg, u64 *agg_peak,
   354						u64 *max_agg_avg)
   355	{
   356		struct icc_node *node;
   357		struct qcom_icc_node *qn;
   358		int i;
   359	
   360		/* Initialise aggregate values */
   361		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
   362			agg_avg[i] = 0;
   363			agg_peak[i] = 0;
   364		}
   365	
   366		*max_agg_avg = 0;
   367	
   368		/*
   369		 * Iterate nodes on the interconnect and aggregate bandwidth
   370		 * requests for every bucket.
   371		 */
   372		list_for_each_entry(node, &provider->nodes, node_list) {
   373			qn = node->data;
   374			for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
   375				agg_avg[i] += qn->sum_avg[i];
   376				agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
   377			}
   378		}
   379	
   380		/* Find maximum values across all buckets */
   381		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++)
   382			*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
   383	}
   384	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
