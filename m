Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C95336C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiEYGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242458AbiEYGes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:34:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD04EA13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653460487; x=1684996487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M0oKdsgpAFHdUbHYt90/YCZ+zPrx6X/Xj0vgaYZnyG4=;
  b=NLE1SCyx5qNngRgCfSvc6gpeHNjNTq/+gaN4QEgAkW9i+on30Zf7ZQ5P
   NMn4VJpxZCe/U42yLhoHmzfTi7kYxZ7BX63e1KQsFFCYS0AAtA0ORC1GV
   0Op/3MJqarqYLT6DnK1Xu2FsmWCOvBl7Wt4YOu7gUNHsWsBKeIym3cwSN
   diRkYCwKlogxYbAuKxZK/6v5QCPLCUK5NPacLauGVWZeAyLaHibayYNen
   LuVADUhJdtKMeUFHJOL1QrtD+hNxgLW1M4V2CKRliDq4HdByCZSTMs4O4
   sbQxnRxKax/HIKr3i9zSc1dxXuL+YwlOjByjCx3vW8KGuDObGrBtgHucL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273459208"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273459208"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745546927"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2022 23:34:45 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntkbV-0002oM-8y;
        Wed, 25 May 2022 06:34:45 +0000
Date:   Wed, 25 May 2022 14:33:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: drivers/clk/imx/clk-imx93.c:324:34: warning: unused variable
 'imx93_clk_of_match'
Message-ID: <202205251429.1APkCSOG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fdaf9a5840acaab18694a19e0eb0aa51162eeeed
commit: 24defbe194b650218680fcd9dec8cd103537b531 clk: imx: add i.MX93 clk
date:   3 months ago
config: hexagon-buildonly-randconfig-r001-20220525 (https://download.01.org/0day-ci/archive/20220525/202205251429.1APkCSOG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
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
