Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D67592A22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiHOHNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiHOHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:13:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0368715FDD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660547611; x=1692083611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oog9uOMOFpVkeybBx2UwtUeicDBnFHQDc3X6l56p1T0=;
  b=Emykm+9GO5gX7zZIggtnXiJ62i/tj7h7LzAM/SzlVets577HfZkKGQTQ
   0OLFE+vokCz6RM0ufW7KhwdYcoeIEJZ64BsR/t37AzNPhuoyE3tbJsDKg
   Rr7ZfxV6jUYHzp+PquEL5kyAdYSxmBnF3N2yJo8wSQQCO29OfFw0T0uzi
   4210sTsUa3EYfbfLYTL+ycYf14IEK5g3QWe0qgC6oBgJcegf21B1JDhJM
   Qqg5V5URYtFpLlnIRTz+uaFBzYwiTm81W6lcawIeXT64eyZl9TG76ROig
   0wEdb7PbO3aYDrGIMmwhJW/2df1x7WTOQmWIpMPzOvJ138n49FU6RotGC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317888754"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="317888754"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="934391976"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 00:13:30 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNUHx-0000sH-25;
        Mon, 15 Aug 2022 07:13:29 +0000
Date:   Mon, 15 Aug 2022 15:12:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Watson Chow <watson.chow@avnet.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/regulator/max20086-regulator.c:288:34: warning:
 'max20086_dt_ids' defined but not used
Message-ID: <202208151511.x4nxpkcQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Watson,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: bfff546aae50ae68ed395bf0e0848188d27b0ba3 regulator: Add MAX20086-MAX20089 driver
date:   7 months ago
config: i386-randconfig-r033-20220815 (https://download.01.org/0day-ci/archive/20220815/202208151511.x4nxpkcQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfff546aae50ae68ed395bf0e0848188d27b0ba3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bfff546aae50ae68ed395bf0e0848188d27b0ba3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/regulator/max20086-regulator.c:288:34: warning: 'max20086_dt_ids' defined but not used [-Wunused-const-variable=]
     288 | static const struct of_device_id max20086_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~


vim +/max20086_dt_ids +288 drivers/regulator/max20086-regulator.c

   287	
 > 288	static const struct of_device_id max20086_dt_ids[] = {
   289		{
   290			.compatible = "maxim,max20086",
   291			.data = &(const struct max20086_chip_info) {
   292				.id = MAX20086_DEVICE_ID_MAX20086,
   293				.num_outputs = 4,
   294			}
   295		}, {
   296			.compatible = "maxim,max20087",
   297			.data = &(const struct max20086_chip_info) {
   298				.id = MAX20086_DEVICE_ID_MAX20087,
   299				.num_outputs = 4,
   300			}
   301		}, {
   302			.compatible = "maxim,max20088",
   303			.data = &(const struct max20086_chip_info) {
   304				.id = MAX20086_DEVICE_ID_MAX20088,
   305				.num_outputs = 2,
   306			}
   307		}, {
   308			.compatible = "maxim,max20089",
   309			.data = &(const struct max20086_chip_info) {
   310				.id = MAX20086_DEVICE_ID_MAX20089,
   311				.num_outputs = 2,
   312			}
   313		},
   314		{ /* Sentinel */ },
   315	};
   316	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
