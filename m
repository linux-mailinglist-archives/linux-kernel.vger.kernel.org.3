Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E144F4E11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587398AbiDFAI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbiDEMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:42:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACF107809;
        Tue,  5 Apr 2022 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649159293; x=1680695293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lx91HnTsU6TyC6GmdWAsmAGHgR+SGdQHhtVYtI/tJfs=;
  b=Lf/Ofu+6yAYOIf+HGxGVAeLKKs2JM3q+FvBIZ3W3k6WVPya7ouSzEnqh
   Cfq39SnLYWJxhQpJULsYuAFSpMQdeW9PmmnzBqqKmjc7AAUxOzGqlfVL5
   rovCDuLTXaUI/VZcmmGZ/W9FOxG35bq77zpwViaaiVbBzJ5xEXuCEEP82
   rFGNUtUTHfsyrXiEACSH5JxUMTGCfXfK8MCE+Ii6aalYItU/YQQVjjkpw
   THtomc7jp3Zrk5/FRwSjFokRVXZwxb1d9E0iaFsIzn7KBopQ+kcx4/367
   5OyPkQmLh+6eSVO4Oahlmmr2PFhfR1PKgWxYrvYGE2w0Swd+vGDygaM1+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="258313471"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258313471"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569848681"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2022 04:48:08 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbhfL-0003B9-Dt;
        Tue, 05 Apr 2022 11:48:07 +0000
Date:   Tue, 5 Apr 2022 19:48:01 +0800
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
Message-ID: <202204051917.AuOOMCQd-lkp@intel.com>
References: <20220402074921.13316-2-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402074921.13316-2-liang.yang@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test ERROR on mtd/mtd/next mtd/mtd/fixes robh/for-next v5.18-rc1 next-20220405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Yang/refine-the-NFC-clock-framework/20220402-155036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
config: parisc-randconfig-r001-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051917.AuOOMCQd-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c34b64ab8005a978739f157a07ed342d247fecac
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-Yang/refine-the-NFC-clock-framework/20220402-155036
        git checkout c34b64ab8005a978739f157a07ed342d247fecac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_clk_register" [drivers/mtd/nand/raw/meson_nand.ko] undefined!
>> ERROR: modpost: "clk_divider_ops" [drivers/mtd/nand/raw/meson_nand.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
