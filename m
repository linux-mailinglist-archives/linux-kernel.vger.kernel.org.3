Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC158B101
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbiHEVMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiHEVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:12:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DB52476
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659733954; x=1691269954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rgnp+MWlLU5CHj9xlH2a9uQta16Hk+Z+ihNqp4Baa3s=;
  b=clHCLTpM2wSsNZ/CXrao9l3IXqDWi7Q83IPalvA9Ss/jrU2LPuExXK5z
   cWwkktVZare0LHlhRgMxzhwb6VxHlJ6tuEy/L6TTIm0YTpkGmiGl7aw0r
   77GMDQmG/9+WGMKp8pI3fZa9mBeVv+pCLl9rBMQZeTiAc65vt8k1xQAcL
   hgen78ka6+GNRmKKQdH5gYNgjuwXgxPuKJ4+OWkY9a22iGgM9IeZjuI3y
   aKylg2tZFP3eTGDEI+hp0XsetW9hQYqOSFKahEM2abTfQ3SRPeX6NYO52
   zMfL80hQx7MI7m3uKRwjL87fkDLS0gakSWhVKjFb4Mj44o98z8Jd8bVTJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="354292953"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354292953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 14:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="632155408"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Aug 2022 14:12:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK4cS-000JjH-1A;
        Fri, 05 Aug 2022 21:12:32 +0000
Date:   Sat, 6 Aug 2022 05:12:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [egtvedt-avr32:avr32-cleanup 9/9]
 drivers/net/ethernet/cadence/macb.h:725:15: error: 'MACB_MII_OFFSET'
 undeclared here (not in a function); did you mean 'MACB_RMII_OFFSET'?
Message-ID: <202208060537.isgDwxJf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git avr32-cleanup
head:   127c95b209653b261277d3a6346b6fc5f9a9ef2e
commit: 127c95b209653b261277d3a6346b6fc5f9a9ef2e [9/9] net:cadence: remove bitfields only used by AVR32
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220806/202208060537.isgDwxJf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git/commit/?id=127c95b209653b261277d3a6346b6fc5f9a9ef2e
        git remote add egtvedt-avr32 https://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git
        git fetch --no-tags egtvedt-avr32 avr32-cleanup
        git checkout 127c95b209653b261277d3a6346b6fc5f9a9ef2e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/cadence/macb_main.c:41:
>> drivers/net/ethernet/cadence/macb.h:725:15: error: 'MACB_MII_OFFSET' undeclared here (not in a function); did you mean 'MACB_RMII_OFFSET'?
     725 |         (1 << MACB_##name##_OFFSET)
         |               ^~~~~
   drivers/net/ethernet/cadence/macb_main.c:4114:16: note: in expansion of macro 'MACB_BIT'
    4114 |         .mii = MACB_BIT(MII),
         |                ^~~~~~~~


vim +725 drivers/net/ethernet/cadence/macb.h

1629dd4f763cc1 drivers/net/ethernet/cadence/macb.h Rafal Ozieblo      2016-11-16  722  
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  723  /* Bit manipulation macros */
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  724  #define MACB_BIT(name)					\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09 @725  	(1 << MACB_##name##_OFFSET)
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  726  #define MACB_BF(name,value)				\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  727  	(((value) & ((1 << MACB_##name##_SIZE) - 1))	\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  728  	 << MACB_##name##_OFFSET)
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  729  #define MACB_BFEXT(name,value)\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  730  	(((value) >> MACB_##name##_OFFSET)		\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  731  	 & ((1 << MACB_##name##_SIZE) - 1))
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  732  #define MACB_BFINS(name,value,old)			\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  733  	(((old) & ~(((1 << MACB_##name##_SIZE) - 1)	\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  734  		    << MACB_##name##_OFFSET))		\
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  735  	 | MACB_BF(name,value))
89e5785fc8a6b9 drivers/net/macb.h                  Haavard Skinnemoen 2006-11-09  736  

:::::: The code at line 725 was first introduced by commit
:::::: 89e5785fc8a6b9eafd37f2318a9a76d479c796be [PATCH] Atmel MACB ethernet driver

:::::: TO: Haavard Skinnemoen <hskinnemoen@atmel.com>
:::::: CC: Jeff Garzik <jeff@garzik.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
