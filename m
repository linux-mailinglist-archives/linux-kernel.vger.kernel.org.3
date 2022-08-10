Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A9258F3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiHJVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiHJVeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:34:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C756715C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660167249; x=1691703249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EMnaEs85VG7l65cRfzn3jO1g1NdeH3E9lRLR0IzTnxg=;
  b=Bvzvm+IPm2EROCF2e5Cscj2StB6DrjiR5cFowN8iwT1kUzg1gtgauElI
   //HaWceCwG3dLwMRmeLIovEQ18/Cm5WaRaI4ZQDgB14TlSCzOAz2fpccf
   tHMuT/JjXKTogGgnSo++LjpGjLx41IF0mMuXuuPUvKMuMERqfNfUA7saX
   DEyd/cvLUgrzz8kNKvb2xlK97VLYGSO/R81KWughAlq5msEnUwyrXmVWa
   KueT0M87n+fco6R+U75IRuNtdRf+fk4oxjygROo18x+123k2i4Db9iqEY
   eUdjHLlHF0bHtawhAp3ZqXmddHtFG9CcQjOL0j+cuIuGe7kZO0M8+xKgN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291989113"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="291989113"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 14:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="638256199"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2022 14:34:07 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLtL5-0000k7-0E;
        Wed, 10 Aug 2022 21:34:07 +0000
Date:   Thu, 11 Aug 2022 05:33:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikhail Khelik <mkhelik@cisco.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:hdcp 4/4] drivers/media/i2c/adv7604.c:2884:38:
 warning: unused variable 'adv7604_ctrl_hdcp_auth'
Message-ID: <202208110500.zRUW89QJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git hdcp
head:   da521c491aa5d01b7a920ef66c8d9aef36f14a02
commit: da521c491aa5d01b7a920ef66c8d9aef36f14a02 [4/4] Added HDCP support for ADV7604
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220811/202208110500.zRUW89QJ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree hdcp
        git checkout da521c491aa5d01b7a920ef66c8d9aef36f14a02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/adv7604.c:2884:38: warning: unused variable 'adv7604_ctrl_hdcp_auth' [-Wunused-const-variable]
   static const struct v4l2_ctrl_config adv7604_ctrl_hdcp_auth = {
                                        ^
   1 warning generated.


vim +/adv7604_ctrl_hdcp_auth +2884 drivers/media/i2c/adv7604.c

  2883	
> 2884	static const struct v4l2_ctrl_config adv7604_ctrl_hdcp_auth = {
  2885		.ops = NULL,
  2886		.id = V4L2_CID_DV_HDCP_RX_AUTH,
  2887		.name = "HDCP Authentication Status",
  2888		.type = V4L2_CTRL_TYPE_BITMASK,
  2889		.min = 0,
  2890		.max = 1,
  2891		.step = 0,
  2892		.def = 0,
  2893		.flags = V4L2_CTRL_FLAG_READ_ONLY
  2894	};
  2895	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
