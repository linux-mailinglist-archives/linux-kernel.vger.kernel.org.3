Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065994C8CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiCANnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiCANnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:43:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416CA4C787
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646142190; x=1677678190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xQXC5Q6QovMBIcAZOvRgYjMGiuNQt1UM+vNXcUeEu7E=;
  b=GKrxdx00IfzxSL2X8XCljfQfTCTP4xQeepJ3rHgVQuU/M23UOv9D9Rn4
   QHeeDLwMN4uRnsn2eiNqjwYbNHg9KQemsNhZkUE3C63D/DvTuc2J55yM4
   Znx/0bI8C1iOq0Lhkqc68BQcmMWv+BV5I0KDjvTHnkBUV/6JTeXw4xvs3
   Fg7v1+KHLu+X1MTn5kCXY0k6yx4TfmxTUAF3Au1RKQ5LTrgV9SOIol25j
   Qj6izJpIKg008lzUaFBDAsTM/BgLEGNMMnvw2PJxWqLXl//Lix20G2kmE
   DGStdqp88Sugw9GB0/kljVyUEx641WZmRWEJJSmMySvbP8X3x91hUFZ7+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250713760"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="250713760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="507804617"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2022 05:43:08 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP2mR-0000Vr-K8; Tue, 01 Mar 2022 13:43:07 +0000
Date:   Tue, 1 Mar 2022 21:42:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [matthias-bgg:v5.17-next/soc 11/14]
 drivers/soc/mediatek/mtk-mmsys.c:64:3: error: field designator
 'sw0_rst_offset' does not refer to any field in type 'const struct
 mtk_mmsys_driver_data'
Message-ID: <202203012101.qgsgTBcz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v5.17-next/soc
head:   eb1b02bef52ae545d5eb24116d5c099f738d39d5
commit: 831785f0e5b919c29e1bc5f9a74e9ebd38289e24 [11/14] soc: mediatek: mmsys: add mmsys reset control for MT8186
config: mips-randconfig-r004-20220301 (https://download.01.org/0day-ci/archive/20220301/202203012101.qgsgTBcz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?id=831785f0e5b919c29e1bc5f9a74e9ebd38289e24
        git remote add matthias-bgg https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
        git fetch --no-tags matthias-bgg v5.17-next/soc
        git checkout 831785f0e5b919c29e1bc5f9a74e9ebd38289e24
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/soc/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/mediatek/mtk-mmsys.c:64:3: error: field designator 'sw0_rst_offset' does not refer to any field in type 'const struct mtk_mmsys_driver_data'
           .sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
            ^
   1 error generated.


vim +64 drivers/soc/mediatek/mtk-mmsys.c

    59	
    60	static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
    61		.clk_driver = "clk-mt8186-mm",
    62		.routes = mmsys_mt8186_routing_table,
    63		.num_routes = ARRAY_SIZE(mmsys_mt8186_routing_table),
  > 64		.sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
    65	};
    66	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
