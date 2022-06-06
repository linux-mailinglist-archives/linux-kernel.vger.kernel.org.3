Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC153EC90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiFFN2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiFFN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:28:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91458CCF1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654522124; x=1686058124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jV+w5dOWr1t7rNYIEA+7OT7tjQehbbZXnLkxc6LGUA0=;
  b=GWomXD8oaScSabVQWAlbe4Fg3R4dww9OgBVyyaGPHtPaFvc9P3TA201a
   bZrxuwBoDHAGYEc4GXCW9LQHOgg7q/Qe3dJO91ewwKlukG2iKHJRE+vyF
   wbD/njW9iVf/0WoLRT9HJlHYF8YBQKJGg/V/BXKfcyp6fAmLO+4WmwmqZ
   SEAjal6Ptg8f5pByNkh+6b7gDbZKROpY2RoMKv4iHT6HJ7dMANQL5tAqM
   6e04vsMOdUqBXqSR1THw65DaZWX0+HxzpNrCtzrsXkW4JhR6Pf0kx38yD
   e0G+zu+MV2hKq0IB/y1A2wTzpedFnaiOG+/XISzZYQIWnUvyGu2hLLNLV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276951855"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276951855"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="532126032"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2022 06:28:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyCmF-000CkX-H9;
        Mon, 06 Jun 2022 13:28:15 +0000
Date:   Mon, 6 Jun 2022 21:27:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 6373/9999] kismet: WARNING: unmet
 direct dependencies detected for PM_GENERIC_DOMAINS when selected by
 QCOM_AOSS_QMP
Message-ID: <202206062135.fQzlABwc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: fdd3df25c06810614b642173cf8eca20610958ce [6373/9999] FROMGIT: soc: qcom: Add AOSS QMP driver
config: (https://download.01.org/0day-ci/archive/20220606/202206062135.fQzlABwc-lkp@intel.com/config)
reproduce:
        # https://github.com/jsarha/linux/commit/fdd3df25c06810614b642173cf8eca20610958ce
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout fdd3df25c06810614b642173cf8eca20610958ce
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_PM_GENERIC_DOMAINS --selectors CONFIG_QCOM_AOSS_QMP -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS when selected by QCOM_AOSS_QMP
   
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
     Depends on [n]: PM [=n]
     Selected by [y]:
     - QCOM_AOSS_QMP [=y] && (ARCH_QCOM || COMPILE_TEST [=y]) && MAILBOX [=y] && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
