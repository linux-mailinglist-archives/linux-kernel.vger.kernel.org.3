Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F064BA097
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiBQNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:06:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiBQNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:06:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607782A8D04;
        Thu, 17 Feb 2022 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645103157; x=1676639157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y40DBqaIdT6zBhrgCBj8cBu666AKZYDew2yl1iQwfVY=;
  b=QuaHIKK7S+ggzo9G375dg6wtprYz5TJ2NrJZqgYDGBFF8rfQElQdq99w
   k2ChiIpvxL+fKKVWWGuLU07PA32FSlBfXEJFI4enBoqPBqrK6KIxsepoh
   JJN1L762kRXXcGSYcgUYWjt7LidlmREFzGAEceGGdhY8WQELUgs4pi+LG
   lNPWDYZJGGOlo1n596auJXBMXKRL9Q+x5P6hMyYPajnPdLiAmFf7f3/wc
   oNhBdGFpVpq1mKzFIqOXWshx11IB0GPIdUnky+R6DokqbI2I8oVFwhuOr
   51S5grlv+auv8qh4cdCQ2tpnqEoFm6U3a+q/oXDxUuTrMg4bbuwDOjZGq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="251066649"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="251066649"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="589386402"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2022 05:05:50 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKgTl-0000D7-BO; Thu, 17 Feb 2022 13:05:49 +0000
Date:   Thu, 17 Feb 2022 21:05:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] mtd: rawnand: meson: discard the common
 MMC sub clock framework
Message-ID: <202202172131.hVJG538q-lkp@intel.com>
References: <20220217063346.21691-2-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217063346.21691-2-liang.yang@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

I love your patch! Yet something to improve:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on mtd/mtd/next mtd/mtd/fixes robh/for-next v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Liang-Yang/refine-the-NFC-clock-framework/20220217-145053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
config: hexagon-randconfig-r013-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172131.hVJG538q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d3d7ef65145346ff8212125d56afff6290a5ab68
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Liang-Yang/refine-the-NFC-clock-framework/20220217-145053
        git checkout d3d7ef65145346ff8212125d56afff6290a5ab68
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __clk_get_name
   >>> referenced by meson_nand.c
   >>> mtd/nand/raw/meson_nand.o:(meson_nfc_probe) in archive drivers/built-in.a
   >>> referenced by meson_nand.c
   >>> mtd/nand/raw/meson_nand.o:(meson_nfc_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: clk_divider_ops
   >>> referenced by meson_nand.c
   >>> mtd/nand/raw/meson_nand.o:(meson_nfc_probe) in archive drivers/built-in.a
   >>> referenced by meson_nand.c
   >>> mtd/nand/raw/meson_nand.o:(meson_nfc_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: devm_clk_register
   >>> referenced by meson_nand.c
   >>> mtd/nand/raw/meson_nand.o:(meson_nfc_probe) in archive drivers/built-in.a
   >>> referenced by meson_nand.c
   >>> mtd/nand/raw/meson_nand.o:(meson_nfc_probe) in archive drivers/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
