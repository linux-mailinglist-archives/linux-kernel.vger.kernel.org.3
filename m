Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20DC59CF97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiHWDlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbiHWDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:41:35 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E005B07E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:41:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A39315C0092;
        Mon, 22 Aug 2022 23:41:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 Aug 2022 23:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661226091; x=
        1661312491; bh=CMNLfcQRTj+R28UNum+p5/OqksTiYz6SjnJF3Y4QVwY=; b=g
        iec6xGS2SDGO/srHmwmwyqEY2qWm50F//hhHCnZXzxXMIHOcIw/ljny2ZZ5QMPQ6
        clyI9zIih+F0xmKJ3n2j8Hac+S1onHhSNYYcMVqFXkhEC24/U7P4k4HUy6AAU1xe
        Y7xVIFcm4JK10TKcfnSavjae/5Nk+YdnI0rfuQIaiJpAaH2D4L5pdMxqITs6NPrP
        gSEl3P0jFQT2cP5/gapfAruXtMdWouuJLYr4427rpfyqrL67Ht7zuFtj0iIXN02a
        x9VIuchP8CYw3i4RV3cBGk6H+jxOliDJv9lj0cf2r2xuuCDcOr03c3lBHM7EaaV9
        muHBBctmfM7n2xVlTbfiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661226091; x=
        1661312491; bh=CMNLfcQRTj+R28UNum+p5/OqksTiYz6SjnJF3Y4QVwY=; b=w
        dNcQ2x7HmD0yyo0TwNZVVB3qQKK4knWsAf4E3YA7svjT1orCPyKSM9uAdwMqTDsY
        xRcotgvTt5Eq7SHdNbpl60hLvOgBtpEBrlqfTDJkgLdkYDV8uWKh/0zH65aMmlnz
        ctuZps/Vwoi+mZ32D4V7dYd9Zf+mqNIhngWSwNx8a4OawHve+J5VT2Ol8Z+l1m98
        J9zB2Aw+DRni5/75COJhDbZi0j3LBWPXz/gTCfzxNGP2N5SQDSNXxsJt8UbLHVmh
        cNysNe65zH2+ozWa69qLvVd9K5YISlMu6ZlwEEs55Uq7kHTCN9R4zL8+GDEKuFRW
        LmPOYMVNsjnKAGOmxJUjQ==
X-ME-Sender: <xms:a0wEY6zjQlrt8sNBp02vqJD8uoABqp_bSbovD6Dg3UV6xtg9Joa6Jw>
    <xme:a0wEY2SUjdm7vbIbm2mCi6aWkxpQvhree_HKJKI7ZQa5rgMt6cLpOrVb3HZrt8sQH
    mZmRYTac2gBALSAPg>
X-ME-Received: <xmr:a0wEY8VeKlDOuwSzlDqWfQymwZM_T1o6onXxPvm4wLDzRsp8WjvEUxDs_Xj7uurF95rAqPMJh14yMKJHz5lXqNG2IL9N8crQ-TlO3P4cgbfCd11BWS4_L_VUXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeikedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:a0wEYwjErqu3ZtDXtTUU7Ytcu3iV22HI94dNQ5Io-SM7ZAEGkx0jIQ>
    <xmx:a0wEY8BrLAFV-6I4C17YTL9UlTlIOedx6rScKHNu-u5HKiikz77n0A>
    <xmx:a0wEYxL9nr5RZNKLMTN6t0S-1uT5PrlxNrEedx01mmOyKtavJq8MjA>
    <xmx:a0wEY42CcrguKp_39qRLmc68NiGPnvjpXMCgU1nrf-sD3wcpW7Nzog>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Aug 2022 23:41:30 -0400 (EDT)
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Return zero after otg sync
To:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220822103219.3985075-1-pgwipeout@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <717fe4e0-ef9c-edef-80d1-caeeae1319b9@sholland.org>
Date:   Mon, 22 Aug 2022 22:41:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220822103219.3985075-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 5:32 AM, Peter Geis wrote:
> The otg sync state patch reuses the ret variable, but fails to set it to
> zero after use. This leads to a situation when the otg port is in
> peripheral mode where the otg phy aborts halfway through setup. Fix this
> by setting ret to zero after use.
> 
> Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
> 
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 0b1e9337ee8e..5fc7c374a6b4 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1169,6 +1169,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  			/* do initial sync of usb state */
>  			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
>  			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> +			ret = 0;

The bug was caused by the unexpected consequence of (mis|re)using the "ret"
variable for a temporary value. Please introduce a new variable here, else the
use of "ret" is even more confusing. This code also wipes out any error returned
by devm_extcon_register_notifier().

Regards,
Samuel
