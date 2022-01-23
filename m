Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F12497151
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiAWLp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiAWLp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:45:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57CFC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:45:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 566E860BAA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AEDC340E2;
        Sun, 23 Jan 2022 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642938356;
        bh=UhU7E+vx7Dalcg6EmkOXd1hIwDDZ71eS8u67xI1UUSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raKMiK95afWZ8hzulavL/GwFzgCKG4JoXWdp3I8Zoaq9A3N46u/5NeJ7T02181wil
         R32Lr3beLtp3UOx3cEmdSfEcJC+LQnd439NGZdiYRL2l1BrfJMf2liUIP+bU1+40v8
         TWmQzz6aoes4Ah7vdtrRsD1IeBbHy6KBiBeh1yBfeKlB+Y2kX0HGxNot4hjf31Wcyr
         eSE5HyS3tvQuzYmvQ2E67hEVt8FLnYw2sF4cxQ1Ts8xZVDjeDg4jzF7UhFB+x6LJaD
         yidPfrRm3TAo3tHVBCMEasp8Yln11hdmTJynadvi0QzZLA5YOPaj6dXcQP0PrMDgXf
         ggPdE1Fjm5Q1g==
Date:   Sun, 23 Jan 2022 17:15:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 0/3] phy: phy-brcm-usb: Fixes for phy-brcm-usb driver
Message-ID: <Ye0/8MSBRVNuBr3L@matsya>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <7cbb745e-8b95-1eed-0903-44070a112ec0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cbb745e-8b95-1eed-0903-44070a112ec0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-22, 15:26, Florian Fainelli wrote:
> Hi Vinod,
> 
> On 12/1/21 10:06 AM, Al Cooper wrote:
> > A few fixes for the phy-brcm-usb driver.
> > 
> > Al Cooper (3):
> >   phy: usb: Leave some clocks running during suspend
> >   usb: Add "wake on" functionality for newer Synopsis XHCI controllers
> >   phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option
> 
> Are you able to pick up those patches? Thank you

Applied phy patches to phy-fixes, thanks

-- 
~Vinod
