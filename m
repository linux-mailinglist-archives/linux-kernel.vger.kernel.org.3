Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972115A0800
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiHYEa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiHYEaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:30:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF11A13F21
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661401819; x=1692937819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OcHzXRbfJvlnSar6hah90+ftgNcXnzuMV+sBjNnQDA0=;
  b=fVH2w9AIFEcT5hjA3CivllxFqT8AcoCMmMVpO0rwLqRFZvqKzE76/vRO
   7oggPT9lHzXNhFeQWaRPHVcE2RVX0r8wHq5EhoQH5RwBugeTxrg/uNg7u
   nnbKJvdt0sGACL5B3uJE7exedpb2s+HxkeY6/3d7VBghhnbbeOl/tHr5O
   zw8E+4dmxXt7LsgNWJ8pESK0kjawdKz2NnLdM6KkwuaDtcz0GaIpZmAQf
   XZ2v9BA6WXF87OA+mmXreUnsPyRGj7LUSMs8Plr8fVmw4/0zeEQ4lloKS
   OjRFd+sM34vBZv2Ju3ajDp34ETD/+N+OZjvbllnmZJukfiwUgaKV9FIXJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="274531805"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="274531805"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 21:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="678305364"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2022 21:30:18 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR4VV-0001i6-1o;
        Thu, 25 Aug 2022 04:30:17 +0000
Date:   Thu, 25 Aug 2022 12:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:deprecate 5/9] kismet: WARNING: unmet direct
 dependencies detected for MEDIA_TUNER_XC2028 when selected by VIDEO_TM6000
Message-ID: <202208251256.ztrjJcRJ-lkp@intel.com>
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
config: x86_64-kismet-CONFIG_MEDIA_TUNER_XC2028-CONFIG_VIDEO_TM6000-0-0 (https://download.01.org/0day-ci/archive/20220825/202208251256.ztrjJcRJ-lkp@intel.com/config)
reproduce:
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree deprecate
        git checkout 3eaffcf890f8c070048019be67c787f91fc54817
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_MEDIA_TUNER_XC2028 --selectors CONFIG_VIDEO_TM6000 -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MEDIA_TUNER_XC2028 when selected by VIDEO_TM6000
   
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
