Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80F4A7C77
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348361AbiBCAMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbiBCAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:12:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C96C06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:12:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC0A608C4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 00:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD17C004E1;
        Thu,  3 Feb 2022 00:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643847133;
        bh=oSYU449OFBEVHqPmnSPu3oVhE+80pUlusICt1ddTPQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKzqPniQnSGUTIbsStvay2/tvR3aI2GaA/tcL9j9Q4hQ3W8zeUUPGHW1e9e/9Z6UZ
         se49QLzV+4CiO1GqNYTJMoArjHSwDnT5QECxB6o5EDihoxVH/+2UBZCqXOeILAQLBF
         uAfnbYP3XNZ5B/5nApk/7Sqlw+NK7xYslSm5/6TNdyzAzTcRRrBqIQrcgq8BdunMy/
         ak6CYIIba/7yr0zgFKEq5IhMnNsN1Cmjy9yp/T5hy/7+qd9JC9dRJ54zIXfj3qF0Gb
         Q5W/9NWEp4z3MbE3kLddhamNVDBoVtCwm7UgGdlnD9/syQdA5IiVTNJo2JkSz+gD+Q
         eqpY2h8NzKAwA==
Date:   Thu, 3 Feb 2022 05:42:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 0/3] phy: phy-brcm-usb: Fixes for phy-brcm-usb driver
Message-ID: <Yfsd14IRHy99k1He@matsya>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <7cbb745e-8b95-1eed-0903-44070a112ec0@gmail.com>
 <Ye0/8MSBRVNuBr3L@matsya>
 <e801d672-bedf-b08b-d27b-2b0cdd476a6d@gmail.com>
 <YfoPIGfs5Q3IwrPm@matsya>
 <71178ae0-053d-d2f4-88cf-a41513432351@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71178ae0-053d-d2f4-88cf-a41513432351@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-22, 08:24, Florian Fainelli wrote:
> 
> 
> On 2/1/2022 8:57 PM, Vinod Koul wrote:
> > On 27-01-22, 17:01, Florian Fainelli wrote:
> > > 
> > > 
> > > On 1/23/2022 3:45 AM, Vinod Koul wrote:
> > > > On 19-01-22, 15:26, Florian Fainelli wrote:
> > > > > Hi Vinod,
> > > > > 
> > > > > On 12/1/21 10:06 AM, Al Cooper wrote:
> > > > > > A few fixes for the phy-brcm-usb driver.
> > > > > > 
> > > > > > Al Cooper (3):
> > > > > >     phy: usb: Leave some clocks running during suspend
> > > > > >     usb: Add "wake on" functionality for newer Synopsis XHCI controllers
> > > > > >     phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option
> > > > > 
> > > > > Are you able to pick up those patches? Thank you
> > > > 
> > > > Applied phy patches to phy-fixes, thanks
> > > 
> > > Thanks! I can see patches 1 and 3 there but patch 2 is not in phy-fixes or
> > > your next branch. Can you pick it up if it is satisfactory? Thanks!
> > 
> > That is usb patch right. I wont pick unless Greg acks it to go thru phy
> > tree
> 
> This is an USB PHY patch, I suppose the subject including "usb: " did
> somewhat mislead you. Here is the diffstat just for that patch:
> 
>  .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 46 +++++++++++++++----
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> definitively falling into the PHY subsystem.

Yeah that was it! Can you please change the title and resend...

> -- 
> Florian

-- 
~Vinod
