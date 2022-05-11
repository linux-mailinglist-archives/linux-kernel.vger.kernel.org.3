Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE580523CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346501AbiEKSvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiEKSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:51:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A21D8103
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652295068; x=1683831068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eo7o/N1AMi+S88uFgAy/x0ypF5HQMsJ+YsmNCO77hPo=;
  b=XaarnIW/N8XPM0ETm1214MgjOkXs85jwA2CXeJaRWhWN9hSKS8B668bZ
   xd6g3kaK6d1Ubm2LO87VWncyy06XLB9tf+UbJKt+SEMswQkkmU5O4BIdW
   wNSLdWUvpIMrnMzPu/zo0PyFSluWqASpbXOPuek0oH8HivWj3rpnVDi/L
   Vwbz/ldMEHAbB42rcE6nwS0E1VMaTZR6fOvB816D8sZMlsjHXsulbXzzF
   R6WRW6rT5fQ4szCd+WwmZ0e8b1xkuZbzuNpaY9a/96dSjcBOfqKVQjTpN
   AZGOWQac5MZ7WSSyq7fStPNnkSqq7MWKFK7MQDM190adcV4XHVGUvS4Rl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="356210560"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="356210560"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 11:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="711606565"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2022 11:51:07 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1norQQ-000JQD-Se;
        Wed, 11 May 2022 18:51:06 +0000
Date:   Thu, 12 May 2022 02:50:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-v3 30/31]
 drivers/scsi/ufs/ufshcd.c:1056: warning: expecting prototype for Returns 0
 for success, non(). Prototype was for ufshcd_set_opp() instead
Message-ID: <202205120226.P786kaQa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-v3
head:   a37fb33a00889e90edd1c74de967b3315980a65d
commit: 83f52b94e7d208a3d1570fb3e8d6684186ac996f [30/31] ifss
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220512/202205120226.P786kaQa-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/83f52b94e7d208a3d1570fb3e8d6684186ac996f
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-v3
        git checkout 83f52b94e7d208a3d1570fb3e8d6684186ac996f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/scsi/ufs/

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
