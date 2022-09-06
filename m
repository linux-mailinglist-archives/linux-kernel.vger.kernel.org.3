Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3095B5AF5D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIFU2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIFU2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:28:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C511E3D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662496126; x=1694032126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kBRFIWHiBN2XlwnV7IWtn+DZ7t/secR34/CqRe3KIks=;
  b=Ug+juEbQkibiYWugGoVTL5h0aVK/U2+YAMwgavNu68SXAu9UhjOtBBcS
   4jQtGR9u5Pag08pcFJGhan+GYLKi98+C8jhsuaqKNcO42P3vwUAdbKcNp
   m6HdYQuo013zGNVxppD2clAkj9O8WsJCH9ABaO+8KTRGOK5B4ryM6Tbv2
   uvNGeNigF6+jKOfN2kGwAK5ugIhiiWk0yBjMNo2ldcQCG94vSLjF9tg7m
   FLk4G1Tk2jSNxnPFV8sOX4dPNtpOYDH6euq7YuRIc303RRKSNc+2BBBsu
   ZMPXfC3CYwpsgsD9cbVbAmqk4eiWOzccC8yX08CVplTWTQxP6bXm0bbkA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279711826"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279711826"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="644314215"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2022 13:28:44 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVfBb-0005aH-1R;
        Tue, 06 Sep 2022 20:28:43 +0000
Date:   Wed, 7 Sep 2022 04:28:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     kyrie wu <kyrie.wu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        irui wang <irui.wang@mediatek.com>
Subject: [hverkuil-media-tree:for-v6.1n 3/15]
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1529:35: error:
 'mtk_jpeg_match' undeclared here (not in a function); did you mean
 'mtk_jpeg_parse'?
Message-ID: <202209070432.kPOHuBAP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v6.1n
head:   da25a9a630c28cda51840e500cdf23d083f1a109
commit: e2175d01f345fff1f66b4769efc812d49cb26e7b [3/15] mtk-jpegenc: support jpegenc multi-hardware
config: arm-randconfig-r036-20220906 (https://download.01.org/0day-ci/archive/20220907/202209070432.kPOHuBAP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v6.1n
        git checkout e2175d01f345fff1f66b4769efc812d49cb26e7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/platform/mediatek/jpeg/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1529:35: error: 'mtk_jpeg_match' undeclared here (not in a function); did you mean 'mtk_jpeg_parse'?
    1529 |                 .of_match_table = mtk_jpeg_match,
         |                                   ^~~~~~~~~~~~~~
         |                                   mtk_jpeg_parse
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1489:38: warning: 'mtk_jpeg_drvdata' defined but not used [-Wunused-const-variable=]
    1489 | static const struct mtk_jpeg_variant mtk_jpeg_drvdata = {
         |                                      ^~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1474:38: warning: 'mt8173_jpeg_drvdata' defined but not used [-Wunused-const-variable=]
    1474 | static const struct mtk_jpeg_variant mt8173_jpeg_drvdata = {
         |                                      ^~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
   Selected by [y]:
   - QCOM_RPMPD [=y] && PM [=y] && QCOM_SMD_RPM [=y]


vim +1529 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c

b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1523  
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1524  static struct platform_driver mtk_jpeg_driver = {
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1525  	.probe = mtk_jpeg_probe,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1526  	.remove = mtk_jpeg_remove,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1527  	.driver = {
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1528  		.name           = MTK_JPEG_NAME,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14 @1529  		.of_match_table = mtk_jpeg_match,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1530  		.pm             = &mtk_jpeg_pm_ops,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1531  	},
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1532  };
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c Rick Chang 2016-12-14  1533  

:::::: The code at line 1529 was first introduced by commit
:::::: b2f0d2724ba477d326e9d654d4db1c93e98f8b93 [media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver

:::::: TO: Rick Chang <rick.chang@mediatek.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
