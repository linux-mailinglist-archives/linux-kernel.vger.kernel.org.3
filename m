Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3AB56CB9A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGIV3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGIV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:29:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCF61EAEB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657402157; x=1688938157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1JYQoaPDwaJgoTNCUD8bDMU8QHWVaG99UZdjHCZ3voI=;
  b=iZ1GZMW9n6VOuq0D5elSN265CTZsNMWveIp5kM5lVR+4ViUloE7K/pP8
   dtFjZuO1zN59POkMzM2yUKlRy90uClrMAbrJTXnE6dXTcF5tWZXtU/Aej
   A7PoSloTdlHQXFVX51ga0UHk1DX3eUdsayc6ycKncslsqoSbHVX1zUJeT
   bgMsHQfrS3otsJBaySWMJWpGDTafhYJJH0LQGvZon7MbpjoQSbkag5lAn
   IOJH8ixHiGRUtEtCaf58AvX58UjJFFbvuv5fKMP4J08DoIvdjSDHJDGhf
   xx9rT2XFnnVE/j2Q1TUQxZv/X5N4kdLdvgj6Qv+Z9rXWVRkvntRHIyiUs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="267503639"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="267503639"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="621624905"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 14:29:16 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAI0p-000P8i-DO;
        Sat, 09 Jul 2022 21:29:15 +0000
Date:   Sun, 10 Jul 2022 05:29:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/060-spi 3/3] drivers/spi/spi-apple.c:536:3-8: No
 need to set .owner here. The core will do it.
Message-ID: <202207100527.BmynlDAK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/060-spi
head:   93200c65a4c0e7c60d02f8811039a8cfafde36fb
commit: 93200c65a4c0e7c60d02f8811039a8cfafde36fb [3/3] spi: apple: Add driver for Apple SPI controller
config: xtensa-randconfig-c004-20220710 (https://download.01.org/0day-ci/archive/20220710/202207100527.BmynlDAK-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/spi/spi-apple.c:536:3-8: No need to set .owner here. The core will do it.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
