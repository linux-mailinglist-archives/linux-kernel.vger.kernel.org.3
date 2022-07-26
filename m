Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22757581332
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGZMeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiGZMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:34:29 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932224BE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=opcQav5T4MbREVpWWZz38bgIRyaBxYgmV1agTFpwly8=;
        b=oE297L+EUvSzWrbNHHzYfm/xzBWWfnxJLe9FNr5KBCREvrJzRqghey9Ykyi/4iRibuHdutOCBn3uN
         Z/a9X+Ognfx4w2yroWe/rh22vsMiKPm1b+9Ht5SUnw5FycAxX4/QYYsL0lXw4KKjFnlQSIjUFdlZcS
         s+CekPQ7XozkZX1Hc6QDxz8tooQh9coJJtr0LP4OM8jy/BBFp9IeRlM1LbHgO5Szn6yrV6uLdOOVmI
         X5sWKdwssIZVF+1OcST3JRkK3QXzYIXKtm0AX9YXVCLdQBwdcsRGREz7N/6EMrSB6TNJ505/pRbI7D
         rC/PCQFvDlDNEEUq03KE03LJ1YaKOjg==
X-MSG-ID: 495cfb04-0cdf-11ed-9051-0050569d2c73
Date:   Tue, 26 Jul 2022 14:34:26 +0200
From:   David Jander <david@protonic.nl>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
Message-ID: <20220726143426.1e8a186f@erd992>
In-Reply-To: <340a4a81-d4ec-2f42-28ae-49124830157a@linaro.org>
References: <20220725124813.1001032-1-david@protonic.nl>
        <de68c1e8-447d-f1e9-7885-6a109af1e971@linaro.org>
        <20220726083006.5c65b597@erd992>
        <340a4a81-d4ec-2f42-28ae-49124830157a@linaro.org>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 09:01:47 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 26/07/2022 08:30, David Jander wrote:
> > On Mon, 25 Jul 2022 22:33:12 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 25/07/2022 14:48, David Jander wrote:  
> >>> On some older hardware models this is needed. It will do no harm if used
> >>> with newer models though.
> >>>
> >>> Signed-off-by: David Jander <david@protonic.nl>
> >>> ---
> >>>  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 22 ++++++++++++++++++++++
> >>>  1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> >>> index a1676b5d2980..08d425020088 100644
> >>> --- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> >>> +++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> >>> @@ -37,6 +37,16 @@ backlight_led: backlight_led {
> >>>  		power-supply = <&reg_3v3>;
> >>>  	};
> >>>  
> >>> +	/* only for backwards compatibility with old HW */
> >>> +	backlight_isb: backlight_isb {    
> >>
> >> Node name: backlight-isb
> >>
> >> I know that other node had underscore, but these are not correct for names.  
> > 
> > I know the names are not correct, but they are in the style of existing node
> > names in the same file. Do you want me to change them all, or just this one?
> > This change would break existing user-space software though, which is something
> > I prefer not to do. Unfortunately both names are relied upon by user-space
> > software for almost 10 years now, and changing them will force me to maintain
> > off-tree patches that revert these changes.
> > I understand the reason for the change though, and if you insist I will do it.  
> 
> Node names are not ABI, thus any user-space depending on them does it
> wrong. Could you link/name which user-space depends on it?
>
> I don't understand why new node is also already a dependency. It's a new
> node, there cannot be anything which depends on it before it is being
> applied in upstream.

Never mind. I already sent out v2 which fixes both node names.
Thanks.

Best regards,

-- 
David Jander
