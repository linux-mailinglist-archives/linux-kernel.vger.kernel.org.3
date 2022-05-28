Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9415F536B74
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiE1Hmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiE1Hmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:42:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A124FFED
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653723769; x=1685259769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ywGXuQMxKCDfWqjpQZx+RISfIiqEWt7+k+K5aGgh+NI=;
  b=Jgg+u5EdrTSIzHGVUiS4uhsNvrNlfTfnuJUcYFGUjSSYHA6gqoK3SiOl
   siB2cZis1NChkannlMGry8WU+dJXCqge3rlnOfJcsT4ZC8kWBuRPymGNV
   Ndo7xHztkJALCJ2ZjTXnefhggW2Ay0ZkPgaIN8OeqjVSrnAzOi+eHbs23
   kY/zp3Qeo2X5V5Q2S9Huz6Y16aybf9vOzAprfDcFYYbOfVaokPS2XoOuT
   cime9OZlqvHjmIS+xh8sa36hyWB8bKXT8s4YhPIPhM3Jfu52xIhr5YiZN
   gkd6NlnNJF7IdplKACe+BbQn0P620i5lEHW0O5Z5C3IyDqqpl1coVQOv2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="272213517"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="272213517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 00:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="643910723"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2022 00:42:47 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nur5y-0005Zr-Ma;
        Sat, 28 May 2022 07:42:46 +0000
Date:   Sat, 28 May 2022 15:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: kismet: WARNING: unmet direct dependencies detected for
 CRYPTO_DEV_FSL_CAAM_BLOB_GEN when selected by TRUSTED_KEYS_CAAM
Message-ID: <202205281527.o6zXpTYo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
commit: e9c5048c2de1913d0bcd589bc1487810c2e24bc1 KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
date:   5 days ago
config: (https://download.01.org/0day-ci/archive/20220528/202205281527.o6zXpTYo-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9c5048c2de1913d0bcd589bc1487810c2e24bc1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e9c5048c2de1913d0bcd589bc1487810c2e24bc1
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN --selectors CONFIG_TRUSTED_KEYS_CAAM -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CRYPTO_DEV_FSL_CAAM_BLOB_GEN when selected by TRUSTED_KEYS_CAAM

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
