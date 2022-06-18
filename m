Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8085503DF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiFRJ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiFRJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:29:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E931EECF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655544554; x=1687080554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FZTpgPb5ZMmV97zM29tbzRVe1LRVIroAaiNLt081iXw=;
  b=KioBvo+8cT3eYk1K9M03pd/AUa8n5GYQ8Nd1ZWYNth9+BO9mf7GJ7bbK
   zcMg36f1JkBHUirokWQOT7rwf2IIAN46E9oWE5Y0jNu65ehkDYddZJBe1
   prxVZB1TVLumPmvVcSJrUEMfxVEYGgnhbdbDYXg5gWiRWDpMjtbjvW9Oh
   eMh9Pn1lo9vz2Q7iApCFdc/AtS/5/mX2Fve8P07nZrXYIjxG6WJMKOdfO
   p8DbCQalBGWeDZcMJ2Z49rOvCRd8VuPYAttCDQJX2pPxgXc39KvWkIILt
   Gaw29YyD28p++6rtZkRAbz4LuIpOtfYrQR5YltZGHvc1P+K1qBld+U3dC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260074980"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260074980"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 02:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="560998187"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2022 02:29:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2UlT-000QCd-9q;
        Sat, 18 Jun 2022 09:29:11 +0000
Date:   Sat, 18 Jun 2022 17:28:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: drivers/clk/imx/clk-imx93.c:324:34: warning: unused variable
 'imx93_clk_of_match'
Message-ID: <202206181724.AJ9MP0Jw-lkp@intel.com>
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

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: 24defbe194b650218680fcd9dec8cd103537b531 clk: imx: add i.MX93 clk
date:   4 months ago
config: hexagon-randconfig-r041-20220618 (https://download.01.org/0day-ci/archive/20220618/202206181724.AJ9MP0Jw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 91688716ba49942051dccdf7b9c4f81a7ec8feaf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24defbe194b650218680fcd9dec8cd103537b531
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 24defbe194b650218680fcd9dec8cd103537b531
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/imx/clk-imx93.c:324:34: warning: unused variable 'imx93_clk_of_match' [-Wunused-const-variable]
   static const struct of_device_id imx93_clk_of_match[] = {
                                    ^
   1 warning generated.


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
