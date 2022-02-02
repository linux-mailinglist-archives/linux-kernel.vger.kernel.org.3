Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260DB4A6B17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbiBBE5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:57:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44752 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiBBE5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:57:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AEDE616EC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 04:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C979C004E1;
        Wed,  2 Feb 2022 04:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643777828;
        bh=23nZgFb5tUueCp7n8vqZWYPUV1GmtHwgiRqqg11GQCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh9fsVhseNFcE/j2rOzvvdxkgkrp82cC6RQAxWX5GNgcbN/zMnyQ4GVQQYBlg469O
         TZvTZ3vsnMjHGEhbcMn340rfrBl2oy9nLVjvSM2Zf3thWhasDO4sw7WkaWg01lRil/
         YacJd4WtUH7jX0Q5rxh/4gNMdc1ZZDnI0j0sB5RQ+Mnu7euGfIWh6Y6nd5ehGP9SbI
         D31V5lG3t54mQAoZ2yVyhTA2CnEEyzXbU+pZkYL96EhP4CmhxO6GOvOrtVjVqIOoOR
         c4BuTRJDUh31mKsYZbgm27S2MpeDR2jG/xqld/ppSt26j6RBfnJota0M2iqF+mLjAC
         Iv2yPll0iUySw==
Date:   Wed, 2 Feb 2022 10:27:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 0/3] phy: phy-brcm-usb: Fixes for phy-brcm-usb driver
Message-ID: <YfoPIGfs5Q3IwrPm@matsya>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <7cbb745e-8b95-1eed-0903-44070a112ec0@gmail.com>
 <Ye0/8MSBRVNuBr3L@matsya>
 <e801d672-bedf-b08b-d27b-2b0cdd476a6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e801d672-bedf-b08b-d27b-2b0cdd476a6d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-22, 17:01, Florian Fainelli wrote:
> 
> 
> On 1/23/2022 3:45 AM, Vinod Koul wrote:
> > On 19-01-22, 15:26, Florian Fainelli wrote:
> > > Hi Vinod,
> > > 
> > > On 12/1/21 10:06 AM, Al Cooper wrote:
> > > > A few fixes for the phy-brcm-usb driver.
> > > > 
> > > > Al Cooper (3):
> > > >    phy: usb: Leave some clocks running during suspend
> > > >    usb: Add "wake on" functionality for newer Synopsis XHCI controllers
> > > >    phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option
> > > 
> > > Are you able to pick up those patches? Thank you
> > 
> > Applied phy patches to phy-fixes, thanks
> 
> Thanks! I can see patches 1 and 3 there but patch 2 is not in phy-fixes or
> your next branch. Can you pick it up if it is satisfactory? Thanks!

That is usb patch right. I wont pick unless Greg acks it to go thru phy
tree

-- 
~Vinod
