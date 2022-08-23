Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B860859CF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiHWDQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbiHWDQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:16:14 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B9C4DF36;
        Mon, 22 Aug 2022 20:16:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 53EB25C00A0;
        Mon, 22 Aug 2022 23:16:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 Aug 2022 23:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661224570; x=
        1661310970; bh=cYmKT+EG0Bj+G1PyMV6PvL1EzCjw1wIFlNXT1MPSLoM=; b=p
        KWPlc+cWYP9aV98RZDDXBbo1x7+JjMoQzDlXzsCk1CqXDvj/pSLbPeCuosCqCNbb
        nXoUnn2c1qmDfiPG49ayKDsK/XtL5pHtBV/n39JWj/1Xe/C11XT6GaLWolo1Hsq/
        Tkf9Vu54U+G2JpyUBb+jm5wMQ4rwa4iOpOxg9Fcm8LiZv72jtUZN1mvqZu+PIjIy
        sQSS4d8vjpE8rzOLElYu7gHHEzCXccUP+uu58PnFOesvRJUwP6gg6HaClgah7UCL
        hOOrVvIyO6HHmp3RcecOx5IcXJLdFyh0+3lEWS5lPdJP2I3uWI2sx9QHL1KzpyK4
        DCOaas55TjCz0phzZMm+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661224570; x=
        1661310970; bh=cYmKT+EG0Bj+G1PyMV6PvL1EzCjw1wIFlNXT1MPSLoM=; b=4
        NLVGMjOA2bLK4uWokogmEGGXeHNl9udHozB2J+7MwJE2yWShz5S83Xw7q/hp6v9o
        QttOYTIT2sdZXP96EeNWVM42dBYFNs/fY+hUrMITBY0rwAquIIYpsOOz76K38LKI
        zXsuUJlrY3hCYv4NNMvYfR8wpajvMWap1MwAl2yOH/WRNYQMIcJkb1XJEoRxTg0X
        zWjpR3bGJFTXj4JawknrJcRIsYn9svjZYI/os+bCCrOpeRE+7EUFh66INkXhUe07
        K4rli6jIeFpucjuHQt6cF9y0oXKQtKKy5G39wFX4EArc3RXYjw9KJzKUyoTEIlpx
        /kvKedu/knaJ3ERxmjsEw==
X-ME-Sender: <xms:ekYEYzCRa3-d2rH1xecEC5n9DhO1WNvU1NkDxxcDndqvoZlr6wF0zw>
    <xme:ekYEY5gNdKXYJsvpRPt_2P48tGsnqfe2-gpVkku_FcBX_bLmdSXSRhoSdEeCjQWRE
    Nx6YesI7h-X4WRn1g>
X-ME-Received: <xmr:ekYEY-mxIAZ8sHmN5RHuAgNDNNq2CubwotoRkv1iTYNn7UULiT3EjNEq_AtFt7hgyzePnbiUfW-8aGzJBgu6oq8UoRaYs1wXfckzryxw_otLZNmqPtK-m0cBnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeikedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ekYEY1yCclEQKlei9KUq_EhZ0dXbv60c4pePkEx3hJeTnFBY5kn2oQ>
    <xmx:ekYEY4Tt878--33jBjWkODBn8U9iwfxsBwihzBN2vs6jTX1F1XHjIQ>
    <xmx:ekYEY4ZV19BCH8qq0-ctPTNXPtaYiT_F4rc-44sToKqEp3s7ipm0vg>
    <xmx:ekYEY9Qt3AXoaNy1LgzT6UQdpYl521DYErEVTL10K_dHW_pTEhPCOw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Aug 2022 23:16:09 -0400 (EDT)
Subject: Re: [PATCH v2 2/4] arm64: dts: allwinner: h6: Add cooling map for GPU
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220821173051.155038-1-peron.clem@gmail.com>
 <20220821173051.155038-3-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <72f901e6-f646-336b-70e6-2747363944ab@sholland.org>
Date:   Mon, 22 Aug 2022 22:16:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220821173051.155038-3-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 12:30 PM, Clément Péron wrote:
> Add a simple cooling map for the GPU.

It would be good to document where the trip point temperatures came from.

> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Acked-by: Samuel Holland <samuel@sholland.org>

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 5a28303d3d4c..943ae5374dd6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -186,6 +186,7 @@ gpu: gpu@1800000 {
>  			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
>  			clock-names = "core", "bus";
>  			resets = <&ccu RST_BUS_GPU>;
> +			#cooling-cells = <2>;
>  			status = "disabled";
>  		};
>  
> @@ -1075,6 +1076,27 @@ gpu-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 1>;
> +
> +			trips {
> +				gpu_alert: gpu-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu-crit {
> +					temperature = <100000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&gpu_alert>;
> +					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  	};
>  };
> 

