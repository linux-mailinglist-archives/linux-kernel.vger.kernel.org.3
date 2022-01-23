Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798134971AF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 14:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiAWNiP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 23 Jan 2022 08:38:15 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46334 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbiAWNiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:38:14 -0500
Received: from p508fcdea.dip0.t-ipconnect.de ([80.143.205.234] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nBd4J-0004q2-V2; Sun, 23 Jan 2022 14:38:07 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aw: Re: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
Date:   Sun, 23 Jan 2022 14:38:09 +0100
Message-ID: <8763546.c4FMd9deqZ@phil>
In-Reply-To: <trinity-d0efbf68-ed45-47d4-97b3-d3788c5a9de6-1642863025116@3c-app-gmx-bap44>
References: <20220116124911.65203-1-linux@fw-web.de> <236548630.RelmrRfzIS@diego> <trinity-d0efbf68-ed45-47d4-97b3-d3788c5a9de6-1642863025116@3c-app-gmx-bap44>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Am Samstag, 22. Januar 2022, 15:50:25 CET schrieb Frank Wunderlich:
> i plan to send a v2 of the series after 5.17-rc1 is out, because i have now verified
> the functions from gpio header and found some pinctrl-changes. V1 had only prepared
> the nodes to know which devices are present on this header.
> 
> should i include this patch again or do you pull it from v1 (maybe as fix)?

I do plan to include this as fix after -rc1, but I just saw that you already sent
a separate patch of it, so I'll take that one instead :-)

Heiko

> 
> regards Frank
> 
> 
> > Gesendet: Montag, 17. Januar 2022 um 22:05 Uhr
> > Von: "Heiko Stübner" <heiko@sntech.de>
> 
> > From looking at the documentation I got the impression that the
> > pclk_xpcs is related to the separate qsgmii_pcs in the memory map.
> > 
> > So yes, I fully agree to dropping this clock from here and then adding
> > them to whatever ip block really needs it.
> 




