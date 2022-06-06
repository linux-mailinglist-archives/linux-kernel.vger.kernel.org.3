Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9653ECFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiFFRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFFRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:21:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CD1A8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654536088; x=1686072088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aZXZAX8ryC13ARBWgSKuw181DuaR6jjPQGTuVRvJkHM=;
  b=Aryw3HZeVxOQmDD1nU7us5Do5TvnfrQr8kIrwc90sbjB70XtIIf+wCeR
   9I5u3iNFpwlkViQJrUEMQoKIx2+2J2PMWOs8DC6ybFsOjzwp6p74Ll4jj
   jnBH65pVOzlKMbB85y8KOikl4wornU3xaAj1WHiAeBj2HaWtvSIf0crfe
   z3tmnqFCS0RWaWFwUIdG33CtUjJtzkhTYKsthlYGBJ4/O5nzXZeVAukmG
   LQV+lFmXjj45dL5Awgl7MruCVCaAiAVpnlJs9GR2fVEWmDAxul5yfUE/y
   fVLneBg4a6V8mBoCzmzcj7usmYfvQVamf7wvuLJHZZBLuQZ7mwMNeZD9/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="257117588"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="257117588"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 10:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635700208"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2022 10:21:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyGPs-000Cvl-0j;
        Mon, 06 Jun 2022 17:21:24 +0000
Date:   Tue, 7 Jun 2022 01:20:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harsha Priya <harshapriya.n@intel.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Mike Mason <michael.w.mason@intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 730/6555] kismet: WARNING: unmet direct
 dependencies detected for SND_SOC_MAX98373 when selected by
 SND_SOC_INTEL_CNL_MAX98373_MACH
Message-ID: <202206070102.DI93Q0qc-lkp@intel.com>
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

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: 0b5ce6206cb013899ab47514f534db745ae7ae17 [730/6555] CHROMIUM: ASoC: Intel: Boards: Add CNL max98373 I2S machine driver
config: (https://download.01.org/0day-ci/archive/20220607/202206070102.DI93Q0qc-lkp@intel.com/config)
reproduce:
        # https://github.com/jsarha/linux/commit/0b5ce6206cb013899ab47514f534db745ae7ae17
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout 0b5ce6206cb013899ab47514f534db745ae7ae17
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_SND_SOC_MAX98373 --selectors CONFIG_SND_SOC_INTEL_CNL_MAX98373_MACH -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SND_SOC_MAX98373 when selected by SND_SOC_INTEL_CNL_MAX98373_MACH
   
   WARNING: unmet direct dependencies detected for SND_SOC_MAX98373
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
     Selected by [y]:
     - SND_SOC_INTEL_CNL_MAX98373_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && SND_SOC_INTEL_SKYLAKE [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
