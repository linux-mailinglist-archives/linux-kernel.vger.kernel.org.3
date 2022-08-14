Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD785926EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiHNXT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 19:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 19:19:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C18012AFA
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660519163; x=1692055163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QrAyEWHZH+836CPboTbqpdmW5ahg8JoCXwhMPGFNxAw=;
  b=MeABdWZFItlHHk1cImD8HzKMlG4lXx9ykQnbhrLpPc+YcRz+gr/1H8Ap
   jAZGsT29MNBuKT0UMq+7Vha7ewfGU9ZQwh9qRiahKTMPPfZzSQYxzqLDQ
   2nz7s2kCfxQEDfFa0RHf1ohZ4xt/QLd32On9osz/v/zLkMgSqW6FL4Dzd
   kHmSAQqxxtYPq9P4nBLOxkY485tB4E/4tOivQdklEjZhCxvmvzi34DGfi
   UXAfSShHDHhfSlYPvTkkIGBxXq+0YYMPp0hlzAv/D5zNR/lnz8CPEXlyM
   W5/KVFwqOnYWWgt2EspC6jgKOKr40AR4DOQb4p/CO1vLPL5BqlPFXYQF2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="293129415"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="293129415"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 16:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="666463321"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2022 16:19:20 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNMt6-0000cX-14;
        Sun, 14 Aug 2022 23:19:20 +0000
Date:   Mon, 15 Aug 2022 07:19:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match'
 defined but not used
Message-ID: <202208150738.90lTg896-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f162193d6e48eb4ff51c2ea3612f1daebca1b7e
commit: 24defbe194b650218680fcd9dec8cd103537b531 clk: imx: add i.MX93 clk
date:   5 months ago
config: x86_64-buildonly-randconfig-r003-20220815 (https://download.01.org/0day-ci/archive/20220815/202208150738.90lTg896-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24defbe194b650218680fcd9dec8cd103537b531
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 24defbe194b650218680fcd9dec8cd103537b531
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/clk/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match' defined but not used [-Wunused-const-variable=]
     324 | static const struct of_device_id imx93_clk_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~


vim +/imx93_clk_of_match +324 drivers/clk/imx/clk-imx93.c

   323	
 > 324	static const struct of_device_id imx93_clk_of_match[] = {
   325		{ .compatible = "fsl,imx93-ccm" },
   326		{ /* Sentinel */ },
   327	};
   328	MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
   329	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
