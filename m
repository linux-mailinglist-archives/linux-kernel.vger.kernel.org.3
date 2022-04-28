Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88E512C82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbiD1HTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiD1HTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:19:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F99972E1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651130179; x=1682666179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6isfrYWtZlwpN1o+WfrvgHuYM1XSrDuAPO77smHhcok=;
  b=AzGoKD8bwmouV7qctTT+USegro1sL3QBa+kYJsiLef3A6+RmqCNjJAYP
   kR4F9Xvn1bVSfXpARdCxZiU9IhfCyjMKVombXpINiDyKgkcbkJdW2rRNX
   P9NstErRiBbrG8yCLvxaWD9jYMFCWcHhZpBu7IeBm7U1Ig5WJfkQlglM2
   iCSyqYkvGBuQ804Dl/SVcU/8EpZN+jgB5vG8ODjzOgJ8D+E3m66eXCp2r
   kWQasm1vKip8DNbDRzrBCu6v2Rxdze27++xUIEL5Yx8W8Z4suCJD0Kw07
   xuOl5rn/5QcKu3EvpeXHj0VxEH6FwzmQYfQjp98LjCX3KkzTELMJfwP99
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="352621103"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="352621103"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 00:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="731255823"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2022 00:16:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njyNs-0005AF-LA;
        Thu, 28 Apr 2022 07:16:16 +0000
Date:   Thu, 28 Apr 2022 15:15:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [drm-msm:msm-next-staging 99/108]
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:410:13: warning:
 variable 'refcount' set but not used
Message-ID: <202204281543.XFvZfER7-lkp@intel.com>
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

tree:   https://gitlab.freedesktop.org/drm/msm.git msm-next-staging
head:   d2dc68276133362f021bc8d429433b5818826c81
commit: 0ce51f19453e2f901c6f6c0f725d1f397228970f [99/108] drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20220428/202204281543.XFvZfER7-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-msm https://gitlab.freedesktop.org/drm/msm.git
        git fetch --no-tags drm-msm msm-next-staging
        git checkout 0ce51f19453e2f901c6f6c0f725d1f397228970f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c: In function 'dpu_encoder_phys_wb_irq_ctrl':
>> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:410:13: warning: variable 'refcount' set but not used [-Wunused-but-set-variable]
     410 |         int refcount;
         |             ^~~~~~~~


vim +/refcount +410 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c

   407	
   408		struct dpu_encoder_phys_wb *wb_enc = to_dpu_encoder_phys_wb(phys);
   409		int ret = 0;
 > 410		int refcount;
   411	
   412		refcount = atomic_read(&wb_enc->wbirq_refcount);
   413	
   414		if (enable && atomic_inc_return(&wb_enc->wbirq_refcount) == 1) {
   415			dpu_core_irq_register_callback(phys->dpu_kms,
   416					phys->irq[INTR_IDX_WB_DONE], dpu_encoder_phys_wb_done_irq, phys);
   417			if (ret)
   418				atomic_dec_return(&wb_enc->wbirq_refcount);
   419		} else if (!enable &&
   420				atomic_dec_return(&wb_enc->wbirq_refcount) == 0) {
   421			dpu_core_irq_unregister_callback(phys->dpu_kms, phys->irq[INTR_IDX_WB_DONE]);
   422			if (ret)
   423				atomic_inc_return(&wb_enc->wbirq_refcount);
   424		}
   425	}
   426	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
