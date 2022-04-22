Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C554E50C569
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiDVXxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiDVXww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:52:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98CEBE1B;
        Fri, 22 Apr 2022 16:49:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 200063201F73;
        Fri, 22 Apr 2022 19:49:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Apr 2022 19:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650671395; x=
        1650757795; bh=vKy+K0ni749aGVp+1oUC/yUMfQ0rzndD82fCAttAbls=; b=I
        QUFboe/5AQmRcwyaB4Nb8DjhXr3/OX+EGDDjQEJS5FEGvBf9iRDPfM/GQ+rb2eLv
        QUsxcPKTECFn4w47l6xFooMRparSFqIh4NCG4rhT6+zT+oV9D6fpj/ZbJAv+8e5t
        OEI0Skw+gP9+KdKL+1u1Qr556bNkPm6v0rCoOgqN3x3yTYEvGPGLdpO4J58JXfoy
        omQbr4AOz2IJni+uGdRL1Sg/6CQDcp3hehvOQeOTF3tLVf4qrIOj2d8dw0eXN3XZ
        Dt4LYK58KfCekA8amlZfZkQwZ5yerRQO0smpzxoBk/3ngc64AqWpbzlP28KKtgVn
        BqFUlWrmGeNxHpQSzoUEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650671395; x=1650757795; bh=vKy+K0ni749aG
        Vp+1oUC/yUMfQ0rzndD82fCAttAbls=; b=T9ewHHHZEsqAyTYuiyjezBFUP39vE
        gkyPYoombSoCnbFKeGbM+06AiZXm0Nz9XWrhDNLYQvXvXW/lnAxgEYg6bAPdnkb/
        v3OroeCELRX5gbOcF1AjJytWbiuIT+EH1jQVV0xqhUE5gzEZWwIXcikxUQb/B2x8
        JiA7DlzwEtscmeuyX9ziXICMsZZcNv9Y8ZGH+vLsjZ0FBXCxw8FimZrrtuYDEpp9
        +BnSLOxwaaqWFDYrGDZIXL0qWbK8sliWjeREKliNasgZRR3UWz1NdMeUfw8EckhT
        XGzmS8SNDp7Bp1YBEPqwOUpMDuleNGbA28wGyCuGd3mOyuMIw2q+m6SMA==
X-ME-Sender: <xms:Iz9jYpVHAElTXT1A04lzN_2IAyaIrdg6vAjuggnSo78INErm_nSJRg>
    <xme:Iz9jYpl0wNCKI6zZ-7ceQ7XD0qJKrVX9TjYcP6hprLNCOGmMOAff8HqPgGWJyjs1s
    PfbASJN6mBYASdMpQ>
X-ME-Received: <xmr:Iz9jYlZzH-13ZBlo8zJjOk5utsmyXxku-bSuoTAMHrp1vGJnXQkqGGZ-3QuYClamA-8aymO0KpLtN1Tl7BcRrGxsblmBIA7JCKYSyImxETYsYbwe9Geb5Cnh2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Iz9jYsXLLmQ3lKYPeeGB2AceYi-2C_hxLtiSZknptl96WTp3ji6j2w>
    <xmx:Iz9jYjmF3565fz7a2MPubOYPkVdycAn-J1gOcr01J0ZxAEdZFs1keQ>
    <xmx:Iz9jYpeLTzYPRyEpDwN-19gMEgp1OsJ63eUNZUxusR_1H-XjEHaRYg>
    <xmx:Iz9jYshn0h9669BfJZkrI9fFw5wSGCcd24HPTgWgZrtJYnV21C2ihA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 19:49:54 -0400 (EDT)
Subject: Re: [PATCH 1/4] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329 SPI
To:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
References: <20220422155639.1071645-1-icenowy@outlook.com>
 <BYAPR20MB2472E8B10BFEF75E7950BBC0BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9ae7d1ee-4e2d-f3c1-f55f-e96b0e449b63@sholland.org>
Date:   Fri, 22 Apr 2022 18:49:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472E8B10BFEF75E7950BBC0BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:56 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R329 SPI has two controllers, and the second one has helper
> functions for MIPI-DBI Type C.
> 
> Add compatible strings for these controllers
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index ca4c95345a49..6354635241fc 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -21,6 +21,8 @@ properties:
>      oneOf:
>        - const: allwinner,sun6i-a31-spi
>        - const: allwinner,sun8i-h3-spi
> +      - const: allwinner,sun50i-r329-spi
> +      - const: allwinner,sun50i-r329-spi-dbi

As far as I'm aware, the SPI portion of the DBI controller is
register-compatible with the regular SPI controller. So I would expect using
that as a fallback compatible for the DBI variant.

Regards,
Samuel

>        - items:
>            - enum:
>                - allwinner,sun8i-r40-spi
> 

