Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B266F4F1052
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377839AbiDDHw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377834AbiDDHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:52:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4543B03B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:50:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j12so5501894wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=9KLUE1NHtEsDFtRjMM1zL7+bD86TSrQIC2LDIAuynOc=;
        b=Fx7T7OoM6yT56hzAxLIOfsn5EYaVjPRxqC5cOUY+DxBFXzSO8N05P+jEOPJdEHuGvl
         yD6zkibXVdGuk6wsZoPi4sU69B09ODb7VYQ+bEULD85UKQEiLVkDemiJh+YcwsGPx8zE
         5PwNCgDhgOc8KqWGlCOJitKrta5XLL1TFhl24+NA26JGWBIxp5MaraKMrmAUUZYMO5Rz
         KX8uoUYuDoqfpLL+L+0efnmxpxRPpr6O0wn8sbEt1gzKSeT9fZwRjwKjlQHLW3NQ2Ysi
         WCC3EIW8tHdhTl2DcAFCf3BuR7pRYY/X8MjPU1Ra8kHXV/y0GIV7jLkEpYvL2096PrDe
         5wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9KLUE1NHtEsDFtRjMM1zL7+bD86TSrQIC2LDIAuynOc=;
        b=zsMssVpb9hgyxVUr0Y3sE5oiotsTVv89UUFxoQgnfGrCflfy1alQ7vQx3VCl/KP8FL
         D33Amdso2jSULhvi01+SBki6NIBheiI8FP+enQq1sMpmEDo18mCpa6AbNqeYaqdWrR6p
         q/S214I0ZNEJJGadxA4+lr/p2VG1YTAVhDgJUjQE6pGhVI/eA0eiN0nf9dZA/+FnockH
         GrdCoG0yx8Gs8J8VKmX5YEQna49aWTvV6cE7kTuCrCygfP8yVJGmXmHdLpc32TyGsd7s
         uFjd3hy+mksGTJiaywZtW4cS3TqwCoDZjpeDBxPsuR27tZeqrg02XddSAXhqGJ2Y+09w
         rSlQ==
X-Gm-Message-State: AOAM532b2O5sMEQShWy+vIXA/+9EAhck2VUlRFbbQRJr72U7S0tlH4QG
        bUCJ80IwpqOEfr6672q0mVGsyw0kttUZCJYJ
X-Google-Smtp-Source: ABdhPJw7zPtSFEMQcbZ44jylQLyS8h2higOBBCEDhyCqGau9g39TY5y+sEjRqQ9F+Fwxv68AQcGaOw==
X-Received: by 2002:adf:e2cc:0:b0:203:e8ba:c709 with SMTP id d12-20020adfe2cc000000b00203e8bac709mr16065391wrj.713.1649058632571;
        Mon, 04 Apr 2022 00:50:32 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:1add:1b28:2457:eb46? ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00205820686dasm9781330wrd.5.2022.04.04.00.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 00:50:31 -0700 (PDT)
Message-ID: <ddcc31b1-2123-2d7b-5334-b4545569e287@baylibre.com>
Date:   Mon, 4 Apr 2022 09:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] arm64: dts: meson: remove CPU opps below 1GHz for
 G12B boards
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220210100638.19130-1-christianshewitt@gmail.com>
 <20220210100638.19130-2-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220210100638.19130-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 11:06, Christian Hewitt wrote:
> Amlogic G12B devices experience CPU stalls and random board wedges when
> the system idles and CPU cores clock down to lower opp points. Recent
> vendor kernels include a change to remove 100-250MHz and other distro
> sources also remove the 500/667MHz points. Unless all 100-667Mhz opps
> are removed or the CPU governor forced to performance stalls are still
> observed, so let's remove them to improve stability and uptime.
> 
> Fixes: b96d4e92709b ("arm64: dts: meson-g12b: support a311d and s922x cpu operating points")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   .../boot/dts/amlogic/meson-g12b-a311d.dtsi    | 40 -------------------
>   .../boot/dts/amlogic/meson-g12b-s922x.dtsi    | 40 -------------------
>   2 files changed, 80 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
> index d61f43052a34..8e9ad1e51d66 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
> @@ -11,26 +11,6 @@
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> -		opp-100000000 {
> -			opp-hz = /bits/ 64 <100000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-250000000 {
> -			opp-hz = /bits/ 64 <250000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-500000000 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-667000000 {
> -			opp-hz = /bits/ 64 <667000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
>   		opp-1000000000 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <761000>;
> @@ -71,26 +51,6 @@
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> -		opp-100000000 {
> -			opp-hz = /bits/ 64 <100000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-250000000 {
> -			opp-hz = /bits/ 64 <250000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-500000000 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-667000000 {
> -			opp-hz = /bits/ 64 <667000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
>   		opp-1000000000 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <731000>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> index 1e5d0ee5d541..44c23c984034 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> @@ -11,26 +11,6 @@
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> -		opp-100000000 {
> -			opp-hz = /bits/ 64 <100000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-250000000 {
> -			opp-hz = /bits/ 64 <250000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-500000000 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
> -		opp-667000000 {
> -			opp-hz = /bits/ 64 <667000000>;
> -			opp-microvolt = <731000>;
> -		};
> -
>   		opp-1000000000 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <731000>;
> @@ -76,26 +56,6 @@
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> -		opp-100000000 {
> -			opp-hz = /bits/ 64 <100000000>;
> -			opp-microvolt = <751000>;
> -		};
> -
> -		opp-250000000 {
> -			opp-hz = /bits/ 64 <250000000>;
> -			opp-microvolt = <751000>;
> -		};
> -
> -		opp-500000000 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <751000>;
> -		};
> -
> -		opp-667000000 {
> -			opp-hz = /bits/ 64 <667000000>;
> -			opp-microvolt = <751000>;
> -		};
> -
>   		opp-1000000000 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <771000>;

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
