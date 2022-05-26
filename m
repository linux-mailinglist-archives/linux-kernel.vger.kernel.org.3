Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90A0534D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbiEZKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346959AbiEZKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:17:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64211176;
        Thu, 26 May 2022 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653560224; x=1685096224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/06/+LdbOWOmFUaiCyNfRy9awv3wYK5GdEyH2WSXjYw=;
  b=LTCpkSzEBi1H/FBUbrKQf+IprxdbAkgMJWJBX8zeHgGs205SJwAaI01t
   moxVexSe0ZVrszg5wf7z8SrNq8fN1OJNBVLEHql5WdxN7v0zFqqRSKJRI
   p1IYS40DsP/S1f8zAlBCuxOgyQRHcI2y7Y6lJ7Y7QNsjrK/fc2/myJtn1
   ARLk52qbjWvz4Cq6Wtd0e5foNqbrvSsFJazm61d5dpgAZh/pKLuUDHwVM
   6iT/bL24fg4hkeKgWGNDUo8/odVI3BJkEL9w1UFlrLqYIrpF1mUNq+zSV
   9snA1w/Zm5k/otNc3ut80N+RG/zOO1RaZm73Ivzvnfy3kTlA9ZIglw7Ol
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="261721629"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="261721629"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 03:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="677402458"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2022 03:16:58 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuAY5-0003mO-1G;
        Thu, 26 May 2022 10:16:57 +0000
Date:   Thu, 26 May 2022 18:16:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 3/6] media: sunxi: Add support for the A31 MIPI CSI-2
 controller
Message-ID: <202205261808.Ob6yfFnu-lkp@intel.com>
References: <20220525190300.696269-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525190300.696269-4-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on sunxi/sunxi/for-next]
[also build test WARNING on media-tree/master clk/clk-next soc/for-next linus/master v5.18 next-20220525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Kocialkowski/Allwinner-A31-A83T-MIPI-CSI-2-and-A31-ISP-MIPI-CSI-2-Support/20220526-030637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
config: (https://download.01.org/0day-ci/archive/20220526/202205261808.Ob6yfFnu-lkp@intel.com/config)
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/497abc0e446f164e23be70628dbd44be8b5c789f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Kocialkowski/Allwinner-A31-A83T-MIPI-CSI-2-and-A31-ISP-MIPI-CSI-2-Support/20220526-030637
        git checkout 497abc0e446f164e23be70628dbd44be8b5c789f
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_PHY_SUN6I_MIPI_DPHY --selectors CONFIG_VIDEO_SUN6I_MIPI_CSI2 -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY when selected by VIDEO_SUN6I_MIPI_CSI2
   
   WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY
     Depends on [n]: (ARCH_SUNXI [=n] || COMPILE_TEST [=y]) && HAS_IOMEM [=y] && COMMON_CLK [=y] && RESET_CONTROLLER [=n]
     Selected by [y]:
     - VIDEO_SUN6I_MIPI_CSI2 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && VIDEO_DEV [=y] && (ARCH_SUNXI [=n] || COMPILE_TEST [=y]) && PM [=y] && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
