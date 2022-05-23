Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26552530B59
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiEWILo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiEWILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:11:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2FF69
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653293480; x=1684829480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=grfiXcB0a0o3DALs3UvtS53V45wFc/9o82K5h81wWJY=;
  b=Y/RkSYvk8EguQr9U4N+WYfr09YsN8SvWXXLbpUHGBHJL1S25qYjEZk0+
   DFMIgYTW04FYNA8WtTY1xmTusml/ahjv2bjO29asnCrXp7r9DkwsVvcc+
   zyacKwEc0a8CSIr7yXF0h4WL0PGOcuspvwj2H9FXDTBaduw8gVzp+2EpH
   uk6/dk7A2TY5qjx0cIGgVHqgRLahpSYtHa6HEPmfen4NhOGMQUXUsWd4y
   KVQBYt521bFnMqv5SL39kvBAzbYf3kSdM9obPQQKgN9yyWCXA5AquDYD7
   KfgYHkNouZcZRbj9SgN8ZRyK6MBC/RXI8Z5btr4kYzURrBAFttw8Rak8h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="272850007"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="272850007"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="608062250"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2022 00:12:24 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nt2Em-0000x0-Rv;
        Mon, 23 May 2022 07:12:20 +0000
Date:   Mon, 23 May 2022 15:11:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Yu <jack.yu@realtek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/rt1019.c:878:34: warning: 'rt1019_of_match' defined
 but not used
Message-ID: <202205231529.IKeOZxBe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b0986a3613c92f4ec1bdc7f60ec66fea135991f
commit: 7ec79d3850d0cb6dc52e6aa472886ab3adf15863 ASoC: rt1019: add rt1019 amplifier driver
date:   1 year, 2 months ago
config: i386-buildonly-randconfig-r002-20220523 (https://download.01.org/0day-ci/archive/20220523/202205231529.IKeOZxBe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7ec79d3850d0cb6dc52e6aa472886ab3adf15863
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7ec79d3850d0cb6dc52e6aa472886ab3adf15863
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/clk/imx/ drivers/irqchip/ drivers/media/platform/ drivers/soc/ixp4xx/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/rt1019.c:878:34: warning: 'rt1019_of_match' defined but not used [-Wunused-const-variable=]
     878 | static const struct of_device_id rt1019_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~


vim +/rt1019_of_match +878 sound/soc/codecs/rt1019.c

   877	
 > 878	static const struct of_device_id rt1019_of_match[] = {
   879		{ .compatible = "realtek,rt1019", },
   880		{},
   881	};
   882	MODULE_DEVICE_TABLE(of, rt1019_of_match);
   883	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
