Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1644FABA8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 05:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiDJDxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 23:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiDJDxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 23:53:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A313F0B;
        Sat,  9 Apr 2022 20:51:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E2C05C0106;
        Sat,  9 Apr 2022 23:51:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 09 Apr 2022 23:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=8sKdFzvVcyArwZ
        LwNXQ9FVQwAuWZZ47XwzYvxhpdEOU=; b=M4xRkZ1ufqtOPmkzI+qxvjaTUSmO55
        xb+TWWFxJvaoXbrcmI10sC/BdmUHP2ZM9F/FsquL3adPQGd6envcSld0QLbpTGC9
        VWYx/ebFwTLnGObIGlqZZ/+/DDDjyVnSn73xXwf+IGBG3TRYbQiBllo/qc7u876k
        txNB166AJwtALPxA3rtVH7wgu5I/cPx2y7ydQNa3W1dkjsW4u3di8ik17Ekj2Qr1
        7qYqdPv2jQ1kP1FLOriCptYaUdjKUh1+7bC60VrA4n6s0MPu0LeIJChYn2nAlxUF
        v3lRlYZ7m2XaO8YQRVy/bjHBc6S6XPMc0joREYTOeaB9EjTpOxO9tztw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=8sKdFzvVcyArwZLwNXQ9FVQwAuWZZ47XwzYvxhpdE
        OU=; b=NPrxSewyPeQXPaBJ80LKeLCeyDsy8YCnK9McUvx+QVkI3qdH9xYj2i+PP
        iRH5e5rweEpYBfDI8E4RyE+chsvnZsLWKNn06t7SdRY1j8YE66cuIPl9IeKuNc89
        B7ukQNAcpajTkrAjJH2Eaep5/EcJqTHRqWiMR57nwnDzh1gmH+aA1ZiOQOwlXr5q
        QmiJtZCB7ZYz6ojX1ohWXrMNhQiSoQ8EYKV7/0xXds5cdeeMih1PC40qJES7XANP
        vyp6baBhA0XB5Iz6KfhS3MB2dgET3Ic6E/9nkPsD5cCtOWvOhM8Q8l28VldfCg+X
        k+2cP42Wm5j/mZlXUpqyPoJ3KAyHg==
X-ME-Sender: <xms:PVRSYts-sa4Vgz9XcSI976mTy-fiOT-jTCyGIdTholnzwWrRwWvKsQ>
    <xme:PVRSYmehysPnFEZDT-pzzT6P-X8hv9u9dbEvK0y_h6fjn7tfjL8rtjhu3_fhjG2qy
    QzVy2PuAdte2n3Kow>
X-ME-Received: <xmr:PVRSYgybnX7tcEtV0HDFhSHRAQbLTBc6mkcGUjoWszijxWcTsKbRPyjGJeUPaGTNK-gqQTssD4Pnkphjzgbs734lRd2TNYu9Ukz-RZ8fgZA_EUBte_WB5vIqvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:PVRSYkM4Wx425nqZnCRtHwHwht0ErbyOhgcpcHj1DUjBDibX13LJxw>
    <xmx:PVRSYt_qahXRKW4l6V2WDD77MHxA0lny1IB-lcex8famOTZQ1XSefg>
    <xmx:PVRSYkX3BJb0A0645O_ByJNGhqbSqEKirnczHUed2NHOwtsXu2NS3A>
    <xmx:PlRSYrcbksWjPPZTNtLvq_it9UZFS_zA20USbrs_Bu6NM8u7umMjxg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Apr 2022 23:51:25 -0400 (EDT)
Subject: Re: [PATCH v3 2/8] dt-bindings: interconnect: sunxi: Add V3s mbus
 compatible
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
 <20220302211100.65264-3-paul.kocialkowski@bootlin.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <5a3ce1aa-2d67-ed2c-cbfc-3fcccc93f40a@sholland.org>
Date:   Sat, 9 Apr 2022 22:51:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220302211100.65264-3-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 3:10 PM, Paul Kocialkowski wrote:
> Since the V3s uses the internal mbus for DMA with multimedia devices,
> document its compatible in accordance with the extended mbus binding.
> 
> This will enable adding support for the V3s in the full-fledged
> devfreq driver eventually.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> index 8eee312c2e6f..e7f3f798491a 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> @@ -31,6 +31,7 @@ properties:
>        - allwinner,sun5i-a13-mbus
>        - allwinner,sun8i-h3-mbus
>        - allwinner,sun8i-r40-mbus
> +      - allwinner,sun8i-v3s-mbus
>        - allwinner,sun50i-a64-mbus
>        - allwinner,sun50i-h5-mbus
>  
> @@ -88,6 +89,7 @@ if:
>            - allwinner,sun8i-h3-mbus
>            - allwinner,sun50i-a64-mbus
>            - allwinner,sun50i-h5-mbus
> +          - allwinner,sun8i-v3s-mbus

This should be sorted, though it can be fixed when applying the patch. With that:

Reviewed-by: Samuel Holland <samuel@sholland.org>

>  
>  then:
>    properties:
> 

