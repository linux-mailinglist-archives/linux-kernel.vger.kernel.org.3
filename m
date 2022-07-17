Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7E57776D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 19:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiGQRPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGQRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 13:15:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB4F11476
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658078099; x=1689614099;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wTgXB9EGh/mezg4ReL7bWkSJ8/7ra5y/gb4D6RCzBUk=;
  b=HLWeUM5IvfU1uPjNMs4qXsplvLT4avV8c62Y4sFga/vZ0FuQCgkEH9bC
   cbhVZpYmtGzGf3St3OpJtVy+9VMwxxJnZZ7IYeW7TRRgAWFuUTuZO11J8
   NFboPCbut6mYouf1U6wrlN5PFUvviVu0NOPNuv0ddasrwySPR88ACua4K
   6SfuuuBmxZNAFewSMNtgXpADNCuJI8okI3GuC6Lh4hR39lkVgDdKrCRHy
   kfI9NQQUCFiPYi6M/oX4/8gfLpFQsCsWRyCF6WmkuNY24/7A41qTQ505Z
   ekyuDphkFg56/KZW7Z6lTMmiahlzTzd0aRvqLpTB4Vm4cll56FzO8iUMK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="350041820"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="350041820"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 10:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="843044307"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2022 10:14:57 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD7r6-0003WE-PY;
        Sun, 17 Jul 2022 17:14:56 +0000
Date:   Mon, 18 Jul 2022 01:14:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     ran jianping <ran.jianping@zte.com.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson-remoteproc:ci-next 32/51]
 drivers/remoteproc/qcom_q6v5_adsp.c:178:56: error: expected ';' before 'if'
Message-ID: <202207180116.3mf56M5t-lkp@intel.com>
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

tree:   https://github.com/andersson/remoteproc ci-next
head:   7bd43ecf97f8237f4e2a7fdc27a26740b6afa92a
commit: dd0e63e9e8273d34512eed1d936640cba51f9c2a [32/51] remoteproc: qcom: using pm_runtime_resume_and_get to simplify the code
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220718/202207180116.3mf56M5t-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/remoteproc/commit/dd0e63e9e8273d34512eed1d936640cba51f9c2a
        git remote add andersson-remoteproc https://github.com/andersson/remoteproc
        git fetch --no-tags andersson-remoteproc ci-next
        git checkout dd0e63e9e8273d34512eed1d936640cba51f9c2a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/remoteproc/qcom_q6v5_adsp.c: In function 'qcom_rproc_pds_enable':
>> drivers/remoteproc/qcom_q6v5_adsp.c:178:56: error: expected ';' before 'if'
     178 |                 ret = pm_runtime_resume_and_get(pds[i])
         |                                                        ^
         |                                                        ;
     179 |                 if (ret < 0) {
         |                 ~~                                      
   drivers/remoteproc/qcom_q6v5_adsp.c:187:1: warning: label 'unroll_pd_votes' defined but not used [-Wunused-label]
     187 | unroll_pd_votes:
         | ^~~~~~~~~~~~~~~


vim +178 drivers/remoteproc/qcom_q6v5_adsp.c

   169	
   170	static int qcom_rproc_pds_enable(struct qcom_adsp *adsp, struct device **pds,
   171					 size_t pd_count)
   172	{
   173		int ret;
   174		int i;
   175	
   176		for (i = 0; i < pd_count; i++) {
   177			dev_pm_genpd_set_performance_state(pds[i], INT_MAX);
 > 178			ret = pm_runtime_resume_and_get(pds[i])
   179			if (ret < 0) {
   180				dev_pm_genpd_set_performance_state(pds[i], 0);
   181				goto unroll_pd_votes;
   182			}
   183		}
   184	
   185		return 0;
   186	
   187	unroll_pd_votes:
   188		for (i--; i >= 0; i--) {
   189			dev_pm_genpd_set_performance_state(pds[i], 0);
   190			pm_runtime_put(pds[i]);
   191		}
   192	
   193		return ret;
   194	}
   195	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
