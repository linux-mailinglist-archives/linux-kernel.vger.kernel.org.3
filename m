Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5A4E515F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbiCWLjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiCWLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:38:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E5175609;
        Wed, 23 Mar 2022 04:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648035449; x=1679571449;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xlkm9eWb6xvz+l7GN3+kAdWFAMPDPRRPwGgbpxQtuRE=;
  b=R2iMFMwI63nGsfS6surgsKYoQhetqP3AmFnlRI1Iwm5UClv1lmgOj19v
   BH9xyGMA1rWX/YUwd1xOXSkQgaM4h6pkITZXzvb6gNNqvpBFMWWsobqVJ
   kwaFHuaNLginQM5Lb+CvmvL7REIzRFMGZ5OtDU2cT+idGjH3ISfA5RBgz
   JJy7AzHny4tHJtL6weeOjMy0iJUXq+f6ghN4hbSxw6OSB8ZrfueaacSjL
   PHOersPxPLPQlcLW9FhZtN+x6MXu8fUWY0RWFjHu1u9pvyVTJqSm028G6
   odI5YE2VNetkw24YCQvEXKHOnKgpNZetk5zOo1Xl1vfvN5CEJAqbIPTW+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="238691890"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="238691890"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 04:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="519328436"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 04:37:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWzIs-000K10-Pv; Wed, 23 Mar 2022 11:37:26 +0000
Date:   Wed, 23 Mar 2022 19:36:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [hverkuil-media-tree:tmp 407/423]
 drivers/media/platform/mediatek/mdp/mtk_mdp_core.c:31:34: warning: unused
 variable 'mtk_mdp_comp_dt_ids'
Message-ID: <202203231910.QNuo5wZb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git tmp
head:   f89d74081c909f1c547a611141a23d7670e44bed
commit: 2023a99811110aebba9eee4aa09ef7bd21a8a249 [407/423] media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
config: hexagon-buildonly-randconfig-r005-20220323 (https://download.01.org/0day-ci/archive/20220323/202203231910.QNuo5wZb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree tmp
        git checkout 2023a99811110aebba9eee4aa09ef7bd21a8a249
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/mediatek/mdp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/mdp/mtk_mdp_core.c:31:34: warning: unused variable 'mtk_mdp_comp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mtk_mdp_comp_dt_ids[] = {
                                    ^
   1 warning generated.


vim +/mtk_mdp_comp_dt_ids +31 drivers/media/platform/mediatek/mdp/mtk_mdp_core.c

c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  30  
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08 @31  static const struct of_device_id mtk_mdp_comp_dt_ids[] = {
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  32  	{
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  33  		.compatible = "mediatek,mt8173-mdp-rdma",
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  34  		.data = (void *)MTK_MDP_RDMA
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  35  	}, {
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  36  		.compatible = "mediatek,mt8173-mdp-rsz",
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  37  		.data = (void *)MTK_MDP_RSZ
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  38  	}, {
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  39  		.compatible = "mediatek,mt8173-mdp-wdma",
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  40  		.data = (void *)MTK_MDP_WDMA
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  41  	}, {
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  42  		.compatible = "mediatek,mt8173-mdp-wrot",
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  43  		.data = (void *)MTK_MDP_WROT
55d80506c5f7c3a drivers/media/platform/mtk-mdp/mtk_mdp_core.c Vincent Stehlé 2016-10-27  44  	},
55d80506c5f7c3a drivers/media/platform/mtk-mdp/mtk_mdp_core.c Vincent Stehlé 2016-10-27  45  	{ },
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  46  };
c8eb2d7e8202fd9 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  47  

:::::: The code at line 31 was first introduced by commit
:::::: c8eb2d7e8202fd9cb912f5d33cc34ede66dcb24a [media] media: Add Mediatek MDP Driver

:::::: TO: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
