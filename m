Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7E4FB05C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 23:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbiDJVob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 17:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiDJVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 17:44:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1D25D2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649626939; x=1681162939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=15MDV13rK6hgSx358Rl8VAA0ogWGReFU+VPsgF70dxg=;
  b=RwbFN+u6d/vXLQRRB6SwiK+kJYjHeMVyY3QIrl15wK6z5eGGSKXAn3z5
   oNfCmbbjDIytHDrIkt0k1M+P2ONaJqzNpPRIJ4yhT8oax1+KtfXzhaR7M
   NTP3QVlLyN9HfGP0M3cjcVH9k3ylLpSO4NkffVQcVmRimqeAxtnciax59
   BusySvNpsSFWPgaQYARpr11Gh3igN1/pIXHpec7KneeYk64aUMzHMGYek
   J2QRz3Zjfw6d08Cfiz921GSiMoC4p2rEzQHeB79aZrPAUXT4+DPT50A9m
   RX9Ny9jLPVP7FlAC4shtpj6txDaKFiNpn2KYnW4XAmpDEktu3lsNMVRd3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="324909556"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="324909556"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 14:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="525104413"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Apr 2022 14:42:17 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndfK4-00017L-Q1;
        Sun, 10 Apr 2022 21:42:16 +0000
Date:   Mon, 11 Apr 2022 05:41:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: drivers/hwmon/sch56xx-common.o: warning: objtool:
 sch56xx_init()+0xfd: stack state mismatch: cfa1=4+200 cfa2=5+40
Message-ID: <202204110525.Bxed5ZYq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ea3c6425269d33da53c79d539ce9554117cf4d4
commit: 393935baa45e5ccb9603cf7f9f020ed1bc0915f7 hwmon: (sch56xx-common) Add automatic module loading on supported devices
date:   6 weeks ago
config: x86_64-randconfig-c022-20220411 (https://download.01.org/0day-ci/archive/20220411/202204110525.Bxed5ZYq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=393935baa45e5ccb9603cf7f9f020ed1bc0915f7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 393935baa45e5ccb9603cf7f9f020ed1bc0915f7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/sch56xx-common.o: warning: objtool: sch56xx_init()+0xfd: stack state mismatch: cfa1=4+200 cfa2=5+40

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
