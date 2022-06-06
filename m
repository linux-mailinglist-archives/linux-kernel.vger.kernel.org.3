Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15853E8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiFFJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiFFJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:21:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2942C5DE4A;
        Mon,  6 Jun 2022 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654507275; x=1686043275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bEVeaOzrfOnpRZjPjSs9cctKDIyELz/CmrZQIO+7XcE=;
  b=Kt/T/ZKiDLBLT3tKA5u4QzYe5w3pkW+vk9Pg0xO/CoiOo9BHcJhNE8qD
   BhmmBb5OGc2TY80VJux99dQfrL5Ila6Uc9dm3Qz8xpBnrbPGsn2fC+/MZ
   LlJad+50I+VcOStEbSeTz9owodZ2ldMhZzNrPGkRClxj2Nhdu8gADFM/b
   HJiFA/3G/Vy0MJ+TCRSFKHX2eYQMDIEiEJvd80pmt0rmIxQUiKqeM+ul9
   Vb1fXLBvqaLHwsL7dwugezVZBPItCaYCATHHcGUZmNhAm1vV4WDsePpFm
   tIZHPZZdzwtj8dNgyfwv8vGwFyyje8pwrRzt9lkZetMqHVL9tEQEIxxZ8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362984293"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362984293"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 02:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="669395514"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 02:21:12 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny8v9-000Cdd-SR;
        Mon, 06 Jun 2022 09:21:11 +0000
Date:   Mon, 6 Jun 2022 17:20:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>, pavel@ucw.cz,
        krzk+dt@kernel.org
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: Re: [PATCH v2 2/3] leds: Add driver for the TLC5925 LED controller
Message-ID: <202206061749.4bLA99z3-lkp@intel.com>
References: <20220603155332.112272-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603155332.112272-3-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pavel-leds/for-next]
[also build test WARNING on v5.18 next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Jacques-Hiblot/Add-support-for-the-TLC5925/20220605-235250
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220606/202206061749.4bLA99z3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e8ae916efd705311a0bdeb2a8f9a1649174867be
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jean-Jacques-Hiblot/Add-support-for-the-TLC5925/20220605-235250
        git checkout e8ae916efd705311a0bdeb2a8f9a1649174867be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/leds/leds-tlc5925.c:144:35: warning: 'tlc5925_id' defined but not used [-Wunused-const-variable=]
     144 | static const struct spi_device_id tlc5925_id[] = {
         |                                   ^~~~~~~~~~


vim +/tlc5925_id +144 drivers/leds/leds-tlc5925.c

   143	
 > 144	static const struct spi_device_id tlc5925_id[] = {
   145		{"tlc5925", 0},
   146		{}
   147	};
   148	MODULE_DEVICE_TABLE(spi, tlc5925_id);
   149	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
