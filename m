Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B575660D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiGEBzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGEBzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:55:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD6EE19;
        Mon,  4 Jul 2022 18:55:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B778A5C00B1;
        Mon,  4 Jul 2022 21:55:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Jul 2022 21:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656986138; x=
        1657072538; bh=YeDhRdYVIKJ6OOuJyZu0kh/FszUE3W6fa+XoxzjAbcg=; b=M
        msPzvHQLmCpP8QJ5/vI3ru2izemjkZsgL0q37y+m4KPzLqxNRuzxCkRe99dn367z
        Zzg/HO5pNJyIiHX+to0X47xZZog+x60myEmA9YpsrPk18uGTu6zEavun7JdjTnDp
        jNkKJ2A+7x7kS9fmCjbPLxlI0IMuiDT8WEOes4+76gYkuM41JPR3uws5KQtrshoE
        ImTwliCpDo638+OKtz4LH9cNUegYpsxURHry6BnJYbsZTyCttBO6dRABV70mWpft
        ucCkqX9O6NAYb2V4oaIzOdTT1i2fYMk6UJmjJX4KTG/8/jmchnFT8z9kpV7tTyWq
        XaAhJYPy9WnQRBwbfV4kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656986138; x=
        1657072538; bh=YeDhRdYVIKJ6OOuJyZu0kh/FszUE3W6fa+XoxzjAbcg=; b=u
        0NLBTV78FamWf4ecwocplUkQsnDA1KevzFeplWjUcpw66jD3Xbr4n/urMM/1KIjy
        T14n/U/Ujt3zbwbwh6/zERPnTSbmTwAjJSf2iHJbrrYlKnPC7pHizFYNXgFSkAbk
        muHc6TduT0Xi9iKYGR12Kcxqdq7lb0ikbCYZEYz2W4NJhaoy3O/9GCxptNhPgti7
        5wpFQqDx9qh4mlDgDwpl/8oxXRIVff498JGgeXiBysg0/igaXNkuuAa8AyjF7n35
        dUa5g/ijXvyC2Bk5sO3T8zfF1WdohReJTZE6b8UO481VbpKXxG/uOpPgpEdh7sYm
        B6WRG1rOh8WnwgrUJB3Nw==
X-ME-Sender: <xms:GZrDYuiacq_OiFy2cca7fAoe573r-feXJW6f4Www0Vo_T9gwUWA-Dg>
    <xme:GZrDYvCAzvABelwSTc7FYwUxeRBWjJ4Ubks-BQSIpKLJ9NNU_QgLm1ZsCFbQqiIof
    wc6UsWI8HnxVGXSyQ>
X-ME-Received: <xmr:GZrDYmHeZAQIBSnjups0le9mSKH-i0AgYDa0JsXzD_6TWlNBWKefq3lls0M8KdfzSVOW1U4i-yWdOajvtqu03_AYeYRq1oS2BbmWk8eqMAX4C8VwwTKAQacQUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:GZrDYnRBDeNVRb_Pw1goG4x3khwqG7jnHud4UMvNNyMaKIq_sco11A>
    <xmx:GZrDYrzapsA62s3vpEZbieUT_bxH9zGOims_BDT39Sa2ho0pcKsR9w>
    <xmx:GZrDYl6mxh3JOSJGkOCkPdg5Zn9h8mRYc7a4VTaGD-9SND7kDSk7qA>
    <xmx:GprDYjenhQa-K8uofVIHpXy5XqeW37mpY6sCLUfWMpCCVOU5TQODgQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 21:55:37 -0400 (EDT)
Subject: Re: [PATCH v4 1/2] ARM: dts: sun8i-r40: Add USB0_OTG/HOST support
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220518101706.26869-1-qianfanguijin@163.com>
 <20220518101706.26869-2-qianfanguijin@163.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <daf5c543-a1d1-04d2-6486-6cc9cd72d8e5@sholland.org>
Date:   Mon, 4 Jul 2022 20:55:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220518101706.26869-2-qianfanguijin@163.com>
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

Hi Qianfan,

On 5/18/22 5:17 AM, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> The USB0 port of R40 is divided into two controllers, one is H3
> compatibled MUSB device, another is OHCI/EHCI.

typo: compatible

> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 212e19183484..ae48474fdefa 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -401,6 +401,21 @@ mmc3: mmc@1c12000 {
>  			#size-cells = <0>;
>  		};
>  
> +		usb_otg: usb@1c13000 {
> +			compatible = "allwinner,sun8i-r40-musb",

This compatible string needs to be documented in the binding[0] before you can
use it.

[0]: Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml

> +				     "allwinner,sun8i-h3-musb";
> +			reg = <0x01c13000 0x0400>;
> +			clocks = <&ccu CLK_BUS_OTG>;
> +			resets = <&ccu RST_BUS_OTG>;
> +			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "mc";
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			extcon = <&usbphy 0>;
> +			dr_mode = "otg";
> +			status = "disabled";
> +		};
> +
>  		usbphy: phy@1c13400 {
>  			compatible = "allwinner,sun8i-r40-usb-phy";
>  			reg = <0x01c13400 0x14>,
> @@ -427,6 +442,25 @@ usbphy: phy@1c13400 {
>  			#phy-cells = <1>;
>  		};
>  
> +		ehci0: usb@1c14000 {
> +			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
> +			reg = <0x01c14000 0x100>;
> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>;
> +			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
> +			status = "disabled";
> +		};
> +
> +		ohci0: usb@1c14400 {
> +			compatible = "allwinner,sun8i-r40-ohci", "generic-ohci";
> +			reg = <0x01c14400 0x100>;
> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>,
> +				 <&ccu CLK_USB_OHCI0>;
> +			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;

Are you sure the OHCI device requires the EHCI clocks/resets? Usually it is only
the other way around.

Regards,
Samuel

> +			status = "disabled";
> +		};
> +
>  		crypto: crypto@1c15000 {
>  			compatible = "allwinner,sun8i-r40-crypto";
>  			reg = <0x01c15000 0x1000>;
> 

