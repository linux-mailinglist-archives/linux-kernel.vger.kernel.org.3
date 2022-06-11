Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255EC547703
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiFKSFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiFKSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:05:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05856BFDF;
        Sat, 11 Jun 2022 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654970728; x=1686506728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0F06aXtU5IgVgHppG2QEXxLO2CeAvZI7lDUyRNb2oU0=;
  b=k13FeTYHKwZFuXsPMvTjCT+WWAta3+voLPbfq3vtHcMiQlSjsdXYHv+e
   d7xzmfmnTqPn1GKeXnQOzx/+QSGhhl8SKGPjbU+nTRqvWgndLVRa9eBPQ
   TQEn/hqoZ7bJA4cZXBTx+/cxbKXqCkDFKhAY9AeCpg6Y2zpRnnxnq98Rm
   DnMxreE5YQIniafoljnxDvqzus+ElFpjGu2V15RANc36JXyKpGZ4E71H9
   ljQQ+m/UjC6mOEXK1JeIvFGD35aG28ZKHhCyhl1LnmAztWtLUY6PH+tLR
   3JkNEfFQwNWy+4AfgfniCjVhtt6A9+qLZQGq/HQBWmagEWQ2EyZyv8w4c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="341944752"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="341944752"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 11:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="556855043"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2022 11:05:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o05UC-000JA5-7c;
        Sat, 11 Jun 2022 18:05:24 +0000
Date:   Sun, 12 Jun 2022 02:04:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        jonathan@marek.ca, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v5 3/6] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Message-ID: <202206120103.ptlYOvp4-lkp@intel.com>
References: <20220609092940.304740-4-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609092940.304740-4-robert.foss@linaro.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next v5.19-rc1 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Foss/SM8350-Display-GPU-clock-enablement/20220609-173149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-buildonly-randconfig-r005-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120103.ptlYOvp4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/e7acd4b7cc95e3f3ffaa4782f09245b44d4faa31
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Robert-Foss/SM8350-Display-GPU-clock-enablement/20220609-173149
        git checkout e7acd4b7cc95e3f3ffaa4782f09245b44d4faa31
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
           gpu_cc_parent,
           ^~~~~~~~~~~~~
   drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
           gpu_cc_parent,
           ^~~~~~~~~~~~~
   2 errors generated.


vim +111 drivers/clk/qcom/gpucc-sm8350.c

05334fe2099d9b Robert Foss 2022-06-09  109  
05334fe2099d9b Robert Foss 2022-06-09  110  static const struct clk_parent_data gpu_cc_parent_data_0[] = {
05334fe2099d9b Robert Foss 2022-06-09 @111  	gpu_cc_parent,
05334fe2099d9b Robert Foss 2022-06-09  112  	{ .hw = &gpu_cc_pll0.clkr.hw },
05334fe2099d9b Robert Foss 2022-06-09  113  	{ .hw = &gpu_cc_pll1.clkr.hw },
05334fe2099d9b Robert Foss 2022-06-09  114  	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
05334fe2099d9b Robert Foss 2022-06-09  115  	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },
05334fe2099d9b Robert Foss 2022-06-09  116  };
05334fe2099d9b Robert Foss 2022-06-09  117  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
