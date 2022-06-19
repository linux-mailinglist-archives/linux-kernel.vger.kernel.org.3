Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BC550C86
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiFSSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 14:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiFSSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 14:21:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2192A1A9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655662869; x=1687198869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LokuTxrf7FEz6z3UVnL1sqws76EIAjh154NaohlIX24=;
  b=GQm0+Ta9lUUtQIVV965/X9odEtYQMvWEgo/Y2BQeERPLTM3o0Ei8K/sM
   1qeIAGzt2zy2iu1R8nJmE9u654MtUqpGgrYVNQP2E+hdYeuRvrMOKgZIo
   R6aq+395QdLbwnBXVjvzwlzBmLMuvZXdmMSIzMPu1uTcQhkbj+IhCM9V5
   37uAgAXwDDK/i+t6EvbH57pNvV2ojJHBs2EcJptFt6TmF1PIhxRbydK/i
   Zb6WK8pX//eze9AISGwZr1mnLYWquscCprscklf8+XFH0GxwqNJoBS9cy
   yZqS8FYGUK9+BuemMVnEQ33KBWhduARGa2cyfgkW2sf4GOD0vfnXdUNCw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279801849"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279801849"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 11:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="614138524"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jun 2022 11:21:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2zXm-000RSD-OB;
        Sun, 19 Jun 2022 18:21:06 +0000
Date:   Mon, 20 Jun 2022 02:20:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] mfd: tc6393xb: Make disable callback return void
Message-ID: <202206200102.cUbYiyCL-lkp@intel.com>
References: <20220619082655.53728-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619082655.53728-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Uwe,

I love your patch! Yet something to improve:

[auto build test ERROR on f2906aa863381afb0015a9eb7fefad885d4e5a56]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/mfd-tc6393xb-Make-disable-callback-return-void/20220619-162855
base:   f2906aa863381afb0015a9eb7fefad885d4e5a56
config: arm-pxa_defconfig (https://download.01.org/0day-ci/archive/20220620/202206200102.cUbYiyCL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e2b80b7c107cdbbff99189431a614f791435ebfd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Uwe-Kleine-K-nig/mfd-tc6393xb-Make-disable-callback-return-void/20220619-162855
        git checkout e2b80b7c107cdbbff99189431a614f791435ebfd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/mach-pxa/eseries.c:47:13: warning: no previous prototype for 'eseries_fixup' [-Wmissing-prototypes]
      47 | void __init eseries_fixup(struct tag *tags, char **cmdline)
         |             ^~~~~~~~~~~~~
   arch/arm/mach-pxa/eseries.c:76:5: warning: no previous prototype for 'eseries_tmio_enable' [-Wmissing-prototypes]
      76 | int eseries_tmio_enable(struct platform_device *dev)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/eseries.c:89:6: warning: no previous prototype for 'eseries_tmio_disable' [-Wmissing-prototypes]
      89 | void eseries_tmio_disable(struct platform_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/eseries.c:95:5: warning: no previous prototype for 'eseries_tmio_suspend' [-Wmissing-prototypes]
      95 | int eseries_tmio_suspend(struct platform_device *dev)
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/eseries.c:101:5: warning: no previous prototype for 'eseries_tmio_resume' [-Wmissing-prototypes]
     101 | int eseries_tmio_resume(struct platform_device *dev)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/eseries.c:108:6: warning: no previous prototype for 'eseries_get_tmio_gpios' [-Wmissing-prototypes]
     108 | void eseries_get_tmio_gpios(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-pxa/eseries.c:141:21: error: initialization of 'int (*)(struct platform_device *)' from incompatible pointer type 'void (*)(struct platform_device *)' [-Werror=incompatible-pointer-types]
     141 |         .disable  = &eseries_tmio_disable,
         |                     ^
   arch/arm/mach-pxa/eseries.c:141:21: note: (near initialization for 'e330_tc6387xb_info.disable')
   cc1: some warnings being treated as errors


vim +141 arch/arm/mach-pxa/eseries.c

e478fe4cd50b86 Eric Miao 2010-06-20  138  
e478fe4cd50b86 Eric Miao 2010-06-20  139  static struct tc6387xb_platform_data e330_tc6387xb_info = {
e478fe4cd50b86 Eric Miao 2010-06-20  140  	.enable   = &eseries_tmio_enable,
e478fe4cd50b86 Eric Miao 2010-06-20 @141  	.disable  = &eseries_tmio_disable,
e478fe4cd50b86 Eric Miao 2010-06-20  142  	.suspend  = &eseries_tmio_suspend,
e478fe4cd50b86 Eric Miao 2010-06-20  143  	.resume   = &eseries_tmio_resume,
e478fe4cd50b86 Eric Miao 2010-06-20  144  };
e478fe4cd50b86 Eric Miao 2010-06-20  145  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
