Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD64E6FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 10:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356205AbiCYJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCYJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:05:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98A45D662;
        Fri, 25 Mar 2022 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648199016; x=1679735016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WbskBVThk2A3f0bek82d4zhtf8YdkGCFyymR0cmcN2k=;
  b=Vsdm8eyG+X53V/UjHR5T1cGPPppcCPo0sQXnFChlbxotjBQz6PF4+vi3
   sT8C3R57Vb+XZBrPkv4g/ut6QPLL0IHX1Ivj+QThs3/sB2tL6riNcaS0w
   9dZNE0HohFNi5EsOl2wJyvbnitnrAxS3JYCluhD/rntNisc3uzZ5T2Cg3
   I/6k3Q1K6ycAGGChsduAzGCs4wGo/aHo90FD5xZb7AFHKek+vAnbQb23G
   BvTrxqk43RFV1fN+/56oWYUMRJw4IBUdGvrRfoo4KwQI232YzKAr2VADu
   /7+64ebhJT1AIzPdgDdleCeeY9vL+ydWG3gyCSPiu9QNjeBmExk2pnLJ2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="246068158"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="246068158"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 02:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="825977531"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2022 02:03:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXfqo-000Lyi-70; Fri, 25 Mar 2022 09:03:18 +0000
Date:   Fri, 25 Mar 2022 17:02:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Howard Chiu <howard_chiu@aspeedtech.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: ast2600-evb: Support KVM
Message-ID: <202203251620.taj6u6mo-lkp@intel.com>
References: <HK0PR06MB2307383743B9AE1D714A899BE61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB2307383743B9AE1D714A899BE61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.17]
[cannot apply to joel-aspeed/for-next next-20220324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Howard-Chiu/ARM-dts-aspeed-ast2600-evb-Support-KVM/20220325-103839
base:    f443e374ae131c168a065ea1748feac6b2e76613
config: arm-aspeed_g4_defconfig (https://download.01.org/0day-ci/archive/20220325/202203251620.taj6u6mo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/9037b86779cd7616b378b3bafd1f32b4c862f0bd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Howard-Chiu/ARM-dts-aspeed-ast2600-evb-Support-KVM/20220325-103839
        git checkout 9037b86779cd7616b378b3bafd1f32b4c862f0bd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-ast2600-evb.dts:322.1-7 Label or path video not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
