Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46E4BD2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbiBTXi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:38:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiBTXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:38:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C946170
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645400279; x=1676936279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OL5B2I1ySDYdJBQ6uhL6Y8l5/uRCaxTi1wUdoG0F57c=;
  b=THqYAIabs8WqmJ91wTkhUbiYOaY/CXnWH+FFqyGWGgkl46XK3Ny5pMVV
   5w2jnUK3KpCphsOVslQj79ZyRjC9IELnmoSqU1yuEUz3Xldo2+PGx/gnm
   +9xbAPI+sHE0yxB1mjJWXhVYkzWorIm0+bMcVa07NhgqGU1olrMayWnVj
   6ljsWBmKNvgiah486iz0yrBc1VJm7qTupDaHnmnIdhIoAOud3r9ZodD9I
   GHapNhyoSpySXMIWiS5+JMWvv+umKZE659mPoazD/YFo+Z78REJJReaXt
   HphgtTj0/GummN0mQOh77Dk0tAEdmlFKv438QtJe+HoQvRHMpJF4OfUsI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314673661"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="314673661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="683036490"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 15:37:57 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLvm9-00011V-66; Sun, 20 Feb 2022 23:37:57 +0000
Date:   Mon, 21 Feb 2022 07:37:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 102/114]
 drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn315/irq_service_dcn315.c:45:20:
 warning: no previous prototype for 'to_dal_irq_source_dcn315'
Message-ID: <202202210738.Waeahl10-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   ad72a74cfe7edab15aef40519727a388285e7510
commit: 92d0c2ebe564f492ea71bf2ca81de5d95d58d6de [102/114] drm/amd/display: Add DCN315 IRQ
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220221/202202210738.Waeahl10-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 92d0c2ebe564f492ea71bf2ca81de5d95d58d6de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn315/irq_service_dcn315.c:45:20: warning: no previous prototype for 'to_dal_irq_source_dcn315' [-Wmissing-prototypes]
      45 | enum dc_irq_source to_dal_irq_source_dcn315(
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/to_dal_irq_source_dcn315 +45 drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn315/irq_service_dcn315.c

    44	
  > 45	enum dc_irq_source to_dal_irq_source_dcn315(
    46			struct irq_service *irq_service,
    47			uint32_t src_id,
    48			uint32_t ext_id)
    49	{
    50		switch (src_id) {
    51		case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
    52			return DC_IRQ_SOURCE_VBLANK1;
    53		case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
    54			return DC_IRQ_SOURCE_VBLANK2;
    55		case DCN_1_0__SRCID__DC_D3_OTG_VSTARTUP:
    56			return DC_IRQ_SOURCE_VBLANK3;
    57		case DCN_1_0__SRCID__DC_D4_OTG_VSTARTUP:
    58			return DC_IRQ_SOURCE_VBLANK4;
    59		case DCN_1_0__SRCID__DC_D5_OTG_VSTARTUP:
    60			return DC_IRQ_SOURCE_VBLANK5;
    61		case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
    62			return DC_IRQ_SOURCE_VBLANK6;
    63		case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
    64			return DC_IRQ_SOURCE_DC1_VLINE0;
    65		case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
    66			return DC_IRQ_SOURCE_DC2_VLINE0;
    67		case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
    68			return DC_IRQ_SOURCE_DC3_VLINE0;
    69		case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
    70			return DC_IRQ_SOURCE_DC4_VLINE0;
    71		case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
    72			return DC_IRQ_SOURCE_DC5_VLINE0;
    73		case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
    74			return DC_IRQ_SOURCE_DC6_VLINE0;
    75		case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
    76			return DC_IRQ_SOURCE_PFLIP1;
    77		case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
    78			return DC_IRQ_SOURCE_PFLIP2;
    79		case DCN_1_0__SRCID__HUBP2_FLIP_INTERRUPT:
    80			return DC_IRQ_SOURCE_PFLIP3;
    81		case DCN_1_0__SRCID__HUBP3_FLIP_INTERRUPT:
    82			return DC_IRQ_SOURCE_PFLIP4;
    83		case DCN_1_0__SRCID__HUBP4_FLIP_INTERRUPT:
    84			return DC_IRQ_SOURCE_PFLIP5;
    85		case DCN_1_0__SRCID__HUBP5_FLIP_INTERRUPT:
    86			return DC_IRQ_SOURCE_PFLIP6;
    87		case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
    88			return DC_IRQ_SOURCE_VUPDATE1;
    89		case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
    90			return DC_IRQ_SOURCE_VUPDATE2;
    91		case DCN_1_0__SRCID__OTG2_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
    92			return DC_IRQ_SOURCE_VUPDATE3;
    93		case DCN_1_0__SRCID__OTG3_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
    94			return DC_IRQ_SOURCE_VUPDATE4;
    95		case DCN_1_0__SRCID__OTG4_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
    96			return DC_IRQ_SOURCE_VUPDATE5;
    97		case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
    98			return DC_IRQ_SOURCE_VUPDATE6;
    99		case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
   100			return DC_IRQ_SOURCE_DMCUB_OUTBOX;
   101		case DCN_1_0__SRCID__DC_HPD1_INT:
   102			/* generic src_id for all HPD and HPDRX interrupts */
   103			switch (ext_id) {
   104			case DCN_1_0__CTXID__DC_HPD1_INT:
   105				return DC_IRQ_SOURCE_HPD1;
   106			case DCN_1_0__CTXID__DC_HPD2_INT:
   107				return DC_IRQ_SOURCE_HPD2;
   108			case DCN_1_0__CTXID__DC_HPD3_INT:
   109				return DC_IRQ_SOURCE_HPD3;
   110			case DCN_1_0__CTXID__DC_HPD4_INT:
   111				return DC_IRQ_SOURCE_HPD4;
   112			case DCN_1_0__CTXID__DC_HPD5_INT:
   113				return DC_IRQ_SOURCE_HPD5;
   114			case DCN_1_0__CTXID__DC_HPD6_INT:
   115				return DC_IRQ_SOURCE_HPD6;
   116			case DCN_1_0__CTXID__DC_HPD1_RX_INT:
   117				return DC_IRQ_SOURCE_HPD1RX;
   118			case DCN_1_0__CTXID__DC_HPD2_RX_INT:
   119				return DC_IRQ_SOURCE_HPD2RX;
   120			case DCN_1_0__CTXID__DC_HPD3_RX_INT:
   121				return DC_IRQ_SOURCE_HPD3RX;
   122			case DCN_1_0__CTXID__DC_HPD4_RX_INT:
   123				return DC_IRQ_SOURCE_HPD4RX;
   124			case DCN_1_0__CTXID__DC_HPD5_RX_INT:
   125				return DC_IRQ_SOURCE_HPD5RX;
   126			case DCN_1_0__CTXID__DC_HPD6_RX_INT:
   127				return DC_IRQ_SOURCE_HPD6RX;
   128			default:
   129				return DC_IRQ_SOURCE_INVALID;
   130			}
   131			break;
   132	
   133		default:
   134			return DC_IRQ_SOURCE_INVALID;
   135		}
   136	}
   137	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
