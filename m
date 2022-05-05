Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE051CA8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385842AbiEEUbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385837AbiEEUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:31:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F575F26D;
        Thu,  5 May 2022 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651782449; x=1683318449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LBkM+/38j5GpzaAIvuHMMzTzEjphpOTuzU4wuxKrqqE=;
  b=Q55U7InrBbNj2+Z2mENUwcQdBj6n7CV5/1nZ3K6CQ1TOMdy0DRR9/DDM
   BP6I/EF0onxNrPn5nwsmdQZzOAQeaVItFX3cJ9ZIV7VHrFxEdhbccPO3p
   6gdhuilIb9rPjojzuuvfz83OZSv0lUfSB893H5zyc1vZYrvYxGobGfLoo
   4L7nfXjsFWy6C19hkTIIgGaRPPGTk8kATH/WQwGrHkvSVtIfUH6m1nMI7
   f3t+0+2mni6qPAcXI77r2wjHOtEJvurRQPs2xraSG13QMS/NpeGkObMuK
   js+E6kXnYOoCcWcbaH7m22d7lPyT5ZPKjPmYmGI53Rw1Ws18glgbmNGUK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268134725"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268134725"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 13:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="891502899"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2022 13:27:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmi4J-000Cj6-UP;
        Thu, 05 May 2022 20:27:23 +0000
Date:   Fri, 6 May 2022 04:26:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        Kavyasree.Kotagiri@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 4/4] mux: lan966: Add support for flexcom mux controller
Message-ID: <202205060409.Vpkpcw6T-lkp@intel.com>
References: <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
[cannot apply to soc/for-next linus/master v5.18-rc5 next-20220505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220503-190011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220506/202205060409.Vpkpcw6T-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8c4bcef1d51c8668507ca53f7cad11e6ace1b2b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220503-190011
        git checkout f8c4bcef1d51c8668507ca53f7cad11e6ace1b2b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_mux_control_get
   >>> referenced by atmel-flexcom.c
   >>> mfd/atmel-flexcom.o:(atmel_flexcom_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: mux_control_select_delay
   >>> referenced by atmel-flexcom.c
   >>> mfd/atmel-flexcom.o:(atmel_flexcom_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: mux_control_deselect
   >>> referenced by atmel-flexcom.c
   >>> mfd/atmel-flexcom.o:(atmel_flexcom_probe) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
