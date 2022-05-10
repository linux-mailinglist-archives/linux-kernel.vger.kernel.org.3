Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB506520AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiEJBuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiEJBud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:50:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06F1BB9B3;
        Mon,  9 May 2022 18:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652147197; x=1683683197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jm5HcOG6ePgg0xlvCVUpmfa8KgOU7ubHWo2csDDoiZs=;
  b=WsF9LHujRIZj4AVp/EHci+gYmiMyfntDBuWY5WpTiap3YwM+79iw/BFe
   Bvp16elpueIy3L91Tq4r+nbKlHGpmjZyiF2QUKB2nt9FAZWYF6YH+IMOr
   CwdN/tpRAjqO24UpENepA3uX/iN0rKuQRzUPxKqD567g5MiT/awghCBu7
   OeLNnka6/KUeT9f4x4WVb3G2I8Fy1q8ry3p71Xuo/3jzLGzJZRE3kP+T1
   99xqq17IJiuVCX1PCROsorGROrBmLHrIHUf8JFAj205GDo9Vl7C4V6R2b
   Di/BK+6HMP0NYuuTwhTDo2EiaJVpwy4tS8m8A066kS3yzPo04cxaa4duI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251272773"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="251272773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 18:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="669638245"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2022 18:46:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noExA-000H8k-DG;
        Tue, 10 May 2022 01:46:20 +0000
Date:   Tue, 10 May 2022 09:46:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        Manohar.Puri@microchip.com, Kavyasree.Kotagiri@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Message-ID: <202205100948.56scrQeg-lkp@intel.com>
References: <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kavyasree,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on robh/for-next]
[cannot apply to soc/for-next linus/master v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220509-171104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: arm-at91_dt_defconfig (https://download.01.org/0day-ci/archive/20220510/202205100948.56scrQeg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6b77ec16441906d1aa067b60cf97807111abdd72
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220509-171104
        git checkout 6b77ec16441906d1aa067b60cf97807111abdd72
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/mfd/atmel-flexcom.o: in function `atmel_flexcom_probe':
   atmel-flexcom.c:(.text+0x160): undefined reference to `devm_mux_control_get'
>> arm-linux-gnueabi-ld: atmel-flexcom.c:(.text+0x1ec): undefined reference to `mux_control_select_delay'
>> arm-linux-gnueabi-ld: atmel-flexcom.c:(.text+0x1fc): undefined reference to `mux_control_deselect'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
