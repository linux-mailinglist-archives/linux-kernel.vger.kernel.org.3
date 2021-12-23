Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9083347E227
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbhLWLTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:19:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40596 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhLWLTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:19:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0148CE1FDD;
        Thu, 23 Dec 2021 11:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FF7C36AE5;
        Thu, 23 Dec 2021 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640258381;
        bh=9as6QT34cWbvbNObFkKEmAbbIbFepkq9xGUjBBZthCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsNQ3Cgzqe76Nl7jbeA9jP9g0EAb1BuYU9G0thpzhEr1KRhlP+Ah7r3RM2zycMkSw
         O0C1Xqs9fCGzdUvDP+wsvqIXDPlcDCssAkeBdx0LC9OOOSvwxax+RXUZ9DPHHYVv21
         yJ8wNQhdjgEquae/DyWWNQVKVIbn2xk07uZeRBCx+It5B0SJS/qVsS238HZMnoPhEX
         pHuTcbsU4foxjQAr3cSYHr4uOXYCkbsliFZsSzfKtO1MTJLfYL5VOxdeCoRmNEstiX
         ldPVrWvV5zbl+2AapLt2zX2mcvkQXiKMlqNrGRBrAiGWo84ik7NJDwGBtfCFuAAP8j
         4wPEIaf4g7Mcw==
Date:   Thu, 23 Dec 2021 16:49:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de,
        kbuild-all@lists.01.org, robh+dt@kernel.org, jbx6244@gmail.com,
        devicetree@vger.kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 3/4] phy: rockchip: add naneng combo phy for RK3568
Message-ID: <YcRbST7GDTNiZAkn@matsya>
References: <20211215095657.13183-4-yifeng.zhao@rock-chips.com>
 <202112160605.2BqI0hlK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112160605.2BqI0hlK-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-21, 06:47, kernel test robot wrote:
> Hi Yifeng,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on rockchip/for-next]
> [also build test ERROR on robh/for-next lee-mfd/for-mfd-next v5.16-rc5 next-20211214]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Yifeng-Zhao/Add-Naneng-combo-PHY-support-for-RK3568/20211215-180610
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211216/202112160605.2BqI0hlK-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/5e4ddb08d86d5232174d88483f29e96272a4b6c0
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Yifeng-Zhao/Add-Naneng-combo-PHY-support-for-RK3568/20211215-180610
>         git checkout 5e4ddb08d86d5232174d88483f29e96272a4b6c0
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/phy/rockchip/phy-rockchip-naneng-combphy.c: In function 'rk3568_combphy_cfg':
> >> drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:22:47: error: 'HZ_PER_MHZ' undeclared (first use in this function)
>       22 | #define REF_CLOCK_24MHz                 (24 * HZ_PER_MHZ)
>          |                                               ^~~~~~~~~~

You need to add the header to your driver for this

>    drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:490:14: note: in expansion of macro 'REF_CLOCK_24MHz'
>      490 |         case REF_CLOCK_24MHz:
>          |              ^~~~~~~~~~~~~~~
>    drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:22:47: note: each undeclared identifier is reported only once for each function it appears in
>       22 | #define REF_CLOCK_24MHz                 (24 * HZ_PER_MHZ)
>          |                                               ^~~~~~~~~~
>    drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:490:14: note: in expansion of macro 'REF_CLOCK_24MHz'
>      490 |         case REF_CLOCK_24MHz:
>          |              ^~~~~~~~~~~~~~~
> 
> 
> vim +/HZ_PER_MHZ +22 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> 
>     20	
>     21	#define BIT_WRITEABLE_SHIFT		16
>   > 22	#define REF_CLOCK_24MHz			(24 * HZ_PER_MHZ)
>     23	#define REF_CLOCK_25MHz			(25 * HZ_PER_MHZ)
>     24	#define REF_CLOCK_100MHz		(100 * HZ_PER_MHZ)
>     25	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
~Vinod
