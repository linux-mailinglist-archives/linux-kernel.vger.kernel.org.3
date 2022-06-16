Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3454DE72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359708AbiFPJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiFPJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:49:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122F4ECEA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655372996; x=1686908996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vynjyFkad2bcT82VPPp8Vl892XMy5vOsQ53BvyViy0g=;
  b=Ixj+jtMydaYRwbtWFA+RBH+7NCUXaUFr/MUewQZ1+XJzpgP0mDLiLAN8
   8JlzkN7Ss2/LManpV/eyKHN2/Pu+fJzUuKS9TCRPb7ODDB/9pZ+0LKg7Z
   kg6+ob5WWt/UVhpIk7WKVSk2TidTYI8S3sJnkuN4T8csc89liX43Dm/vn
   vm6r6vHTou42aFSuXN/Fcx3MOgTus1Ooz3bLkCbq4HbIkR8L+03/lfg0d
   Mq/bohu8zS8oIkYF9K0cS5pk08kXS0+zlEZ4ER2x9gqFKsOSQP2zFwkYC
   VrIBi7rZkiDt1uhtSU7yMhHDBWekW9x0pTlvzIvIxKhBZ3mOrNT8soKql
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304653258"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="304653258"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 02:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="674953064"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2022 02:49:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1m8Q-000OG3-H4;
        Thu, 16 Jun 2022 09:49:54 +0000
Date:   Thu, 16 Jun 2022 17:49:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:248:34: warning: unused
 variable 'vop2_dt_match'
Message-ID: <202206161754.ctnWSH3Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30306f6194cadcc29c77f6ddcd416a75bf5c0232
commit: 604be85547ce4d61b89292d2f9a78c721b778c16 drm/rockchip: Add VOP2 driver
date:   6 weeks ago
config: arm-randconfig-r002-20220616 (https://download.01.org/0day-ci/archive/20220616/202206161754.ctnWSH3Q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=604be85547ce4d61b89292d2f9a78c721b778c16
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 604be85547ce4d61b89292d2f9a78c721b778c16
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/rockchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:248:34: warning: unused variable 'vop2_dt_match' [-Wunused-const-variable]
   static const struct of_device_id vop2_dt_match[] = {
                                    ^
   1 warning generated.


vim +/vop2_dt_match +248 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c

   247	
 > 248	static const struct of_device_id vop2_dt_match[] = {
   249		{
   250			.compatible = "rockchip,rk3566-vop",
   251			.data = &rk3566_vop,
   252		}, {
   253			.compatible = "rockchip,rk3568-vop",
   254			.data = &rk3568_vop,
   255		}, {
   256		},
   257	};
   258	MODULE_DEVICE_TABLE(of, vop2_dt_match);
   259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
