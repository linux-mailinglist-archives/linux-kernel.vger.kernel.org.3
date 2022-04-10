Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57694FAF10
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbiDJQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbiDJQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:50:37 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB414B840;
        Sun, 10 Apr 2022 09:48:25 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndajc-0006bM-FX; Sun, 10 Apr 2022 18:48:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH v1 0/2] Change Bananapi-R2-Pro board to match V1.0
Date:   Sun, 10 Apr 2022 18:48:19 +0200
Message-ID: <3163720.aeNJFYEL58@phil>
In-Reply-To: <7EC83317-29EA-4464-9C24-27A78FB77911@fw-web.de>
References: <20220402110045.104031-1-linux@fw-web.de> <164906273049.1398682.587469799631775473.b4-ty@sntech.de> <7EC83317-29EA-4464-9C24-27A78FB77911@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Am Dienstag, 5. April 2022, 08:09:43 CEST schrieb Frank Wunderlich:
> Am 4. April 2022 10:59:59 MESZ schrieb Heiko Stuebner <heiko@sntech.de>:
> >On Sat, 2 Apr 2022 13:00:43 +0200, Frank Wunderlich wrote:
> >> Mainline Devicetree was created for v00 prototype that was not in
> >> public sale and only shipped to few developers. V1.0 of the board
> >> has some changes in io-domain and gmacs are swapped.
> >> 
> >> Change mainline DTS to match the current hardware.
> >> 
> >> Frank Wunderlich (2):
> >>   arm64: dts: rockchip: Change io-domains of bpi-r2-pro
> >>   arm64: dts: rockchip: Add gmac1 and change network settings
> >> 
> >> [...]
> >
> >Applied, thanks!
> >
> >[1/2] arm64: dts: rockchip: Change io-domains of bpi-r2-pro
> >      commit: 34fc952867aa2a2e257bf2bcbbaac97ac91f8bd1
> >[2/2] arm64: dts: rockchip: Add gmac1 and change network settings
> >      commit: 5c8e82ed3a4a5c8023b2959d8f3292f7291e7227
> >
> >Best regards,
> 
> Hi Heiko,
> 
> Thanks for fast apply.
> 
> Can you treat it as fix (for 5.18). At least io-domain will damage board if someone use 5.18. Network will simply not work.

I've moved both over to fixes now.

It's clear for the io-domain but also the second patch probably makes
the 1.0 board actually work where it wasn't before I guess, so that
also counts as a fix :-)

Heiko


