Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64B34F520E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiDFC3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379706AbiDEVdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:33:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8153719
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649192736; x=1680728736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JqaYMwGEXpddZ7ZUFSouvDUJd/m68Tphv68XwazE8qo=;
  b=nIGjD87JSoDd67nMWMhmcTxu0jbipTx6LICpSqLI817qTpz4KFvEsJHU
   XJqL1qCYBRovLfeKQr73rsxZnuvh5/XKFp+oNcHzBlUjaf62/lK4r/vQy
   tFL0yiT1i2hxV/bFM9an7v3xC47ozp7ggbRIW/ouyRtLCv3TB3uCd4cw8
   zTj8nl5btIuhCNnlpJvxbRaUxHEpVwdwuII19nBNt7VK7XUU3E6gQJB7P
   1V2AvkA9/KI6lP31gYabEWylzq+RBB+elbcoBrHoi5T5VyQ+pF/r78A4b
   tUeAEzdoaYxtGk8rHkxzZoyu7LaXU+Qd0TO8/JDmdeCNkpjPIZfFgmLy2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="243004874"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="243004874"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="722213854"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2022 14:05:34 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbqMn-0003kp-KL;
        Tue, 05 Apr 2022 21:05:33 +0000
Date:   Wed, 6 Apr 2022 05:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: drivers/clk/imx/clk-imx93.c:324:34: warning: unused variable
 'imx93_clk_of_match'
Message-ID: <202204060405.Le0PCoYZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e732ebf7316ac83e8562db7e64cc68aec390a18
commit: 24defbe194b650218680fcd9dec8cd103537b531 clk: imx: add i.MX93 clk
date:   5 weeks ago
config: hexagon-randconfig-r032-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060405.Le0PCoYZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24defbe194b650218680fcd9dec8cd103537b531
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 24defbe194b650218680fcd9dec8cd103537b531
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/imx/

If you fix the issue, kindly add following tag as appropriate
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
