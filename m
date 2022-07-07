Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924256A023
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiGGKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiGGKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:40:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE484564E2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657190440; x=1688726440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7s975MrwC03kpMNyhF7dXyx+y+MDHobyn16lSKjRgrA=;
  b=lwkTPb54wLoUbnQmEj8QixlHWljLTHxbpoYGde7Nz/OlpmcGmZbsP8Y4
   nyBMaJ5FTKhXE/Q/7DJXbJQLShV2TJ1ee7j04sTuESnxoz6VO3lQg52uX
   QG0WwxcE0o2GFTDR0hIagOji0ixgmmS160ABgJducslTmo1jszzRVdjpw
   bByNkwj3Lj+gbFkvEjvyoExSfb4XU4+hFFugNm00Y8SCo8Zd9YCdZjylC
   FzhW8KUwxv86wl9btRk8CxYxv8bWXEmgPgzTOZYPeBeBlxfDmR4CvkdNO
   j8mXqja6s//cIS+TrvoxLmv2LyxPWaxenN55AjcHMDZ+V5/gQmmnZExrp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347976848"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="347976848"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 03:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="543779895"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2022 03:40:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Ow1-000LsE-T0;
        Thu, 07 Jul 2022 10:40:37 +0000
Date:   Thu, 7 Jul 2022 18:40:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-next 328/353] kismet: WARNING:
 unmet direct dependencies detected for SND_SOC_ES8316 when selected by
 SND_SOC_AMD_ST_ES8336_MACH
Message-ID: <202207071820.zgSI5DPp-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   3f4322bb413adb7f9d8b5e9005eb1b9bc85f9312
commit: f94fa84058014f81ad526641f1b1f583ca2cf32f [328/353] ASoC: amd: enable machine driver build for Jadeite platform
config: (https://download.01.org/0day-ci/archive/20220707/202207071820.zgSI5DPp-lkp@intel.com/config)
reproduce:
        # https://github.com/ammarfaizi2/linux-block/commit/f94fa84058014f81ad526641f1b1f583ca2cf32f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout f94fa84058014f81ad526641f1b1f583ca2cf32f
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_SND_SOC_ES8316 --selectors CONFIG_SND_SOC_AMD_ST_ES8336_MACH -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SND_SOC_ES8316 when selected by SND_SOC_AMD_ST_ES8336_MACH
   
   WARNING: unmet direct dependencies detected for SND_SOC_ES8316
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
     Selected by [y]:
     - SND_SOC_AMD_ST_ES8336_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP [=y] && (ACPI [=n] || COMPILE_TEST [=y]) && (I2C [=n] || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
