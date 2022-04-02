Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA24EFE23
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 05:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiDBDTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 23:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiDBDTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:19:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA81D41A3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648869446; x=1680405446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7nMXdxIExRgGycuIq4MdZ0asGNlTbX92SRW/yLR0U60=;
  b=S4aLkirNR1oXsVz9UHicmeTJLF9BleGuDu+IwJeVTO9AuszU62Zcha8u
   fhGmsvyOJBth4cXMCAH/ZvmKZiAGHhMxllSzcYDZdM7v6fJrz7HVThynT
   QNtfYx05j6eHnDRrb1jYeuKEtcU3su6xiCHSyXH1Nq2ug4Vw7snAph8Ad
   Hf0KE/yuPy3W/LuR7IRmk/sSftzSDKHOAYz7+5kJ5suc7Pd1t78Sff3v2
   wLE5dA91EEslBX6LuHsfk0Dzk6VOpInD56dFnBrszEY4ifGuLDqBNFKgU
   kdX19gxZXaBbxL3xYo8Z6OV/Pv0JH6C1ZaVTrI32NLZqe98KIYU+ziCuC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259099899"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259099899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 20:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="587062864"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2022 20:17:25 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naUGS-0001iE-Du;
        Sat, 02 Apr 2022 03:17:24 +0000
Date:   Sat, 2 Apr 2022 11:16:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-ci:tmp 1/1] init/main.c:1641:2: error: #error TEST
Message-ID: <202204021123.U3C0WDDj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git tmp
head:   43b72ebc853c105427885ca515416f58459c0a5d
commit: 43b72ebc853c105427885ca515416f58459c0a5d [1/1] Test build failures
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220402/202204021123.U3C0WDDj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=43b72ebc853c105427885ca515416f58459c0a5d
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci tmp
        git checkout 43b72ebc853c105427885ca515416f58459c0a5d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c:769:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     769 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:781:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     781 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:783:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     783 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
>> init/main.c:1641:2: error: #error TEST
    1641 | #error TEST
         |  ^~~~~


vim +1641 init/main.c

  1640	
> 1641	#error TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
