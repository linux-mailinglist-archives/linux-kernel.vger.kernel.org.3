Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3C599381
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbiHSDal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346116AbiHSDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:30:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32788BCC27
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660879835; x=1692415835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SBAecMOHFaQM8iwILUH200jYxCAP79bJ+2ClGk5u9ts=;
  b=HyD9gx8KSIff5J3n4Pq++4jG31QVfAM3B15kJrAGMYYeMiSIFww+XoAI
   ulBi1axH8svqPApi0tfHhwE+JhmsRzClFXp6/UlykyYbVD+hnmyCXEY1o
   W5fHAXjYj34aJixayNo/1Cmr3FT2k/OGWyxG4g6b02AFD80HQ8YTWNRTD
   a4yj6Fr5hwwVAUxqwTn93+UaESq+y9AbhBQqxRcXexetvvboMXmdLcheh
   XAQOk7xidEW0lwnbOi7wvFZ0Fany6Zx+CFI9RIFw2RfLqy/ikq/mtuQ4i
   VC+Ee8qJzMi9JHS+9Tfag9ZQRSzVeqC1V45wgn+1actxSmn9qnH/mbFXi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="290493716"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="290493716"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 20:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558795476"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 20:30:33 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOsiO-000113-2K;
        Fri, 19 Aug 2022 03:30:32 +0000
Date:   Fri, 19 Aug 2022 11:30:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220818 155/159] common.c:undefined reference
 to `sdw_disable_stream'
Message-ID: <202208191141.sqLU7loJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-next-20220818
head:   34fef0fd022b76178b8c48819465ec265c5aac2e
commit: 772198b336cb84f29f202a0d360bc84ea46ba63f [155/159] ASoC: qcom: sm8250: move some code to common
config: s390-randconfig-r044-20220818 (https://download.01.org/0day-ci/archive/20220819/202208191141.sqLU7loJ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/772198b336cb84f29f202a0d360bc84ea46ba63f
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220818
        git checkout 772198b336cb84f29f202a0d360bc84ea46ba63f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: sound/soc/qcom/common.o: in function `qcom_snd_sdw_prepare':
>> common.c:(.text+0x188): undefined reference to `sdw_disable_stream'
>> s390-linux-ld: common.c:(.text+0x192): undefined reference to `sdw_deprepare_stream'
>> s390-linux-ld: common.c:(.text+0x1a0): undefined reference to `sdw_prepare_stream'
>> s390-linux-ld: common.c:(.text+0x1b2): undefined reference to `sdw_enable_stream'
   s390-linux-ld: common.c:(.text+0x1c4): undefined reference to `sdw_deprepare_stream'
   s390-linux-ld: sound/soc/qcom/common.o: in function `qcom_snd_sdw_hw_free':
   common.c:(.text+0x344): undefined reference to `sdw_disable_stream'
   s390-linux-ld: common.c:(.text+0x34e): undefined reference to `sdw_deprepare_stream'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
