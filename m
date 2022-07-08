Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9C56B3AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiGHHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbiGHHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:36:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E987C1B9;
        Fri,  8 Jul 2022 00:36:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E0FD5320090D;
        Fri,  8 Jul 2022 03:36:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 08 Jul 2022 03:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657265788; x=
        1657352188; bh=z0PrsiMp/J8Gv6mQx5qf+wqbiMQmbkqPC6B/AdbiIY8=; b=i
        w0jSHokLG+MkpRk/awanv/tvrseU28ynMDacGvU2JXIj0msMzSMttrU4Je8qj5i2
        BP7Gn1VQkRIRgejxhiPF1AF1uz2IbGSDVmPHywdeu1+2p8rl6SzHXKxzIvx8T6yr
        9BnT/IKOao7fHi7e8KPvp6SGHTz9TIeLyMxl7m0g+eQ8PAR3ZxSxKcFdWtipxp9D
        gnnEL9TSH3ioqM0uRmpR+2y8ThZDULP8/4JrBM3BwfYFh2uhHSJp8xec1NeCxJA6
        xsDO7gGaSlPL0FYeur3F0lmZ4x79b0V+4yoYpDl39RSNKoKKqWQjVQX9mCbp50BN
        rHCeHgd6QTZ18HA1mTNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657265788; x=
        1657352188; bh=z0PrsiMp/J8Gv6mQx5qf+wqbiMQmbkqPC6B/AdbiIY8=; b=U
        xIbHS17H7qUB8ks06rKakXd2A/yS6I3aYCJel7XDIvMIvpbngXwBxoE1OkmsEyqk
        JW05vxcNb2o/ewrZFznQZr/631B/2g3heSchiBsdu1mKmWO5BMA//zq8SkuHPDh2
        e70sD24hcFxWordsX5EJyatva1Yx2XBo88NnDINA+IIyDBCxlXPTrDDswQVcs4lj
        qMbNtCLmmpt1r0+rN2NJcGjTZy2Vw7/pbpNt1y8mn2pVxO/r4GJwteTTshXW8eju
        hO2x2qDKGTAoXJPt+NYn5BamnEJmNnrM8ww36HetwJ7RBls4AkVbjZBoI+auoFnM
        grWAPt8/R0IjXJ4BgzB9Q==
X-ME-Sender: <xms:e97HYuu_jaLYqWX--4K4uzOGZoq8Fw5AybMHYgKebeo-WWmqE9z9iw>
    <xme:e97HYjf1YY__iVsJngVIDlYxNskiXLndNyPjs1rI5t7yPQZ2X5KgCUfZc_elslC9j
    y14m5pbhAmM-NUGQQ>
X-ME-Received: <xmr:e97HYpwqGccGGZiackWtnGkcSU03h619n4WZ4Jfht6ntpwmol3Dof8CIj39887Xyx2WIiUlRcC-uE_Ch0KjdEVZSlOVR0bCjH_ATJzalrF0yNu-WiKHkakAEfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:e97HYpO4sjaSEfnKMi7ydtt-Y8nmnYXX-1AcCD52yBdL1aKjztctdw>
    <xmx:e97HYu9stLmJetYfleSpZLK2-iCAvThtQTXKVuPXLQwjaHcgyJw5nA>
    <xmx:e97HYhW461qiSC8m3kjb-CPQsjnpJi0jJN59qV2dIjYQYHzJau7W9Q>
    <xmx:fN7HYhYkgyi9bcjSTXduyjWlKt0SJgCzgNy8Js4Bv-hAatlzIGSvww>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Jul 2022 03:36:27 -0400 (EDT)
Subject: Re: [PATCH v2] sunxi: dts: Fix SPI NOR campatible on Orange Pi Zero
To:     Michal Suchanek <msuchanek@suse.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@aosc.xyz>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220707174801.36e010da@donnerap.cambridge.arm.com>
 <20220707170721.20225-1-msuchanek@suse.de>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0c575068-abd7-c69a-e59c-3140f8cb7813@sholland.org>
Date:   Fri, 8 Jul 2022 02:36:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220707170721.20225-1-msuchanek@suse.de>
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

Hi Michal,

The subject prefix should start with "ARM: dts:" (e.g. "ARM: dts: sunxi:").
Generally it is a good idea to look at the log of the file and follow the
pattern you see there.

On 7/7/22 12:07 PM, Michal Suchanek wrote:
> Without "jedec,spi-nor" compatible the flash memory cannot be probed by
> u-boot. The macronix part is what is shipped on the boards that come
> with a flash chip.
> 

Fixes: 45857ae95478 ("ARM: dts: orange-pi-zero: add node for SPI NOR")

Regards,
Samuel

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index f19ed981da9d..3706216ffb40 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -169,7 +169,7 @@ &spi0 {
>  	flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
> +		compatible = "mxicy,mx25l1606e", "jedec,spi-nor";
>  		reg = <0>;
>  		spi-max-frequency = <40000000>;
>  	};
> 

