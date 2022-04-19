Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A86507A38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbiDSTaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbiDSTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:30:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD320BFA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650396441; x=1681932441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AWV0nFDudSa8k5CXl+StQ2rO2zSr5AFYSyncP3znOPs=;
  b=mWzAWFuCm0huAVQogbnuXC7X1W2BMHrgmbo2P0UnBJ+LOvVrNoNfJ7Wn
   WSKGOGTqtQiNoY8QzPTvMnYE+l28yfqK/olKCsgI2cUYbCaSBG1LvHgqw
   BesGpsqhbw/8LQWDBy7oWMHRzoyEMXBaGBiZzKS45+rHvkCuoUffeLEMc
   saMSK6qJG+QMKhyMcO8rcM1gug+3wF235APx9nH91PBboevNxpnPGBSAJ
   cPL/hVe5nN5TTYvjfPqiO2mGHgNEpGp8roP699UP2CLLTuNy4PvGrxp0G
   3F9eFtvK558TjYX1o2MqPzwmmoTmT4FHwGJ+4pP41M3bzgGEGr/RrcGcg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245744997"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245744997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 12:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="510252822"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2022 12:27:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngtVO-00067I-S8;
        Tue, 19 Apr 2022 19:27:18 +0000
Date:   Wed, 20 Apr 2022 03:26:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:file4opaUI 20/24] drivers/spi/spi-intel.c:808:43: error:
 too many arguments to function call, expected 3, have 4
Message-ID: <202204200302.RR7dzxDb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git file4opaUI
head:   64ef86292800d770fcd8916cf07b1bea58559680
commit: 246bb4cbc6a55a247e5e0afd57c91e0dec0c77c3 [20/24] spi: intel: Implement dirmap hooks
config: arm-randconfig-r025-20220419 (https://download.01.org/0day-ci/archive/20220420/202204200302.RR7dzxDb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=246bb4cbc6a55a247e5e0afd57c91e0dec0c77c3
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci file4opaUI
        git checkout 246bb4cbc6a55a247e5e0afd57c91e0dec0c77c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/spi/spi-intel.c:808:43: error: too many arguments to function call, expected 3, have 4
           ret = iop->exec_op(ispi, desc->mem, iop, &op);
                 ~~~~~~~~~~~~                       ^~~
   drivers/spi/spi-intel.c:824:43: error: too many arguments to function call, expected 3, have 4
           ret = iop->exec_op(ispi, desc->mem, iop, &op);
                 ~~~~~~~~~~~~                       ^~~
   2 errors generated.


vim +808 drivers/spi/spi-intel.c

   794	
   795	static ssize_t intel_spi_dirmap_read(struct spi_mem_dirmap_desc *desc, u64 offs,
   796					     size_t len, void *buf)
   797	{
   798		struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
   799		const struct intel_spi_mem_op *iop = desc->priv;
   800		struct spi_mem_op op = desc->info.op_tmpl;
   801		int ret;
   802	
   803		/* Fill in the gaps */
   804		op.addr.val = offs;
   805		op.data.nbytes = len;
   806		op.data.buf.in = buf;
   807	
 > 808		ret = iop->exec_op(ispi, desc->mem, iop, &op);
   809		return ret ? ret : len;
   810	}
   811	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
