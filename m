Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE1475C73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbhLOP5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:57:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59964 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244312AbhLOP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:57:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD316195C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D13C33D08;
        Wed, 15 Dec 2021 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639581707;
        bh=RrbKXeLGT86mKHHzXfbS7Zvc1u/9yveHLJ8kMXAW9mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlFscuUbBGrpssU83yuU6eR1TmKWtsE772UwqMzDUp/KLgvzk4lHabwjfqfA7LBEy
         Em4yzgryz/iSk/bzKwRF1DuO2TAnqUFs0u3Lkv02vcexCktXDHQxM2no4+lNcc6Kfb
         C06nh42FoRWsFR70/u1Ayg0VmQmFf+czQ8yW/qAXcrK30CzeYkTf8uNEUJz1NJKiYQ
         cAqp4O9ALYk3cCwrraEwt+NgSCoSE+ysV6+r9R+31fEhm2DIm3ANgNs+OdXgyR1wtd
         M3PFDQ9d1tTLP6HMNx4eJOc/QXizjcyyUMpSl3GMnNngPUbd0A1AXt42miJB+SuxqX
         L8m7OfKB5wlqg==
Date:   Wed, 15 Dec 2021 20:51:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] phy: freescale: pcie: explictly add bitfield.h
Message-ID: <YboIAzhMrUYS09As@matsya>
References: <20211215060834.921617-1-vkoul@kernel.org>
 <AS8PR04MB86765D95A0E42CED2C5D9B4D8C769@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB86765D95A0E42CED2C5D9B4D8C769@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-12-21, 06:29, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Wednesday, December 15, 2021 2:09 PM
> > To: Kishon Vijay Abraham I <kishon@ti.com>; Hongxing Zhu
> > <hongxing.zhu@nxp.com>
> > Cc: linux-phy@lists.infradead.org; Vinod Koul <vkoul@kernel.org>;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel test robot <lkp@intel.com>
> > Subject: [PATCH] phy: freescale: pcie: explictly add bitfield.h
> > 
> > kernel test robot complains about missing FIELD_PREP, so include
> > bitfield.h for that
> > 
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:37: error: implicit
> > declaration of function 'FIELD_PREP'
> > [-Werror=implicit-function-declaration]
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:41: error: implicit
> > declaration of function 'FIELD_PREP'
> > [-Werror=implicit-function-declaration]
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie
> > standalone phy driver")
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>

Thanks for quick review, I have pushed this

> Thanks a lot for your help to fix it.
> And I'm sorry about that I didn't capture this error in my local build and tests.

No worries, Do test on different arch's other than yours

-- 
~Vinod
