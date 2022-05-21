Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10B52FC85
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbiEUM6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbiEUM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:58:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF55EBC2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653137922; x=1684673922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0tRAvgSKuQPLyLy119zsdFhtaoBKVwi090INAu59s5Y=;
  b=FvJrtcr3UHCO2VCepb0Z7BaXyzSAHsujQTYw1BmpQKqRxgTQLgCX/dnL
   9ZsnplK8+oPvQ5ArArkja/gjEhC4ykpVe95/CqOuwww6XS7/RdPEK+mvF
   AlclO625mk7M0jtzvtiEE5kV1UvATHQ4TmeC4PMWA/qeLxb4h2IbdmgT7
   fsVs6XM9GvIezrVO0TkkyvqfmKH2uiP9q8x8GM8fp9rpoK6fwZKxwzH+q
   uZ+GPM3q6Si7q1OFUEJuA6M/EJ5HoOY83kt5T6tJHMqSMzqcgwmI1G1CF
   if+lN1oLBbQBUvAfmR0tAp1mbLNhO/JbERu6MVw44WFweespONz3Ktaf3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272825707"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="272825707"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 05:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="571289239"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2022 05:58:40 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsOgp-0006JK-QK;
        Sat, 21 May 2022 12:58:39 +0000
Date:   Sat, 21 May 2022 20:58:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [brgl:gpio/for-next 19/36] kismet: WARNING: unmet direct
 dependencies detected for GPIO_IXP4XX when selected by ARCH_IXP4XX
Message-ID: <202205212023.U2plpfsA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
head:   7869b481025c048ec6ea5b99acb14d057547de80
commit: c83227a5d05ed77b634ce4c2fc5f143ae2a4d6f5 [19/36] irq/gpio: ixp4xx: Drop boardfile probe path
config: (https://download.01.org/0day-ci/archive/20220521/202205212023.U2plpfsA-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?id=c83227a5d05ed77b634ce4c2fc5f143ae2a4d6f5
        git remote add brgl https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
        git fetch --no-tags brgl gpio/for-next
        git checkout c83227a5d05ed77b634ce4c2fc5f143ae2a4d6f5
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_GPIO_IXP4XX --selectors CONFIG_ARCH_IXP4XX -a=arm
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GPIO_IXP4XX when selected by ARCH_IXP4XX
   
   WARNING: unmet direct dependencies detected for ARM_PATCH_PHYS_VIRT
     Depends on [n]: !XIP_KERNEL [=y] && MMU [=y]
     Selected by [y]:
     - ARCH_IXP4XX [=y] && <choice>
   
   WARNING: unmet direct dependencies detected for GPIO_IXP4XX
     Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=y] && ARCH_IXP4XX [=y] && OF [=n]
     Selected by [y]:
     - ARCH_IXP4XX [=y] && <choice>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
