Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE24B585D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356998AbiBNRUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:20:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356997AbiBNRUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:20:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE44652D7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644859216; x=1676395216;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BAeNsOY0uqTmM7se1dt63YdDCvDLcIoZUPwATxAwt14=;
  b=j6KqKx0c/2QrF2fo/mLgGwA1hEuA3WoC8iCCxbUJTPD1rP/4wuU2HTRr
   pNCXLcHmH8GqSdZRZp/xD+Cx5UgI6XOqEHRF2ywaeR+i4DeIj07/71rG3
   V/d3ymiud11e1nrkBo7sswcmeTYcxicAK0x4BDL038zYcumwWJGOpDVFq
   zAh0MPrzMX1ClDgfys2q7Zja1KKFq0JQ8ouT278yTeGz+eDG1EHG3T1Fj
   KQoASDKZ2bwQbZgdTUeGvjuUwkgNu08mOLBUtYGgCx2A5OmGliol2T11D
   0IHg1XyDwvlNPLNKlVg7gCV4brlIOOzCzLEoCC8SdXSNKoYRZJwUgr5SR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237548048"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="237548048"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="528303945"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2022 09:20:14 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJf1K-0008n6-3h; Mon, 14 Feb 2022 17:20:14 +0000
Date:   Tue, 15 Feb 2022 01:19:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Watson Chow <watson.chow@avnet.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/regulator/max20086-regulator.c:288:34: error:
 'max20086_dt_ids' defined but not used
Message-ID: <202202142332.ciTQ7uCd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: bfff546aae50ae68ed395bf0e0848188d27b0ba3 regulator: Add MAX20086-MAX20089 driver
date:   5 weeks ago
config: xtensa-randconfig-c004-20220213 (https://download.01.org/0day-ci/archive/20220214/202202142332.ciTQ7uCd-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfff546aae50ae68ed395bf0e0848188d27b0ba3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bfff546aae50ae68ed395bf0e0848188d27b0ba3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash arch/xtensa/ drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/regulator/max20086-regulator.c:288:34: error: 'max20086_dt_ids' defined but not used [-Werror=unused-const-variable=]
     288 | static const struct of_device_id max20086_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
