Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2C4C0A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiBWDi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiBWDir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:38:47 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E643D4B8;
        Tue, 22 Feb 2022 19:38:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 543F7580209;
        Tue, 22 Feb 2022 22:38:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 22 Feb 2022 22:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=oWdrlKGF1NWtcC
        xtncJT3dMTsSPn/4SNUwtDAP8s094=; b=WmKlJIecYXldLnuTQkF3fQ+rDgnbxM
        PndaTMe0JL8/bQi2B0KEW9m7QVbYSBKbuRm/OgkC20PSmWybJvUy1Rsxf5WAzlqE
        Da893Neus6o1VOfEWWqZSyPngnal2Ds0C991oXXwrtyThoUx54SM0iHLLmj2ZIO/
        5SvCZZCYN3IVTaUNebPGs0vdiHVrUF6izjM2ONcTkOWTljdHbPeOVVIVGrO59XQA
        1n8jlih4ufPm+t7WZR0ViDqsaAhj42Iy760ExDcVZnMXVbtGDDpjUAssgAWLZlor
        YcpM4VJIlNSkUjUHlmiJIkzjZuUMseEqmcVMkGSZotJUxauVwpwJ62Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=oWdrlKGF1NWtcCxtncJT3dMTsSPn/4SNUwtDAP8s0
        94=; b=Dk5I5bhMoKG0LwVTVmOJi4mFCM2abdDIVHVyQLV8UThRojqVgT6FtP6y1
        Nw0h6wfCUUfTR72MqTDvF00RUqjultaI2C8i5QMuCrQteqt2w5stzDJkVVj6n+1w
        riii+/oAE6OvI5Fq29J9xvxnwaGSyBA41cvhPOxwUKT5eUovFUQkbEXSDQSCM0vz
        6aVCz0/duHGZMUDLA1QNa3/RGOKahvzJi7rHCjboKABdGJXsy9vwfwjsz0lRkEFR
        kH1UT0paGmrHFvmqBPbb2Ui81qw33DX0IEc+Xdtbvd4+QGcX9V6HwLWdh/OFEPER
        WQyl8aU3FXapkKDTlQwzIzZck1IDg==
X-ME-Sender: <xms:KKwVYhn8YIsfyF01rhsH18ZaIwXk6DXfyYA3shP6RqVtMkagpm4jPg>
    <xme:KKwVYs3oy9cHpZq7ZK0tq-X9o-JU2M4yYzwobni-opgSYeQnA3TlEalcbS4YC3x7j
    XBcybw4eVGshrN4xA>
X-ME-Received: <xmr:KKwVYnqlVm9Nt6aqIaDzhdRdHDtcOCiVV7j98tko8EXF7mwIoeypiKa5hLRZXTMor-Wkb8_WA8GpJZJyVgbM34fDnGoG09aB-i0Mgt1uW5Ine0bRm_Fkymb3uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:KawVYhl9692HpbV-WvrBsol48vcKd087_7VoSGw_x_d7w1IQiPpKFA>
    <xmx:KawVYv19-EzbZqUdyxn9u5e4kheNj-YA7kbbPDuSuCb8y0Kz0oyi9A>
    <xmx:KawVYguPIRM4aUbqQitloEChQl7dNMplyLKBA_cAi5q8jIErwlCgFg>
    <xmx:KawVYhwWLlzFb0XCEKPon3VyeYkprQLdtCaGvqVFJc_g0NC2oy7w_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 22:38:16 -0500 (EST)
Subject: Re: [PATCH v10 08/18] dt-bindings: arm: sunxi: Add two H616 board
 compatible strings
To:     Andre Przywara <andre.przywara@arm.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-9-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <1d6d8f0f-c528-f1e2-2be5-a844776aade4@sholland.org>
Date:   Tue, 22 Feb 2022 21:38:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220211122643.1343315-9-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 6:26 AM, Andre Przywara wrote:
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index c8a3102c0fde..185ced5da6b8 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -853,6 +853,11 @@ properties:
>            - const: yones-toptech,bs1078-v2
>            - const: allwinner,sun6i-a31s
>  
> +      - description: X96 Mate TV box
> +        items:
> +          - const: hechuang,x96-mate

I don't see this vendor in vendor-prefixes.yaml. I would have expected
checkpatch.pl to warn about this.

Regards,
Samuel

> +          - const: allwinner,sun50i-h616
> +
>        - description: Xunlong OrangePi
>          items:
>            - const: xunlong,orangepi
> @@ -953,4 +958,9 @@ properties:
>            - const: xunlong,orangepi-zero-plus2-h3
>            - const: allwinner,sun8i-h3
>  
> +      - description: Xunlong OrangePi Zero 2
> +        items:
> +          - const: xunlong,orangepi-zero2
> +          - const: allwinner,sun50i-h616
> +
>  additionalProperties: true
> 

