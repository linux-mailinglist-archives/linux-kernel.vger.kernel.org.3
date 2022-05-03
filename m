Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E660C5181E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiECKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiECKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:04:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7EE37A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651572038; x=1683108038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7nYW3m6U9WzWR6GrhJAghe1Ayb355GATsN76yTsByA4=;
  b=MXg2Poawzyn3jd2RBppEBBCf4ceDIPbHwvcfxqbv9aj6YJHv4MtIK18o
   PoSNHK5VyD+iJQtrKgkSLHk3mYWCigQo7lmWHHYK1rETfrtEuV45GJk/n
   Ge9f1HhMyQHrIt8CzvVpDtEdoPUtEjCxx5xRg7xRFv4YJEYNtzEYFgRPa
   jPDCeR/xJgBU0rsFERTP4Z4AINRDIHumhGcxRKdlnaOtKxUxYKDZeMFzA
   LoCqyWbCS2PBP3VZI+e9YdGcKCP3Fi8miPjEpYgvwXPtEPt9MEuvqbg/i
   sxLtZrwYXP38RGqINn4mVz5W6kgZAcu7tWzpl8NIlv1AkPg+4IZZkSfKu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267318438"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267318438"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 03:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="888411116"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2022 03:00:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlpKc-000AMJ-Ug;
        Tue, 03 May 2022 10:00:34 +0000
Date:   Tue, 3 May 2022 18:00:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 3/14] drivers/gpio/gpio-macsmc.c:230:3-8:
 No need to set .owner here. The core will do it.
Message-ID: <202205031706.nUBZtKaH-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   dc3db43287ff1d44b447fff8ed6386b28b339f1c
commit: a29b7d982f099846c00493140bbf5b6aff25c948 [3/14] gpio: Add new gpio-macsmc driver for Apple Macs
config: arm64-randconfig-c023-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031706.nUBZtKaH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/gpio/gpio-macsmc.c:230:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
