Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBFD4B0998
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbiBJJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:34:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiBJJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:34:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4237C64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:34:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m14so8356571wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=vxX/8zifzyFYTCAPgNpbL+1rDLu/Md5JII8F66Zcgtc=;
        b=3teWvtZsSrrrJESfa7vF84YVSNgwtbUY1wIxqDcxH7iwMzjyUo7p53oOAmoVaoU16Z
         PNYf0YZYqECGJy9F+jVXYcFQUXw4TQHFfMmGiW7tNlJDLpsmdH3jB6zD7sJmfbhd83P6
         drQlHE49cvvnBsEV1WSg6/Icx1q/hJGe5tdBMw4rCVW9kNaendOZHVDH0gmcHNXuYJPu
         qYfG/tB6X9LQt/hZMzQ+fvWIe2x5MKtPwuRZX6sMAF955nWKFbYPXo4oDIyuEXUYZjwj
         +8MoWdFO915oyshOm66cayioydZbsisHdtBm2//hBtdV/nAprEYGD0PeOQytScSehht9
         7Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=vxX/8zifzyFYTCAPgNpbL+1rDLu/Md5JII8F66Zcgtc=;
        b=lrrkyjQflZ3LzFW/WBV1r/xj3x0t9//9Z6Fc9nKdehw3xTlxX33qOEb6QHOOTWOtN2
         /E0+J79YX/Cy9rOJBPdxPWM5tgFYEWf5r4uvalcXqgLPvxPDnOnGQvcuKFtAf/KIDVGK
         /+yAq4bwIR37h9QK4w6ugGCO6qe86/9rOzq+B0hMbc1Cb85XjHK3MCgQU+V+1XlXheSM
         R5hZwWrKKTVU8WYDG9ThcN4kJGrBQp4mGlUdWMUB0XFIUcFzWDqslD/oRzVQyzGHNi+I
         HVv+HCSCVHwE0idgHwagufe4+ckh9l17ts5PvR1STWVNppvLbBGO/kpv+GKq0sPfvxsl
         rayw==
X-Gm-Message-State: AOAM530IQY2STc0P/fqtAYamvNzceehaVWARMzptaa6kXKJh/UupLLyF
        O0bYBHf1nbr17aEunerbex2Y+foZbOchN3/s
X-Google-Smtp-Source: ABdhPJwYmf/xTj+0L3TetNb2WBvO7oJeJgkuCVLbksq3xzAoCbJ6xmnGlCzlqQsuDz7mn0tMnK3fMg==
X-Received: by 2002:a05:6000:16cc:: with SMTP id h12mr5547466wrf.408.1644485666342;
        Thu, 10 Feb 2022 01:34:26 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:76d9:bf0e:e516:58a9? ([2001:861:44c0:66c0:76d9:bf0e:e516:58a9])
        by smtp.gmail.com with ESMTPSA id a15sm7522310wri.22.2022.02.10.01.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 01:34:25 -0800 (PST)
Message-ID: <98acfb7c-59bc-e437-899f-4f1eda0fea0b@baylibre.com>
Date:   Thu, 10 Feb 2022 10:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: meson: remove CPU opps below 1GHz for
 G12B/SM1
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220209135535.29547-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220209135535.29547-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2022 14:55, Christian Hewitt wrote:
> Amlogic G12B and SM1 devices experience CPU stalls and random board
> wedges when the system idles and CPU cores clock down to lower opp
> points. Recent vendor kernels include a change to remove 100-250MHz
> (with no explanation) [0] but other downstream sources also remove
> the 500/667MHz points (also with no explanation). Unless 100-667Mhz
> opps are removed or the CPU governor forced to performance, stalls
> are observed, so let's remove them an improve stability/uptime.
> 
> [0] https://github.com/khadas/linux/commit/20e237a4fe9f0302370e24950cb1416e038eee03
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> Numerous people have experienced this issue and I have tested with
> only the low opp-points removed and numerous voltage tweaks: but it
> makes no difference. With the opp points present an Odroid N2 or
> Khadas VIM3 reliably drop off my network after being left idling
> overnight with UART showing a CPU stall splat. With the opp points
> removed I see weeks of uninterupted uptime. It's beyond my skills
> to research what the cause of the stalls might be, but if anyone
> ever figures it out we can always restore things. NB: This issue
> is not too widely reported in forums, but that's largely because
> most of the Amlogic supporting distros have been including this
> change picked from my kernel patchset for some time.
> 
>   .../boot/dts/amlogic/meson-g12b-a311d.dtsi    | 40 -------------------
>   .../boot/dts/amlogic/meson-g12b-s922x.dtsi    | 40 -------------------
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 20 ----------
>   3 files changed, 100 deletions(-)
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 3c07a89bfd27..80737731af3f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -95,26 +95,6 @@
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> -		opp-100000000 {
> -			opp-hz = /bits/ 64 <100000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-250000000 {
> -			opp-hz = /bits/ 64 <250000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-500000000 {
> -			opp-hz = /bits/ 64 <500000000>;
> -			opp-microvolt = <730000>;
> -		};
> -
> -		opp-667000000 {
> -			opp-hz = /bits/ 64 <666666666>;
> -			opp-microvolt = <750000>;
> -		};
> -
>   		opp-1000000000 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <770000>;

Can you find if an acceptable set of Fixes tag can be added to permit backporting to the current LTS kernels ?

Neil
