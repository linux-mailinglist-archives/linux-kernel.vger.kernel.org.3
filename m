Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69664523E05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347269AbiEKTxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiEKTxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:53:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB6719DD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652298794; x=1683834794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xK0Eukk7VSWdIHg/43+hYhiSqrcgXg46IKQhLyMLnaw=;
  b=bg4k0ghjBskuBF+7wrkR2WalwqYbwbyT0DU+Qx1Yw8uGWb+4In2HvlIh
   jKiIfhKEhTochHxiZHuv65ZzfUZdDGXth+q6+FOimkxYdO4u48EFHO49D
   AW+c1H9EA8QtHjjACTpj2Va08B+rmUy1ywCEb2rKK/xcstBrxawoX9etZ
   EHI/ay6q67G+nbuJiYo2YkyavqVZ+A4e7QczDGmLeCfqHjbL0E/tgGn6R
   9Bi8+Q1VpjizbF0o0PWTaxdGJzMkgdEXRzSI+1jLDcgRC0uhSH5Hy+2S0
   JSujmiG49EFjPszPXkSvRXBsIX5IOiTJAT9HtbsVp9NTCEdSQF0dKxmfj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269469872"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269469872"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 12:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="636549100"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2022 12:53:12 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nosOV-000JVs-DK;
        Wed, 11 May 2022 19:53:11 +0000
Date:   Thu, 12 May 2022 03:52:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v3 30/31]
 drivers/scsi/ufs/ufshcd.c:1056: warning: expecting prototype for Returns 0
 for success, non(). Prototype was for ufshcd_set_opp() instead
Message-ID: <202205120302.UplNopuT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v3
head:   a37fb33a00889e90edd1c74de967b3315980a65d
commit: 83f52b94e7d208a3d1570fb3e8d6684186ac996f [30/31] ifss
config: x86_64-randconfig-a003-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120302.UplNopuT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/83f52b94e7d208a3d1570fb3e8d6684186ac996f
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-v3
        git checkout 83f52b94e7d208a3d1570fb3e8d6684186ac996f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/ufs/ufshcd.c:1039: warning: cannot understand function prototype: '/* static int ufshcd_set_clk_freq(struct ufs_hba *hba, unsigned long freq) '
   drivers/scsi/ufs/ufshcd.c:1056: warning: Function parameter or member 'data' not described in 'ufshcd_set_opp'
>> drivers/scsi/ufs/ufshcd.c:1056: warning: expecting prototype for Returns 0 for success, non(). Prototype was for ufshcd_set_opp() instead


vim +1056 drivers/scsi/ufs/ufshcd.c

868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1051  
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1052  /**
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1053   * Returns 0 for success, non-zero error value for errors.
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1054   */
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1055  int ufshcd_set_opp(struct dev_pm_set_opp_data *data)
868147b0e847f5 Krzysztof Kozlowski 2022-05-11 @1056  {
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1057  	struct ufs_hba *hba = dev_get_drvdata(data->dev);
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1058  	unsigned long old_freq = data->old_opp.rate;
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1059  	unsigned long freq = data->new_opp.rate;
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1060  	bool scale_up;
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1061  
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1062  	scale_up = (freq > old_freq);
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1063  
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1064  	pr_err("AAAA ufs %s %s %lu->%lu\n", __func__,
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1065  	       (scale_up ? "up" : "down"),
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1066  	       old_freq, freq);
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1067  
e9b0ff4416ed23 Krzysztof Kozlowski 2022-05-11  1068  	return ufshcd_set_clk_freq_direct(hba, scale_up);
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1069  }
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1070  EXPORT_SYMBOL_GPL(ufshcd_set_opp);
868147b0e847f5 Krzysztof Kozlowski 2022-05-11  1071  

:::::: The code at line 1056 was first introduced by commit
:::::: 868147b0e847f596b8fff395a553c423f32ab7db wip

:::::: TO: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
:::::: CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
