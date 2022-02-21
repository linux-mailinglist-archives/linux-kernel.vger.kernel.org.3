Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0554BDC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379367AbiBUPms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:42:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379358AbiBUPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:42:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA9221E2D;
        Mon, 21 Feb 2022 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645458141; x=1676994141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DsqhZGfFBJu6Rm4feltuqWXpba00QaQpv/X7MkMRRHk=;
  b=IwWNdo3OXTJ7QbiUbCMlf5Fbl4mWYh4ObSUaRGPbXFz+Ov15BmO9bO8d
   VoeKm0vjtZOnd8iRE9dsnAM+9xyNyLYM01ckWB+2MiUuwRXhYqTbDb4D8
   qRTZwj5H5hMGkPH6vD0HstHyJevAiwHsSdECc8AOdedhLTdHrF9cngtJF
   nazvg9FF4TqyVV/M5mVkWsLbQzfX3+SkumB7HyU1xNxQGoin6P5p3izDP
   24zXZmnqQ5abeTRqCpr57V2ANJgvkPSEPu0f2dTypGwZDa3XKujVLC2ri
   u3EGxQsNhPlbomL42yl/yYFCsoUQj3DMj/l0Y5B06QcxvRhBDwc8vlCaf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249108869"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="249108869"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 07:42:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="778719726"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2022 07:42:19 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMApO-0001jR-SF; Mon, 21 Feb 2022 15:42:18 +0000
Date:   Mon, 21 Feb 2022 23:41:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sameer Pujar <spujar@nvidia.com>,
        krzysztof.kozlowski@canonical.com, thierry.reding@gmail.com
Cc:     kbuild-all@lists.01.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] memory: tegra: Add APE memory clients for Tegra234
Message-ID: <202202212350.xbGhqWuI-lkp@intel.com>
References: <1645186589-25118-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645186589-25118-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sameer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on next-20220217]
[cannot apply to v5.17-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sameer-Pujar/memory-tegra-Add-APE-memory-clients-for-Tegra234/20220220-190451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: arm64-randconfig-c004-20220220 (https://download.01.org/0day-ci/archive/20220221/202202212350.xbGhqWuI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2432353686ce99492ca9a6100ba6b121fa858950
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sameer-Pujar/memory-tegra-Add-APE-memory-clients-for-Tegra234/20220220-190451
        git checkout 2432353686ce99492ca9a6100ba6b121fa858950
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/memory/tegra/tegra234.c:74:23: error: 'TEGRA234_MEMORY_CLIENT_APEDMAR' undeclared here (not in a function); did you mean 'TEGRA234_MEMORY_CLIENT_BPMPDMAR'?
      74 |                 .id = TEGRA234_MEMORY_CLIENT_APEDMAR,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       TEGRA234_MEMORY_CLIENT_BPMPDMAR
>> drivers/memory/tegra/tegra234.c:76:24: error: 'TEGRA234_SID_APE' undeclared here (not in a function); did you mean 'TEGRA234_SID_BPMP'?
      76 |                 .sid = TEGRA234_SID_APE,
         |                        ^~~~~~~~~~~~~~~~
         |                        TEGRA234_SID_BPMP
>> drivers/memory/tegra/tegra234.c:84:23: error: 'TEGRA234_MEMORY_CLIENT_APEDMAW' undeclared here (not in a function); did you mean 'TEGRA234_MEMORY_CLIENT_BPMPDMAW'?
      84 |                 .id = TEGRA234_MEMORY_CLIENT_APEDMAW,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       TEGRA234_MEMORY_CLIENT_BPMPDMAW


vim +74 drivers/memory/tegra/tegra234.c

    11	
    12	static const struct tegra_mc_client tegra234_mc_clients[] = {
    13		{
    14			.id = TEGRA234_MEMORY_CLIENT_SDMMCRAB,
    15			.name = "sdmmcrab",
    16			.sid = TEGRA234_SID_SDMMC4,
    17			.regs = {
    18				.sid = {
    19					.override = 0x318,
    20					.security = 0x31c,
    21				},
    22			},
    23		}, {
    24			.id = TEGRA234_MEMORY_CLIENT_SDMMCWAB,
    25			.name = "sdmmcwab",
    26			.sid = TEGRA234_SID_SDMMC4,
    27			.regs = {
    28				.sid = {
    29					.override = 0x338,
    30					.security = 0x33c,
    31				},
    32			},
    33		}, {
    34			.id = TEGRA234_MEMORY_CLIENT_BPMPR,
    35			.name = "bpmpr",
    36			.sid = TEGRA234_SID_BPMP,
    37			.regs = {
    38				.sid = {
    39					.override = 0x498,
    40					.security = 0x49c,
    41				},
    42			},
    43		}, {
    44			.id = TEGRA234_MEMORY_CLIENT_BPMPW,
    45			.name = "bpmpw",
    46			.sid = TEGRA234_SID_BPMP,
    47			.regs = {
    48				.sid = {
    49					.override = 0x4a0,
    50					.security = 0x4a4,
    51				},
    52			},
    53		}, {
    54			.id = TEGRA234_MEMORY_CLIENT_BPMPDMAR,
    55			.name = "bpmpdmar",
    56			.sid = TEGRA234_SID_BPMP,
    57			.regs = {
    58				.sid = {
    59					.override = 0x4a8,
    60					.security = 0x4ac,
    61				},
    62			},
    63		}, {
    64			.id = TEGRA234_MEMORY_CLIENT_BPMPDMAW,
    65			.name = "bpmpdmaw",
    66			.sid = TEGRA234_SID_BPMP,
    67			.regs = {
    68				.sid = {
    69					.override = 0x4b0,
    70					.security = 0x4b4,
    71				},
    72			},
    73		}, {
  > 74			.id = TEGRA234_MEMORY_CLIENT_APEDMAR,
    75			.name = "apedmar",
  > 76			.sid = TEGRA234_SID_APE,
    77			.regs = {
    78				.sid = {
    79					.override = 0x4f8,
    80					.security = 0x4fc,
    81				},
    82			},
    83		}, {
  > 84			.id = TEGRA234_MEMORY_CLIENT_APEDMAW,
    85			.name = "apedmaw",
    86			.sid = TEGRA234_SID_APE,
    87			.regs = {
    88				.sid = {
    89					.override = 0x500,
    90					.security = 0x504,
    91				},
    92			},
    93		},
    94	};
    95	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
