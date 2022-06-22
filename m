Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C855422C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356859AbiFVFQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiFVFQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:16:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E2636145
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:16:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 713ED5C0085;
        Wed, 22 Jun 2022 01:16:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Jun 2022 01:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655874977; x=
        1655961377; bh=raNbZ5XrTaJju1j0bn9K1zUDHO3TU92MxD3fSTWP0rs=; b=q
        vdtq3WjDZiEK5YG9tchH647p/Iw/Y5Zs7hMfLZkyFMvl+ffhtGzPt/ILO9t/J4pY
        aVh6OCUixEJv78Ux+OHNZvJwyAK5CgKVQxx1AiHax5x5K8xTi8IbgCNWVvn2OOX/
        4p+2g7+hhbEgfpbb/QUIf/61BGVvunohHXeGWVNq24IKYBn9+QRYAGHG17Tf3jgl
        CYCvRfQqKUPXN6YBCDs3epBhPSd2GHdO2hpHdWBimj8pV8IC26DcQLR6w0Rb51DO
        ngUg5fwmsSj9LTy6HcxGB/vnOXMk6E1YC4VvC3Xl2lqbgZd3FcR5lJbJ4JgPly51
        iSeHDn5HYcj8ghd8WJqXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655874977; x=
        1655961377; bh=raNbZ5XrTaJju1j0bn9K1zUDHO3TU92MxD3fSTWP0rs=; b=x
        WhshaypefrwmpT1bwf3HCZBvc4U7xKpYZ/Tgu8AyTFwK74d1VX3NPQNHFDf42WsS
        tMP4C8joE2oEk6zKYmJOSpa7DCkVyaEX9RtGiUEq26y48T5p+qf3GNmFxR2WHpG/
        BZeESjon+nMKiXRkikeVNcqnPOFtwJ1G4qH8lktmfFIE3Dhy/0F0hH4Yw9dy0fRT
        ZIv9LM1+63kg1/pNjNRt89GFHgIoGBTFYkDaFdXZJXKKp5qd1OrzW9u1tB3vg2Qj
        /MpHOCjqiiUW2qXYwrtZdz1idZIvZgPAYf8sHYcuFvoONwzjPMkvOlytjvSuwjXx
        OSpuKtY/7vIc1ANK/i/Xw==
X-ME-Sender: <xms:oaWyYsCjSgg5cbgE8Hrl1-4Uh7lj1ynHoXi-nFiszyd1h9_-QlrhmQ>
    <xme:oaWyYuhU3FOPWNk33MayY29C3KnW9OXvBZEKrH9XhO__Dkyr6lPOvOvZxBdsWqr-k
    OxnzEdEgNFEu1ILDw>
X-ME-Received: <xmr:oaWyYvnuWBbobhQNwfP-tuYSqgx_8NQdUeBKN7k4ziDIL3WtFJApT7Q94T6mrD1-fh4W4fEphn4c8wJ7fajR1VNTFqL42vfQ82oT3BXFrN53d2B4AsOrck9xFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:oaWyYiziAOsu4ceIlQgNl01DIuw3FK6LeRyciThy9lRTP86LKkjeaw>
    <xmx:oaWyYhSZZ7-FVHlReemQFpwH92FS8WiyaufgGfeycagsCkDZhlnjPA>
    <xmx:oaWyYtbB-om1ZEg8Va4NPxaWGMzKH1ygm0ZJWUifimyEkdzRe9DZbg>
    <xmx:oaWyYgF5qI69K325-oVH_SS3LWoTtbiFl0ol0KrfADdHIjZN49bV0A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 01:16:16 -0400 (EDT)
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Sync initial otg state
To:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622003140.30365-1-pgwipeout@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f252c182-e306-174e-dd32-51c9a406d3f7@sholland.org>
Date:   Wed, 22 Jun 2022 00:16:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220622003140.30365-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 7:31 PM, Peter Geis wrote:
> The initial otg state for the phy defaults to device mode. The actual
> state isn't detected until an ID IRQ fires. Fix this by syncing the ID
> state during initialization.
> 
> Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>

One comment below. Either way it fixes a bug, so:

Reviewed-by: Samuel Holland <samuel@sholland.org>

> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 6711659f727c..6e44069617df 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  					EXTCON_USB_HOST, &rport->event_nb);
>  		if (ret)
>  			dev_err(rphy->dev, "register USB HOST notifier failed\n");
> +
> +		if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {

Currently the IRQ handler does not care who created the extcon. We should at
least be consistent between here and there.

Regards,
Samuel

> +			/* do initial sync of usb state */
> +			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> +			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> +		}
>  	}
>  
>  out:
> 

