Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA856CBD9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGIWvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGIWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:51:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE16213EB5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657407080; x=1688943080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1avsvh0DsidozjjxyzxpYK3Ip0iH5McbGzDR18/Bt+E=;
  b=c8+g9I+sdZSs9A2jC4SCBsr4piIvB3H58B7q6pIw5nWjAJfkpkL7wHuC
   QXzznVROoYHe93k9Eg2YDXGhS51ocna5rdt8kJFXPdD5wQpy4o70GB11H
   fATGC5YLRmJSxbrw/ObNbdDeNigpi6Cs4hdyRRH3/y18DabsqtUFmbylt
   sSi6D7jPKivlpCpo/51JCFexd+NsS+CNSpZsZKqWzZPwdkLBbp1tEfJ1w
   mpOWOGqvJqnKexVttcPKV3c6cHk63ycIOYcK2qf2LPaBEsPmuQZsmHwmq
   KO8VFoRLHjO/7WPtxk7pQ/7Gxu/fP+2gxpM9IwrOL4VS1v7Kuk3+b8o22
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="348448963"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="348448963"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 15:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="627072333"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2022 15:51:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAJIE-000PDk-Oq;
        Sat, 09 Jul 2022 22:51:18 +0000
Date:   Sun, 10 Jul 2022 06:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/120-spmi 3/3]
 drivers/nvmem/spmi-mfd-nvmem.c:90:3-8: No need to set .owner here. The core
 will do it.
Message-ID: <202207100625.KPdgo7Xg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/120-spmi
head:   cfeab618c438619d550c161335ba6b242603213c
commit: cfeab618c438619d550c161335ba6b242603213c [3/3] nvmem: Add spmi-mfd-nvmem driver
config: xtensa-randconfig-c004-20220710 (https://download.01.org/0day-ci/archive/20220710/202207100625.KPdgo7Xg-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/nvmem/spmi-mfd-nvmem.c:90:3-8: No need to set .owner here. The core will do it.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
