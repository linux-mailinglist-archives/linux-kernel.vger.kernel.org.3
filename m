Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C195A4759
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiH2Kjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2Kjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:39:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738785B050
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661769576; x=1693305576;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t7GuYZO5ulomC4Kc+Yn7T0tXmir/Uia8FcI8CB074ME=;
  b=McB4oi2QN19hkvphbvWrByY9YvBcTZryAjl6sZa5GPOXef/DaBDT2AUu
   GHuHQpDv+ELJEBFMLjxqpHz6ww83SWhkYvhn4mAACaDU7Vc3+WbZPchj4
   Q3TYtQ0jjFYYMCa7EvIelv/86vE6rTPcJtdzEMicOxply3cYkhoCJmkMC
   u5LH+z2h4V7fdmOkVgjE3pv4aaaqjE8WYoNSCaBgdjh/ZssabW8Tfj264
   eMFUWg2wxA6861kRuVjKdtp3itstJXMs2uPQAHp9ZVIjlViC0l+6ZAsgM
   xKHsLHurc7Nc1ag0Db/1qhOZwjP826B5CVx+lJsWkaaILxI3eLnvqPBlS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="296139038"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="296139038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 03:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="679578366"
Received: from lkp-server02.sh.intel.com (HELO a13edbbf6006) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2022 03:39:12 -0700
Received: from kbuild by a13edbbf6006 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oScAi-00002f-0a;
        Mon, 29 Aug 2022 10:39:12 +0000
Date:   Mon, 29 Aug 2022 18:38:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-6.0.0-rc3 156/167] undefined reference to
 `sdw_disable_stream'
Message-ID: <202208291807.tyAnOYIv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-6.0.0-rc3
head:   219615b30a2e783a7af7d39e20f9e0ce56ac082e
commit: 7b56a20a3a015c2ee678b6d593889ac33fc93627 [156/167] ASoC: qcom: sm8250: move some code to common
config: microblaze-randconfig-r025-20220828 (https://download.01.org/0day-ci/archive/20220829/202208291807.tyAnOYIv-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/7b56a20a3a015c2ee678b6d593889ac33fc93627
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-6.0.0-rc3
        git checkout 7b56a20a3a015c2ee678b6d593889ac33fc93627
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: sound/soc/qcom/common.o: in function `qcom_snd_sdw_prepare':
>> (.text+0x790): undefined reference to `sdw_disable_stream'
>> microblaze-linux-ld: (.text+0x79c): undefined reference to `sdw_deprepare_stream'
>> microblaze-linux-ld: (.text+0x7ac): undefined reference to `sdw_prepare_stream'
>> microblaze-linux-ld: (.text+0x7c0): undefined reference to `sdw_enable_stream'
   microblaze-linux-ld: (.text+0x7d4): undefined reference to `sdw_deprepare_stream'
   microblaze-linux-ld: sound/soc/qcom/common.o: in function `qcom_snd_sdw_hw_free':
   (.text+0x9a8): undefined reference to `sdw_disable_stream'
   microblaze-linux-ld: (.text+0x9b8): undefined reference to `sdw_deprepare_stream'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
