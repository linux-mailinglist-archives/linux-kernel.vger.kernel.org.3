Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10D4F16F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377221AbiDDO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358330AbiDDO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:28:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039E3BFA3;
        Mon,  4 Apr 2022 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649082387; x=1680618387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YFMFyz8A4KQU+l3+HDFx/zBlfNq5vKwG+g4aU+dWt+M=;
  b=SzvnfVhPArQxDV4mUfMyHyEmdf6+X0XSvL/96q0mkTZeucr+2hrrfrfC
   zFfaFxIWwglNGRjoFULtbJMB9LVJO1VgI3jTuHCOPAlUvMwzqBa0+5pX5
   hQITlDLT01Kboc0XIhNNHzrNgylhK7YZMpaUNDZ42RQjCd+02lJcoNq8d
   xDtgO2pPiXzrlVlQVGHqtOULIsOMqUZMPOXVLHQ5Rbw+PYF4aLdlDivLN
   mJElYBgeGrsF3aGS4JKXApTspZfCNbaGEY7ugCHfanrmKL+Cau7KFb4qW
   JKJqDWMZj2iYV1CfJ9rEH6d+yyU/EVRNEzOWqPNcfOnXP0kPEOAcQRJ2I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323698513"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323698513"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 07:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="657518638"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2022 07:26:16 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbNep-00027d-VP;
        Mon, 04 Apr 2022 14:26:15 +0000
Date:   Mon, 4 Apr 2022 22:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     kbuild-all@lists.01.org, Liang Yang <liang.yang@amlogic.com>,
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
Subject: Re: [PATCH v4 1/2] mtd: rawnand: meson: discard the common MMC sub
 clock framework
Message-ID: <202204042238.eZq8bjau-lkp@intel.com>
References: <20220402074921.13316-2-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402074921.13316-2-liang.yang@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
[also build test ERROR on mtd/mtd/next mtd/mtd/fixes robh/for-next v5.18-rc1 next-20220404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Yang/refine-the-NFC-clock-framework/20220402-155036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
config: s390-randconfig-r002-20220403 (https://download.01.org/0day-ci/archive/20220404/202204042238.eZq8bjau-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c34b64ab8005a978739f157a07ed342d247fecac
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-Yang/refine-the-NFC-clock-framework/20220402-155036
        git checkout c34b64ab8005a978739f157a07ed342d247fecac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/mtd/nand/raw/meson_nand.o: in function `meson_nfc_probe':
   meson_nand.c:(.text+0xd9e): undefined reference to `clk_divider_ops'
>> s390-linux-ld: meson_nand.c:(.text+0xe34): undefined reference to `devm_clk_register'
   s390-linux-ld: net/core/sock.o: in function `sk_destruct':
   sock.c:(.text+0x373e): undefined reference to `__sk_defer_free_flush'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
