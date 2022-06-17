Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54EC54FDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiFQTj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiFQTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:39:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF753E22;
        Fri, 17 Jun 2022 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655494796; x=1687030796;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5SgFd7WkR3Wqzp/vk0OtAaks+k5JfvTv93sayUfSxWw=;
  b=Z+knRYh8YcCiIsKkymh6qnoUN65UV14wBTIh/3XTHtPo47VWSVsCXxPE
   XISATpq9nSjv59EjJ/f8VG9erv+7hzcD0GmDpFdi5llXq0KRFcZDlbsxw
   jMOPKIJZDpJCLFjzFwe00mKknquJMHPTsU0KKXZc8lcziS1B/OPemsoB1
   Zs7opteSCH1a0sR7/RzqUjxqqIgkYxw8E7uzm/4aPRMLZ2PZ4Gl9Sg0I/
   Gtw3O5/MShlQrZ8Al/yLSuzgfz3IbPZSeKTtJ4APqkzwArCvV7f/xe86f
   GgxGPgmvYe7hEpdRKBAadOPVYOeS+2ded3/561zEDO+P/eTO7JBOjB0cS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343557983"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343557983"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 12:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642160152"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2022 12:39:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Hov-000Pi5-AF;
        Fri, 17 Jun 2022 19:39:53 +0000
Date:   Sat, 18 Jun 2022 03:39:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/mediatek/mdp/mtk_mdp_core.c:31:34: warning:
 unused variable 'mtk_mdp_comp_dt_ids'
Message-ID: <202206180318.LDlpyiIW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   274295c6e53f8b8b8dfa8b24a3fcb8a9d670c22c
commit: 2023a99811110aebba9eee4aa09ef7bd21a8a249 media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
date:   3 months ago
config: mips-randconfig-c004-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180318.LDlpyiIW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2023a99811110aebba9eee4aa09ef7bd21a8a249
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2023a99811110aebba9eee4aa09ef7bd21a8a249
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/mediatek/mdp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/mdp/mtk_mdp_core.c:31:34: warning: unused variable 'mtk_mdp_comp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mtk_mdp_comp_dt_ids[] = {
                                    ^
   1 warning generated.


vim +/mtk_mdp_comp_dt_ids +31 drivers/media/platform/mediatek/mdp/mtk_mdp_core.c

c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  30  
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08 @31  static const struct of_device_id mtk_mdp_comp_dt_ids[] = {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  32  	{
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  33  		.compatible = "mediatek,mt8173-mdp-rdma",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  34  		.data = (void *)MTK_MDP_RDMA
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  35  	}, {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  36  		.compatible = "mediatek,mt8173-mdp-rsz",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  37  		.data = (void *)MTK_MDP_RSZ
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  38  	}, {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  39  		.compatible = "mediatek,mt8173-mdp-wdma",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  40  		.data = (void *)MTK_MDP_WDMA
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  41  	}, {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  42  		.compatible = "mediatek,mt8173-mdp-wrot",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  43  		.data = (void *)MTK_MDP_WROT
55d80506c5f7c3 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Vincent Stehlé 2016-10-27  44  	},
55d80506c5f7c3 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Vincent Stehlé 2016-10-27  45  	{ },
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  46  };
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  47  

:::::: The code at line 31 was first introduced by commit
:::::: c8eb2d7e8202fd9cb912f5d33cc34ede66dcb24a [media] media: Add Mediatek MDP Driver

:::::: TO: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
