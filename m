Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B09519C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347911AbiEDJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347841AbiEDJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:59:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD64D1B7B1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651658122; x=1683194122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TQAj5zU5YBDIpsvllkIWVZmIaEkdqHUjk7C411iG0ro=;
  b=EO15RvGKWaJtoET+wJ8FTc3kOPjgRUiEtVkXA3qOjABUZMMBQxOFIuq1
   ey5/VAJP6SoTcinJeilkBHysZCE+xAxGWqlDdNLbsZnBBd6rEe+Z5duEM
   ZhkGMQaOZzSybOseAIVazFhoqtpJHKitboK1ootjatkHLV7WDhtS8P/P2
   ou8daeknctcrkD2uXTtauNj06/LWQqJhtfaswZgrXZ/OIN6UeLbRDHxue
   RTLLNx1/KeM0eC8S9W/pTrzD42ax8FJwTmnHmm7YFP/gnx/t3GflyyXAq
   pxdNtuCtuvU5BbCbrlu0sHCFWbWb8bNyffYn+DMcg2SP2nJZh9lANO45X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330704702"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="330704702"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="693685435"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2022 02:55:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmBj4-000BI3-Qu;
        Wed, 04 May 2022 09:55:18 +0000
Date:   Wed, 4 May 2022 17:55:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8180x-next-20220502 2/29]
 drivers/usb/typec/ucsi/ucsi_glink.c:622:34: warning: unused variable
 'ucsi_glink_of_match'
Message-ID: <202205041711.8Ka8RUyq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220502
head:   6199153320a3b7d1dce23ad1ea4d894a86793cb6
commit: be6dcf10ab84d8bb9ec872791f28b2724996fc32 [2/29] pmic_glink: Add UCSI/PAN prototype
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220504/202205041711.8Ka8RUyq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/be6dcf10ab84d8bb9ec872791f28b2724996fc32
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220502
        git checkout be6dcf10ab84d8bb9ec872791f28b2724996fc32
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/msm/ drivers/usb/typec/ucsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/ucsi/ucsi_glink.c:622:34: warning: unused variable 'ucsi_glink_of_match' [-Wunused-const-variable]
   static const struct of_device_id ucsi_glink_of_match[] = {
                                    ^
   1 warning generated.


vim +/ucsi_glink_of_match +622 drivers/usb/typec/ucsi/ucsi_glink.c

   621	
 > 622	static const struct of_device_id ucsi_glink_of_match[] = {
   623		{ .compatible = "qcom,glink-ucsi", },
   624		{}
   625	};
   626	//MODULE_DEVICE_TABLE(of, ucsi_glink_of_match);
   627	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
