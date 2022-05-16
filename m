Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74A52801B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbiEPIxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiEPIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:53:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C613EA5;
        Mon, 16 May 2022 01:53:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6E08B3200930;
        Mon, 16 May 2022 04:53:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 16 May 2022 04:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1652691193; x=
        1652777593; bh=+Xd3PLAvDk9oWGFHPx+CW0Qh/oAyEPqTd5DjSbxGME0=; b=D
        tKU0DACi1vO/P+Q3BY7U+Dngk5OeXRwGSjw6sAgClTTvNQ/kEic0vMclukz7iYVg
        TsUF6UvLTvk+p7vxqXzFt2oz9JLN58srGNTsq4sz8coViK0KjD1XnqY+nuOwqNNH
        FoF8QatRwcgWl+sXckWBSIEeWsJQTI6bYc+XYW8qZ8TvGW8IkKKiDOKdwuriwz7U
        9v5HVyulxIVnWQInrnDFhRdqyr7alERUa5wcSJ6/kgAfSZT/+DGEuanDSSXF+UO2
        sNbM5vBd9R/t+McGJzB//bPet2brlxme92GLm/nXHZGXcPaVgZqD3hkugbVgHz53
        lWNmp6hVvA18bLXSmo2IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652691193; x=1652777593; bh=+Xd3PLAvDk9oW
        GFHPx+CW0Qh/oAyEPqTd5DjSbxGME0=; b=Tp8ZS+t1MQwMeT2DiiCVpW3RY9rAs
        u18kmVGDJDrEV8jVrUOPlrSj03zkhZIaP8+IqAcpcUfniJThz3qLDX4LlHN5u4fe
        okqkBWYHVJK+HboR8CPFZ7DzBzREZnH3RRAtaN1SmeiYeYUI/zKg+eBVYzbC9fxs
        SsblbKJUG0bwGbqwBew9/GtK3bma9AINh2VYjD1+h8PW08AJthc9YRtzcMxRFxgK
        sTL0U0IHhZiBL893rEY0o6tI1S5KLKErRcCaeQ3NvZ3BQFRyoc24efKjNsAxptU5
        JENIMXhSKIauCzefEQ+Rc7Tp/8vhGnshhmralujBjDIGYcWlmnNQ6ifLA==
X-ME-Sender: <xms:-RCCYvtlF57rD14MAdZsMzqWPoG2-CEFUbQ1xeZ-yu2pFS3slFkMLQ>
    <xme:-RCCYgcK8ErZMrzy9Z1mhd3tDa7s7aIy4wt7OkkY1tJAbd2JkauGaXvpBxF2AtOUW
    57OS5wuLWcMKTXHHxQ>
X-ME-Received: <xmr:-RCCYiznCtmKfiL3P4kdsB-h9O8PnanGXMpDHa1y4cS_3ZGt7B0evIjgqvg42LE_6Orb9S_Ayyr1VnYIFze8roDreS7HvtEQELkCswc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetgfelgefggeekkefggfeludeiudffjeffgeevveekjedukedtudeuteef
    teefgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:-RCCYuNhyb6KgmKHuD2-6jjJ8J74sbQTtyYXJnZZ1K6OssQ575Spgg>
    <xmx:-RCCYv9jOH14-609woY2dmX34nupuYQpc4I0AI1oEuI3pcJs9C2Vaw>
    <xmx:-RCCYuVJ1MxAmk6lJlI_aDcjDSvabA1NBdrHrOPeodq5gnDVZVNhtw>
    <xmx:-RCCYmbB1puiO02N3N3yjP1qSteUQK-i-X-dgeXJ1XDX-dEdSkaHSw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 May 2022 04:53:12 -0400 (EDT)
Date:   Mon, 16 May 2022 10:53:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ARM: dts: sun8i-r40: add opp table for cpu
Message-ID: <20220516085309.jp5yautmb3veocvl@houat>
References: <20220516021516.23216-1-qianfanguijin@163.com>
 <20220516021516.23216-3-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220516021516.23216-3-qianfanguijin@163.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:15:16AM +0800, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
>=20
> OPP table value is get from allwinner lichee linux-3.10 kernel driver
>=20
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index 291f4784e86c..8949153eb0eb 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -54,6 +54,36 @@ / {
>  	#size-cells =3D <1>;
>  	interrupt-parent =3D <&gic>;
> =20
> +	cpu0_opp_table: opp_table0 {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp-720000000 {
> +			opp-hz =3D /bits/ 64 <720000000>;
> +			opp-microvolt =3D <1000000 1000000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +
> +		opp-912000000 {
> +			opp-hz =3D /bits/ 64 <912000000>;
> +			opp-microvolt =3D <1100000 1100000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +
> +		opp-1008000000 {
> +			opp-hz =3D /bits/ 64 <1008000000>;
> +			opp-microvolt =3D <1160000 1160000 1300000>;
> +			clock-latency-ns =3D <2000000>;
> +		};
> +
> +		/* The opp table of the cpu frequency that exceeds 1G
> +		 * is not defined here. They require higher operating
> +		 * current, which may exceed the 500mA limited if the
> +		 * system is powered by USB. You can add them to the
> +		 * board's DTS is you make sure.
> +		 */

That's not the issue though. The issue is that the board is setup with a
CPU voltage at 1160mV, and if we raise the frequency to a higher OPP
without raising the voltage as well, the CPU will crash.

Maxime
