Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162056628A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGEE5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGEE5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:57:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0801CBCBB;
        Mon,  4 Jul 2022 21:57:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6725B5C005A;
        Tue,  5 Jul 2022 00:57:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 05 Jul 2022 00:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656997065; x=
        1657083465; bh=lNiuLvBXQLvDbsAsBDhebXbFbPXkCEhA9xFI27g2xcU=; b=F
        fh6wWiqLjHTaw6lmgr/TeXOOQy5g+UWpmxS7ijZG6EhSmXoeTctJ20XK0sl3djrF
        q36fdCzVS7HLhK50vF37cOd9ANofwAie9wLvf0oJqDl1vLQIQONuvAL+g2Hmfir0
        t0g7yr/ICxcJ0Tsy+9PMA/PzDRsJ21IcAJEt1PnRrGEI+IX2yuyzuu55j3FTb1bF
        DidUsCkRrGXfOYp1EL/MLwelDXmtnFEfzfuP91RBiQqHWyNJKns8CBcq7jSaNLhN
        wrPxuWu6iOsSdLBiH7qMWIv74ck2PCBM64FDdjxBPeBbhU8h01cmhpEBE+PA1bfN
        7HbfLvQeDg0qFtBBsBh5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656997065; x=
        1657083465; bh=lNiuLvBXQLvDbsAsBDhebXbFbPXkCEhA9xFI27g2xcU=; b=K
        /CM9VDexsN1FKc+YzfKEfoG0a6LSzxV/xn/FN4vXS9vT2LE1Sd7AwMGLYxPays8/
        SMLsxCCDrW3Am4Dr+dJ61wT0nbLzyVtZg2BXHZm3oS6sKzN0El6kdprHlqz9uItb
        9Gdm9PG4g0/70tupf/5L/+SjPaq+T5R8QuQgEg2GZg3ezHZME0p8lfneiH1kVChf
        mfn1RTgdb0oBnJ8/cDphuCoTluHJBu93OhT7aCx+LxSCrDlO9M4zjqsFCkliuOZY
        TYc9ZSv1NOiLYjCMTiSYxDyR8zLeCex4b/P71t/yBWxXJxzyoewL4T2SgE/BkdPc
        ksQmnlKsuiG0kbW4zksWA==
X-ME-Sender: <xms:ycTDYiva5z0CWEuf1prGDmXOXPlbczbYFxDqvJI_g5QAvhe0Fl3DjQ>
    <xme:ycTDYneiVFs8DVKcbsfl1NcXkkwGwwqQfeI723CYrsOJxF19b3HwhlNTKGogx91eE
    UMiuHSRG8juPbkWNA>
X-ME-Received: <xmr:ycTDYtxuFNxq6I9z19lG0wIF6lr0x5LV4RhdjsIMu8GM6ocAj_JVu0u352PxdQ2hiuvcLSOzlHxbDPBhrF3kge-aVjhp-a-phnikU-aNjotzXOEEcfBzGIxcig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ycTDYtNHAFCR5P-KJsak7ukAqmVxCDI7GidalUqgeGw6FjvCPry0Ew>
    <xmx:ycTDYi_rbb1hbviwd3mmTNTxZXc4dEQQ8Va8mUVYJ1BVrSSEaBSinQ>
    <xmx:ycTDYlX5U3uK6HxU8CfCmGhIblgaGhbf5DjBVn1n9i8eFnmB7su8uw>
    <xmx:ycTDYj2ncbZx_ZsE6PqV29r5GurPgK__tv51OikNQndk6iq6qMUkkg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 00:57:44 -0400 (EDT)
Subject: Re: [PATCH v5 2/3] ARM: dts: sun8i-r40: add opp table for cpu
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220517013607.2252-1-qianfanguijin@163.com>
 <20220517013607.2252-3-qianfanguijin@163.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <161faad6-4ee5-97a7-ab4a-53bcb5b47334@sholland.org>
Date:   Mon, 4 Jul 2022 23:57:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220517013607.2252-3-qianfanguijin@163.com>
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

On 5/16/22 8:36 PM, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> OPP table value is get from allwinner lichee linux-3.10 kernel driver
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  1 +
>  arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi      | 52 +++++++++++++++++++
>  arch/arm/boot/dts/sun8i-r40-feta40i.dtsi      |  1 +
>  arch/arm/boot/dts/sun8i-r40.dtsi              |  8 +++
>  arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts      |  1 +
>  .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  1 +
>  6 files changed, 64 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 4f30018ec4a2..28197bbcb1d5 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -43,6 +43,7 @@
>  
>  /dts-v1/;
>  #include "sun8i-r40.dtsi"
> +#include "sun8i-r40-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> diff --git a/arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi b/arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..4faa22d3bac8
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi
> @@ -0,0 +1,52 @@
> +/{
> +	cpu0_opp_table: opp_table0 {

The binding requires the node name to match a specific regex. The patch as
written does not validate:

arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dtb: opp_table0: $nodename:0: 'opp_table0'
does not match '^opp-table(-[a-z0-9]+)?$'
        From schema: Documentation/devicetree/bindings/opp/opp-v2.yaml

With the node renamed to "opp-table-cpu" (following H3), the devicetrees pass
validation. So with that one change:

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

Regards,
Samuel

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-720000000 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <1000000 1000000 1300000>;
> +			clock-latency-ns = <2000000>;
> +		};
> +
> +		opp-912000000 {
> +			opp-hz = /bits/ 64 <912000000>;
> +			opp-microvolt = <1100000 1100000 1300000>;
> +			clock-latency-ns = <2000000>;
> +		};
> +
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1160000 1160000 1300000>;
> +			clock-latency-ns = <2000000>;
> +		};
> +
> +		opp-1104000000 {
> +			opp-hz = /bits/ 64 <1104000000>;
> +			opp-microvolt = <1240000 1240000 1300000>;
> +			clock-latency-ns = <2000000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1300000 1300000 1300000>;
> +			clock-latency-ns = <2000000>;
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +
> +&cpu1 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +
> +&cpu2 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +
> +&cpu3 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> diff --git a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
> index b872b51a346d..9f39b5a2bb35 100644
> --- a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
> @@ -5,6 +5,7 @@
>  //  Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>  
>  #include "sun8i-r40.dtsi"
> +#include "sun8i-r40-cpu-opp.dtsi"
>  
>  &cpu0 {
>  	cpu-supply = <&reg_dcdc2>;
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 291f4784e86c..ae2a5ebd9924 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -84,24 +84,32 @@ cpu0: cpu@0 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <0>;
> +			clocks = <&ccu CLK_CPU>;
> +			clock-names = "cpu";
>  		};
>  
>  		cpu1: cpu@1 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <1>;
> +			clocks = <&ccu CLK_CPU>;
> +			clock-names = "cpu";
>  		};
>  
>  		cpu2: cpu@2 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <2>;
> +			clocks = <&ccu CLK_CPU>;
> +			clock-names = "cpu";
>  		};
>  
>  		cpu3: cpu@3 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <3>;
> +			clocks = <&ccu CLK_CPU>;
> +			clock-names = "cpu";
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
> index 0eb1990742ff..9f472521f4a4 100644
> --- a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
> +++ b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
> @@ -45,6 +45,7 @@
>  
>  /dts-v1/;
>  #include "sun8i-r40.dtsi"
> +#include "sun8i-r40-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> index fdf8bd12faaa..434871040aca 100644
> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> @@ -42,6 +42,7 @@
>  
>  /dts-v1/;
>  #include "sun8i-r40.dtsi"
> +#include "sun8i-r40-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> 

