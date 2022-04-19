Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588AA506337
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348266AbiDSEdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348244AbiDSEdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:33:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF703220CE;
        Mon, 18 Apr 2022 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342627; x=1681878627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=52jRYIsgk/Pqgtn5x/D1TRnNFy5xBM8vIsx91EWTXOg=;
  b=Q4AN0uBLrjOcsHKhcNoL1iZwSF2Ivevu0ezP6PnZBrTKPubCFqUjx9Of
   9G5NOuhyCa3o0pC2U6R40x9g5KlFTTBCC6Ce/WFBLzYdkeb2ve2ElXbWx
   jbCUkFbxK7g/7nggVC9gFDLYbVGvSTDk+SVT1dwM+PhojrPv53YC/uxFV
   yehJDz8koJQAforSKYdHXJ38OOcLTrbBHuGnVtA8SmxLM/GcoxnkOXYPE
   +EiQ/a2XdTMk55+DAj6ogBihKvdpjJ32jX0q0Ri5zn7szqP6TReaF+jKL
   dJxPRYT/+ByW3kSNKE0L3DEQltqaZXkQX1qZCOKMvnPqEfvYmT1McKPrt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="243604053"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="243604053"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="561574119"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2022 21:30:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfVP-0005LD-Os;
        Tue, 19 Apr 2022 04:30:23 +0000
Date:   Tue, 19 Apr 2022 12:30:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kbuild-all@lists.01.org, list@opendingux.net,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/5] rtc: jz4740: Register clock provider for the CLK32K
 pin
Message-ID: <202204191107.MvgmbaHZ-lkp@intel.com>
References: <20220418184933.13172-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418184933.13172-5-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Yet something to improve:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/rtc-ingenic-various-updates/20220419-025341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: parisc-randconfig-r022-20220419 (https://download.01.org/0day-ci/archive/20220419/202204191107.MvgmbaHZ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a8eada718214bc34ea29f8ff353228abacc0bfb9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/rtc-ingenic-various-updates/20220419-025341
        git checkout a8eada718214bc34ea29f8ff353228abacc0bfb9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "of_clk_add_hw_provider" [drivers/rtc/rtc-jz4740.ko] undefined!
>> ERROR: modpost: "devm_clk_hw_register" [drivers/rtc/rtc-jz4740.ko] undefined!
>> ERROR: modpost: "of_clk_hw_simple_get" [drivers/rtc/rtc-jz4740.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
