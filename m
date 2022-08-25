Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456195A0A93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiHYHoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiHYHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:44:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB99D8E4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661413472; x=1692949472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z81HgPLciv/z8OgJGdvFnLN1o7Tse/Cm47+slFWNvSY=;
  b=MZdVuUjVGSm0mhJ38rAwi4DQiK+TJ3t38Bl2hosW/+mpFMSdWYT1yl3e
   I59bK8wLbT8R5h/kERRI53K/FF1atXAn7ucP5qEpx41DqKHNLVPmMkOcZ
   R0TZo0M2XwgGzq+tv9r4UBg9GY5AN0j7N8DTdKvBEmryRKJn3pMW3rs1V
   P2CJlntSwJWSmZFk3LSuXbdeNENXz4tzwyltGV/Mu+n0NjYVmq9QOCN0K
   BZn//ZqMU5ARVFpPUAh+HOEKMuXJuTng2DSsxdBOkeSADbgeUtt3g1DKJ
   4zUPBE71xvFOmlM4RdNJlTUQA2aO3IzAuf525kYatq4lpAiKAcehppf7f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295452246"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="295452246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 00:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="639480311"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2022 00:44:31 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR7XS-0001t7-1o;
        Thu, 25 Aug 2022 07:44:30 +0000
Date:   Thu, 25 Aug 2022 15:43:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:deprecate 5/9] kismet: WARNING: unmet direct
 dependencies detected for MEDIA_TUNER_XC5000 when selected by VIDEO_TM6000
Message-ID: <202208251518.TurdyyAQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git deprecate
head:   31c9d3d20a0e443e6b9b493096b6f06db534fff4
commit: 3eaffcf890f8c070048019be67c787f91fc54817 [5/9] tm6000: deprecate this driver
config: x86_64-kismet-CONFIG_MEDIA_TUNER_XC5000-CONFIG_VIDEO_TM6000-0-0 (https://download.01.org/0day-ci/archive/20220825/202208251518.TurdyyAQ-lkp@intel.com/config)
reproduce:
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree deprecate
        git checkout 3eaffcf890f8c070048019be67c787f91fc54817
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_MEDIA_TUNER_XC5000 --selectors CONFIG_VIDEO_TM6000 -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MEDIA_TUNER_XC5000 when selected by VIDEO_TM6000
   
   WARNING: unmet direct dependencies detected for MEDIA_TUNER_XC5000
     Depends on [n]: (MEDIA_ANALOG_TV_SUPPORT [=n] || MEDIA_DIGITAL_TV_SUPPORT [=n] || MEDIA_RADIO_SUPPORT [=n] || MEDIA_SDR_SUPPORT [=n]) && MEDIA_SUPPORT [=y] && I2C [=y]
     Selected by [y]:
     - VIDEO_TM6000 [=y] && STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && STAGING_MEDIA_DEPRECATED [=y] && VIDEO_DEV [=y] && I2C [=y] && INPUT [=y] && RC_CORE [=y] && USB [=y]
   
   WARNING: unmet direct dependencies detected for MEDIA_TUNER_XC2028
     Depends on [n]: (MEDIA_ANALOG_TV_SUPPORT [=n] || MEDIA_DIGITAL_TV_SUPPORT [=n] || MEDIA_RADIO_SUPPORT [=n] || MEDIA_SDR_SUPPORT [=n]) && MEDIA_SUPPORT [=y] && I2C [=y]
     Selected by [y]:
     - VIDEO_TM6000 [=y] && STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && STAGING_MEDIA_DEPRECATED [=y] && VIDEO_DEV [=y] && I2C [=y] && INPUT [=y] && RC_CORE [=y] && USB [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
