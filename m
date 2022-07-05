Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25645662B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGEFRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGEFRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:17:37 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795BD9D;
        Mon,  4 Jul 2022 22:17:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 44B635C009A;
        Tue,  5 Jul 2022 01:17:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Jul 2022 01:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656998256; x=
        1657084656; bh=l06hKa8FX6f2rc48K0AkRV8GNe0TgQght/OVF4ypUag=; b=V
        U/kgryCJ6yVCm81ZS+aci+Bl4bPdaRa0dCkHHQFHPZo1e3Yg14Eiv7tQfGuZeKHS
        q8wZPUqdlNgf2BzJ677d2k9nieISzpWkkASyirapBforOYn6KboTQb2jZT+rqsR3
        3JV4Ifte7daxvxxHlqAWoFzG1XHxWXoZuP0vI4WfmCI23N0KcIfL6i5AidUBbFzB
        u4xOSHklUkLEDx68ycfz8fa++amjoOdCQAjpUubkU468zeHkfGrNMVrpCJBl+Wtj
        aCi734X4cXcvi5Vve6d4YdinMcGQinP75vPo7c/5KQRMPCT477HYaXJBSv5n22LQ
        YtL6gxE+/hQJR0kbVIF9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656998256; x=
        1657084656; bh=l06hKa8FX6f2rc48K0AkRV8GNe0TgQght/OVF4ypUag=; b=m
        ZSqr8TEq53pUAE2WPhGKf8d4RTZ0tbR6UkPXL5/jEbdeJrhtfS9NcfKQ3XeiKx7x
        rnK/D+osPhuhiJBPxatOucmsI70/jmL8NZqrinkzZONPR937B4k2WaZbZx2+LLdW
        grtR4P84xKMRJ6j1qq2Oll45kTyjcTt2dp/oDnXb/BnCQTh+YVxBKX+dVBrhDFIm
        UxyEt8bXF7ub8XH6woXRWwfi67VFm7b8FZW1zcNHnPMsb2D/nYvHCaiF6P9VHcd5
        kg7LvDXILIcIzEq2B2mYDQ8Zn3VjU+rPug5YkQ+wcM4nOuxB42tFJpsYFcU+3aYN
        vuMK+1A9oIx3CiA1km0VA==
X-ME-Sender: <xms:b8nDYlokvJ97rwqdNGNj8mabFwVK-2Vv1r_OnUhmSjc4VQldzGFi6w>
    <xme:b8nDYnpysuJaFUQT5HELXBk98__VU2Fy_VENxPGxlnXVEGqeBFE6_SVjQAtkBLoj9
    I05X7gYsheYbN3uMQ>
X-ME-Received: <xmr:b8nDYiOyrCSe_nzQMH4vJqfqzWGqTIR38Zbi5IffjNnH2Qns5uB8gWoebIfuXudmEJ9LugKC3ecBEzJ0Q0P2sC5VlwpN-DvlU9-oroxZ6Mc1RHqlH4Fduj0yoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:b8nDYg63upzuEj5QuqmvXbJdJWEVDCoK1Z1cVnXFW67B5rxtOb8N7Q>
    <xmx:b8nDYk5JIp0uKlRlqUFRRNlxfmrpD0fBjwSkiLnkq3SzgNBATwow5A>
    <xmx:b8nDYojmQ277RnZBZY7oLtnKQOsi4ZeP49C582t0fSeRBoyZEZPi0Q>
    <xmx:cMnDYjaP5YXuMF9o9sY_5_yoBa3rxd2Qd5_-Ytv_8BT1hpUmqy7bWQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 01:17:34 -0400 (EDT)
Subject: Re: [PATCH v2 1/1] arm64: dts: allwinner: h6: Enable CPU opp tables
 for OrangePi One Plus
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220510153006.279233-1-amadeus@jmu.edu.cn>
 <20220510153006.279233-2-amadeus@jmu.edu.cn>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <93bbf82c-5868-e5ad-6325-7c4e6ba50907@sholland.org>
Date:   Tue, 5 Jul 2022 00:17:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220510153006.279233-2-amadeus@jmu.edu.cn>
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

On 5/10/22 10:30 AM, Chukun Pan wrote:
> Enable CPU opp tables for OrangePi One Plus.
> 
> This needs to change the CPU regulator max voltage to fit
> the OPP table.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> index 92745128fcfe..7773c51438ce 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi

Putting the changes in this file also applies them to the OrangePi Lite2 and
OrangePi 3.

Did you test OrangePi Lite2? They both use the same PMIC with a similar
configuration, so it may be safe to assume that what works on OrangePi One Plus
also works there, but I am not sure.

OrangePi 3 already includes the OPP header and these changes, so it is safe but
redundant.

Either these changes need to be made in sun50i-h6-orangepi-one-plus.dts, or we
need to remove the duplicate changes from sun50i-h6-orangepi-3.dts.

Regards,
Samuel

> @@ -5,6 +5,7 @@
>  /dts-v1/;
>  
>  #include "sun50i-h6.dtsi"
> +#include "sun50i-h6-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> @@ -64,6 +65,10 @@ reg_vcc5v: vcc5v {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdca>;
> +};
> +
>  &de {
>  	status = "okay";
>  };
> @@ -208,7 +213,7 @@ reg_cldo3: cldo3 {
>  			reg_dcdca: dcdca {
>  				regulator-always-on;
>  				regulator-min-microvolt = <810000>;
> -				regulator-max-microvolt = <1080000>;
> +				regulator-max-microvolt = <1160000>;
>  				regulator-name = "vdd-cpu";
>  			};
>  
> 

