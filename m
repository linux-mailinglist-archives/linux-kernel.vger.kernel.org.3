Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669FD56CA91
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGIQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGIQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:19:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E847459B6;
        Sat,  9 Jul 2022 09:19:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5708C32009C0;
        Sat,  9 Jul 2022 12:19:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Jul 2022 12:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657383584; x=
        1657469984; bh=wZ/WZnzrMZ2yHYrnPl7KcvmHD956qS1jBpdJ++/2Nn8=; b=I
        QsRsh3xYwgNpe17m90OgxP1gEiocN87NHaq32yTAGnXvphrl9l8QJdNL7uDK2jIQ
        k3xtAxEzkwzDOQ7hRxN9sq5oEJQIdSb2Oah+a1hlXKzeZ299OIs4M/MG0Mso4GnP
        d4dfA0aV6328nSR0x312Ld3Qz213LWxp2RwDCrXQQdqWSbmfHADGxH6j3mlrAMfx
        43ISFgXPEC94olxO0tow8xFst+n1zzvo7t8hj21pGsYhdf6tSPdH9tqF4D1BBPYs
        QiosD5zPBFyIEouf97Tqc1PqrIBU4YUPWwm4CqBLE2XM4CQwDNPr41TC1Cy+W5vp
        eEQL82YIEaCsBCx1/I/bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657383584; x=
        1657469984; bh=wZ/WZnzrMZ2yHYrnPl7KcvmHD956qS1jBpdJ++/2Nn8=; b=S
        iDAkZ0Hp13LQakY84JUljzgDziVE2NPdRscprSF9Lt0CYdlAFBPezEwYLhnK/rbA
        Szqs2zeioqAhqo5Gjln+Q2ZC8e8Xvox5Td2AXGwNg/XntsldhvqX883I20Co/Yp1
        uBoV7R+12nyMs1hzqSGIKioyc/8M2jNrP9ZXTSP1v3LmuSvCu4FkVk2WrpPIixKe
        X2KlpEx7jnt6XIpqYt+JRih6iys92BU/8k1DEZpr3n1xQSFiLsZIUZ7v+qeia/hv
        3mFZdnMvYSaO6x07SpVIvZWRvPamorbqCoLU9MJqEsb4yUK47cexvS5q2INTirKF
        Ysz1NoPk5N82nwilr+Nhw==
X-ME-Sender: <xms:n6rJYvR2_cjwTC7FNfjHimIUxIs542_Fr-eBxatuVGVrW31nf-lUnw>
    <xme:n6rJYgz6sNVlNtkZzGJbcYFoLZjCaj0xa6bD1JCaPOjydSYf2JS1p743VoDjMzE3Y
    knivXKEyabwuqs3Ug>
X-ME-Received: <xmr:n6rJYk2Xcd8-bCll2CAwvOtd8mWOo8Uqc2ekHz-eeLBV6TyiQ66kidys8VXjMaObSqRpMlnmEkQfGoe0QWANu0eRlqNPVJ9OdXJ24GVsU8EiIkoQwMJdn8k5AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:n6rJYvAFLLd8EJsRbihFF5ZMPkkbSUA_l-Vxrr0ZollZAfECbaYPCA>
    <xmx:n6rJYojrl2C2EHMgakqvaUV7C5mxkgaDLoY45fkGB3_e09kZ3esUQQ>
    <xmx:n6rJYjoVkjCO66cQo3UBEzcSGJKoDMIDolVv0BLdpGkUnofp1d4jdw>
    <xmx:oKrJYrOCDqiY2yQYIj65Bc9HrIhxfMaYva7zASB2z1DFxx9mygbHvA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Jul 2022 12:19:43 -0400 (EDT)
Subject: Re: [PATCH v13 1/7] dt-bindings: arm: sunxi: Add H616 EMAC compatible
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220708105235.3983266-1-andre.przywara@arm.com>
 <20220708105235.3983266-2-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <272cbbb8-bc3e-1c5e-6c8a-fc82007d17cd@sholland.org>
Date:   Sat, 9 Jul 2022 11:19:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220708105235.3983266-2-andre.przywara@arm.com>
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

Hi Andre,

On 7/8/22 5:52 AM, Andre Przywara wrote:
> The Allwinner H616 contains an "EMAC" Ethernet MAC compatible to the A64
> version.

H616 contains two EMACs, and only EMAC0 is compatible to the A64 version. EMAC1
requires an updated driver that knows about the different syscon register
location. So the new compatible string should be limited to EMAC0, i.e.
allwinner,sun50i-h616-emac0.

Regards,
Samuel

> Add it to the list of compatible strings.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> index 6a4831fd3616c..87f1306831cc9 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> @@ -22,6 +22,7 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-emac
>                - allwinner,sun50i-h6-emac
> +              - allwinner,sun50i-h616-emac
>            - const: allwinner,sun50i-a64-emac
>  
>    reg:
> 

