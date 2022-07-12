Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC0570FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiGLBzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGLBzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:55:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1278930552
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657590953; x=1689126953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yhg4X3uJ78CkkuhpD1JTMC4vc3XrLWPPFKLY1I7Nr7I=;
  b=h5J28Ew8RRLm+At0eUcxQ690W37kOXD9eULm15EbpO2WHtSxgBgY3FUd
   DrbgvkX40CcWcavsn39MHezQxbyVMGKSMjpIjPLQ/0TZfiyxS206qw2a1
   SbO3w3kW1Y5hz0v+qcvWH1C55zt22Oqh/E5+QDwmGKX56mVbfG5CvYVOc
   ZJqA8SbZ9JVuckz3IU7lVMA5W+Mxp/di5EDusP6i20p195li69/Laog48
   cInwwR5hKdVG4j9ZTXYI++sTqu45STAzBwnj8Smy/tcBFup4DnsMtRD6E
   fGkkcrmBluU9oUFrS/5sPQWSeXfL7ilRWqG+74skPPMn8jAio60ZzJhlh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="265227371"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="265227371"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 18:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="622315816"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2022 18:55:51 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB57u-0001X5-Jr;
        Tue, 12 Jul 2022 01:55:50 +0000
Date:   Tue, 12 Jul 2022 09:55:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 4/18]
 drivers/platform/apple/smc_rtkit.c:74:16: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202207120900.4SEXcrZa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   b76dc0fdf51c9227cd04d9d3648a5555d9c61fa8
commit: 092d508daf53fa9e5ba7fb7c0163a125753054c3 [4/18] platform/apple: Add new Apple Mac SMC driver
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220712/202207120900.4SEXcrZa-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/092d508daf53fa9e5ba7fb7c0163a125753054c3
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 092d508daf53fa9e5ba7fb7c0163a125753054c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/platform/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_rtkit_write_key_atomic':
>> drivers/platform/apple/smc_rtkit.c:74:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      74 |         msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
         |                ^~~~~~~~~~
>> drivers/platform/apple/smc_rtkit.c:95:13: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      95 |         if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
         |             ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +74 drivers/platform/apple/smc_rtkit.c

    58	
    59	static int apple_smc_rtkit_write_key_atomic(void *cookie, smc_key key, void *buf, size_t size)
    60	{
    61		struct apple_smc_rtkit *smc = cookie;
    62		int ret;
    63		u64 msg;
    64		u8 result;
    65	
    66		if (size > SMC_SHMEM_SIZE || size == 0)
    67			return -EINVAL;
    68	
    69		if (!smc->alive)
    70			return -EIO;
    71	
    72		memcpy_toio(smc->shmem.iomem, buf, size);
    73		smc->msg_id = (smc->msg_id + 1) & 0xf;
  > 74		msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
    75		       FIELD_PREP(SMC_SIZE, size) |
    76		       FIELD_PREP(SMC_ID, smc->msg_id) |
    77		       FIELD_PREP(SMC_DATA, key));
    78		smc->atomic_pending = true;
    79	
    80		ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL, true);
    81		if (ret < 0) {
    82			dev_err(smc->dev, "Failed to send command (%d)\n", ret);
    83			return ret;
    84		}
    85	
    86		while (smc->atomic_pending) {
    87			ret = apple_rtkit_poll(smc->rtk);
    88			if (ret < 0) {
    89				dev_err(smc->dev, "RTKit poll failed (%llx)", msg);
    90				return ret;
    91			}
    92			udelay(100);
    93		}
    94	
  > 95		if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
    96			dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
    97				smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
    98			return -EIO;
    99		}
   100	
   101		result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
   102		if (result != 0)
   103			return -result;
   104	
   105		return FIELD_GET(SMC_SIZE, smc->cmd_ret);
   106	}
   107	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
