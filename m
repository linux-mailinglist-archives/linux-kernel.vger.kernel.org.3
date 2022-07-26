Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5E580BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiGZGaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiGZGaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:30:13 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1849810AF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=QVIS0e/Pgyjm/UeHloB3YzmyfAb0KD91LCWzYjWV8Kw=;
        b=NoGCHGPHhgtT8otrzY+UiHQE0y309ougCSpmiwh2wyt5UvTABhWhXno5jJp3bGLMmzK3TvuFPGLVD
         +nSJd5egxlnRx8dduRd2IC1lW0xMoIHxglV0ExcSu72O9EKFosqmwLk7+y1YYJq2s69wh4nofbumwu
         lKqfWiF0DTV5w4QTw3dTJz81eUQ/YUFdWQxfNt8uqSyw0Vu7Dk4M97hTptXvHuNjtp/tkekQzba2fV
         GqdGIF1uHd3Ul8rhxemf0nkBnr8nL9zzz0HujhJvwaHcVn04+aNoAoP+1Ion85gqTGLqH4sItFy/8W
         WKAo73j9tdT/elM2wd12z+TGWYg/6RA==
X-MSG-ID: 63f9ca3c-0cac-11ed-8a45-0050569d11ae
Date:   Tue, 26 Jul 2022 08:30:06 +0200
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
Message-ID: <20220726083006.5c65b597@erd992>
In-Reply-To: <de68c1e8-447d-f1e9-7885-6a109af1e971@linaro.org>
References: <20220725124813.1001032-1-david@protonic.nl>
        <de68c1e8-447d-f1e9-7885-6a109af1e971@linaro.org>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 22:33:12 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/07/2022 14:48, David Jander wrote:
> > On some older hardware models this is needed. It will do no harm if used
> > with newer models though.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> > index a1676b5d2980..08d425020088 100644
> > --- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> > @@ -37,6 +37,16 @@ backlight_led: backlight_led {
> >  		power-supply = <&reg_3v3>;
> >  	};
> >  
> > +	/* only for backwards compatibility with old HW */
> > +	backlight_isb: backlight_isb {  
> 
> Node name: backlight-isb
> 
> I know that other node had underscore, but these are not correct for names.

I know the names are not correct, but they are in the style of existing node
names in the same file. Do you want me to change them all, or just this one?
This change would break existing user-space software though, which is something
I prefer not to do. Unfortunately both names are relied upon by user-space
software for almost 10 years now, and changing them will force me to maintain
off-tree patches that revert these changes.
I understand the reason for the change though, and if you insist I will do it.

Best regards,

-- 
David Jander
