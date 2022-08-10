Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35258F378
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiHJUWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJUWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:22:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E3811468
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660162927; x=1691698927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3UfGyFVQ2WmrPgaEdcoJCW+o1R+svTrwDPYf3xkTFJ0=;
  b=YhAD5OQHaoQDEtoUPyiXZ/PfX4UFVL7AySgYKbYLyuDJqgpuTAz/N0zB
   su3+ssgiq/y9oNWbiByBQmLm29MCBTHMDg34nprV8cj0USijCmBQH3x8T
   gnSiSoTuDp459qghtli0W3xltN9I4BL4TmWIzj6Yw6L5+kiVLFXBueW2B
   koTHNRkyIG3/cemNTsBjHolVG+MM2R7qzdUnNA61FVtFeCc7HkShb7uMM
   4IcI8vZxmf3YmlsLWhaErFNiUeJn1ED7kHnIKs2pQZjeRwv+N13MzYyBi
   lvuSvuRWQsjV8yvQ/AkTLI66RUXLlXdrnufmRk4ar4XROvLKyIumhUDWO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="288752444"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="288752444"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="850957673"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2022 13:22:05 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLsDN-0000gL-0X;
        Wed, 10 Aug 2022 20:22:05 +0000
Date:   Thu, 11 Aug 2022 04:21:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikhail Khelik <mkhelik@cisco.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media-tree:hdcp 3/4] drivers/media/i2c/adv7842.c:3449:38:
 warning: 'adv7842_ctrl_hdcp_auth' defined but not used
Message-ID: <202208110437.wfh39aEX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git hdcp
head:   da521c491aa5d01b7a920ef66c8d9aef36f14a02
commit: aea22ce596846ba20f94105739f3867b8459ae45 [3/4] Added HDCP support for ADV7842
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220811/202208110437.wfh39aEX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree hdcp
        git checkout aea22ce596846ba20f94105739f3867b8459ae45
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/adv7842.c:3449:38: warning: 'adv7842_ctrl_hdcp_auth' defined but not used [-Wunused-const-variable=]
    3449 | static const struct v4l2_ctrl_config adv7842_ctrl_hdcp_auth = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~


vim +/adv7842_ctrl_hdcp_auth +3449 drivers/media/i2c/adv7842.c

  3448	
> 3449	static const struct v4l2_ctrl_config adv7842_ctrl_hdcp_auth = {
  3450		.ops = NULL,
  3451		.id = V4L2_CID_DV_HDCP_RX_AUTH,
  3452		.name = "HDCP Authentication Status",
  3453		.type = V4L2_CTRL_TYPE_BITMASK,
  3454		.min = 0,
  3455		.max = 1,
  3456		.step = 0,
  3457		.def = 0,
  3458		.flags = V4L2_CTRL_FLAG_READ_ONLY
  3459	};
  3460	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
