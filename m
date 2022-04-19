Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69757506464
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348055AbiDSGaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiDSGaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:30:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67E21260
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650349653; x=1681885653;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EMVws8GUsm9wx8jY0PPUOTcYSw4FDAVfHaH4X0Sr/4I=;
  b=d/biYX2XVcF6Z4RbuMTz4Fb/ggZ+7aAUPYiex+nqTpAL/LLgvcgOTwel
   H1fP8xCUd3GQsjHcf0H7zVFiAHvYCNuusLS7uWmvL+cedPpYkudEhkTvG
   5I5G26Ddvy5HudQIakJeNN2ByAqaNbdj7LvJyR1pDlXeTGV/ohzJllK9S
   lTTSo0X7Lr6oCcB1QAQ4V7ngKQSZar80ihHSZDKCGO/c7eu2Mf5YHlrVw
   mpykZu8ZGWkX7G8+y82Kui+Lwo8M/U410F+TU+4jLxSDFAK8qPjhH7dDQ
   MxELYFaLd29vGLFmK0yPfc0TrxKnGVHltrixlh0Fm4O7CJe6BbhMOEhtN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="244274103"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="244274103"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 23:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="529994416"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 23:27:32 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nghKl-0005Qf-QS;
        Tue, 19 Apr 2022 06:27:31 +0000
Date:   Tue, 19 Apr 2022 14:26:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2193/2356]
 drivers/crypto/qat/qat_common/adf_gen4_pm.c:99:17: warning: assignment to
 'struct adf_gen4_pm_data *' from 'int' makes pointer from integer without a
 cast
Message-ID: <202204191448.K7JF5bcS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: f2ce8327351a044882fbafa2cad2f9c3688414b4 [2193/2356] headers/deps: pci/x86: Optimize <asm/pci.h> dependencies
config: x86_64-randconfig-a006-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191448.K7JF5bcS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f2ce8327351a044882fbafa2cad2f9c3688414b4
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f2ce8327351a044882fbafa2cad2f9c3688414b4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/bus/mhi/host/ drivers/crypto/qat/qat_common/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/crypto/qat/qat_common/adf_gen4_pm.c: In function 'pm_bh_handler':
   drivers/crypto/qat/qat_common/adf_gen4_pm.c:72:9: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
      72 |         kfree(pm_data);
         |         ^~~~~
         |         vfree
   drivers/crypto/qat/qat_common/adf_gen4_pm.c: In function 'adf_gen4_handle_pm_interrupt':
   drivers/crypto/qat/qat_common/adf_gen4_pm.c:99:19: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
      99 |         pm_data = kzalloc(sizeof(*pm_data), GFP_ATOMIC);
         |                   ^~~~~~~
         |                   vzalloc
>> drivers/crypto/qat/qat_common/adf_gen4_pm.c:99:17: warning: assignment to 'struct adf_gen4_pm_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      99 |         pm_data = kzalloc(sizeof(*pm_data), GFP_ATOMIC);
         |                 ^
   cc1: some warnings being treated as errors


vim +99 drivers/crypto/qat/qat_common/adf_gen4_pm.c

e5745f34113b75 Wojciech Ziemba 2022-02-10   74  
e5745f34113b75 Wojciech Ziemba 2022-02-10   75  bool adf_gen4_handle_pm_interrupt(struct adf_accel_dev *accel_dev)
e5745f34113b75 Wojciech Ziemba 2022-02-10   76  {
e5745f34113b75 Wojciech Ziemba 2022-02-10   77  	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
e5745f34113b75 Wojciech Ziemba 2022-02-10   78  	struct adf_gen4_pm_data *pm_data = NULL;
e5745f34113b75 Wojciech Ziemba 2022-02-10   79  	u32 errsou2;
e5745f34113b75 Wojciech Ziemba 2022-02-10   80  	u32 errmsk2;
e5745f34113b75 Wojciech Ziemba 2022-02-10   81  	u32 val;
e5745f34113b75 Wojciech Ziemba 2022-02-10   82  
e5745f34113b75 Wojciech Ziemba 2022-02-10   83  	/* Only handle the interrupt triggered by PM */
e5745f34113b75 Wojciech Ziemba 2022-02-10   84  	errmsk2 = ADF_CSR_RD(pmisc, ADF_GEN4_ERRMSK2);
e5745f34113b75 Wojciech Ziemba 2022-02-10   85  	if (errmsk2 & ADF_GEN4_PM_SOU)
e5745f34113b75 Wojciech Ziemba 2022-02-10   86  		return false;
e5745f34113b75 Wojciech Ziemba 2022-02-10   87  
e5745f34113b75 Wojciech Ziemba 2022-02-10   88  	errsou2 = ADF_CSR_RD(pmisc, ADF_GEN4_ERRSOU2);
e5745f34113b75 Wojciech Ziemba 2022-02-10   89  	if (!(errsou2 & ADF_GEN4_PM_SOU))
e5745f34113b75 Wojciech Ziemba 2022-02-10   90  		return false;
e5745f34113b75 Wojciech Ziemba 2022-02-10   91  
e5745f34113b75 Wojciech Ziemba 2022-02-10   92  	/* Disable interrupt */
e5745f34113b75 Wojciech Ziemba 2022-02-10   93  	val = ADF_CSR_RD(pmisc, ADF_GEN4_ERRMSK2);
e5745f34113b75 Wojciech Ziemba 2022-02-10   94  	val |= ADF_GEN4_PM_SOU;
e5745f34113b75 Wojciech Ziemba 2022-02-10   95  	ADF_CSR_WR(pmisc, ADF_GEN4_ERRMSK2, val);
e5745f34113b75 Wojciech Ziemba 2022-02-10   96  
e5745f34113b75 Wojciech Ziemba 2022-02-10   97  	val = ADF_CSR_RD(pmisc, ADF_GEN4_PM_INTERRUPT);
e5745f34113b75 Wojciech Ziemba 2022-02-10   98  
e5745f34113b75 Wojciech Ziemba 2022-02-10  @99  	pm_data = kzalloc(sizeof(*pm_data), GFP_ATOMIC);
e5745f34113b75 Wojciech Ziemba 2022-02-10  100  	if (!pm_data)
e5745f34113b75 Wojciech Ziemba 2022-02-10  101  		return false;
e5745f34113b75 Wojciech Ziemba 2022-02-10  102  
e5745f34113b75 Wojciech Ziemba 2022-02-10  103  	pm_data->pm_int_sts = val;
e5745f34113b75 Wojciech Ziemba 2022-02-10  104  	pm_data->accel_dev = accel_dev;
e5745f34113b75 Wojciech Ziemba 2022-02-10  105  
e5745f34113b75 Wojciech Ziemba 2022-02-10  106  	INIT_WORK(&pm_data->pm_irq_work, pm_bh_handler);
e5745f34113b75 Wojciech Ziemba 2022-02-10  107  	adf_misc_wq_queue_work(&pm_data->pm_irq_work);
e5745f34113b75 Wojciech Ziemba 2022-02-10  108  
e5745f34113b75 Wojciech Ziemba 2022-02-10  109  	return true;
e5745f34113b75 Wojciech Ziemba 2022-02-10  110  }
e5745f34113b75 Wojciech Ziemba 2022-02-10  111  EXPORT_SYMBOL_GPL(adf_gen4_handle_pm_interrupt);
e5745f34113b75 Wojciech Ziemba 2022-02-10  112  

:::::: The code at line 99 was first introduced by commit
:::::: e5745f34113b758b45d134dec04a7df94dc67131 crypto: qat - enable power management for QAT GEN4

:::::: TO: Wojciech Ziemba <wojciech.ziemba@intel.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
