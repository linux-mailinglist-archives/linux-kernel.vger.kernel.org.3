Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E811B517BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiECC1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiECC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:27:51 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3919C1F;
        Mon,  2 May 2022 19:24:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 34D2832009C5;
        Mon,  2 May 2022 22:24:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 May 2022 22:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1651544658; x=
        1651631058; bh=tycuARXVqUe2TLl3K12T3UUhqG6qp0PN6otB8sEoyhA=; b=D
        49zDk7dIyBK+x4sws1KEYwiKpw/4HXuug9Xbah4BT0ByUAfUgMMVXBt7QD1h/nVa
        CFVBHruG7YaQ2ksZ9EjEvN+OOBfRU8Muv341f8vLrlelPok4AjVQ/u1+TeL/uPR6
        c80ZnhkZDYDwFpYw6ubzrQzWLkVGS4aR24tMK8SHRyfU2aUglvw3ZGZukXY0gTNI
        kcPlAa8EGjuSqtCq6UWhJlrDmGRYHtyMnmgwfuryy9sxskthx7q6/0cJIA4VrRHj
        y8sYSZDnm8dfSfxRTLYCf8f0jntRIT2EDP2VgNgq5sHE0GfiU1iZbHK3d4g21S16
        Tjd1T8/IYhJSkVjXf5puw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651544658; x=1651631058; bh=tycuARXVqUe2T
        Ll3K12T3UUhqG6qp0PN6otB8sEoyhA=; b=NXSC46eEWmuy1pd3froyQpdN6Q6rp
        Q5w1qPsj/JKWqzAx3RhKbYl6M+zny22QyWIEk6E7OHU1/QWv1bOm1gaDOka2u75/
        TdHKLk/eNOejdsBPap4Vm8ywNN1a/gq/MTZH86+HdEMXKQd7W6IpzYpBst9CNJpb
        /fdynwgdkyS/d4Zs/lJ19E5fzoKX5/Ymn1AUeD2oTP5kcF+jkN6S+mG/K/FIMfVv
        5leN9D9xvL/IcBv+Q8IWcNQ+YuqcPDvaaT3L8wJWUvZf/SRZACgZhTE4//2CoTxm
        clnKzsqpBFgH4xbGX8aq+3KjbP6lnCefdzsXvGyKtuoEkFPMDAlRAMv5A==
X-ME-Sender: <xms:UZJwYngTLd7sOuIQlodPZi5jlQhJNxEKVNt3oWpx4jVNcJhpon2z9w>
    <xme:UZJwYkA2RWPlmhLMdeir5WmUken0YHCPviw2xOQnxNhEjxmjz3dujajZmjl2TcTDe
    N7yfuNkPzvIMM7tCQ>
X-ME-Received: <xmr:UZJwYnHxle1ONnfFfbdNdeQV-b23FVJHlXW23R8DZsd1JY3CHTq_30FfZlJtPQweWV62Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:UZJwYkS_0rb1-qcpoAfzbbSA0q_gO7LrSViJW0PIi2nNqM3fWSAGlQ>
    <xmx:UZJwYkxMhrYqWn22UEMO8cLugxRjLX28q9Wyuu3svYwg0pStxNnIUg>
    <xmx:UZJwYq5gsR7NFX0IYRNM3q2-BlCnM5FzH7cu3gYZKH52zmtY2eHxvg>
    <xmx:UpJwYjkY2H1GS6IjGvyyHNNsl8Ed3tZHqGQTfbUrgpJLGffQyZsOJQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 22:24:16 -0400 (EDT)
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Enable CPU opp tables for
 OrangePi One Plus
To:     Chukun Pan <amadeus@jmu.edu.cn>, Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220502150101.45200-1-amadeus@jmu.edu.cn>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <16b5d02f-5fa0-3094-1fc2-5b8322f047b0@sholland.org>
Date:   Mon, 2 May 2022 21:24:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220502150101.45200-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 10:01 AM, Chukun Pan wrote:
> Enable CPU opp tables for OrangePi One Plus.
> 
> This needs to change the CPU regulator max voltage to fit
> the OPP table.
> 
> Also add the ramp-delay information to avoid any out of spec
> running as the regulator is slower at reaching the voltage
> requested compare to the PLL reaching the frequency.
> 
> There is no such information for AXP805 but similar PMIC (AXP813)
> has a DVM (Dynamic Voltage scaling Management) ramp rate equal
> to 2500uV/us.

The AXP805 datasheet has this information in the description for REG 1A. DVM is
disabled by default, and when it is enabled, the default ramp rate is 10
mV/15.625 us == 640 uV/us.

Did you notice any instability without this delay?

> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> index 92745128fcfe..d7b82ef6be55 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
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
> @@ -208,7 +213,8 @@ reg_cldo3: cldo3 {
>  			reg_dcdca: dcdca {
>  				regulator-always-on;
>  				regulator-min-microvolt = <810000>;
> -				regulator-max-microvolt = <1080000>;
> +				regulator-max-microvolt = <1160000>;
> +				regulator-ramp-delay = <2500>;
>  				regulator-name = "vdd-cpu";
>  			};
>  
> @@ -216,6 +222,7 @@ reg_dcdcc: dcdcc {
>  				regulator-enable-ramp-delay = <32000>;
>  				regulator-min-microvolt = <810000>;
>  				regulator-max-microvolt = <1080000>;
> +				regulator-ramp-delay = <2500>;

This change is not related to CPU frequency scaling, so it belongs in a separate
patch (if it is needed).

Regards,
Samuel

>  				regulator-name = "vdd-gpu";
>  			};
>  
> 

