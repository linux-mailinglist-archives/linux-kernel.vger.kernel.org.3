Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D057D905
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiGVDfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVDfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:35:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174E65599
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658460915; x=1689996915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lWlT43z7X5jkLeiXa/ilB1H7P0nRbVxthTbpsJtMHa0=;
  b=XU8/I8CX2cGsoPZp8cNBr2l7I6QEYYdIhjkAdNkNcGQqOwtzT9d+MC8C
   GfrB1mm6Y+ac47ZRgSOA/AFgcVm4vDpKQhud3aMLqaxAj+F46q5yidY1P
   NE4MM1FjQ3L+pGqWWajuhIL8ApDeGMK4SjjoG6t+T1T54mt7R2wcW5PlA
   VifrsUfUaYhoOXL+vAwdpaP0uWaKTiVbLdFRrwZfeFF/UrEYWUeC/nTBA
   AAjmUyvLDSETO8YdixymLP+rSbrHLbelmeJZ7SVEEAvzRyptCPVSLsd/G
   cRR+c6lwXv3df6AIV09+aYhTZ9lo9OvjLCRvJPPAVz/G3mFf+LV3As/we
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312949825"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="312949825"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 20:35:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="549026918"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 20:35:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEjRY-0000um-0q;
        Fri, 22 Jul 2022 03:35:12 +0000
Date:   Fri, 22 Jul 2022 11:34:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:linux-5.19.0-rc7+thinkpad-x13s 117/122]
 drivers/firmware/qcom_scm.c:176: warning: expecting prototype for
 qcom_scm_call(). Prototype was for __qcom_scm_call() instead
Message-ID: <202207221110.7CMk2Way-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-5.19.0-rc7+thinkpad-x13s
head:   5c9f7a9316d17912ed92e6d6b6b1f89561270896
commit: 67a79524f0074c3a9abd9c489521ff0647b72192 [117/122] firmware: qcom_scm: Export SCM call functions
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220722/202207221110.7CMk2Way-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/67a79524f0074c3a9abd9c489521ff0647b72192
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-5.19.0-rc7+thinkpad-x13s
        git checkout 67a79524f0074c3a9abd9c489521ff0647b72192
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/clk/qcom/ drivers/firmware/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/qcom_scm.c:176: warning: expecting prototype for qcom_scm_call(). Prototype was for __qcom_scm_call() instead
>> drivers/firmware/qcom_scm.c:211: warning: expecting prototype for qcom_scm_call_atomic(). Prototype was for __qcom_scm_call_atomic() instead


vim +176 drivers/firmware/qcom_scm.c

9a434cee773ae15 Elliot Berman  2020-01-07  164  
9a434cee773ae15 Elliot Berman  2020-01-07  165  /**
9a434cee773ae15 Elliot Berman  2020-01-07  166   * qcom_scm_call() - Invoke a syscall in the secure world
9a434cee773ae15 Elliot Berman  2020-01-07  167   * @dev:	device
9a434cee773ae15 Elliot Berman  2020-01-07  168   * @desc:	Descriptor structure containing arguments and return values
a5d32f6d2e59a65 Yang Li        2021-12-30  169   * @res:        Structure containing results from SMC/HVC call
9a434cee773ae15 Elliot Berman  2020-01-07  170   *
9a434cee773ae15 Elliot Berman  2020-01-07  171   * Sends a command to the SCM and waits for the command to finish processing.
9a434cee773ae15 Elliot Berman  2020-01-07  172   * This should *only* be called in pre-emptible context.
9a434cee773ae15 Elliot Berman  2020-01-07  173   */
67a79524f0074c3 Maximilian Luz 2022-07-19  174  static int __qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
9a434cee773ae15 Elliot Berman  2020-01-07  175  			   struct qcom_scm_res *res)
9a434cee773ae15 Elliot Berman  2020-01-07 @176  {
9a434cee773ae15 Elliot Berman  2020-01-07  177  	might_sleep();
9a434cee773ae15 Elliot Berman  2020-01-07  178  	switch (__get_convention()) {
9a434cee773ae15 Elliot Berman  2020-01-07  179  	case SMC_CONVENTION_ARM_32:
9a434cee773ae15 Elliot Berman  2020-01-07  180  	case SMC_CONVENTION_ARM_64:
9a434cee773ae15 Elliot Berman  2020-01-07  181  		return scm_smc_call(dev, desc, res, false);
9a434cee773ae15 Elliot Berman  2020-01-07  182  	case SMC_CONVENTION_LEGACY:
9a434cee773ae15 Elliot Berman  2020-01-07  183  		return scm_legacy_call(dev, desc, res);
9a434cee773ae15 Elliot Berman  2020-01-07  184  	default:
9a434cee773ae15 Elliot Berman  2020-01-07  185  		pr_err("Unknown current SCM calling convention.\n");
9a434cee773ae15 Elliot Berman  2020-01-07  186  		return -EINVAL;
9a434cee773ae15 Elliot Berman  2020-01-07  187  	}
9a434cee773ae15 Elliot Berman  2020-01-07  188  }
9a434cee773ae15 Elliot Berman  2020-01-07  189  
67a79524f0074c3 Maximilian Luz 2022-07-19  190  int qcom_scm_call(const struct qcom_scm_desc *desc, struct qcom_scm_res *res)
67a79524f0074c3 Maximilian Luz 2022-07-19  191  {
67a79524f0074c3 Maximilian Luz 2022-07-19  192  	if (!__scm)
67a79524f0074c3 Maximilian Luz 2022-07-19  193  		return -ENODEV;
67a79524f0074c3 Maximilian Luz 2022-07-19  194  
67a79524f0074c3 Maximilian Luz 2022-07-19  195  	return __qcom_scm_call(__scm->dev, desc, res);
67a79524f0074c3 Maximilian Luz 2022-07-19  196  }
67a79524f0074c3 Maximilian Luz 2022-07-19  197  EXPORT_SYMBOL_GPL(qcom_scm_call);
67a79524f0074c3 Maximilian Luz 2022-07-19  198  
9a434cee773ae15 Elliot Berman  2020-01-07  199  /**
9a434cee773ae15 Elliot Berman  2020-01-07  200   * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
9a434cee773ae15 Elliot Berman  2020-01-07  201   * @dev:	device
9a434cee773ae15 Elliot Berman  2020-01-07  202   * @desc:	Descriptor structure containing arguments and return values
9a434cee773ae15 Elliot Berman  2020-01-07  203   * @res:	Structure containing results from SMC/HVC call
9a434cee773ae15 Elliot Berman  2020-01-07  204   *
9a434cee773ae15 Elliot Berman  2020-01-07  205   * Sends a command to the SCM and waits for the command to finish processing.
9a434cee773ae15 Elliot Berman  2020-01-07  206   * This can be called in atomic context.
9a434cee773ae15 Elliot Berman  2020-01-07  207   */
67a79524f0074c3 Maximilian Luz 2022-07-19  208  static int __qcom_scm_call_atomic(struct device *dev,
9a434cee773ae15 Elliot Berman  2020-01-07  209  				  const struct qcom_scm_desc *desc,
9a434cee773ae15 Elliot Berman  2020-01-07  210  				  struct qcom_scm_res *res)
9a434cee773ae15 Elliot Berman  2020-01-07 @211  {
9a434cee773ae15 Elliot Berman  2020-01-07  212  	switch (__get_convention()) {
9a434cee773ae15 Elliot Berman  2020-01-07  213  	case SMC_CONVENTION_ARM_32:
9a434cee773ae15 Elliot Berman  2020-01-07  214  	case SMC_CONVENTION_ARM_64:
9a434cee773ae15 Elliot Berman  2020-01-07  215  		return scm_smc_call(dev, desc, res, true);
9a434cee773ae15 Elliot Berman  2020-01-07  216  	case SMC_CONVENTION_LEGACY:
9a434cee773ae15 Elliot Berman  2020-01-07  217  		return scm_legacy_call_atomic(dev, desc, res);
9a434cee773ae15 Elliot Berman  2020-01-07  218  	default:
9a434cee773ae15 Elliot Berman  2020-01-07  219  		pr_err("Unknown current SCM calling convention.\n");
9a434cee773ae15 Elliot Berman  2020-01-07  220  		return -EINVAL;
9a434cee773ae15 Elliot Berman  2020-01-07  221  	}
9a434cee773ae15 Elliot Berman  2020-01-07  222  }
9a434cee773ae15 Elliot Berman  2020-01-07  223  

:::::: The code at line 176 was first introduced by commit
:::::: 9a434cee773ae15309ac225f27551b5492618e4a firmware: qcom_scm: Dynamically support SMCCC and legacy conventions

:::::: TO: Elliot Berman <eberman@codeaurora.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
