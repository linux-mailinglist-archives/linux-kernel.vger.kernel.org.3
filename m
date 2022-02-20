Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C214BCF92
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiBTPxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:53:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiBTPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:53:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA13C717
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645372363; x=1676908363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+gN2CDp8q2u60eFf8847Xv8+qzOmqqhYLLNLGiU8RAA=;
  b=nlU5v6w9V8cEO1zF7B0vpUEH394ofJpThvFJhYuf5Hqg5xYIIanrMbRO
   7teh9lrmhiqIY9oKkwh6nccYWKkui2GEMzA+qep+V5jDCkri3rjlLlAQp
   EQPSRGgFd89cPRU5dNt1dbmiyRZqQtndbR+gPcFdhvgKTywwbUVzaF3nt
   oOFUeUYOF6qhmbMfjOe+9FxTWYRFWZ5eM6L35ihqmNxJZh2AFmvmbJKnv
   Omt4AYt2PM72DRTLFpqKk22BrhA6z6yDeFgHxfIOS7034ExBJgUVU7oHc
   aC7RIEl3+rdrc5h6JP9MP7VtTaHrkZAuQMjSNjy9WJONdFpXtZXLDetXh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251566567"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="251566567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 07:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="682972204"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 07:52:41 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLoVt-0000Qj-7v; Sun, 20 Feb 2022 15:52:41 +0000
Date:   Sun, 20 Feb 2022 23:52:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yifan Zhang <yifan1.zhang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [agd5f:drm-next 96/114]
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c:235:5-8: Unneeded
 variable: "ret". Return "0" on line 243
Message-ID: <202202202323.i1r9Jm11-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   ad72a74cfe7edab15aef40519727a388285e7510
commit: 068ea8bdc0aacb3bba3d1392ed41cc1116a671b8 [96/114] drm/amd/pm: add smu_v13_0_5_ppt implementation
config: arm64-randconfig-c023-20220220 (https://download.01.org/0day-ci/archive/20220220/202202202323.i1r9Jm11-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c:235:5-8: Unneeded variable: "ret". Return "0" on line 243

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
