Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C19565FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 01:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiGDX4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 19:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGDX4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 19:56:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D577650;
        Mon,  4 Jul 2022 16:56:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B8C1D5C00DD;
        Mon,  4 Jul 2022 19:56:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Jul 2022 19:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656978960; x=
        1657065360; bh=VjjCNK/QUJQgIUTHTpMOStvQY2cL+8rDq3LhVbeEC1Q=; b=h
        ifwV1yYFNvbZC/udgowFCmTOSmQ/qcy2IOL1cTA8TMdVqjZhB9dnAHZSMTvDZej/
        7f8JVANCeh2WkC4Gx0lbISJquIb/EYAsH7G+w8Avw7tNbG5EEsbqIfWOoo/Kl1Sl
        zDDUUR3a1495DQ8KQ1ZqlMKQbCX4XRvdu1sQ02OsaubVt/TKq0bSXc82t7MwFmgf
        8wVwLk/tjIlZh17NInWC6o7T1WLeQqmpI7JPhjqQ2Of0VhpP22i1VHBakOFpl8n+
        PFHBG6oyN6QnLzMkGMKeedBjw11r1R82EvLyFHXFGgxTaiTeMfGDWu5oIRyEh1F6
        nkjqcLWNH15X0/5FF43Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656978960; x=
        1657065360; bh=VjjCNK/QUJQgIUTHTpMOStvQY2cL+8rDq3LhVbeEC1Q=; b=R
        TfYJfkvawaWXek+h6Zjyz4SYSCyrOlatEV2aVVi3K9KE/5JO2sTjVWLnHJse8zGu
        y1vw8jIt8HuiyyAsxt4HDpGiZGaBFE8H0KSxkyzIP0Uu/hpLQx29qo3hqXFQhCJy
        oIm3OoqjzqREaxG73SbcUYjbl1XSOKzuzKy9dv9/OGLu5CR0HYWK/o4AZQylbbeH
        m24CjKkXDGhEyDulJjs9krZlEUhSOj9D3WO4GVPqYr3+AscUSw7sDSIafmTWeHfy
        OVlPrKR2kGddRUQdIR9In8KqUNbrghtgCDLsXi4zpyqVknimZCYWIpg+vBR+6IKb
        ZPZjr30lTUAXID68e5X7g==
X-ME-Sender: <xms:EH7DYvWbRUH8tTcu-a_7OhCENgU3bg5LBZp7rPwzF0wBSs0NvE0VUw>
    <xme:EH7DYnmhk9gDVCrR66Keb9k5qquPEyPP3T-UECCulDX04sICbDqKsqLm6nzZ-STZQ
    _bkSdwEPJJaJnGjVg>
X-ME-Received: <xmr:EH7DYrbO2prypG0RvHH_4a_vxgxuvB5Ybboo2nqO47ljSDtzvvJ3sHVr3i5RkhVrLo_RwYwWn1FJn1bBuTiyI7ml1ToH9J-JTLxkIR6iu1JVcWcJ6uaAsGbOLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:EH7DYqXzjC3S-vANAIgpERQCjTt-QuPff7X3R7z6yWIwbREF4ntQvg>
    <xmx:EH7DYpm_SfYE_oP0QSRD5dBf_9rtcOLBa6r2GgL6ZaYQUeMNSDhpNA>
    <xmx:EH7DYnemfO8_xw_clYBvmvIUnIyLIyz8023rquBwyAzkxzUJCz5JYw>
    <xmx:EH7DYqhHig5EpJ-EFrQn9UYxW4YZDZe8m3AQ5iRs1_5IN545ezH0Zw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 19:55:59 -0400 (EDT)
Subject: Re: [PATCH v12 2/7] dt-bindings: pinctrl: sunxi: Make interrupts
 optional
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-3-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <74a5466c-a84b-57fa-79ad-96155c1324a0@sholland.org>
Date:   Mon, 4 Jul 2022 18:55:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220701112453.2310722-3-andre.przywara@arm.com>
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

On 7/1/22 6:24 AM, Andre Przywara wrote:
> The R_PIO pinctrl device on the Allwinner H616 SoC does not have an
> interrupt (it features only two pins).
> However the binding requires at least naming one upstream interrupt,
> plus the #interrupt-cells and interrupt-controller properties.
> 
> Drop the unconditional requirement for the interrupt properties, and
> make them dependent on being not this particular pinctrl device.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>

> ---
>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml      | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
> index bfce850c20351..0bd903954195b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
> @@ -133,14 +133,11 @@ patternProperties:
>  
>  required:
>    - "#gpio-cells"
> -  - "#interrupt-cells"
>    - compatible
>    - reg
> -  - interrupts
>    - clocks
>    - clock-names
>    - gpio-controller
> -  - interrupt-controller
>  
>  allOf:
>    # FIXME: We should have the pin bank supplies here, but not a lot of
> @@ -148,6 +145,18 @@ allOf:
>    # warnings.
>  
>    - $ref: "pinctrl.yaml#"
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            enum:
> +              - allwinner,sun50i-h616-r-pinctrl
> +    then:

Nit: all of the existing ifs and thens have blank lines between them.

> +      required:
> +        - "#interrupt-cells"
> +        - interrupts
> +        - interrupt-controller
> +
>    - if:
>        properties:
>          compatible:
> 

