Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0084B3445
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiBLKjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:39:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiBLKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:39:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D426548
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644662383; x=1676198383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dyrVGvm6aHy6JUcrneabP4PT1dWr5KSKwYtqdojd098=;
  b=R2PDU5u9CzjEDYfcWTlkeQ+jY0GRKsSby0pMbvCnv4MY2Y3ft4Vpe1Gs
   9IE7TDvRULW9lQyzhHWhHRy0sFoyzr6u1ECdkRzEpzSqL4iNmxQioRWTv
   UwSfuO/mWa1jd4Uqj4BZPHJP8RsEzAOriK9NB43cLSjuI3/t2bNj+hS2f
   Q+Rx6H1gAkR22n2h3gf/sHqBRv+jjmLeap07H+NpubBycbO2hWqoIDWTd
   0swBku5N0AZ1Z6Ra6RQEFJ9Pzjtl4Mo5iw5G/CVrJ9dQHT0hYsrmU3uLo
   4XfFKf4tdGg/9jU/bZcYQqWKOpfxOqGhFPw1/O6/iFzvAFFCv+OmWAHxq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="274433749"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="274433749"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 02:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="537874368"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Feb 2022 02:39:41 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIpob-00061T-2e; Sat, 12 Feb 2022 10:39:41 +0000
Date:   Sat, 12 Feb 2022 18:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mkp:5.18/discovery2 64/67] drivers/scsi/sd.c:1096:4: warning: add
 explicit braces to avoid dangling else
Message-ID: <202202121642.NBfsbeBr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git 5.18/discovery2
head:   7c371ec158614870d9c9c5d1a9e0f0c35f9198d7
commit: 56db0eb9f48930efde746c3cb9af11524102dc76 [64/67] scsi: sd: Implement support for NDOB flag in WRITE SAME(16)
config: riscv-randconfig-r021-20220211 (https://download.01.org/0day-ci/archive/20220212/202202121642.NBfsbeBr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c7eb84634519e6497be42f5fe323f9a04ed67127)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git/commit/?id=56db0eb9f48930efde746c3cb9af11524102dc76
        git remote add mkp https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git
        git fetch --no-tags mkp 5.18/discovery2
        git checkout 56db0eb9f48930efde746c3cb9af11524102dc76
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/sd.c:1096:4: warning: add explicit braces to avoid dangling else [-Wdangling-else]
                           else
                           ^
   1 warning generated.


vim +1096 drivers/scsi/sd.c

  1076	
  1077	static void sd_config_write_zeroes(struct scsi_disk *sdkp,
  1078					   enum sd_zeroing_mode mode)
  1079	{
  1080		struct request_queue *q = sdkp->disk->queue;
  1081		unsigned int logical_block_size = sdkp->device->sector_size;
  1082	
  1083		if (mode == SD_ZERO_DEFAULT && !sdkp->zeroing_override) {
  1084			mode = SD_ZERO_WRITE;
  1085	
  1086			if (sdkp->lbprz && sdkp->lbpws)
  1087				if (sdkp->ndob)
  1088					mode = SD_ZERO_WS16_NDOB;
  1089				else
  1090					mode = SD_ZERO_WS16_UNMAP;
  1091			else if (sdkp->lbprz && sdkp->lbpws10)
  1092				mode = SD_ZERO_WS10_UNMAP;
  1093			else if (sdkp->max_ws_blocks)
  1094				if (sdkp->ndob)
  1095					mode = SD_ZERO_WS16_NDOB;
> 1096				else
  1097					mode = SD_ZERO_WS;
  1098		}
  1099	
  1100		if (mode == SD_ZERO_DISABLE)
  1101			sdkp->zeroing_override = true;
  1102	
  1103		sdkp->zeroing_mode = mode;
  1104		blk_queue_max_write_zeroes_sectors(q, sdkp->max_ws_blocks *
  1105						   (logical_block_size >> 9));
  1106	}
  1107	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
